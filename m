Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:32863 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616AbaJ0TSZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 27 Oct 2014 15:18:25 -0400
Message-ID: <544E97ED.7040406@earthlink.net>
Date: Mon, 27 Oct 2014 15:07:25 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: dE <de.techno@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
References: <544E923E.6050406@gmail.com>
In-Reply-To: <544E923E.6050406@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

dE composed on 2014-10-28 00:13 (UTC+0530):

> I was learning about GPT when I noticed this behavior of fdisk which I 
> never though about before.

> Regardless of the partition table, fdisk always starts the first 
> partition at 2048. In reality, the maximum size required by the gap 
> between MBR and the 1st partition is a single sector, which's used by 
> GRUB 1.5. GPT doesn't need this space at all.

> Then extended partitions too have a gap of 2048 sectors.

> Why this behavior?

http://www.seagate.com/tech-insights/advanced-format-4k-sector-hard-drives-master-ti/
may provide some insight WRT performance issues ensuing from other start
sector selections.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
