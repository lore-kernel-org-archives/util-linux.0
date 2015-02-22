Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48834 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752021AbbBVVDH (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 16:03:07 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id A3C1020551
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 16:03:06 -0500 (EST)
Message-Id: <1424638987.3185993.230906669.39E662B2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1424616207-747-19-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
 <1424616207-747-19-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 18/31] more: split run time help screen to multiple
 translatable lines
Date: Sun, 22 Feb 2015 22:03:07 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:43, Sami Kerola wrote:
> -	fputs(_("\n"
> -		"Most commands optionally preceded by integer argument k.  "
> -		"Defaults in brackets.\n"
> -		"Star (*) indicates argument becomes new default.\n"), stdout);
> [...]
> +	fputs(  "\n", stdout);
> +	fputs(_("Most commands optionally preceded by integer argument k.\n"), stdout);
> +	fputs(_("Defaults in brackets.\n"), stdout);
> +	fputs(_("Star (*) indicates argument becomes new default.\n"), stdout);

These three sentences are somewhat interrelated, so it is better to keep
them in a single translatable string, as it was.  It would have been nice
to take out the leading newline, but it's not worth invalidating all the
existing translations.  So I suggest keeping the first fputs() unchanged.
Splitting up all the other lines is fine.

> +	fputs(_("q or Q or <interrupt>   Exit from more\n"), stdout);

Interrupt is always ctrl-C, no?  If so, then better use that, as
it matches the representation of the other ctrl combos.

> +	fputs(_("/<regular expression>   Search for kth occurrence of regular expression [1]\n"), stdout);

In order to be able to reduce the amount of whitespace between
key name and explanation in the whole help screen, I would
suggest replacing <regular expression> with <regexp>, which
is a very common abbreviation.

> +	fputs(_("n                       Search for kth occurrence of last r.e [1]\n"), stdout);

s/r.e/regexp/

> +	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);

Hmm...  Are there certain circumstances where ! doesn't work and
:! is needed?  If not, I would suggest dropping the second form,
to reduce the space between keys and explanations.  A help screen
doesn't have to tell everything, that's what the man page is for.

> +	fputs(_("ctrl-L                  Redraw screen\n"), stdout);

For all key explanations: start them with a lowercase letter, as they
don't end in a period either.

Benno

-- 
http://www.fastmail.com - Choose from over 50 domains or use your own

