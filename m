Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:56239 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933469AbaHYVSv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Aug 2014 17:18:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XM1f8-0000cF-2a
	for util-linux@vger.kernel.org; Mon, 25 Aug 2014 23:18:50 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 23:18:50 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 23:18:50 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: lsblk vice fdisk, etc
Date: Mon, 25 Aug 2014 21:18:34 +0000 (UTC)
Message-ID: <loom.20140825T225526-531@post.gmane.org>
References: <loom.20140819T114407-592@post.gmane.org> <loom.20140825T160840-339@post.gmane.org> <loom.20140825T223105-992@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

jb <jb.1234abcd@...> writes:

> ... 
> But the question "why for /dev/sda3 only ?" stands.
> Actually, it should not be included in 'blkid' display at all.
> According to BLKID(8), only option -p should display this field.
> # blkid -p /dev/sda
> /dev/sda: PTUUID="3db012b3" PTTYPE="dos" 

This should be further qualified.

# blkid /dev/sda
/dev/sda: PTUUID="3db012b3" PTTYPE="dos" 
# blkid -p /dev/sda
/dev/sda: PTUUID="3db012b3" PTTYPE="dos" 

and so I think that 'blkid' entry I referred previously to (with that
PTTYPE="dos" in /dev/sda3 row, believed to be erroneously displayed there),
should have the "/dev/sda: ..." line displayed at the top:
# blkid
/dev/sda: PTUUID="3db012b3" PTTYPE="dos"
/dev/sda1: UUID="fb838405-607c-4723-9355-47ccbf1eb273" TYPE="ext4"
PARTUUID="3db012b3-01" 
...

because BLKID(8) says:
"       When  device is specified, tokens from only this device are
        displayed.
        It is possible to specify multiple device  arguments  on  the
        command line.   If none is given, all devices which appear in
        /proc/partitions are shown, if they are recognized."

$ cat /proc/partitions 
major minor  #blocks  name

  11        0    1048575 sr0
   8        0   39070080 sda
   8        1   17825792 sda1
   8        2    4647936 sda2
   8        3   14076928 sda3
   8        4          1 sda4
   8        5    2518368 sda5

jb


