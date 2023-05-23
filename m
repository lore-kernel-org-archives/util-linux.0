Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91788C7EE23
	for <util-linux@archiver.kernel.org>; Tue, 23 May 2023 09:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjEWJJL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 23 May 2023 05:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjEWJJK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 23 May 2023 05:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0D133
        for <util-linux@vger.kernel.org>; Tue, 23 May 2023 02:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684832899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=354h1ZoWXyfYIq7s5uKUUGub482jrWvNyq1FKFYAwQ4=;
        b=AciLrUHunGY4DrjN8pF6CVZwIMnu4RvK4eKPYaTOuBGOitUkmWra04TcwoVxYIRnVk9u1I
        o9OD8P6jHH4YxnK2wa2HDk7UT9+dgzAWtqbELdUa3ez9hJAV+ZMErQqsj0fS9ZP+/ExWp0
        WIIdFMuS6wdfCyvy/1xmXNXecQusBjc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-r08SUteZNfCnPB5qyqsUBA-1; Tue, 23 May 2023 05:08:08 -0400
X-MC-Unique: r08SUteZNfCnPB5qyqsUBA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CF54811E8F;
        Tue, 23 May 2023 09:08:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB85D140E95D;
        Tue, 23 May 2023 09:08:07 +0000 (UTC)
Date:   Tue, 23 May 2023 11:08:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] enosys: add support for LoongArch
Message-ID: <20230523090804.tvb3myuxohm7kxyi@ws.net.home>
References: <20230523083356.377658-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523083356.377658-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


Please, see https://github.com/util-linux/util-linux/pull/2260, Thomas
wants to move all this to include/audit-arch.h

    Karel


On Tue, May 23, 2023 at 04:33:56PM +0800, Enze Li wrote:
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  misc-utils/enosys.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/misc-utils/enosys.c b/misc-utils/enosys.c
> index 02978c20a..9facbcb53 100644
> --- a/misc-utils/enosys.c
> +++ b/misc-utils/enosys.c
> @@ -70,6 +70,12 @@
>  #    else
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_ARCV2
>  #    endif
> +#elif __loongarch__
> +#    if _LOONGARCH_SZPTR == 32
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH32
> +#    elif _LOONGARCH_SZPTR == 64
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_LOONGARCH64
> +#    endif
>  #else
>  #    error Unknown target architecture
>  #endif
> 
> base-commit: fe0b1e793c9017edba72768e2e0b4c769c204604
> -- 
> 2.34.1
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

