Return-Path: util-linux-owner@vger.kernel.org
Received: from bombadil.infradead.org ([65.50.211.133]:45208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762316AbdJRHPb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 18 Oct 2017 03:15:31 -0400
Date: Wed, 18 Oct 2017 00:15:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use explicit_bzero() in uuid_clear() when
 possible
Message-ID: <20171018071531.GA2929@infradead.org>
References: <20171016213734.23237-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016213734.23237-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 16, 2017 at 10:37:34PM +0100, Sami Kerola wrote:
> This ensures value is blanked.  It is possible compiler optimization removed
> earlier uuid_clear() calls as unnecessary if value was not used after clear.

Can you explain the logic behind this a bit more?  If no one uses the
uuid later it doesn't matter if we cleared it or not.
