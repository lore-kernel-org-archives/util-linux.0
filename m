Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:46247 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbbBXWoS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 Feb 2015 17:44:18 -0500
Message-ID: <54ECFEC0.3050702@worldbroken.com>
Date: Tue, 24 Feb 2015 17:44:16 -0500
From: Bill Pemberton <wfp5p@worldbroken.com>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/8] fix spelling/typos in man pages
References: <1424798123-11044-1-git-send-email-wfp5p@worldbroken.com> <1424812410.4082705.231939245.08843DF4@webmail.messagingengine.com>
In-Reply-To: <1424812410.4082705.231939245.08843DF4@webmail.messagingengine.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 02/24/2015 04:13 PM, Benno Schulenberg wrote:
>
> On Tue, Feb 24, 2015, at 18:15, wfp5p@worldbroken.com wrote:
>>    runuser.1: fix spelling implemenation -> implementation
>>    scriptreplay.1: fix spelling overide -> override
>>    unshare.1: fix spelling permamently -> permanently
>>    last.1: fix spelling preferrable -> preferable
>>    lslogins.1: fix spelling priviliges -> privileges
>>    hwclock.8.in: fix spelling transfered -> transferred
>>    prlimit.1: fix typo umlimited -> unlimited
>>    agetty.8: fix typo unnsupported -> unsupported
>
> It would be better to do this in a single patch instead, with subject:
>
> docs: fix some spellos/typos in man pages
>
> And then put the above eight lines in the commit message.
>

Ok, I'm used to 1 patch 1 fix.  While they're all spelling/typos they're 
not the same word/typo.

But obviously it's trivial for me to squash them into 1 commit and 
resend if that will make folks happy.

-- 
Bill


