Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mail.station1.mxsweep.com ([212.147.136.149]:4456 "EHLO
	SCMF01.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965581AbXBOPFn (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 10:05:43 -0500
Received: from SCMF01.mxsweep.com (127.0.0.1) by SCMF01.mxsweep.com (MlfMTA v3.2r1b3) id hqhriu0171sm for <util-linux-ng@vger.kernel.org>; Thu, 15 Feb 2007 15:07:16 +0000 (envelope-from <P@draigBrady.com>)
Message-ID: <45D47657.70006@draigBrady.com>
Date: Thu, 15 Feb 2007 15:03:51 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Christian Schlotter <schlotter@users.sourceforge.net>,
        util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
References: <45868535.5030402@users.sourceforge.net> <20070215130303.GG3925@petra.dvoda.cz> <45D460A8.7080409@draigBrady.com> <20070215144938.GI3925@petra.dvoda.cz>
In-Reply-To: <20070215144938.GI3925@petra.dvoda.cz>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Feb 15, 2007 at 01:31:20PM +0000, Pádraig Brady wrote:
>> Karel Zak wrote:
>>>  Hi Christian,
>>>
>>>  some ideas from your patch are really good, but the rest is not so
>>>  perfect after all.
>> Sorry I missed the original mail/patch.
>> Can you send again?
> 
>  Done.
> 
>> For reference I did the "highlight today" functionality
>> in cal a couple of years back which has alignment issues,
>> and have been trying to get the fix in since then:
>> http://www.pixelbeat.org/patches/cal-2.12q-highlight.diff
> 
>  This patch is already in my mail box ;-)
> 
>  Well, Christian's patch is more about code refactoring rather than
>  about simple bug fix only. (It might good idea to cleanup the code.)

Yes the code can definitely be refactored.
I was wary of changing format though when I looked at it,
in case I broke scripts depending on whitespace etc.

> 
>> Incidentally I also fixed the weekday alignment for
>> multibyte locales in the changes I did a couple of years ago
> 
>  There is also other multibyte fix (by RH):
> 
>      http://people.redhat.com/kzak/util-linux/util-linux-2.12p-cal-wide.patch
> 
>  My plan is write some regression tests for the "cal" before playing
>  with these patches.

I used the following 2 scripts to test my changes:

[ ! -e "./cal" ] && CAL=cal || CAL=./cal
LANG=ga_IE.utf8 $CAL -3 11 2004 #truncation (first month)
LANG=zh_HK.utf8 $CAL -3         #multibyte centering
$CAL | cat  #no highlight
TERM= $CAL  #no highlight
TERM=vt100 $CAL  #highlight, with characters to be stripped by putp
$CAL -y | head | tr ' ' . #3 spaces between cols?
$CAL -3 | tr ' ' .        #2 spaces between cols and trailing spaces?


locale -a |
grep utf8 |
uniq -w2 |
while read LANG; do
    cal -3 |
    head -2 | tail -1;
done


Pádraig
