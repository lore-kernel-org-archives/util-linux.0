Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-curtail.atl.sa.earthlink.net ([209.86.89.64]:49833 "EHLO
	elasmtp-curtail.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760713AbaGPRtH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Jul 2014 13:49:07 -0400
Received: from [24.144.107.77] (helo=[192.168.0.11])
	by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1X7TBS-0007eO-NB
	for util-linux@vger.kernel.org; Wed, 16 Jul 2014 13:40:02 -0400
Message-ID: <53C6B8F1.7000607@earthlink.net>
Date: Wed, 16 Jul 2014 13:40:01 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: some comments about the new cfdisk
References: <1405350470.21924.141447857.78268FC5@webmail.messagingengine.com> <20140715105920.GS30288@x2.net.home> <1405509773.32592.142240757.286353E5@webmail.messagingengine.com>
In-Reply-To: <1405509773.32592.142240757.286353E5@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-07-16 13:22 (GMT+0200) Benno Schulenberg composed:

> Karel Zak wrote:

>> It would be possible to add some extra optimization for MBR to
>> enlarge/reduce the extended partition if there is a free space behind
>> the partition and no possibility to create another primary partition.
>> Not sure... I'll think about it.

> Don't bother for now.  Somehow the current way feels more
> precise.

Maybe I'm missing something in this discussion, but...

I find it inexplicably confusing that any partitioning tool would ever 
describe an extended to exclude any freespace contiguous to any logical 
partition, regardless how actually defined in the tables. Making creation of 
a logical in freespace adjoining any existing logical take more than one step 
makes no sense.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
