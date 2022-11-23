Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B961C4332F
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 11:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiKWLLD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiKWLJa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 06:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3FBAF08D
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669201694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BqYbyoxzB31Gm+B75CxNYWxP+0cqdnQAiuIP8VZ4BoM=;
        b=T4Qvaa1aRVuP+v7J5BW9cE3+IUOHwYFJlTb5RJ6nlDf5x4cxi0H1F7HnHmKUA/za7JwKnX
        Tq5FCUvWKoOzDnS+IpJ2OcXtA+Xg9xPsBrg4DOtyTuzynborssJTjUvsuSzAi0w8hi25Ro
        3b3mqG282vdOKJH5QThJqFJzJngzJiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-DokHRdeXMceTWFslf73ASg-1; Wed, 23 Nov 2022 06:08:13 -0500
X-MC-Unique: DokHRdeXMceTWFslf73ASg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB86A811E67;
        Wed, 23 Nov 2022 11:08:12 +0000 (UTC)
Received: from ws.net.home (ovpn-192-16.brq.redhat.com [10.40.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B2F8C1908A;
        Wed, 23 Nov 2022 11:08:12 +0000 (UTC)
Date:   Wed, 23 Nov 2022 12:08:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/2] libmount: use autofs mount hint to ignore autofs
 mount entries
Message-ID: <20221123110810.tkiivfuhdkgd6y74@ws.net.home>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
 <166856404555.472741.8761384857533986022.stgit@donald.themaw.net>
 <20221123095636.gmmnayyvssyzgccu@ws.net.home>
 <0173dc4a-5fc4-bc35-9b08-cc4afcdaffb3@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0173dc4a-5fc4-bc35-9b08-cc4afcdaffb3@themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 23, 2022 at 07:00:08PM +0800, Ian Kent wrote:
> I'll change it for v2, what about the check-if-enabled function,
> 
> any conventions for those?

I usually use _is_ or _has_ in the function name, maybe

 mnt_table_is_noautofs()
 mnt_context_is_noautofs()

and maybe

 mnt_table_enable_noautofs() 

not sure how horrible is it for native English speakers ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

