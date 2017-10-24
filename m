Return-Path: util-linux-owner@vger.kernel.org
Received: from bombadil.infradead.org ([65.50.211.133]:49072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932276AbdJXJap (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Oct 2017 05:30:45 -0400
Date: Tue, 24 Oct 2017 02:30:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: kerolasa@gmail.com
Cc: Christoph Hellwig <hch@infradead.org>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libuuid: use explicit_bzero() in uuid_clear() when
 possible
Message-ID: <20171024093045.GA5752@infradead.org>
References: <20171016213734.23237-1-kerolasa@iki.fi>
 <20171018071531.GA2929@infradead.org>
 <CAG27Bk0aKyD_ZuTOUTM4jgvaioWGLA2-jUHeZTABO+0hz354gw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0aKyD_ZuTOUTM4jgvaioWGLA2-jUHeZTABO+0hz354gw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 23, 2017 at 08:38:20PM +0100, Sami Kerola wrote:
> > Can you explain the logic behind this a bit more?  If no one uses the
> > uuid later it doesn't matter if we cleared it or not.
> 
> When value is not used compiler might deside to remove such clearning
> altogether. To me uuid_clear() is promise that the value disappears, and
> that is what the function should do. Who knows, maybe someone uses
> uuids to something sensitive that must be cleared not to leak secrets.
> In that sort of context one really hopes promise of clearing is kept.

That's not how uuid_clear is documented.  From the man page:

NAME
       uuid_clear - reset value of UUID variable to the NULL value

SYNOPSIS
       #include <uuid.h>

       void uuid_clear(uuid_t uu);

DESCRIPTION
       The uuid_clear function sets the value of the supplied uuid variable uu to the NULL value.

If the variable isn't used it obviously must not be cleared.
