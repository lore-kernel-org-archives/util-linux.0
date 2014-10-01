Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28598 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaJAKcr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Oct 2014 06:32:47 -0400
Date: Wed, 1 Oct 2014 12:32:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 22/23] lslogins: use more narrow layout when initializing
 struct members
Message-ID: <20141001103225.GO26272@x2.net.home>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
 <1411933916-30576-23-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411933916-30576-23-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 28, 2014 at 08:51:55PM +0100, Sami Kerola wrote:
> +static const struct lslogins_coldesc
> +    coldescs[] = {
> +	[COL_USER] =
> +	    {"USER",
> +	     N_("user name"),
> +	     N_("Username"),
> +	     0.1,
> +	     SCOLS_FL_NOEXTREMES},

 Oh, nooo.. don't be 80-cols fanatic. This bikeshed has already the
 best possible color. Really. ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
