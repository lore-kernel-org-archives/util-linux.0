Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:44087 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbbCALLe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:11:34 -0500
Received: by wggx12 with SMTP id x12so28208388wgg.11
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:11:33 -0800 (PST)
Date: Sun, 1 Mar 2015 11:11:31 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 02/16] flock: add --verbose option
In-Reply-To: <1424627071.3149397.230857529.0E42F353@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011109100.822@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi> <1424616106-580-3-git-send-email-kerolasa@iki.fi> <1424627071.3149397.230857529.0E42F353@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 22 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:41, Sami Kerola wrote:
> > +.B \-\-verbose
> > +Tell why lock could not be got, and when it can be how long did it take
> > +to acquire the lock.
> 
> Better: "Report how long it took to acquire the lock, or why the lock
> could not be obtained."
> 
> > -		{"version", no_argument, NULL, 'V'},
> > +		{"version", required_argument, NULL, 'V'},
> 
> Huh?

Thanks Benno,

Wording is updated, and --version option argument reuirement reverted. To 
be honest I have no idea how that error slipped to change, excellent you 
noticed it.

https://github.com/kerolasa/lelux-utiliteetit/commit/f1cb67206af5e6b46ba10b482d3c315c484082d6

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
