Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098C5C433F5
	for <util-linux@archiver.kernel.org>; Fri,  1 Apr 2022 08:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiDAI0a (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 1 Apr 2022 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiDAI03 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 1 Apr 2022 04:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B12585FF2D
        for <util-linux@vger.kernel.org>; Fri,  1 Apr 2022 01:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648801479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vl7ZPzSUahTGykj/E92K/LwMe2NHJvWK3nGmhBH3D5U=;
        b=WSk5d23qiVkk6/uT3Mhc2qu2KzgkxDQIJvfbagoQWt2F3/azzZ1EdztVoO7BdZd6NNm9Ne
        VgPAqVD6gM/dY4hFyzRUpFX3dJEFd2PnIum3kiMbvu2cU9cmtZDvBuKuP9RZu9F9nXNIVX
        T455wpmFEQSK3Cpr++9IC/mMoxqM52k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-v2KlsKdSMzeNr6EJ--gTXg-1; Fri, 01 Apr 2022 04:24:36 -0400
X-MC-Unique: v2KlsKdSMzeNr6EJ--gTXg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 274AD800B28;
        Fri,  1 Apr 2022 08:24:36 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A11F8401E4A;
        Fri,  1 Apr 2022 08:24:35 +0000 (UTC)
Date:   Fri, 1 Apr 2022 10:24:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] irqtop: support -C/--cpu-list
Message-ID: <20220401082433.ameq55psccqkay3p@ws.net.home>
References: <20220329085951.766333-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329085951.766333-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Mar 29, 2022 at 04:59:51PM +0800, zhenwei pi wrote:
>  bash-completion/irqtop  |  4 ++++
>  sys-utils/irq-common.c  | 46 ++++++++++++++++++++++++++++++-----------
>  sys-utils/irq-common.h  |  9 ++++++--
>  sys-utils/irqtop.1.adoc |  3 +++
>  sys-utils/irqtop.c      | 29 +++++++++++++++++++++++---
>  sys-utils/lsirq.c       |  2 +-
>  6 files changed, 75 insertions(+), 18 deletions(-)

Cool idea. Applied, thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

