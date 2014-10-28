Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66]:58536
	"EHLO elasmtp-spurfowl.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758135AbaJ1HtB (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 03:49:01 -0400
Received: from [24.144.107.77] (helo=[192.168.0.11])
	by elasmtp-spurfowl.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1Xj1WW-0005XE-Pi
	for util-linux@vger.kernel.org; Tue, 28 Oct 2014 03:49:00 -0400
Message-ID: <544F4A6C.808@earthlink.net>
Date: Tue, 28 Oct 2014 03:49:00 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com> <544E97ED.7040406@earthlink.net> <544F0C88.1080807@gmail.com> <544F13CD.8000502@earthlink.net> <544F1BF2.3040203@gmail.com> <544F2F5A.5090608@earthlink.net> <20141028073208.GH10134@x2.net.home>
In-Reply-To: <20141028073208.GH10134@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak composed on 2014-10-28 08:32 (UTC+0100):

>> The man page does fail to explain what dos mode actually means.

>  - start at sector 63
>  - care about CHS in partition table
>  - extra checks for alignment to be compatible with CHS addressing

Why isn't that in the man page? People trying to use a program aren't always
able to Google an explanation of its man page minimalism.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
