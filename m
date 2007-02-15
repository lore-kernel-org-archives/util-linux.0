Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mail.station1.mxsweep.com ([212.147.136.149]:4563 "EHLO
	SCMF01.mxsweep.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965967AbXBOPGM (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 10:06:12 -0500
Received: from SCMF01.mxsweep.com (127.0.0.1) by SCMF01.mxsweep.com (MlfMTA v3.2r1b3) id hqhrkm0171so for <util-linux-ng@vger.kernel.org>; Thu, 15 Feb 2007 15:07:54 +0000 (envelope-from <P@draigBrady.com>)
Message-ID: <45D4767E.6060206@draigBrady.com>
Date: Thu, 15 Feb 2007 15:04:30 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: Christian Schlotter <schlotter@users.sourceforge.net>,
        util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
References: <45868535.5030402@users.sourceforge.net> <20070215130303.GG3925@petra.dvoda.cz> <45D460A8.7080409@draigBrady.com> <20070215141835.GH3925@petra.dvoda.cz>
In-Reply-To: <20070215141835.GH3925@petra.dvoda.cz>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> On Thu, Feb 15, 2007 at 01:31:20PM +0000, Pádraig Brady wrote:
>  
>> Sorry I missed the original mail/patch.
>> Can you send again?
> 
> There is a small display error when using cal from util-linux-2.13-pre7
> with the command line "cal -3m".  On Sep 27th 2006 it produced the
> following output (Sep 27th is highlighted):
> 
>     August 2006          September 2006         October 2006
> Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su  Mo Tu We Th Fr Sa Su
>     1  2  3  4  5  6               1  2  3                     1
>  7  8  9 10 11 12 13   4  5  6  7  8  9 10   2  3  4  5  6  7  8
> 14 15 16 17 18 19 20  11 12 13 14 15 16 17   9 10 11 12 13 14 15
> 21 22 23 24 25 26 27  18 19 20 21 22 23 24  16 17 18 19 20 21 22
> 28 29 30 31           25 26 27 28 29 30  23 24 25 26 27 28 29
>                                             30 31
> 
> As one can see, the second but last row of October is misaligned because
> the characters used for highlighting are not taken into account when
> aligning the last line of September.

Yes, that is exactly the issue my patch fixes.

Pádraig.
