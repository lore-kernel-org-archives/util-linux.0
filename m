Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38FAC64EC7
	for <util-linux@archiver.kernel.org>; Tue, 28 Feb 2023 11:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjB1LDx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Feb 2023 06:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjB1LDx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2023 06:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDE32CFFA
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2023 03:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677582165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfZ+BxdVjI3yc3NJKj3EpFJUaxLJDgAp4ku0PIZ6fXs=;
        b=E0TU8tpZl4TqDQriPMYvSZXTsu+okKxCZ1Rwiyv2IGW/hrDCChljHNPtPdG3LQcdKKlZrx
        rr0fFF1rJ6B3l3Gfo4Mv0+RMsA6Bilg/ljn8JQtcjrf53zNNHzH4xUZhhNMJBoUzgrha/y
        r2QQV/VgBq9SRLK7qI4YT9Q9m3gJ/sQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-cWBPsDC5O1GQ6BGFWA5PSw-1; Tue, 28 Feb 2023 06:02:44 -0500
X-MC-Unique: cWBPsDC5O1GQ6BGFWA5PSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D6341871D94;
        Tue, 28 Feb 2023 11:02:44 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 88099404BEC5;
        Tue, 28 Feb 2023 11:02:43 +0000 (UTC)
Date:   Tue, 28 Feb 2023 12:02:41 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?U8O2cmVu?= Tempel <soeren@soeren-tempel.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: Fix access to uninitialised value in
 mnt_optstr_locate_option
Message-ID: <20230228110241.pu33qzx3u4xb4743@ws.net.home>
References: <20230225114352.9151-1-soeren@soeren-tempel.net>
 <20230225124131.10401-1-soeren@soeren-tempel.net>
 <3E04KR1SLWLFQ.25IAX13LC3PWS@8pit.net>
 <20230227105038.l2pw3nn6x62tridi@ws.net.home>
 <2B71FNQUV107Y.2UPOBHSWLST8P@8pit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2B71FNQUV107Y.2UPOBHSWLST8P@8pit.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Feb 27, 2023 at 08:00:55PM +0100, Sören Tempel wrote:
> Thanks for your patch, the changes look good to me!

Thanks.

> I have one small follow-up question though. You added the following
> sentence to the documentation for mnt_match_options():
> 
> > The alone "no" is error and all matching ends with False.
> 
> I believe this to be a good change. However, If my understanding of
> this documentation comment is correct I would have expected
> 
> 	mnt_match_options("bla", "no,,")

Good point.

> 
> to return False as well but to my surprise it actually returns True. I
> understand that this is an edge case but is that intended? Maybe the ","
> should be treated as an terminating character for the "no" as well (i.e.
> in addition to the null byte)?
> 
> diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
> index 4fbbb0859..a0056c767 100644
> --- a/libmount/src/optstr.c
> +++ b/libmount/src/optstr.c
> @@ -865,7 +865,7 @@ int mnt_match_options(const char *optstr, const char *pattern)
>  			name++, namesz--;
>  		else if ((no = (startswith(name, "no") != NULL))) {
>  			name += 2, namesz -= 2;
> -			if (!*name) {
> +			if (!*name || *name == ',') {
>  				match = 0;
>  				break;	/* alone "no" keyword is error */
>  			}
> 
> With this patch applied it also returns False for the "no,," pattern.

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

