Return-Path: util-linux-owner@vger.kernel.org
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:39235 "EHLO
	resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751699AbbBMDVw (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Feb 2015 22:21:52 -0500
From: worley@alum.mit.edu (Dale R. Worley)
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
Cc: mrmazda@earthlink.net, util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
In-Reply-To: <54DC88BF.5040702@draigBrady.com> (P@draigBrady.com)
Date: Thu, 12 Feb 2015 22:21:48 -0500
Message-ID: <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

<P@draigBrady.com> writes:
> I agree completely. color is useful but one has to be very careful
> in how it's used. ls --color for example is too aggressive IMHO,
> and I adjust to highlight rather than color with:
>   http://www.pixelbeat.org/scripts/l
> I've been pusing back upstream against adding new color combinations.

I don't particularly like colorization.  But technically, it seems to me
that what is needed is a systematic way for the user to indicate his
colorization preferences to *all* utilities.  And a corresponding way
for the system to provide defaults for those user preferences.

Only when there is a systematic framework for colorization will all the
programs allow colorizing to be configured.

Dale
