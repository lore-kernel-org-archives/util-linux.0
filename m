Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A21C433E0
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DB164DFF
	for <util-linux@archiver.kernel.org>; Tue, 16 Feb 2021 17:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBPRWR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Feb 2021 12:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230469AbhBPRWI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 16 Feb 2021 12:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613496042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hceEodIpYWmg/4ecDxrLYyx0p3k6FETIVfuv/YAUQg0=;
        b=IP6VsNjVkPfGUmkaRhZIQbcxlZ0JUZvK3svyapv6B7z7gJoKijNzk2Vquw4JaLwX151MsL
        ENl72zN9QxCMvIfUN0bfeafvTE9pZogoPVPZUp4Ns42VejRAL4E+RKlYFxZsALx5nEIgS5
        +o3wDYmOBRYaKc+e0M0AAVde1JZUfU0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-tsbeu-_TOFGfM7NVQP83rg-1; Tue, 16 Feb 2021 12:20:37 -0500
X-MC-Unique: tsbeu-_TOFGfM7NVQP83rg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4524BBEE3;
        Tue, 16 Feb 2021 17:20:36 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1186E5B697;
        Tue, 16 Feb 2021 17:20:35 +0000 (UTC)
Date:   Tue, 16 Feb 2021 18:20:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: Typo in commit build-sys: release++ (v2.36.2)?
Message-ID: <20210216172033.he3licr6ve3ezu6s@ws.net.home>
References: <20210214164728.7f461991@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214164728.7f461991@gmx.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Feb 14, 2021 at 04:47:28PM +0100, Peter Seiderer wrote:
> Hello,
> 
> the commit for release v2.36.2 ([1]) 'build-sys: release++ (v2.36.2)'
> contains a typo setting LIBBLKID_DATE to '12-Feb-2020'
> instead of '12-Feb-2021'?
> 
> --- a/configure.ac
> +++ b/configure.ac
> @@ -29,7 +29,7 @@ PACKAGE_VERSION_RELEASE=$(echo $PACKAGE_VERSION | awk -F. '{
> 
>  dnl libblkid version
>  LIBBLKID_VERSION="$PACKAGE_VERSION_MAJOR.$PACKAGE_VERSION_MINOR.$PACKAGE_VERSION_RELEASE"
> -LIBBLKID_DATE="16-Nov-2020"
> +LIBBLKID_DATE="12-Feb-2020"

Oh, nice... fixed in the git tree, but I guess we do not need a new
release to fix this typo. It's really used only as date, nothing in
the library is calculated from this string.

Thanks for your report.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

