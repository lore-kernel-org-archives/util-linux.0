Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:43374 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753453AbaHYUqw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Aug 2014 16:46:52 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XM1AB-0005ps-2j
	for util-linux@vger.kernel.org; Mon, 25 Aug 2014 22:46:51 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 22:46:51 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 25 Aug 2014 22:46:51 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: lsblk vice fdisk, etc
Date: Mon, 25 Aug 2014 20:46:36 +0000 (UTC)
Message-ID: <loom.20140825T223105-992@post.gmane.org>
References: <loom.20140819T114407-592@post.gmane.org> <loom.20140825T160840-339@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

jb <jb.1234abcd@...> writes:

> ... 
> PTTYPE refers to "dos" ... here I am at a loss; I assume it means partition
> type, so it should be renamed to PARTTYPE to correspond to lsblk display;
> why "dos" ? why for /dev/sda3 only ?

I have to correct myself here.
PTTYPE refers to partition table type, in this case "dos", which is correct.
But the question "why for /dev/sda3 only ?" stands.
Actually, it should not be included in 'blkid' display at all.
According to BLKID(8), only option -p should display this field.
# blkid -p /dev/sda
/dev/sda: PTUUID="3db012b3" PTTYPE="dos" 

jb


