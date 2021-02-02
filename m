Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8634C433DB
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 15:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E0E964F68
	for <util-linux@archiver.kernel.org>; Tue,  2 Feb 2021 15:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhBBPmu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:42:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235685AbhBBPlw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2021 10:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612280425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ws+Suivcnp9I3HZeXnrcMRHgCwVGPHSMFbm+/aXr71Y=;
        b=BS2ZsmDgQu9GUQkwVMvqGMnFYa+WXCRpYZOHJYb51o2Spho49C1ZqgxiTW5SuZk4Rcgpat
        hRUagBQSbitLt9RLX0k6pajM4i1h3SC3/Szpaqr446jlwllyDmiSeLxNeGR3ZXr+XHC9wE
        pa1BBsGWP6StLYm6RvYBqStpu2sY9d4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-a7d4HNaUMHKWkT2sRchusA-1; Tue, 02 Feb 2021 10:40:22 -0500
X-MC-Unique: a7d4HNaUMHKWkT2sRchusA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C63C415730;
        Tue,  2 Feb 2021 15:40:21 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2222910023AD;
        Tue,  2 Feb 2021 15:40:20 +0000 (UTC)
Date:   Tue, 2 Feb 2021 16:40:18 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/5] Add uclampset schedutil
Message-ID: <20210202154018.hncghl7jas3o4pyb@ws.net.home>
References: <20210130205039.581764-1-qais.yousef@arm.com>
 <20210130205039.581764-3-qais.yousef@arm.com>
 <20210201161252.3suz2dbihpdxyg5x@ws.net.home>
 <20210201173202.jrsd6mbhbm2hhebm@e107158-lin>
 <20210202080131.lyvsda3rtp7btc3q@ws.net.home>
 <20210202110225.bhddyfcu43v34y7e@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202110225.bhddyfcu43v34y7e@e107158-lin>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 02, 2021 at 11:02:25AM +0000, Qais Yousef wrote:
> Thanks a lot Karel. Pushed a new uclampset-v3 branch so that you can easily
> review the diff against v2 before merging.

Merged. I did some minor changes to --help and ./configure by other
commits.

Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

