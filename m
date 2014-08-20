Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:47731 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbaHTJAy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Aug 2014 05:00:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XK1l0-0005Oc-Ue
	for util-linux@vger.kernel.org; Wed, 20 Aug 2014 11:00:43 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 11:00:38 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 20 Aug 2014 11:00:38 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: lsblk vice fdisk, etc
Date: Wed, 20 Aug 2014 09:00:29 +0000 (UTC)
Message-ID: <loom.20140820T101248-582@post.gmane.org>
References: <loom.20140819T114407-592@post.gmane.org> <loom.20140819T201609-326@post.gmane.org> <20140819200511.GA511@rampage>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dave Reisner <d <at> falconindy.com> writes:

> ...
> Why do you think this is contradictory? The filesystem type and
> partition type are two disparate types.

Yes, you are right, technically.

But I mentioned it because it bothers me, and confuses slightly.
Let me explain why, and I reserve the right to be wrong if I miss some
aspects of it.
It is about the business of partition types and file system types, perhaps
even partitions and file systems in general.

Example:
# lsblk -o name,fstype,parttype,label,mountpoint /dev/sdb
NAME   FSTYPE PARTTYPE LABEL MOUNTPOINT
sdb                          
├─sdb1 ntfs   0x83           
└─sdb2 ext4   0x17           
# fdisk -l /dev/sdb
...
Device     Boot   Start      End Sectors  Size Id Type
/dev/sdb1  *       2048  7522303 7520256  3.6G 83 Linux
/dev/sdb2       7522304 15356159 7833856  3.8G 17 Hidden HPFS/NTFS
#

This is what I mean, a mixture of partition types (with their type names
suggesting something) and file system types, contradicting each other at
least in descriptions.

Somehow I have an impression that there was an intention at some time in the
past to associate partition types with only certain file system types.
But it never worked, or was misunderstood, or was abandoned.
That's my guess.

There is some evidence to that assumption (note that they are actually
contradictory in their wording):

http://en.wikipedia.org/wiki/Disk_partition
"The partition type code for a primary partition can either correspond to a
file system contained within (e.g. 0x07 means either an NTFS or an OS/2 HPFS
file system) or indicate that the partition has a special use (e.g. code
0x82 usually indicates a Linux swap partition). The FAT16 and FAT32 file
systems have made use of a number of partition type codes due to the limits
of various DOS and Windows OS versions. Though a Linux operating system may
recognize a number of different file systems (ext4, ext3, ext2, ReiserFS,
etc.), they have all consistently used the same partition type code: 0x83
(Linux native file system)."

http://tldp.org/HOWTO/Partition/partition-types.html
"A partition is labeled to host a certain kind of file system (...). Such a
file system could be the linux standard ext2 file system or linux swap
space, or even foreign file systems like (Microsoft) NTFS or (Sun) UFS."

I would like to get to the point here.
Why not abandon the partition and file system dichotomy.
Why not use just one term, let's call it fspart (file system partition),
encompassing functionality of both partition and file system.
For example, fspart would mean "none" for empty space (no fs), ext4, swap,
NTFS, etc.
Basically, let's eliminate partition and file system as known today.

jb


