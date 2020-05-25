Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7184FC433DF
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533592073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV3pLfnf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390516AbgEYMSc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390196AbgEYMSb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 May 2020 08:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590409110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rb6xjv5xpG/P/hssdQaWDZlaauSV+yGMnMNVlN2RijI=;
        b=LV3pLfnfi6heSBhyCPukleNGlPYdzPwBM5Ldd7L1zvmR0VmCMqeLHfX7n7FeKcNezG/ZqY
        C21zmHuLzhNxVyG7bVMHQLXqK3G4lY3mSvugWLPPnDjVpA5/goJrdfJ13jBEfXVx9DlOCG
        YT/SrI2IS3J+gms0BWgYvfahUC8fQUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-GRWfEpuaM8G5692BQZneqg-1; Mon, 25 May 2020 08:18:28 -0400
X-MC-Unique: GRWfEpuaM8G5692BQZneqg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 946DD461;
        Mon, 25 May 2020 12:18:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D38AE6062D;
        Mon, 25 May 2020 12:18:26 +0000 (UTC)
Date:   Mon, 25 May 2020 14:18:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Sami Kerola <kerolasa@iki.fi>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] more: avoid libmagic telling an empty file is binary
Message-ID: <20200525121824.szmnpg7gexytcecx@ws.net.home>
References: <20200525073024.40308-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525073024.40308-1-kerolasa@iki.fi>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 25, 2020 at 08:30:24AM +0100, Sami Kerola wrote:
>  text-utils/more.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

