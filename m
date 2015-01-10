Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51588 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751698AbbAJMo1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Jan 2015 07:44:27 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id AEA11206BF
	for <util-linux@vger.kernel.org>; Sat, 10 Jan 2015 07:44:26 -0500 (EST)
Message-Id: <1420893866.3537848.212162497.2B990B0E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 3/4] hwclock: update man page for v2.26 rc
Date: Sat, 10 Jan 2015 13:44:26 +0100
In-Reply-To: <54AE052C.6050202@gmx.com>
References: <54AE031C.30907@gmx.com> <54AE052C.6050202@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Thu, Jan 8, 2015, at 05:18, JWP wrote:
> +.\" 2015-01-07 J William Piggott
> +.\" Authored new section: DATE-TIME CONFIGURATION.
> +.\" Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
> +.\" Errata and drop outdated language.
> +.\" Updates for v2.26

Please don't add such changelog stuff to files -- this is what git is for.

> +.\" Included for troff portability.
> +.\" Continuation line for .TP header.
> +.de TQ
> [...]

Is this really needed?  Is there any chance that this new hwclock
will get installed on a legacy Unix system (instead of on a recent
Linux system with complete man macros)?

> +is a tool for accessing the Hardware Clock.  It can: display the
> +Hardware Clock time; set the Hardware Clock to a specified time; set the
> +Hardware Clock from the System Clock; set the System Clock from the
> +Hardware Clock; compensate for Hardware Clock drift; correct the System
> +Clock timescale; set the kernel's timezone, NTP timescale, and epoch
> +(Alpha only); compare the System and Hardware Clocks; and predict future
> +Hardware Clock values based on its drift rate.

Nice.

> +.

Why all these added dots?  No other man page contains them.

> +The following functions are mutually exclusive, only one can be given at
> +a time. If none are given the default is
> +.BR \-\-show .

s/none are/none is/
because at most one may be given.

> -.B hwclock
> +.B \%hwclock

What does \% do?  Why is it not used fully everywhere where
.B hwclock occurs?

> [...]

Too much text to review.  :|

For such a huge change, it would have been nice to keep the
formatting changes and text changes in separate patches.

Benno

-- 
http://www.fastmail.com - mmm... Fastmail...

