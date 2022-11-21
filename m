Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A65C4332F
	for <util-linux@archiver.kernel.org>; Mon, 21 Nov 2022 10:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiKUKK1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiKUKKO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 21 Nov 2022 05:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166E2FD2
        for <util-linux@vger.kernel.org>; Mon, 21 Nov 2022 02:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669025362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYCJ1TgJ/FowbzayJsP1g6jpyVWmO84X7AlaJoepBaQ=;
        b=Iln6fYq37Obnn47tUf03E8paKRpr426QSnRp4gxrfJe4XxhuGADIlWMg4tkA6LlPz+C+b4
        VJdqknOIA+0XHHl7B5oDwVf6gQdUYCYASyt++n2MXLxMthI2Tv47ie39Wksu+ipRr2gGCb
        LWBj1xyb4Z4TqYPbvo92PJs3/6j6rrg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-aTmZbftsOzucBvTrSS1y-Q-1; Mon, 21 Nov 2022 05:09:18 -0500
X-MC-Unique: aTmZbftsOzucBvTrSS1y-Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C2688027EC;
        Mon, 21 Nov 2022 10:09:18 +0000 (UTC)
Received: from ws.net.home (ovpn-192-16.brq.redhat.com [10.40.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82BB940C6EE9;
        Mon, 21 Nov 2022 10:09:17 +0000 (UTC)
Date:   Mon, 21 Nov 2022 11:09:15 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org,
        =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: [PATCH] script: abort if unused arguments are given
Message-ID: <20221121100915.4yxsk7e4boftssrv@ws.net.home>
References: <20221118132337.616146-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118132337.616146-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Nov 18, 2022 at 01:23:37PM +0000, Chris Hofstaedtler wrote:
>  term-utils/script.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Applied.

> +	if (argc > 0) {
> +		/* only one filename is accepted. if --log-out was given,
> +		 * freestanding filename is ignored */
> +		usage();
> +	}

We do not use usage() in this case, but errtryhelp() to get

        $ script aaa bbb
        script: unexpected number of arguments
        Try 'script --help' for more information.

Fixed. Thanks.

    Karel
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

