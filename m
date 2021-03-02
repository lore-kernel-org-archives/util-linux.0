Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207E9C433DB
	for <util-linux@archiver.kernel.org>; Wed,  3 Mar 2021 03:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAC064E6B
	for <util-linux@archiver.kernel.org>; Wed,  3 Mar 2021 03:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbhCCDfU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 2 Mar 2021 22:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1577741AbhCBJw2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Mar 2021 04:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614678659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zBQTkNKODntpAzxRu/De4cOUf004jFgYPcjZHoOMot4=;
        b=NlWyQapYKTamyNJjJvPs1tkWnYgt/xqHPSye7py8pz4s4oZTnmqo1Z5tjkq5xObi9xn+aD
        cPYyrtTVQhe8d0l9nqRgkr893VXO2/xgGXXMPnHI9mcjpRUxevfe15Y7K+x60yQE9VFWe1
        3OmxMaizuZ6+8WvwteDgUWY9r4xA27Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-YJ3wys39NwmF8ZPeEPeGxw-1; Tue, 02 Mar 2021 04:50:55 -0500
X-MC-Unique: YJ3wys39NwmF8ZPeEPeGxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D17427C1;
        Tue,  2 Mar 2021 09:50:54 +0000 (UTC)
Received: from ws.net.home (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25E8560BFA;
        Tue,  2 Mar 2021 09:50:52 +0000 (UTC)
Date:   Tue, 2 Mar 2021 10:50:50 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Andrew Shapiro <anshapiro@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] utmpdup: Ensure flushing when using follow flag
Message-ID: <20210302095050.mk57iobf4ivugafi@ws.net.home>
References: <593E7F58-59CA-4310-8420-D400CBF8ADE7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <593E7F58-59CA-4310-8420-D400CBF8ADE7@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 01, 2021 at 01:18:27PM -0500, Andrew Shapiro wrote:
>  login-utils/utmpdump.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

