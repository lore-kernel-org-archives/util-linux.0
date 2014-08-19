Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f49.google.com ([209.85.216.49]:49368 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaHSUFR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Aug 2014 16:05:17 -0400
Received: by mail-qa0-f49.google.com with SMTP id dc16so6139089qab.36
        for <util-linux@vger.kernel.org>; Tue, 19 Aug 2014 13:05:16 -0700 (PDT)
Date: Tue, 19 Aug 2014 16:05:11 -0400
From: Dave Reisner <d@falconindy.com>
To: jb <jb.1234abcd@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: lsblk vice fdisk, etc
Message-ID: <20140819200511.GA511@rampage>
References: <loom.20140819T114407-592@post.gmane.org>
 <loom.20140819T201609-326@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <loom.20140819T201609-326@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 19, 2014 at 06:21:06PM +0000, jb wrote:
> jb <jb.1234abcd@...> writes:
> 
> > ...
> > The line
> > └─sdb1 iso9660 Test
> > should be reconciled with what fdisk, etc show.
> > ...
> 
> The following display demonstrates it better.
> 
> $ lsblk -o name,fstype,parttype,size
> NAME   FSTYPE  PARTTYPE  SIZE
> sda                     37.3G
> ├─sda1 ext4    0x83       20G
> ├─sda2 swap    0x82      1.5G
> ├─sda3 ext4    0x83     13.4G
> └─sda5 ext4    0x83      2.4G
> sdb    iso9660           7.3G
> └─sdb1 iso9660 0x17      683M
> sr0                     1024M
> $
> 
> Note the sda device lines - they have proper "FSTYPE  PARTTYPE" translation.
> 
> This line
> └─sdb1 iso9660 0x17      683M
> is contradictory as 0x17 represents "Hidden HPFS/NTFS" elsewhere (fdisk, etc).

Why do you think this is contradictory? The filesystem type and
partition type are two disparate types.

d
