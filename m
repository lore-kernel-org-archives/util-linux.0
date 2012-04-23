Return-Path: util-linux-owner@vger.kernel.org
Received: from n26.netmark.pl ([94.124.9.61]:50927 "EHLO n26.netmark.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab2DWQCH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 12:02:07 -0400
Received: from jyb26.internetdsl.tpnet.pl ([95.50.1.26]:53241 helo=magazyn-ziarno)
	by n26.netmark.pl with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <Marcin.Szewczyk@wodny.org>)
	id 1SMLNz-000O2Q-1X
	for util-linux@vger.kernel.org; Mon, 23 Apr 2012 17:41:07 +0200
Date: Mon, 23 Apr 2012 17:41:06 +0200
From: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
To: util-linux@vger.kernel.org
Subject: Duplicate UUIDs, findmnt, /dev/disk/by-uuid
Message-ID: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I have a system with most of the files on one disk. Sometimes an
additional storage is added by inserting another disk. There is an
application included in this system to setup a disk for that additional
storage. It lets a user choose any disk from the pool of not mounted
drives.

The system has been cloned (with dd) to many disks inserted to many
machines. From time to time someone inserts an additional disk which has
been previously used as the system disk. Then there are two filesystems
with same UUIDs inserted to one machine.

The mentioned application uses findmnt to blacklist drives with any
partitions mounted.

Findmnt seems to use links from /dev/disk/by-uuid. There is only one
link for every UUID and it leads to the last detected disk with that
UUID. It causes my application to let the user choose the mounted root
filesystem.

As a workaround I use /proc/self/mountinfo as it gives me major and
minor numbers.

My question is: is there a way to force findmnt to use major and minor
numbers from /proc/self/mountinfo to identify disks/partitions?


Example (using only one disk):
# findmnt -cnko SOURCE /media/sdd
/dev/sdd2
# cat /proc/self/mountinfo | grep sdd
31 19 8:49 / /media/sdd rw,relatime - ext4 /dev/disk/by-uuid/a1d15a89-470a-4a1e-a763-20d4b404d507 rw,user_xattr,barrier=1,data=ordered
# blkid | grep sdd
/dev/sdd1: UUID="a1d15a89-470a-4a1e-a763-20d4b404d507" TYPE="ext4" 
/dev/sdd2: UUID="a1d15a89-470a-4a1e-a763-20d4b404d507" TYPE="ext4"
# ls -la /dev/sdd*
brw-rw---T 1 root floppy 8, 48 Apr 23 16:13 /dev/sdd
brw-rw---T 1 root floppy 8, 49 Apr 23 16:13 /dev/sdd1
brw-rw---T 1 root floppy 8, 50 Apr 23 16:20 /dev/sdd2


-- 
Marcin Szewczyk                       http://wodny.org
mailto:Marcin.Szewczyk@wodny.borg  <- remove b / usuń b
xmpp:wodny@ubuntu.pl                  xmpp:wodny@jabster.pl
