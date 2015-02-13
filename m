Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54551 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752153AbbBMJWK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Feb 2015 04:22:10 -0500
Date: Fri, 13 Feb 2015 10:21:31 +0100
From: Karel Zak <kzak@redhat.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>, mrmazda@earthlink.net,
        util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150213092131.GM32318@ws.net.home>
References: <54DC88BF.5040702@draigBrady.com>
 <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h9uqv6lv.fsf@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 12, 2015 at 10:21:48PM -0500, Dale R. Worley wrote:
> I don't particularly like colorization.  But technically, it seems to me
> that what is needed is a systematic way for the user to indicate his
> colorization preferences to *all* utilities.  And a corresponding way
> for the system to provide defaults for those user preferences.
>
> 
> Only when there is a systematic framework for colorization will all the
> programs allow colorizing to be configured.

It would be possible to create a shared library from our lib/colors.c
to support terminal-colors.d/... :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
