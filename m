Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45129 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756114AbaJXLly (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 07:41:54 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 03DAE20844
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 07:41:53 -0400 (EDT)
Message-Id: <1414150913.842267.182835465.32A1CB8B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: JWP <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <5449BF2E.7040604@gmx.com>
References: <5449BF2E.7040604@gmx.com>
Subject: Re: [PATCH 4/5] hwclock: Fix --date debug messages
Date: Fri, 24 Oct 2014 13:41:53 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Fri, Oct 24, 2014, at 04:53, JWP wrote:
>  	if (debug)
> -		printf(_("response from date command = %s"), date_resp);
> +		printf(_("The response was: %s"), date_resp);
>  	if (strncmp(date_resp, magic, sizeof(magic) - 1) != 0) {
>  		warnx(_("The date command issued by %s returned "
> -				  "unexpected results\n"
> -				  "The command was:\n  %s\n"
> -				  "The response was:\n  %s"),
> -			program_invocation_short_name, date_command, date_resp);
> +			"unexpected results\nThe response was: %s"
> +			"The command was: %s"),
> +		      program_invocation_short_name, date_resp, date_command);

Oh no.  If the user does not use --debug, hwclock will warn that
a command gave an unexpected result and will print the command
but not the actual result.  This is silly.

By the way, the --debug flag is improperly named.  It should actually
be called --verbose, because in all the rest of util-linux debug messages
are never gettextized (using calls to _()).  The use of --debug is not
meant to debug hwclock itself but to debug the user's use of hwclock.
It should therefore be called --verbose.

Benno

-- 
http://www.fastmail.fm - A fast, anti-spam email service.

