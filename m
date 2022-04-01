Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB163C433F5
	for <util-linux@archiver.kernel.org>; Fri,  1 Apr 2022 08:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiDAI1N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDAI1M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 1 Apr 2022 04:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76AC45FF2D
        for <util-linux@vger.kernel.org>; Fri,  1 Apr 2022 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648801522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agJ2FuXa1R6xlsEGCz5SQ4ZGXQh36EBMqDDfBQkwLPE=;
        b=XUXUBGyPsTF6gsHsTk8dgL/msKVEUEcm87/H0wG9I42+IUkTIQDudVzg+yGv3NOa91EnCm
        TIVgpqdSeyLuU6g4B9cqZ3WVlot4t4A4nv0RDh0pKOTeXoevJRl7Y267JG8xaYuozkVX+Z
        p+athxK24lmbuNVjQ8NijMebu0+AbRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-wnRRH_1uP-qi2__QiLYDGQ-1; Fri, 01 Apr 2022 04:25:21 -0400
X-MC-Unique: wnRRH_1uP-qi2__QiLYDGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2BDD85A5BE;
        Fri,  1 Apr 2022 08:25:20 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 265B040C1438;
        Fri,  1 Apr 2022 08:25:19 +0000 (UTC)
Date:   Fri, 1 Apr 2022 10:25:17 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Anatoly Pugachev <matorola@gmail.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH v2] libmount: fix typos
Message-ID: <20220401082517.lmmxebfhxjz5rhyo@ws.net.home>
References: <CADxRZqwk7_9KiQrJV5_KvUP4KEy_fPZu13papeg3A6fzhsCC9Q@mail.gmail.com>
 <20220331165535.ug2wqtifl37d63en@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220331165535.ug2wqtifl37d63en@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Mar 31, 2022 at 06:55:35PM +0200, наб wrote:
>  lib/colors.c                   |  4 ++--
>  lib/idcache.c                  |  2 +-
>  libmount/src/optstr.c          |  2 +-
>  libmount/src/utils.c           |  4 ++--
>  login-utils/sulogin-consoles.c |  2 +-
>  misc-utils/lsfd-filter.c       | 10 +++++-----
>  6 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

