Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965563AbdLSMpG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Dec 2017 07:45:06 -0500
Date: Tue, 19 Dec 2017 13:45:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.31.1 plan
Message-ID: <20171219124501.3wflh5ibmco42n7c@ws.net.home>
References: <201712191250.51516.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201712191250.51516.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 19, 2017 at 12:50:51PM +0100, Ruediger Meier wrote:
> I can reproduce it trying to mount an ext4 device using "-t nofoo,bar"
> like in the test, as you see below. I'm not sure whether the bad return 
> value of mount.exfat is the problem or why mount is trying mount.exfat
> (and friends) at all.

"-t <name>" specifies FS type and forces mount(8) do not use built-in
(libblkid) FS detection. It's good enough if you provide fstype by <name>.

If you specify "-t [no]<list>" then it disables built-in detection and
define what FS types are [un]wanted. If built-in detection is disabled,
and FS type is unknown, so it reads /{etc,proc}/filesystems and
filter out filesystem types by your [no]<list> pattern. 

The final list of wanted filesystems is tried for mount.<type> helpers 
or by direct mount(2) syscall.

The problem is that function do_mount_by_pattern() cares about exec()
return code, but don't care about waitpid() status from the helper.
I'll fix it in the master branch. For stable branch we can add "-i"
(disable helpers) to the test.


The reason why I don't this problem is that Fedora have ext4 as the
first FS in the /etc/filesystems and I'd have exfat in the lists at
all.


> 6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.exfat         ... 
> found
> 6682: libmount:      CXT: [0x1f00fb0]: mount: executing 
> helper /sbin/mount.exfat
> 6682: libmount:      CXT: [0x1f00fb0]: mount: generate helper mount 
> options
> 6697: libmount:      CXT: [0x1f00fb0]: argv[0] = "/sbin/mount.exfat"
> 6697: libmount:      CXT: [0x1f00fb0]: argv[1] = "/dev/mapper/vg0-root"
> 6697: libmount:      CXT: [0x1f00fb0]: argv[2] = "/mnt/tmp"
> 6697: libmount:      CXT: [0x1f00fb0]: argv[3] = "-o"
> 6697: libmount:      CXT: [0x1f00fb0]: argv[4] = "rw"
> FUSE exfat 1.2.6
> ERROR: exFAT file system is not found.
> 6682: libmount:      CXT: [0x1f00fb0]: /sbin/mount.exfat executed 
> [status=1, rc=0]
   ^^^^^^^^^^^^^

We need to try another FS for status=1.

Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
