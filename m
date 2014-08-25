Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:60679 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932274AbaHYOVd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Aug 2014 10:21:33 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XLv9E-0003Zq-5H
	for util-linux@vger.kernel.org; Mon, 25 Aug 2014 16:21:30 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 16:21:28 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 16:21:28 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: lsblk vice fdisk, etc
Date: Mon, 25 Aug 2014 14:21:17 +0000 (UTC)
Message-ID: <loom.20140825T160840-339@post.gmane.org>
References: <loom.20140819T114407-592@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

jb <jb.1234abcd@...> writes:

> ...

To continue with "Dazed and Confused" ...
I assume all of them became programmers.
https://www.youtube.com/watch?v=wknywxfcE5M

It would be good to have some rules in field naming (meaning and continuity
of their use) in similar (almost identical) displays.
All of these entries display the same data types, so it is imperative that
they correspond to each other clearly.

This will give you an overview of output columns:
$ lsblk -h
...

# lsblk 
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0 37.3G  0 disk 
├─sda1   8:1    0   17G  0 part 
├─sda2   8:2    0  4.4G  0 part [SWAP]
├─sda3   8:3    0 13.4G  0 part /
├─sda4   8:4    0    1K  0 part 
└─sda5   8:5    0  2.4G  0 part 
sr0     11:0    1 1024M  0 rom  

The field TYPE refers to a device type, so it should be renamed to DEVTYPE.
This would avoid confusion with other TYPE-like fields, e.g.
- cfdisk and fdisk
  Type means partition type (by Id): Linux, Linux swap, Extended, FAT12,
  empty, AIX, Dell Utility, etc  
- parted
  Type means partition type: primary, extended, logical
- partx
  Type means partition type (a string, a UUID, or hex)

# lsblk -o name,fstype,label,parttype,partlabel,mountpoint
NAME   FSTYPE LABEL  PARTTYPE PARTLABEL MOUNTPOINT
sda                                     
├─sda1 ext4          0x83               
├─sda2 swap          0x82               [SWAP]
├─sda3 ext4   Arch   0x83               /
├─sda4               0x5                
└─sda5 ext4   backup 0x83               
sr0                                     

The field LABEL should be renamed to FSLABEL, as there is also a partition
label PARTLABEL.

# blkid 
/dev/sda1: UUID="fb838405-607c-4723-9355-47ccbf1eb273" TYPE="ext4"
PARTUUID="3db012b3-01" 
/dev/sda5: LABEL="backup" UUID="4f168c8f-ac1d-4048-ac3f-254fa4392c60"
TYPE="ext4" PARTUUID="3db012b3-05" 
/dev/sda2: UUID="8afa3b49-ae96-4496-9335-1afd62d67097" TYPE="swap"
PARTUUID="3db012b3-02" 
/dev/sda3: LABEL="Arch" UUID="d067602d-f15d-49c0-abad-865adab2cc8f"
TYPE="ext4" PTTYPE="dos" PARTUUID="3db012b3-03" 

The fields:
LABEL corresponds to LABEL in lsblk display, which is suggested to be
renamed to FSLABEL, so this one should be too.
TYPE refers to "ext4" and "swap", which suggests a fs type, so it should be
renamed to FSTYPE to correspond to lsblk display.
PTTYPE refers to "dos" ... here I am at a loss; I assume it means partition
type, so it should be renamed to PARTTYPE to correspond to lsblk display;
why "dos" ? why for /dev/sda3 only ?

jb


