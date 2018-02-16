Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:51852 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161066AbeBPRKp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 16 Feb 2018 12:10:45 -0500
Date: Fri, 16 Feb 2018 12:10:40 -0500
From: Theodore Ts'o <tytso@mit.edu>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux@vger.kernel.org, Hornseth_Brenan@bah.com
Subject: Re: [PATCH] fsck: use xasprintf to avoid buffer overruns with an
 insane fs type
Message-ID: <20180216171040.GD12890@thunk.org>
References: <20180215200508.1466-1-tytso@mit.edu>
 <20180216155505.GL9479@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216155505.GL9479@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 16, 2018 at 11:55:05AM -0400, Peter Cordes wrote:
> > -	static char prog[256];
> > +	static char *prog = NULL;
> 
>  You're allocating / freeing every time it's used, so it shouldn't be
> static anymore.

Good point.  Karels has already accepted the patch, but if he hasn't
pushed it out, maybe he can ammend it.

> It might be easier to just use snprintf to truncate long strings,
> instead of introducing dynamic allocation which requires explicit
> freeing.  OTOH xasprintf makes it re-entrant / thread-safe, at the
> cost of forcing the caller to care about memory management.  (And at
> the cost of efficiency: prog is allocated / freed inside the loop.)

That's certainly an alternative, and in fact that's how I fixed it in
the old version of fsck still shipping in e2fsprogs (there are a few
places that still use it).

My main reason for using it there is that in e2fsprogs we don't assume
the use of xasprintf and family (it's a GNU extension, and e2fsprogs
tries to support legacy platforms such as MacOS and Windows :-).

However, given that fsck does use xasprintf already (and so there is
no portability advantag) and it's a lot easier to prove (or at least
satisfy to oneself) that an attacker who is trying to play tricks
can't do something unexpected when using xasprintf versus snprintf, I
went with asprintf in my patch to util-linux.

Cheers,

					- Ted
