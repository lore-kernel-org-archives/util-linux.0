Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9A9C433E0
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E122333C
	for <util-linux@archiver.kernel.org>; Wed, 20 Jan 2021 12:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbhATMxk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Jan 2021 07:53:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46757 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732027AbhATMY0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 20 Jan 2021 07:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611145380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1MDybgnCghxBmdmeaQTvqXz8K3sSvgyKTxl6ShL340=;
        b=UzslF8FUKawZ8MNTB/xkwC1cR266SwFcmianEgpdr8Km29nYsotzU/xMXUvR2ANG5ruzns
        8uG4B45bvb3nwTQm4sPmf2E1bn9uXQ0OMvpNv808f6ZWqS05Q1B44utav0pOi1YEfts8gc
        DUi7lMQUzx9MOKpKLvliNH0YklES2/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-YnhR-wObPZejFoiHUwBukA-1; Wed, 20 Jan 2021 07:22:56 -0500
X-MC-Unique: YnhR-wObPZejFoiHUwBukA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7020100F359;
        Wed, 20 Jan 2021 12:22:54 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94E4260C6A;
        Wed, 20 Jan 2021 12:22:53 +0000 (UTC)
Date:   Wed, 20 Jan 2021 13:22:51 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH 3/5] uclampset: Add man page
Message-ID: <20210120122251.fyvbuecsgrg5yv4p@ws.net.home>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
 <20210116190940.2320819-4-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116190940.2320819-4-qais.yousef@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jan 16, 2021 at 07:09:38PM +0000, Qais Yousef wrote:
> +See
> +.BR sched_setscheduler (2)
> +for a description of the Linux scheduling scheme.

and maybe sched_setattr(2) too.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

