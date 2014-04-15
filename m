Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbaDOLWK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Apr 2014 07:22:10 -0400
Date: Tue, 15 Apr 2014 13:21:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: libblkid: Idea to force given cached entry to be invalidated?
Message-ID: <20140415112159.GE5786@x2.net.home>
References: <534C9625.8030906@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <534C9625.8030906@cn.fujitsu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 15, 2014 at 10:15:01AM +0800, Qu Wenruo wrote:
> When using the blkid_get_cache(), things will be cached to reduce the probe
> frequency.

The question is if you really want to use the cache at all :-) 

It's pretty common that we have udevd that maintain all necessary
information about devices, including information from libblkid. The
udev db is the primary source for many system actions and tools.

All you need is to use libudev udev_enumerate API to scan for all
block devices and udev_device_get_property_value(ID_FS_TYPE). Maybe
you can add a new method BTRFS_SCAN_UDEV and use it as default. It
would be better to keep libblkid as a fallback solution only. (For
very unusual situations where there is no udev or so.)

> But filesystem which supports device management like btrfs can remove device
> and if fast enough, libblkid will not invalidate the old cache and cause to get
> the wrong filesystem type.

Well, since commit 6c2f2b9d (year 2010, v2.18), the libblkid uses
microsecond resolution to check for device modifications.

So the problem is not that btrfs is fast enough ;-)

> The bug is describe in the following btrfs patch:
> https://patchwork.kernel.org/patch/3960191/

The patch does not make sense at all, blkid without a cache scans
/proc/partitions -- so it's almost the same like BTRFS_SCAN_PROC
btrfs_scan_block_devices().


> So is there any idea about forcing given cached entry invalidated?

It seems you're trying workaround the *btrfs problem*. The command 

  btrfs device delete

does not open and modify the device! It uses btrfs ioctl and kernel
does the changes to the device. The problem is that kernel does not
update atime and mtime of the device. So the changes are completely
invisible for libblkid (or another mtime based solutions). See
my example below.

IMHO it's strange manner to modify files in kernel, but no update 
mtime.

Fortunately kernel at least sends event to udev.

Maybe possible workaround is to add utime() call to "btrfs device
delete". Something like:

diff --git a/cmds-device.c b/cmds-device.c
index 309b49e..5c438bf 100644
--- a/cmds-device.c
+++ b/cmds-device.c
@@ -20,6 +20,8 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <utime.h>
 #include <errno.h>
 #include <sys/stat.h>
 #include <getopt.h>
@@ -179,7 +181,8 @@ static int cmd_rm_dev(int argc, char **argv)
 				"ERROR: error removing the device '%s' - %s\n",
 				argv[i], strerror(e));
 			ret++;
-		}
+		} else
+			utime(argv[i], NULL);
 	}
 
 	close_file_or_dir(fdmnt, dirstream);


BTW, it would be nice to have --verbose option for btrfs-scan, now it
seems like black box.

    Karel


See mtime:


# stat /dev/sdb2
  File: ‘/dev/sdb2’
  Size: 0               Blocks: 0          IO Block: 4096   block special file
Device: 5h/5d   Inode: 392701      Links: 1     Device type: 8,12
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/    disk)
Access: 2014-04-15 11:58:58.338758155 +0200
Modify: 2014-04-15 11:58:58.338758155 +0200
Change: 2014-04-15 11:58:58.338758155 +0200
 Birth: -

# btrfs device add /dev/sdb2 /mnt/test
SMALL VOLUME: forcing mixed metadata/data groups

# stat /dev/sdb2
  File: ‘/dev/sdb2’
  Size: 0               Blocks: 0          IO Block: 4096   block special file
Device: 5h/5d   Inode: 392701      Links: 1     Device type: 8,12
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/    disk)
Access: 2014-04-15 11:59:34.930143021 +0200
Modify: 2014-04-15 11:59:34.930143021 +0200
Change: 2014-04-15 11:59:34.930143021 +0200
                            ^^^^^^^^

# btrfs device delete /dev/sdb2 /mnt/test

# stat /dev/sdb2
  File: ‘/dev/sdb2’
  Size: 0               Blocks: 0          IO Block: 4096   block special file
Device: 5h/5d   Inode: 392701      Links: 1     Device type: 8,12
Access: (0660/brw-rw----)  Uid: (    0/    root)   Gid: (    6/    disk)
Access: 2014-04-15 11:59:34.930143021 +0200
Modify: 2014-04-15 11:59:34.930143021 +0200
Change: 2014-04-15 11:59:34.930143021 +0200
                            ^^^^^^^^^


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
