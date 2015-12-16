Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbLPLPd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Dec 2015 06:15:33 -0500
Date: Wed, 16 Dec 2015 12:15:30 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Sami Kerola <kerolasa@iki.fi>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/8] pull: bash-completion updates
Message-ID: <20151216111530.GA13224@ws.net.home>
References: <1450130093-12108-1-git-send-email-kerolasa@iki.fi>
 <1450208404.1111354.468335457.59637230@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450208404.1111354.468335457.59637230@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 15, 2015 at 08:40:04PM +0100, Benno Schulenberg wrote:
> On Mon, Dec 14, 2015, at 22:54, Sami Kerola wrote:
> > The pull adds new function, print_long_opts(), to c.h and
> > it does what one might expect a function of such name do.
> 
> Hm.  You want to add --print-long-opts to almost all commands?

It seems so, and I'm really not sure with this solution.

> And burden all --help outputs with listing it?  But... is this
> option useful for users?  Or really only for bash-completion?

It means that always when I press <tab> on command line then the util is
executed with --print-long-opts. It seems expensive.

>From my point of view it would be enough to have tools/checkcompletion 
script to extract "struct option" from our utils and check if the options
are also in bash-completion/<name> and in the util man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
