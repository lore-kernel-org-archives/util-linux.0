Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:52822 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753990AbbBFTh5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 6 Feb 2015 14:37:57 -0500
Received: from [69.22.67.43] (helo=[192.168.0.11])
	by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1YJoLb-0004Eu-22
	for util-linux@vger.kernel.org; Fri, 06 Feb 2015 14:13:47 -0500
Message-ID: <54D5126A.3020308@earthlink.net>
Date: Fri, 06 Feb 2015 14:13:46 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk -l hits floppy drive
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

util-linux-2.25.1-5.2.x86_64 on openSUSE
kernels 3.16.6 and 3.18.3

fdisk -l is causing the floppy drive to get hit, which reflects the 4 kernel
messages onto the tty running fdisk. Is this expected or intended?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
