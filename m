Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:38088 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752354AbbBJO74 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 09:59:56 -0500
Received: from [69.22.67.43] (helo=[192.168.0.11])
	by elasmtp-junco.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1YLCI7-0003L5-AU
	for util-linux@vger.kernel.org; Tue, 10 Feb 2015 09:59:55 -0500
Message-ID: <54DA1CEA.1000802@earthlink.net>
Date: Tue, 10 Feb 2015 09:59:54 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk -l hits floppy drive
References: <54D5126A.3020308@earthlink.net> <54D8C81C.30804@ubuntu.com>
In-Reply-To: <54D8C81C.30804@ubuntu.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Phillip Susi composed on 2015-02-09 09:45 (UTC-0500):

> On 2/6/2015 2:13 PM, Felix Miata wrote:

>> util-linux-2.25.1-5.2.x86_64 on openSUSE kernels 3.16.6 and 3.18.3

>> fdisk -l is causing the floppy drive to get hit, which reflects the
>> 4 kernel messages onto the tty running fdisk. Is this expected or
>> intended?

> I'm guessing you don't actually have a floppy, in which case, your
> bios is misconfigured to think you do and you should fix that.

You guessed wrong:
https://bugzilla.opensuse.org/show_bug.cgi?id=773058
https://bugzilla.opensuse.org/show_bug.cgi?id=916773
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
