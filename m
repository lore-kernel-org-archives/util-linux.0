Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58240 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752027AbbBVVHn (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Feb 2015 16:07:43 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7A73320185
	for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 16:07:42 -0500 (EST)
Message-Id: <1424639262.3186882.230911425.0FF04135@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 19/31] more: tell in run time help what the 'v' will execute
 as editor
Date: Sun, 22 Feb 2015 22:07:42 +0100
In-Reply-To: <1424616207-747-20-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
 <1424616207-747-20-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Sun, Feb 22, 2015, at 15:43, Sami Kerola wrote:
> -	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);
> -	fputs(_("v                       Start up /usr/bin/vi at current line\n"), stdout);
> +	fputs(_("!<cmd> or :!<cmd>       Execute <cmd> in a subshell\n"), stdout);	fprintf(stdout, _(
> +		"v                       Start up '%s' at current line\n"), find_editor());

Forgot a newline after the semicolon before the fprinf()?

Benno

-- 
http://www.fastmail.com - Access your email from home and the web

