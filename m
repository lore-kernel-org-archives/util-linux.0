Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5D7C43331
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 09:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302622078B
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 09:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgDAJeS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 05:34:18 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:40309 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgDAJeS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2020 05:34:18 -0400
Received: by mail-vk1-f195.google.com with SMTP id k63so6524637vka.7
        for <util-linux@vger.kernel.org>; Wed, 01 Apr 2020 02:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pG/STzWZlpta9KzVwHMx0QqVFCfNV+GPIGnQs85+mtQ=;
        b=nS8KztaYTFHlHrI2ecdEtNd5QO37hn7T3Krtv5w2nWDzMr5iZPDgwcyVP06PYXoTX7
         1i+LnLlwNcdmZfR+8pl78f0a44zi/vg5k6Aun1sCfgTBwjiH7yOeEOJUC/AhTQs7byb7
         2dbsVuvsrzqoGJpeAidq9PN6QbTlWfGK1Fg9mOAxCVLDn4LVe38z6CxDRadCub3Vu7Id
         BJe2wgqZyBC8fmpAtLhotnRxTPC75RRfxIkc02oOGNWteVkNzoDRoxtCna0N7lTpmr3+
         BXe+x0i9vHgqhFC8yTlpzg0+/8rbFWOsqwLFaHAOdycAHNkClo/cP5FIwpKTJuKKcgDC
         N2DQ==
X-Gm-Message-State: AGi0Pubz9pDkpBIz8KGywa36wINvsWn5E19bO0lrUm9rRgrgaaqV4QK9
        Vqr0QZBRjkh5hpm7oPtQfgMrrPTfZUIP8q1GARw=
X-Google-Smtp-Source: APiQypL+zXcn5+bnadj0sQOc96g+8lGYY92dsN7de4DG90/GrK+He0smyOL8a42Jeypx0r32tm+CBQjCEUmLv4nkm6E=
X-Received: by 2002:a1f:9e17:: with SMTP id h23mr14232693vke.99.1585733657478;
 Wed, 01 Apr 2020 02:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200326143827.25879-1-orel@melix.net> <20200401083103.ipberscb6yzvpu4r@ws.net.home>
In-Reply-To: <20200401083103.ipberscb6yzvpu4r@ws.net.home>
From:   Peter Cordes <peter@cordes.ca>
Date:   Wed, 1 Apr 2020 06:34:06 -0300
Message-ID: <CA+bjHUSbRp7G=4C-_m9WR+OCLFZAyN0p85UH4R5m13w5YXWYgg@mail.gmail.com>
Subject: Re: [PATCH v2] libuuid: improve uuid_unparse() performance
To:     Karel Zak <kzak@redhat.com>
Cc:     Aurelien LAJOIE <orel@melix.net>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 1, 2020 at 5:31 AM Karel Zak <kzak@redhat.com> wrote:
>
> On Thu, Mar 26, 2020 at 03:38:27PM +0100, Aurelien LAJOIE wrote:
> > +     __attribute__((alias("uuid_unparse_upper")));
> > +#else
> > +void uuid_unparse(const uuid_t uu, char *out)
> > +     __attribute__((alias("uuid_unparse_lower")));
> > +#endif
>
> The alias attribute is not portable to clang on Darwin.
>
>  https://travis-ci.org/github/karelzak/util-linux/jobs/669244356?utm_medium=notification&utm_source=email
>
> I have replaced the aliases with function calls.
>
>  https://github.com/karelzak/util-linux/commit/bee464006776203a8cb545a35c86234181c7a55a

Since Darwin does support weak_alias, can we just use that?  Is it
"strong enough"?  I'm assuming nothing will override the alias so it
can still have the same efficient end result, having both symbols
resolve to the same address with no extra per-call overhead.  (And
without bloating the library from a compiler deciding to inline the
static helper function into all 3 instead of 2 callers.  Although most
programs probably only ever call one, so only one has to stay hot in
I-cache, with the others only bloating the file size and space in that
iTLB memory page.)

Or can we put the wrapper function in a .h so it can inline away?
That would bake the choice into applications that use libuuid, so you
couldn't change it just by rebuilding libuuid.  That's perhaps not
desirable; if applications wanted to have that choice baked in they
could have called the explicit upper or lower versions.
