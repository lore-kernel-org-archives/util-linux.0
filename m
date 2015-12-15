Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36627 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754121AbbLOTkF (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Dec 2015 14:40:05 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 399A021847
	for <util-linux@vger.kernel.org>; Tue, 15 Dec 2015 14:40:05 -0500 (EST)
Message-Id: <1450208404.1111354.468335457.59637230@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Sami Kerola <kerolasa@iki.fi>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
Subject: Re: [PATCH 0/8] pull: bash-completion updates
Date: Tue, 15 Dec 2015 20:40:04 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hello Sami,

On Mon, Dec 14, 2015, at 22:54, Sami Kerola wrote:
> The pull adds new function, print_long_opts(), to c.h and
> it does what one might expect a function of such name do.

Hm.  You want to add --print-long-opts to almost all commands?
And burden all --help outputs with listing it?  But... is this
option useful for users?  Or really only for bash-completion?
If the latter, wouldn't it be better to leave it undocumented?

If the option is added, it had better be called --show-long-options.
Printing is to paper, and long options shouldn't abbreviate any of
its constituent words.

Oh, and if added, should it be added to all of the manpages too?

Benno

-- 
http://www.fastmail.com - Email service worth paying for. Try it for free

