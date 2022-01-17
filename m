Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B201C433F5
	for <util-linux@archiver.kernel.org>; Mon, 17 Jan 2022 08:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiAQIuU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Jan 2022 03:50:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24388 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbiAQIuT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jan 2022 03:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642409418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPGAnASHlapnEmxUNWUyIPqH6v/MCzAb1SRiHkCWIsw=;
        b=NOmrxuq4FytH+dsvu6MZNH0VX/FiorCtA+VKcAOKwuoRVs6Rq9ekNdNCYaPNAMlc1q4HBM
        Nq/Yn/4DiJr869Bi20cHZEkrraBXWy2N0ML2YLFmQXtwWEk7qO1qdHd9rByrxlKA7aevi8
        uozC5/gf3lf7kKQpYmvmDpr/Jt/ZzK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-RQ5t2lVVNKGlAwQfqSgSrw-1; Mon, 17 Jan 2022 03:50:16 -0500
X-MC-Unique: RQ5t2lVVNKGlAwQfqSgSrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D099383DD21;
        Mon, 17 Jan 2022 08:50:15 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C483B7B9D5;
        Mon, 17 Jan 2022 08:50:14 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:50:12 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     util-linux@vger.kernel.org, Daniel Gerber <dg@atufi.org>
Subject: Re: [PATCH 1/2] unshare: Fix parsing of id maps
Message-ID: <20220117084842.2a56c2wbcgx46rek@ws.net.home>
References: <20220115162926.546843-1-seanga2@gmail.com>
 <20220115162926.546843-2-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220115162926.546843-2-seanga2@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 15, 2022 at 11:29:25AM -0500, Sean Anderson wrote:
> For whatever reason, mem2strcpy places the nul-terminator at the end of
> the buffer

Yes, it was originally designed for utmp-like strings where rest of
the buffer is filled by nul-terminators. I think we can fix it to make
it usable for normal strings too.

> instead of at the end of the string it copies. This makes it
> completely useless for our purposes, since one would have to add a
> terminator manually to avoid getting garbage. Just use memcpy instead.
> 
> Fixes: ff5dc96eb ("unshare: Add options to map blocks of user/group IDs")
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> Reported-by: Daniel Gerber <dg@atufi.org>
> ---
> 
>  sys-utils/unshare.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
> index 443358952..889c561ca 100644
> --- a/sys-utils/unshare.c
> +++ b/sys-utils/unshare.c
> @@ -387,8 +387,9 @@ static int uint_to_id(const char *name, size_t sz)
>  {
>  	char buf[UID_BUFSIZ];
>  
> -	mem2strcpy(buf, name, sz, sizeof(buf));
> -	return strtoul_or_err(name, _("could not parse ID"));
> +	memcpy(buf, name, min(sz, sizeof(buf) - 1));
> +	buf[sz] = '\0';
        ^^
What about sz > sizeof(buf)?

Maybe it would be enough to improve mem2strcpy() in include/strutils.h 

 - dest[nmax-1] = '\0';
 + dest[n] = '\0';

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

