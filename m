Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.aswsp.com ([193.34.35.150]:40241 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413AbbCTKRK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 20 Mar 2015 06:17:10 -0400
Message-ID: <550BF3A9.8080508@parrot.com>
Date: Fri, 20 Mar 2015 11:17:13 +0100
From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
MIME-Version: 1.0
To: <util-linux@vger.kernel.org>
CC: matthieu CASTET <matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: [libfdisk]: gpt_write_disklabel function robustness to sudden power
 off
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello everyone,

I have a question regarding the fdisk library (libfdisk) provided in the 
2.26 version of util-linux. I use it to create a MBR/GPT partition 
scheme on a eMMC memory. I also use the partition renaming mechanism to 
switch from a normal boot to an update boot (the bootloader compares 
partitions names to choose the one to boot on).

I was wondering if the gpt_write_disklabel function was robust to sudden 
power-off. In the source code, the writing procedure is as follow (UEFI 
requires writing in this specific order):

1) backup partition tables
2) backup GPT header
3) primary partition tables
4) primary GPT header
5) protective MBR

and uses the standard linux write function with a file descriptor. Is 
the writing order guaranty as operation is not synchronous ? I know that 
the linux io scheduler can "optimize" writing operations order. This can 
introduce an issue if only the primary and backup headers are written 
but not the partition tables.

Thank you,

-- 
Ronan CHAUVIN
Embedded Software Engineer
ASIC team
--------------------------------
Parrot
174, quai de Jemmapes
75010 Paris  France
--------------------------------
www.parrot.com

