Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A413BC43219
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 10:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbiKWKIu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 05:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbiKWKHO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 05:07:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32BB11604A
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 01:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669197402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1WN5uAVyXRHTWu9nPzTKEPgR7hfSAj11bXuyDu+XGKo=;
        b=g+R/6ceUvTI93f6irC1+8kdywYF41a/vzskyWWaHXSq1ZlOoNEgUmC4X2xjByAoXqGmiIg
        qio3LaqMGj64gr/HY05RvGHdvALVWhh7g5QpG9QZgDJ9ZoHXWUcqjZREF0O0L6kO83JKU7
        tAowaDy3he7nCCpblA7IXWzLPqMZ2vU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-NAoCQ6wRPveEtPteWA0V9w-1; Wed, 23 Nov 2022 04:56:39 -0500
X-MC-Unique: NAoCQ6wRPveEtPteWA0V9w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BD049811E75;
        Wed, 23 Nov 2022 09:56:38 +0000 (UTC)
Received: from ws.net.home (ovpn-192-16.brq.redhat.com [10.40.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E82A2166B26;
        Wed, 23 Nov 2022 09:56:38 +0000 (UTC)
Date:   Wed, 23 Nov 2022 10:56:36 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] libmount: use autofs mount hint to ignore autofs
 mount entries
Message-ID: <20221123095636.gmmnayyvssyzgccu@ws.net.home>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
 <166856404555.472741.8761384857533986022.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166856404555.472741.8761384857533986022.stgit@donald.themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 16, 2022 at 10:00:45AM +0800, Ian Kent wrote:
> diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
> index 75f8e406b..293f0a8ed 100644
> --- a/libmount/src/tab_parse.c
> +++ b/libmount/src/tab_parse.c
> @@ -762,6 +762,14 @@ int mnt_table_parse_stream(struct libmnt_table *tb, FILE *f, const char *filenam
>  		if (rc == 0 && tb->fltrcb && tb->fltrcb(fs, tb->fltrcb_data))
>  			rc = 1;	/* filtered out by callback... */
>  
> +		if (mnt_table_ignore_autofs(tb)) {

 if (rc == 0 && mnt_table_ignore_autofs(tb)) {

Don't waste time if already ignored or in case of error :-)

> +/*
> + * mnt_table_enable_ignore_autofs:
> + * @tb: table
> + *
> + * Enable ignore autofs mount table entries on reading.
> + */
> +int mnt_table_enable_ignore_autofs(struct libmnt_table *tb)
> +{
> +	if (!tb)
> +		return -EINVAL;
> +	tb->ignore_autofs = 1;
> +	return 0;
> +}


The library usually uses the same function to enable as well as disable:

int mnt_table_enable_ignore_autofs(struct libmnt_table *tb, int ignore)
{
    if (tb)
        return -EINVAL;
    tb->ignore_autofs = ignore ? 1 : 0;
}

and mnt_context_enable_ignore_autofs() is the same.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

