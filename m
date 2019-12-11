Return-Path: <SRS0=hwxx=2B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83695C43603
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 12:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C33720836
	for <util-linux@archiver.kernel.org>; Wed, 11 Dec 2019 12:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yig8ngKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfLKM1M (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:27:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728446AbfLKM1L (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 11 Dec 2019 07:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576067230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qphCaT19Vzj81da3s8ECxIWlvMcMtyIZpj7ikWtub5A=;
        b=Yig8ngKAprBzU/5l2c57gLZgvEtlDVSqDdLMKilF7FQ0tw93lH8baM8GySKlk3or7Cr+XY
        oKEHHRoS2MRVrBgnSkEPVtMsXHS6ci9PFAaSqpVVxrp0fDvdEG/zZIyknDniw7br85ZXEH
        P6EiolvyEBtyPPIi1BCrFxH9mylTS4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-u-4-0P3kNgCwFzT2pAs1KA-1; Wed, 11 Dec 2019 07:27:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1209800053;
        Wed, 11 Dec 2019 12:27:06 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E57435DA76;
        Wed, 11 Dec 2019 12:27:05 +0000 (UTC)
Date:   Wed, 11 Dec 2019 13:27:03 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.35-rc1
Message-ID: <20191211122703.ihusmtsaw3fkejh2@10.255.255.10>
References: <20191211101831.ei3qksv6c2qk4aii@10.255.255.10>
 <20191211121702.337bssjynpupiimz@function>
MIME-Version: 1.0
In-Reply-To: <20191211121702.337bssjynpupiimz@function>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: u-4-0P3kNgCwFzT2pAs1KA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 11, 2019 at 01:17:02PM +0100, Samuel Thibault wrote:
> diff --git a/configure.ac b/configure.ac
> index 40352a0fb..c187927e1 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1845,7 +1845,7 @@ AM_CONDITIONAL([BUILD_SCRIPT], [test "x$build_scrip=
t" =3D xyes])
>  UL_BUILD_INIT([scriptreplay], [yes])
>  AM_CONDITIONAL([BUILD_SCRIPTREPLAY], [test "x$build_scriptreplay" =3D xy=
es])
> =20
> -UL_BUILD_INIT([scriptlive], [yes])
> +UL_BUILD_INIT([scriptlive], [check])

Good point. Applied, thanks!

    Karel

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

