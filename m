Return-Path: util-linux-owner@vger.kernel.org
Received: from ns.horizon.com ([71.41.210.147]:62295 "HELO ns.horizon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750853AbcCNSoU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Mar 2016 14:44:20 -0400
Date: 14 Mar 2016 14:44:19 -0400
Message-ID: <20160314184419.7527.qmail@ns.horizon.com>
From: "George Spelvin" <linux@horizon.com>
To: kzak@redhat.com, linux@horizon.com
Subject: Re: e2fsck: /dev/hda2 is mounted.
Cc: util-linux@vger.kernel.org
In-Reply-To: <20160314162947.22odxuup5lij7mz6@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thanks for the help.  I don't quite understand the structure of libmount
well enough to know where a fix *should* go.

> Can you send me your /proc/self/mountinfo? (or at least root fs entry
> from the file)

12 0 3:2 / / rw,relatime - ext4 /dev/root rw,errors=remount-ro,data=ordered
13 12 0:12 / /sys rw,nosuid,nodev,noexec,relatime - sysfs sysfs rw
14 12 0:13 / /run rw,nosuid,noexec,relatime - tmpfs tmpfs rw,size=207448k,mode=755
15 14 0:14 / /run/lock rw,nosuid,nodev,noexec,relatime - tmpfs tmpfs rw,size=5120k
16 12 0:4 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
17 12 0:6 / /dev rw,nosuid,relatime - devtmpfs devtmpfs rw,size=10240k,nr_inodes=221580,mode=755
18 14 0:15 / /run/shm rw,nosuid,nodev,noexec,relatime - tmpfs tmpfs rw,size=1391640k
19 17 0:11 / /dev/pts rw,nosuid,noexec,relatime - devpts devpts rw,gid=5,mode=620
20 12 0:16 / /tmp rw,noexec,relatime - tmpfs tmpfs rw,size=524288k
21 12 3:3 / /home rw,relatime - ext4 /dev/hda3 rw,data=ordered

And here's /etc/mtab -> /proc/mounts:

/dev/root / ext4 rw,relatime,errors=remount-ro,data=ordered 0 0                 
sysfs /sys sysfs rw,nosuid,nodev,noexec,relatime 0 0                            
tmpfs /run tmpfs rw,nosuid,noexec,relatime,size=207448k,mode=755 0 0            tmpfs /run/lock tmpfs rw,nosuid,nodev,noexec,relatime,size=5120k 0 0            
proc /proc proc rw,nosuid,nodev,noexec,relatime 0 0                             
devtmpfs /dev devtmpfs rw,nosuid,relatime,size=10240k,nr_inodes=221580,mode=755 0 0                                                                             
tmpfs /run/shm tmpfs rw,nosuid,nodev,noexec,relatime,size=1391640k 0 0          
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620 0 0             
tmpfs /tmp tmpfs rw,noexec,relatime,size=524288k 0 0                            
/dev/hda3 /home ext4 rw,relatime,data=ordered 0 0             16,0-1        All

