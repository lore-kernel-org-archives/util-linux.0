Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7F4C7618A
	for <util-linux@archiver.kernel.org>; Thu, 16 Mar 2023 20:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCPUdM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 16 Mar 2023 16:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPUdL (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Mar 2023 16:33:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6296EB82
        for <util-linux@vger.kernel.org>; Thu, 16 Mar 2023 13:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678998745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+W9m5BCo8FbI7zH8T03WKcpYhgUO5aObg1PjVEMMP7g=;
        b=QPpgB1f0kepYMlrXeDC0TLu8IXpVcSvA2onR6HQuz2+RBVqcdXBZ2+NBOCajpzlD7I/FvN
        rWfiCuMP1yRe53JS55mRxutPJTZKZ1a53iCta4oI9VZYJM6/s7GEwerpInQ0to8cmuIZeH
        dJv0NZVQzgpFbiYzE15n1jKmB0BIfMg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-cbtLj3a8M5mLzeLCIOjJHQ-1; Thu, 16 Mar 2023 16:32:22 -0400
X-MC-Unique: cbtLj3a8M5mLzeLCIOjJHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39A6A96DC80;
        Thu, 16 Mar 2023 20:32:22 +0000 (UTC)
Received: from localhost (unknown [10.67.24.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD2FA40C6E67;
        Thu, 16 Mar 2023 20:32:20 +0000 (UTC)
Date:   Fri, 17 Mar 2023 05:32:18 +0900 (JST)
Message-Id: <20230317.053218.162189423146300973.yamato@redhat.com>
To:     nabijaczleweli@nabijaczleweli.xyz
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lsfd: error if extraneous argument given
From:   Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20230316160859.zksrhccvnnslkgyd@tarta.nabijaczleweli.xyz>
References: <20230316160859.zksrhccvnnslkgyd@tarta.nabijaczleweli.xyz>
Organization: Red Hat Japan, K.K.
Mime-Version: 1.0
Content-Type: Text/Plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: =CE=C1=C2 <nabijaczleweli@nabijaczleweli.xyz>
Subject: [PATCH] lsfd: error if extraneous argument given
Date: Thu, 16 Mar 2023 17:08:59 +0100

> The manual and help string both spec lsfd [options];
> actually stick to that instead of ignoring subsequent arguments.
> =

> This is particularly a weird thing to allow given that lsof path
> is legal and does something (either same as
> lsfd -Q "MAJ:MIN =3D=3D \"$(stat -c %Hd:%Ld path)\"" if it's a mountp=
oint or
> lsfd -Q "NAME ~=3D '$path'" (sans the regex and escaping) otherwise).=

> =

> This mirrors ec96a89ed9551ffacfc58b3056c8070444e3a2f3 for largely the=

> same reason.
> ---
>  misc-utils/lsfd.c | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/misc-utils/lsfd.c b/misc-utils/lsfd.c
> index 27a0ada01..4b21bf6d2 100644
> --- a/misc-utils/lsfd.c
> +++ b/misc-utils/lsfd.c
> @@ -1943,6 +1943,8 @@ int main(int argc, char *argv[])
>  			errtryhelp(EXIT_FAILURE);
>  		}
>  	}
> +	if (argv[optind])
> +		errtryhelp(EXIT_FAILURE);
>  =

>  #define INITIALIZE_COLUMNS(COLUMN_SPEC)				\
>  	for (i =3D 0; i < ARRAY_SIZE(COLUMN_SPEC); i++)	\
> -- =

> 2.30.2

Tested-by: Masatake YAMATO <yamato@redhat.com>

