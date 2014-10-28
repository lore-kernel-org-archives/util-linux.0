Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:41776 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756754AbaJ1Fxd (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 01:53:33 -0400
Message-ID: <544F2F5A.5090608@earthlink.net>
Date: Tue, 28 Oct 2014 01:53:30 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F13CD.8000502@earthlink.net> <544F1BF2.3040203@gmail.com>
In-Reply-To: <544F1BF2.3040203@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

dE composed on 2014-10-28 10:00 (UTC+0530):

> But I also think this fdisk 2048 behavior should be removed now or at 
> least provide a switch for the same and document this in the man page.

There is a switch:

	-c , --compatibility[=mode]

The man page does fail to explain what dos mode actually means. Google can
take up that slack for those interested, while the man page ought to be better.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
