Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.aswsp.com ([193.34.35.150]:40239 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbbCXNyj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Mar 2015 09:54:39 -0400
Message-ID: <55116CA9.3040402@parrot.com>
Date: Tue, 24 Mar 2015 14:54:49 +0100
From: Ronan CHAUVIN <ronan.chauvin@parrot.com>
MIME-Version: 1.0
To: "Dale R. Worley" <worley@alum.mit.edu>
CC: <util-linux@vger.kernel.org>, matthieu CASTET <matthieu.castet@parrot.com>,
        Alexandre Dilly <alexandre.dilly@parrot.com>
Subject: Re: [libfdisk]: gpt_write_disklabel function robustness to sudden
 power off
References: <87384vyt4y.fsf@hobgoblin.ariadne.com>
In-Reply-To: <87384vyt4y.fsf@hobgoblin.ariadne.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Thank you for your answer.

If we are not resizing/adding but just renaming a partition, we want to 
be sure that at least the primary or the backup GPT header/GPT partition 
array will not be corrupted in the case of a sudden power-off. If the 
write order is not guaranty, then the primary and backup GPT headers can 
be written to the emmc without the corresponding partition array and the 
system will not be consistent.

For example, if we have this effective write operation order on the disk:

1) backup GPT header
2) primary GPT header
--> power-off <--
3) primary partition tables
4) backup partition tables
5) protective MBR

then, CRC of partition array present in both GPT headers will be incorrect.

On 03/24/2015 04:24 AM, Dale R. Worley wrote:
> But it seems to me that there is
> no such consistent state -- what condition would you want that
> information to be in?  The old information is irretrevably lost during
> the operation;

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

