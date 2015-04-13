Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:62552 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621AbbDMK1t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 06:27:49 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Sergey Zolotarev <szx@live.ru>
Subject: Re: Fix partition order killed my hard drive (twice)
Date: Mon, 13 Apr 2015 12:27:44 +0200
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
In-Reply-To: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Message-Id: <201504131227.45506.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 13 April 2015, Sergey Zolotarev wrote:
> Hello,
>
> Is it possible that fdisk could damage / kill a hard drive after
> using the "Fix partition order" command?

I remember there was such bug in past. Which version are you using?
$ fdisk -V

> It seems that that is 
> exactly what happened to me two times already, with two different
> hard drives.
>
> First time I thought that it was my hard drive's fault as it was
> pretty old and cheap, So I bought a new not-so-cheap one and was
> quite happy with until today, when I used that evil command again!
>
> Both of HDDs seem unrecoverable. When either is plugged BIOS gets
> stuck at initial screen (can't even enter setup). Using a USB adapter
> didn't help either... I'm not an expert in hard drives, but could it
> be the result of a corrupted / bad sector in the place where the
> partition table is stored?

First I would try to boot via rescue CD or similar. 
Then check how the partitiontable looks now (fdisk -l) and try to mout 
partitions manually. If you are missing partitions or if you just can't 
mount them then you may try to repair/recover the partition table.  

cu,
Rudi
