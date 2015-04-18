Return-Path: util-linux-owner@vger.kernel.org
Received: from dub004-omc2s15.hotmail.com ([157.55.1.154]:51855 "EHLO
	DUB004-OMC2S15.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751029AbbDRGZm convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 18 Apr 2015 02:25:42 -0400
Message-ID: <DUB119-W4735A75DC3BB7A09F87995B4E20@phx.gbl>
From: Sergey Zolotarev <szx@live.ru>
To: Peter Cordes <peter@cordes.ca>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: RE: Fix partition order killed my hard drive (twice)
Date: Sat, 18 Apr 2015 12:25:41 +0600
In-Reply-To: <20150418034306.GF3933@cordes.ca>
References: <20150413135815.GC3933@cordes.ca>,<DUB119-W317EAA79F1829FA13DAEA6B4E60@phx.gbl>,<20150418034306.GF3933@cordes.ca>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> If you redo the steps that messed it up, does it mess it up again?
> Or, do you know what the steps were and have a copy of the messed up
> table? Without one or the other, it's probably going to be hard to
> debug.

I have a backup.log created by testdisk for the messed up version, would it be sufficient? The steps were

1. fdisk /dev/sda
2. enter expert mode
3. fix partition order
4. write partition table
5. exit

I'll try to re-create the same bug on my first hard drive (already copied everything from there).
 		 	   		  