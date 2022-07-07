Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2558C433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Jul 2022 11:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiGGLDF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 7 Jul 2022 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiGGLDC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 7 Jul 2022 07:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F91057224
        for <util-linux@vger.kernel.org>; Thu,  7 Jul 2022 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657191780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=shctpHWRZGMNkQ55gwM+nDGvkKHIls/N8u8+DcsPUyk=;
        b=DvEOGVfiNGYWes5TX5z8/mobaC2EEZxkB/CASK3SSL2718/Z4NH8nU5TyRVcRShTqDRJcC
        XQLVOsZ4BcZ+HnKpFwU+QNnkLUop9ASV6AmhubBQuz3Uh+wpfQfpnLa6YSGCRgP8YvJm4d
        fCrF9/+NZtYpXyoEd8afZ9nNsF+bzNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-Ag-qkM26OU2TgCNX9Uv5yg-1; Thu, 07 Jul 2022 07:02:50 -0400
X-MC-Unique: Ag-qkM26OU2TgCNX9Uv5yg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90722185A794;
        Thu,  7 Jul 2022 11:02:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1397C492C3B;
        Thu,  7 Jul 2022 11:02:49 +0000 (UTC)
Date:   Thu, 7 Jul 2022 13:02:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Trapp <michael.trapp@sap.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Implement continuous clock handling for time based UUIDs
Message-ID: <20220707110246.n2krnr6gj2p664k7@ws.net.home>
References: <20220620151036.97706-1-michael.trapp@sap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620151036.97706-1-michael.trapp@sap.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 20, 2022 at 05:10:36PM +0200, Michael Trapp wrote:
>  libuuid/src/gen_uuid.c  | 91 ++++++++++++++++++++++++++++++++++++++---
>  libuuid/src/libuuid.sym |  1 +
>  libuuid/src/uuidd.h     |  1 +
>  misc-utils/uuidd.8.adoc |  3 ++
>  misc-utils/uuidd.c      | 54 +++++++++++++++++++++---
>  5 files changed, 140 insertions(+), 10 deletions(-)

 Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

