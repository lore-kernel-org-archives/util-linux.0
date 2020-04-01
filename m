Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E47FC2D0E7
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 10:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C2A2078B
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 10:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e2p8ogCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgDAKAP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:00:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20698 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgDAKAP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2020 06:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585735214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1h/FlxD30Bu83CXjlaeK70sIboYmtQAZikvXAVdH9hg=;
        b=e2p8ogCAYMaPXTd8oUeI4Zrnw3IetnPjID9tHqfc12R3WjYO0mguRde5BToWtwd072T+xg
        POYxK2FZMEerhQlPTlyUfQeBlRRBZ9cIAjqRG7Hx7PD07pY0laEfHqxJYxjY1BhCgMgVFd
        dHiTLRWixlLanOqCAafIEB26HAQ6ZUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-ioqDkGB-NX-daNpU6kWxqw-1; Wed, 01 Apr 2020 06:00:10 -0400
X-MC-Unique: ioqDkGB-NX-daNpU6kWxqw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BADB1137843;
        Wed,  1 Apr 2020 10:00:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D9B660BEC;
        Wed,  1 Apr 2020 10:00:08 +0000 (UTC)
Date:   Wed, 1 Apr 2020 12:00:05 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Peter Cordes <peter@cordes.ca>
Cc:     Aurelien LAJOIE <orel@melix.net>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libuuid: improve uuid_unparse() performance
Message-ID: <20200401100005.tuamlrlrujfzr7yd@ws.net.home>
References: <20200326143827.25879-1-orel@melix.net>
 <20200401083103.ipberscb6yzvpu4r@ws.net.home>
 <CA+bjHUSbRp7G=4C-_m9WR+OCLFZAyN0p85UH4R5m13w5YXWYgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+bjHUSbRp7G=4C-_m9WR+OCLFZAyN0p85UH4R5m13w5YXWYgg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 01, 2020 at 06:34:06AM -0300, Peter Cordes wrote:
> On Wed, Apr 1, 2020 at 5:31 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Thu, Mar 26, 2020 at 03:38:27PM +0100, Aurelien LAJOIE wrote:
> > > +     __attribute__((alias("uuid_unparse_upper")));
> > > +#else
> > > +void uuid_unparse(const uuid_t uu, char *out)
> > > +     __attribute__((alias("uuid_unparse_lower")));
> > > +#endif
> >
> > The alias attribute is not portable to clang on Darwin.
> >
> >  https://travis-ci.org/github/karelzak/util-linux/jobs/669244356?utm_medium=notification&utm_source=email
> >
> > I have replaced the aliases with function calls.
> >
> >  https://github.com/karelzak/util-linux/commit/bee464006776203a8cb545a35c86234181c7a55a
> 
> Since Darwin does support weak_alias, can we just use that?  Is it
> "strong enough"?  I'm assuming nothing will override the alias so it
> can still have the same efficient end result, having both symbols
> resolve to the same address with no extra per-call overhead.  (And
> without bloating the library from a compiler deciding to inline the
> static helper function into all 3 instead of 2 callers.  Although most
> programs probably only ever call one, so only one has to stay hot in
> I-cache, with the others only bloating the file size and space in that
> iTLB memory page.)
> 
> Or can we put the wrapper function in a .h so it can inline away?
> That would bake the choice into applications that use libuuid, so you
> couldn't change it just by rebuilding libuuid.  That's perhaps not
> desirable; if applications wanted to have that choice baked in they
> could have called the explicit upper or lower versions.
 
 Frankly, what we're trying to fix by the alias? It sounds like
 premature optimization. The current solution works, maybe foo(bar())
 is also optimized by compiler. I have doubts that use inline function 
 in header or so makes a real sense.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

