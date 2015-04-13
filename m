Return-Path: util-linux-owner@vger.kernel.org
Received: from dub004-omc2s6.hotmail.com ([157.55.1.145]:58776 "EHLO
	DUB004-OMC2S6.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbbDMKQK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 13 Apr 2015 06:16:10 -0400
Message-ID: <DUB119-W10D0E142F9CF92AA8A3436B4E70@phx.gbl>
From: Sergey Zolotarev <szx@live.ru>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Fix partition order killed my hard drive (twice)
Date: Mon, 13 Apr 2015 16:11:05 +0600
Content-Type: text/plain; charset="koi8-r"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Is it possible that fdisk could damage / kill a hard drive after using the "Fix partition order" command? It seems that that is exactly what happened to me two times already, with two different hard drives.š

First time I thought that it was my hard drive's fault as it was pretty old and cheap, So I bought a new not-so-cheap one and was quite happy with until today, when I used that evil command again!

Both of HDDs seem unrecoverable. When either is plugged BIOS gets stuck at initial screen (can't even enter setup). Using a USB adapter didn't help either... I'm not an expert in hard drives, but could it be the result of a corrupted / bad sector in the place where the partition table is stored? 		 	   		  