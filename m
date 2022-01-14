Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8ABC433F5
	for <util-linux@archiver.kernel.org>; Fri, 14 Jan 2022 17:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiANRTv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 14 Jan 2022 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiANRTu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 14 Jan 2022 12:19:50 -0500
X-Greylist: delayed 312 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jan 2022 09:19:49 PST
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch [IPv6:2001:1600:3:17::190f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75BC061574
        for <util-linux@vger.kernel.org>; Fri, 14 Jan 2022 09:19:49 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Jb7Fj0MClzMqJfd;
        Fri, 14 Jan 2022 18:14:33 +0100 (CET)
Received: from jura (unknown [84.73.10.131])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Jb7Fh3zKgzljTfx;
        Fri, 14 Jan 2022 18:14:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atufi.org;
        s=20191114; t=1642180473;
        bh=kw02D6mfQf9Dgm8Vb7FjM/nztAfElxwQSGg9qMhLBn0=;
        h=References:From:To:Cc:Subject:In-reply-to:Date:From;
        b=gq5HRVUqMc3r2tjqWyRT2FcCXh/ESuxwWe87wXwg2sZdwBum5KDn6f57fZs1PwYW2
         PlJucVK6SyXYTeLlD3w4VSb+oQ6t2zQmlx++SMn0x7OSwHkTyA0dwqdYbyyRISL0mo
         got6wfBAxIZ1dgwelalxW4qNqaAmKJW6BVsGghuY=
References: <874k664nlq.fsf@atufi.org>
 <73850170-db69-7d64-ca9e-6e41dfa4eab9@gmail.com>
From:   Daniel Gerber <dg@atufi.org>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     dottedmag@dottedmag.net, id@mbekkema.name, jpeach@apache.org,
        kzak@redhat.com, util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
In-reply-to: <73850170-db69-7d64-ca9e-6e41dfa4eab9@gmail.com>
Date:   Fri, 14 Jan 2022 18:15:31 +0100
Message-ID: <87zgny2q8c.fsf@atufi.org>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


2022-01-14, Sean Anderson:
> It's stack garbage. Try
>
> diff --git i/sys-utils/unshare.c w/sys-utils/unshare.c
> index 3cdd90329..5ac7af3de 100644
> --- i/sys-utils/unshare.c
> +++ w/sys-utils/unshare.c
> @@ -385,10 +385,10 @@ struct map_range {
>   */
>  static int uint_to_id(const char *name, size_t sz)
>  {
> -       char buf[UID_BUFSIZ];
> +       char buf[UID_BUFSIZ] = {0};
>  -       mem2strcpy(buf, name, sz, sizeof(buf));
> -       return strtoul_or_err(name, _("could not parse ID"));
> +       memcpy(buf, name, min(sz, sizeof(buf) - 1));
> +       return strtoul_or_err(buf, _("could not parse ID"));
>  }
>    /**

That works, thanks.


> > Also, I would suggest adopting the same argument order as in /proc/<pid>/uid_map and newuidmap -- inner,outer,count.

> I think this is a rather silly order. Since this is a mapping, the "natural" order is

> outer -> inner

> and only from the new namespace's PoV is it

> inner -> outer

> It certainly helped me remember things once I reversed the order...

All right, this may make some sense to me now. To the user discovering these tools though (me yesterday) the worst is missing one "standard" notation...

> > This doc string has it reversed:

> As noted above, this is intended.

> >   * struct map_range - A range of IDs to map
> >   * @outer: First ID inside the namespace
> >   * @inner: First ID outside the namespace

I mean "@outer: First ID inside ..." surely is a typo, isn't it?


Best,

Daniel
