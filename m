Return-Path: <util-linux-ng-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:54178 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965581AbXBOOtq (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 15 Feb 2007 09:49:46 -0500
Date: Thu, 15 Feb 2007 15:49:38 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: Christian Schlotter <schlotter@users.sourceforge.net>,
        util-linux-ng@vger.kernel.org
Subject: Re: [PATCH] cal: Output unaligned with "-3" option and libtermcap
Message-ID: <20070215144938.GI3925@petra.dvoda.cz>
References: <45868535.5030402@users.sourceforge.net> <20070215130303.GG3925@petra.dvoda.cz> <45D460A8.7080409@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <45D460A8.7080409@draigBrady.com>
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 15, 2007 at 01:31:20PM +0000, Pádraig Brady wrote:
> Karel Zak wrote:
> >  Hi Christian,
> > 
> >  some ideas from your patch are really good, but the rest is not so
> >  perfect after all.
> 
> Sorry I missed the original mail/patch.
> Can you send again?

 Done.

> For reference I did the "highlight today" functionality
> in cal a couple of years back which has alignment issues,
> and have been trying to get the fix in since then:
> http://www.pixelbeat.org/patches/cal-2.12q-highlight.diff

 This patch is already in my mail box ;-)

 Well, Christian's patch is more about code refactoring rather than
 about simple bug fix only. (It might good idea to cleanup the code.)

> Incidentally I also fixed the weekday alignment for
> multibyte locales in the changes I did a couple of years ago

 There is also other multibyte fix (by RH):

     http://people.redhat.com/kzak/util-linux/util-linux-2.12p-cal-wide.patch

 My plan is write some regression tests for the "cal" before playing
 with these patches.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
