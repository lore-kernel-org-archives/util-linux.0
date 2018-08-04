Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:37776 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbeHDVsn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 4 Aug 2018 17:48:43 -0400
Date: Sat, 4 Aug 2018 15:46:55 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libuuid: use kernel crypto api
Message-ID: <20180804194655.GD4461@thunk.org>
References: <20180804191706.10641-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180804191706.10641-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Aug 04, 2018 at 08:17:06PM +0100, Sami Kerola wrote:
> Try to speed up md5 checksums by using hardware accelerators when they are
> present with use of kernel crypto api.
> 
> Reference: http://www.chronox.de/libkcapi/html/ch01s02.html
> Signed-off-by: Sami Kerola <kerolasa@iki.fi>

I'm not sure I see the point of this change.  Is there a use case you
have in mind where people would be using crypto hash based UUID's
where performance is a concern?  In in that case where someone was
trying to create a huge number of crypto hash based UUID's, how much
overhead is there in going through the kernel API if there is *not* a
hardware accelerator present?

						- Ted
