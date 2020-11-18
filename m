Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6327C5519F
	for <util-linux@archiver.kernel.org>; Wed, 18 Nov 2020 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B4421D7E
	for <util-linux@archiver.kernel.org>; Wed, 18 Nov 2020 09:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlBwEq/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKRJe4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 18 Nov 2020 04:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbgKRJe4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 18 Nov 2020 04:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605692095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PRSMbltyYmhy12hW3bUrp3wFeU/QpoGCAO9fPt1jycI=;
        b=DlBwEq/M83vToAaL06cbny7stSPrG+n8WtEiCwj9LDtEv2KvZGnviavyHypqQzJ2ZKLk+K
        aTK1Ti/5T91GgaJbG4kDpaQx1ynST4UMzdKcaZRHcdkkNoaQxtTC+97U2x0pO+9GDgylro
        MblDvBYrYtrGC+nswCkQcHsbN7ONefE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-0_wrdrDbNHqYkZ6YitAjJA-1; Wed, 18 Nov 2020 04:34:49 -0500
X-MC-Unique: 0_wrdrDbNHqYkZ6YitAjJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB9921882FBC;
        Wed, 18 Nov 2020 09:34:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E61AF5D9F1;
        Wed, 18 Nov 2020 09:34:47 +0000 (UTC)
Date:   Wed, 18 Nov 2020 10:34:45 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        util-linux@vger.kernel.org
Subject: Re: Fix building util-linux on non-linux
Message-ID: <20201118093445.addb4cfshmx6wt3a@ws.net.home>
References: <20201117202017.afatx2kpuxp5kf7u@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117202017.afatx2kpuxp5kf7u@function>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 17, 2020 at 09:20:17PM +0100, Samuel Thibault wrote:
> Hello,
> 
> The attached patch fixes building on non-linux
> 
> Samuel

> diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
> index 4f52cea3c..8bc3ee37e 100644
> --- a/login-utils/Makemodule.am
> +++ b/login-utils/Makemodule.am
> @@ -31,8 +31,10 @@ dist_man_MANS += login-utils/sulogin.8
>  sulogin_SOURCES = \
>  	login-utils/sulogin.c \
>  	login-utils/sulogin-consoles.c \
> -	login-utils/sulogin-consoles.h \
> -	lib/plymouth-ctrl.c
> +	login-utils/sulogin-consoles.h
> +if USE_PLYMOUTH_SUPPORT
> +sulogin_SOURCES += lib/plymouth-ctrl.c
> +endif
>  sulogin_LDADD = $(LDADD) libcommon.la

Yep, stupid bug. Fixed by https://github.com/karelzak/util-linux/pull/1190.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

