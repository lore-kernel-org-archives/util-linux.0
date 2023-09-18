Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EACC46CA1
	for <util-linux@archiver.kernel.org>; Mon, 18 Sep 2023 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjIRLMs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Sep 2023 07:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjIRLMQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Sep 2023 07:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3811311C
        for <util-linux@vger.kernel.org>; Mon, 18 Sep 2023 04:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695035476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddntBp4wn38ifUJeJdilnbdUBV1OBtAWrhnWOCFjhv4=;
        b=BbFx6xy9JLcPSyDXVMpUi49dZjm7Uyli9GPC7xJOGO60uMZ2iBcRXfq9L8Q1GojFM6UE74
        yeSMBmlEj8w843yW9fZfQ4gGF2qn7kCHrE/hbNO67lmiM2Z2wErtsEEDIUkYnoUpJNTlXR
        iqX1gpJrrg9HFsr7OPRtafdeYCtMZGQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-T3v48kBqPzGTd69xwYHsVQ-1; Mon, 18 Sep 2023 07:11:12 -0400
X-MC-Unique: T3v48kBqPzGTd69xwYHsVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0AD9629AA3AE;
        Mon, 18 Sep 2023 11:11:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AB3F492B16;
        Mon, 18 Sep 2023 11:11:11 +0000 (UTC)
Date:   Mon, 18 Sep 2023 13:11:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@aquilenet.fr>,
        util-linux@vger.kernel.org
Subject: Re: Fix non-Linux build
Message-ID: <20230918111109.2b25gk3zixqdj7zt@ws.net.home>
References: <20230917163631.xcmdnwodz4wrcpyq@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917163631.xcmdnwodz4wrcpyq@begin>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Sep 17, 2023 at 06:36:31PM +0200, Samuel Thibault wrote:
> Here are some fixes for non-linux build.

Thanks!

> diff --git a/configure.ac b/configure.ac
> index 5f609dec7..061e22e15 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1906,7 +1906,8 @@ AS_IF([test "x$build_enosys" = xyes], [
>  ])
>  AM_CONDITIONAL([BUILD_ENOSYS], [test "x$build_enosys" = xyes])
>  
> -UL_BUILD_INIT([lsclocks], [yes])
> +UL_BUILD_INIT([lsclocks], [check])
> +UL_REQUIRES_LINUX([lsclocks])
>  AM_CONDITIONAL([BUILD_LSCLOCKS], [test "x$build_lsclocks" = xyes])

Applied.

> --- a/libmount/src/hooks.c
> +++ b/libmount/src/hooks.c
> @@ -315,9 +315,11 @@ static int call_hook(struct libmnt_context *cxt, struct hookset_hook *hook)
>  {
>  	int rc = 0;
>  
> +#if LINUX
>  	if (mnt_context_is_fake(cxt))
>  		DBG(CXT, ul_debugobj(cxt, " FAKE call"));
>  	else
> +#endif
>  		rc = hook->func(cxt, hook->hookset, hook->data);

It seems better to not use libmount/src/hooks.c on non-Linux systems.
Fixed (but not tested:-).

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

