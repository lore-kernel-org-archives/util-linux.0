Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:41968 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbbCALdv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:33:51 -0500
Received: by wevm14 with SMTP id m14so28201421wev.8
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:33:50 -0800 (PST)
Date: Sun, 1 Mar 2015 11:33:42 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 11/13] rtcwake: improve coding style
In-Reply-To: <1424724011.3617363.231394013.6C35BC75@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011128500.822@iki.fi>
References: <1424616139-638-1-git-send-email-kerolasa@iki.fi> <1424616139-638-12-git-send-email-kerolasa@iki.fi> <1424724011.3617363.231394013.6C35BC75@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, 23 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:42, Sami Kerola wrote:
> > -	/* this process works in RTC time, except when working
> > -	 * with the system clock (which always uses UTC).
> > -	 */
> > +	/* this process works in RTC time, except when working with the
> > +	 * system clock (which always uses UTC). */
> 
> Since this and the other comments ends with a period, it really
> should start with a capital.  When changing the line anyway...

Oopps. I fixed the commits as part of other commit.

https://github.com/kerolasa/lelux-utiliteetit/commit/021378dd2baae75e42014b5e1cc595e8c1ab96bc

And missed the few time/date improvements you mentioned in mail:

Date: Mon, 23 Feb 2015 21:32:34 +0100
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 06/13] rtcwake: add human readable --date timestamp format

Perhaps string improvements can be done later with corrections to last(1) 
as well. If I remember right I copied the messages from last(1) pretty 
much as-is.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
