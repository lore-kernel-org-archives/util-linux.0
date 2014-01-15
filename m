Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-dupuy.atl.sa.earthlink.net ([209.86.89.62]:51516 "EHLO
	elasmtp-dupuy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725AbaAOOOc (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jan 2014 09:14:32 -0500
Received: from [24.144.107.66] (helo=[192.168.0.11])
	by elasmtp-dupuy.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1W3REm-0001vt-63
	for util-linux@vger.kernel.org; Wed, 15 Jan 2014 09:14:32 -0500
Message-ID: <52D697C6.9000304@earthlink.net>
Date: Wed, 15 Jan 2014 09:14:30 -0500
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: global fdisk colors disable
References: <52D62F0C.9060308@earthlink.net> <20140115082708.GH12700@x2.net.home> <52D6552B.6040704@draigBrady.com>
In-Reply-To: <52D6552B.6040704@draigBrady.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-01-15 09:30 (GMT) Pádraig Brady composed:

> I think the current mechanism used is best.

What mechanism are you referring to, needing an override switch on every 
invocation on an alien system?

> I.E. default to showing colors when possible but give an option to disable.

$SUBJECT Keyword: global.

> Global env vars come with their own disadvantages.

+1

> However I will say that one has to be careful when using colors,

Exactly.

> and the use in fdisk seems a bit redundant.

I think orthogonal is the better word than redundant.

> I.E. colors are useful
> to distinguish things, like the portion of a match in grep or
> the type of a file in ls. I'm not sure the items distinguished
> in fdisk non obvious and worth the hassle of worrying about color.

Indeed.
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

  Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
