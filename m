Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41170 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061AbaIOM5X (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Sep 2014 08:57:23 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by gateway2.nyi.internal (Postfix) with ESMTP id A782920B9C
	for <util-linux@vger.kernel.org>; Mon, 15 Sep 2014 08:57:22 -0400 (EDT)
Message-Id: <1410785842.2933378.167623997.3BD2AF1B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Marcin Kocur <marcin2006@gmail.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>,
        Jakub Bogusz <qboosh@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5416D9FC.50204@gmail.com>
References: <5416D9FC.50204@gmail.com>
Subject: Re: cfdisk 2.25 doesn't write partition table when using localized
 version
Date: Mon, 15 Sep 2014 14:57:22 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Marcin,

On Mon, Sep 15, 2014, at 14:22, Marcin Kocur wrote:
> I'm using LANG=pl_PL.UTF-8, my cfdisk is translated into Polish. When 
> trying to write the partition table, cfdisk tells me that the the 
> partition table wasn't written, no matter if I type yes in English or 
> "tak" in Polish.

It was a mistake in cfdisk and has been fixed in git:
https://github.com/karelzak/util-linux/commit/ce3134dfdd3a9feb614050cbf742cec4c97e984b
https://github.com/karelzak/util-linux/commit/59af21c3f294b9fdec62914568de0455cf884623

It should work correctly in util-linux-2.25.1.

> I have briefly checked the pl.po file and it seems to 
> be fine. When I set export LANG=en_US, then I was able to save the 
> partition table on the device.

Benno

-- 
http://www.fastmail.fm - A fast, anti-spam email service.

