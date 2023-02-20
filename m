Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1951C6379F
	for <util-linux@archiver.kernel.org>; Mon, 20 Feb 2023 01:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBTBjV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 19 Feb 2023 20:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBTBjV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Feb 2023 20:39:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF5FD517
        for <util-linux@vger.kernel.org>; Sun, 19 Feb 2023 17:39:18 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31K1d4Hg013076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 20:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676857146; bh=koKCO0G721HoKbZlfStfYQazMs3r15QfIB9HBwcaxLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RBREhqjFXVpKzjjgXLiuJ52knBxUrkGwuCzqgN5Fw3jIzGbaGtCUQOvuxdzTw3hUE
         NAhlXlYSxfYL9hxxKaU/JjJgVldU5ykUH73L3RerqK7rFc9dEPKwjfzFqkgtEtanuI
         93kBxpqct57DPIzC+WQn6QP7BioCTvOsNxzBOIjaPGW21PX+XnG8omnjj5H33cD1gK
         iDaNAYwR07M1W14VQE4WU2xRQ2UVz8YnQrfzqIBejOt6z9BjPZ3shH2FZY5lr7JUzX
         Rshh2/8n9BIPpFKiT0YUjuatGrM4HTV9kc+aK7yJviik+q2TK8AAZO3WnZZjiGQFWT
         ba4m12CxML7AQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EF91115C35A1; Sun, 19 Feb 2023 20:39:03 -0500 (EST)
Date:   Sun, 19 Feb 2023 20:39:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     Michael Richardson <mcr@sandelman.ca>, util-linux@vger.kernel.org
Subject: Re: uuid and RFC4122
Message-ID: <Y/LPN7pf6x75Xm9H@mit.edu>
References: <14266.1676658860@localhost>
 <20230219170116.q453di5cmknxn665@zeha.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219170116.q453di5cmknxn665@zeha.at>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Feb 19, 2023 at 06:01:16PM +0100, Chris Hofstaedtler wrote:
> Hello Michael,
> 
> * Michael Richardson <mcr@sandelman.ca>:
> > Hi, thanks for your work on debian packages.
> > I'm contacting you wearing my IETF uuidrev WG co-chair on.
> > 
> > The https://datatracker.ietf.org/wg/uuidrev/documents/ WG was chartered to
> > update RFC4122 last summer, and we expect to start a WGLC on RFC4122bis in
> > the next few weeks.  This is just a heads up for now.
> > 
> > Some comments, even they are just "Looks Good to Me" from the util-linux
> > folks would be awesome.
> 
> Thanks for reaching out, but from the Debian side I think we have
> little to comment on (mostly for lack of expertise).
> 
> I've CC:ed the upstream mailing list, in the hope that upstream
> util-linux folks have comments.

Hi,

I originally wrote the uuid implementation in util-linux.  Originally,
it was first in e2fsprogs, and then later the library was transferred
to util-linux at least for most Linux distributions.  Technically
speaking, however, libuuid is still shipped in the e2fsprogs sourecs
and that's the version which is used by Android and some non-Linux
OS's including NetBSD and Darwin (MacOS may have forked the library,
though, so if I shipped updates in e2fsprogs how quickly it would get
picked up by Apple.)  Libuuid is mostly in maintenance mode, actually;
the sort of changes that have landed recently have been to support the
getrandom(2) system call.

I'm not sure what the context is for this e-mail thread, or what
you're asking for in terms of an LGTM?  Were you looking for comments
on draft-ietf-uuidrev-rfc4122bis?  Or were you hoping to see if folks
might be interested in implementing the new UUID versions in
draft-ietf-uuidrev-rfc4122bis so the libuuid in Linux might support
those new variants?

Cheers,

					- Ted

P.S.  Hi Michael; long time no chat --- I haven't been to an IETF
meeting in many years!)

