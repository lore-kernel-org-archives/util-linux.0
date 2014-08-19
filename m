Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:37361 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbaHSSVV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Aug 2014 14:21:21 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XJo22-0004oi-DN
	for util-linux@vger.kernel.org; Tue, 19 Aug 2014 20:21:18 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Aug 2014 20:21:18 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Aug 2014 20:21:18 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: lsblk vice fdisk, etc
Date: Tue, 19 Aug 2014 18:21:06 +0000 (UTC)
Message-ID: <loom.20140819T201609-326@post.gmane.org>
References: <loom.20140819T114407-592@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

jb <jb.1234abcd@...> writes:

> ...
> The line
> └─sdb1 iso9660 Test
> should be reconciled with what fdisk, etc show.
> ...

The following display demonstrates it better.

$ lsblk -o name,fstype,parttype,size
NAME   FSTYPE  PARTTYPE  SIZE
sda                     37.3G
├─sda1 ext4    0x83       20G
├─sda2 swap    0x82      1.5G
├─sda3 ext4    0x83     13.4G
└─sda5 ext4    0x83      2.4G
sdb    iso9660           7.3G
└─sdb1 iso9660 0x17      683M
sr0                     1024M
$

Note the sda device lines - they have proper "FSTYPE  PARTTYPE" translation.

This line
└─sdb1 iso9660 0x17      683M
is contradictory as 0x17 represents "Hidden HPFS/NTFS" elsewhere (fdisk, etc).

jb


