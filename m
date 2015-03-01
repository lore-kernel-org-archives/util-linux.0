Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:43525 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbCALAH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 06:00:07 -0500
Received: by wesu56 with SMTP id u56so28108194wes.10
        for <util-linux@vger.kernel.org>; Sun, 01 Mar 2015 03:00:05 -0800 (PST)
Date: Sun, 1 Mar 2015 10:59:51 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 18/31] more: split run time help screen to multiple
 translatable lines
In-Reply-To: <1424638987.3185993.230906669.39E662B2@webmail.messagingengine.com>
Message-ID: <alpine.LNX.2.03.1503011058110.822@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi> <1424616207-747-19-git-send-email-kerolasa@iki.fi> <1424638987.3185993.230906669.39E662B2@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, 22 Feb 2015, Benno Schulenberg wrote:

> On Sun, Feb 22, 2015, at 15:43, Sami Kerola wrote:
> > -	fputs(_("\n"
> > -		"Most commands optionally preceded by integer argument k.  "
> > -		"Defaults in brackets.\n"
> > -		"Star (*) indicates argument becomes new default.\n"), stdout);
> > [...]
> > +	fputs(  "\n", stdout);
> > +	fputs(_("Most commands optionally preceded by integer argument k.\n"), stdout);
> > +	fputs(_("Defaults in brackets.\n"), stdout);
> > +	fputs(_("Star (*) indicates argument becomes new default.\n"), stdout);
> 
> These three sentences are somewhat interrelated, so it is better to keep
> them in a single translatable string, as it was.  It would have been nice
> to take out the leading newline, but it's not worth invalidating all the
> existing translations.  So I suggest keeping the first fputs() unchanged.
> Splitting up all the other lines is fine.
> 
> > +	fputs(_("q or Q or <interrupt>   Exit from more\n"), stdout);
> 
> Interrupt is always ctrl-C, no?  If so, then better use that, as
> it matches the representation of the other ctrl combos.
> 
> > +	fputs(_("/<regular expression>   Search for kth occurrence of regular expression [1]\n"), stdout);
> 
> In order to be able to reduce the amount of whitespace between
> key name and explanation in the whole help screen, I would
> suggest replacing <regular expression> with <regexp>, which
> is a very common abbreviation.
> 
> > +	fputs(_("n                       Search for kth occurrence of last r.e [1]\n"), stdout);
> 
> s/r.e/regexp/
> 
> > +	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);
> 
> Hmm...  Are there certain circumstances where ! doesn't work and
> :! is needed?  If not, I would suggest dropping the second form,
> to reduce the space between keys and explanations.  A help screen
> doesn't have to tell everything, that's what the man page is for.
> 
> > +	fputs(_("ctrl-L                  Redraw screen\n"), stdout);
> 
> For all key explanations: start them with a lowercase letter, as they
> don't end in a period either.

Thanks Benno,

Here is updated version of the change.

https://github.com/kerolasa/lelux-utiliteetit/commit/613c30239c6a284914fb70f7f7e96c44896f6414

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
