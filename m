Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E1FC6FD1C
	for <util-linux@archiver.kernel.org>; Thu,  9 Mar 2023 12:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCIMHD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Mar 2023 07:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCIMHC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Mar 2023 07:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D17E41EE
        for <util-linux@vger.kernel.org>; Thu,  9 Mar 2023 04:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678363575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haewsCCUbd0BIa0WImFmFMRnfl1oqoqo1fzEe4jLF48=;
        b=JegKqHvz3nkf+LlupjbEfHacS7I1mSWkpfp6YiSchGvVYZT2525ikn0qLnitUKVmpFY+1u
        HOwahivY+o/apUerqpj7h9feNKsM5PaqAbnynB5Qc046zFhboeIRj2I1A1vHwdI5q3+QLY
        T3FkrvyQoHdIhR1kdz/7C7faagEAkNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-SQ_MiINCMve4R9UoWtvS5w-1; Thu, 09 Mar 2023 07:06:14 -0500
X-MC-Unique: SQ_MiINCMve4R9UoWtvS5w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72926183B3F0;
        Thu,  9 Mar 2023 12:06:13 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F744014D1D;
        Thu,  9 Mar 2023 12:06:12 +0000 (UTC)
Date:   Thu, 9 Mar 2023 13:06:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Toomas Losin <tlo@lenrek.net>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libfdisk: Fix randomly generated GPT UUID's
Message-ID: <20230309120610.zif6ta4g6mgqsgud@ws.net.home>
References: <20230305155755.49a0534e@marley.lenrek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230305155755.49a0534e@marley.lenrek.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Mar 05, 2023 at 03:57:55PM -0800, Toomas Losin wrote:
>  libfdisk/src/gpt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks!

> 
> diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
> index d7b3e1c70..c3c0347cb 100644
> --- a/libfdisk/src/gpt.c
> +++ b/libfdisk/src/gpt.c
> @@ -878,9 +878,9 @@ static int gpt_mknew_header(struct fdisk_context *cxt,
>  	if (!has_id) {
>  		struct gpt_guid guid;
>  
> -		uuid_generate_random((unsigned char *) &header->disk_guid);
> -		guid = header->disk_guid;
> +		uuid_generate_random((unsigned char *) &guid);
>  		swap_efi_guid(&guid);
> +		header->disk_guid = guid;
>  	}

Good catch, stupid bug.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

