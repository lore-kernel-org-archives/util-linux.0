Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39780 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbbCALTq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:19:46 -0500
Received: by wggx12 with SMTP id x12so28243402wgg.6
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:19:45 -0800 (PST)
Date: Sun, 1 Mar 2015 11:19:43 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 19/31] more: tell in run time help what the 'v' will
 execute as editor
In-Reply-To: <1424639262.3186882.230911425.0FF04135@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011111420.822@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi> <1424616207-747-20-git-send-email-kerolasa@iki.fi> <1424639262.3186882.230911425.0FF04135@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 22 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:43, Sami Kerola wrote:
> > -	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);
> > -	fputs(_("v                       Start up /usr/bin/vi at current line\n"), stdout);
> > +	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);	fprintf(stdout, _(
> > +		"v                       Start up '%s' at current line\n"), find_editor());
> 
> Forgot a newline after the semicolon before the fprinf()?

Thanks Benno,

I tried to make print out block to be continuous, but that broke style as 
you pointed out. Updated version tries to combine style and overall print 
out block readability - while still taking tiny indentation liberties.

https://github.com/kerolasa/lelux-utiliteetit/commit/1e5b8bd88200bc0c7454030b99ad91482131f3a9

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
