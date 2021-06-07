Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62515C48BCF
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 08:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481C660FE3
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 08:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhFGIqW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Jun 2021 04:46:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231187AbhFGIqM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Jun 2021 04:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623055461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GX+rMSpwrc2kyNtHkQuuIiQi4CphoIFGayxEdqPZ+a4=;
        b=NtKPPxkIxcm2HFxcPV4iiIAM71jlr+V0vu9EErSYohdxg6yRvlVcKx+4Asru3AGRzs2lO8
        3PagMCFlKjcCjxyIUTrNyX1ELbJekhrpjRuk8dzKZz9jH9Xq9ICPqndjkKqqSVsFFRSP2E
        7DJazpkwUpT+xv0YnbOo3jIVrhdqrUc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-VokPIPRcOy6xBzFzIorxpQ-1; Mon, 07 Jun 2021 04:44:19 -0400
X-MC-Unique: VokPIPRcOy6xBzFzIorxpQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DA0B107ACC7;
        Mon,  7 Jun 2021 08:44:18 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 700755D75A;
        Mon,  7 Jun 2021 08:44:17 +0000 (UTC)
Date:   Mon, 7 Jun 2021 10:44:14 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nicolai Dagestad <nicolai@dagestad.fr>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] rfkill: Set scols table name to make the json output
 valid
Message-ID: <20210607084414.6uxl6gck3ey3cy4q@ws.net.home>
References: <20210606162835.131020-1-nicolai@dagestad.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606162835.131020-1-nicolai@dagestad.fr>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jun 06, 2021 at 06:28:35PM +0200, Nicolai Dagestad wrote:
> Hi, I just noticed that the json input for rfkill is invalid.
> The array member of the top-level object, should be named but it wasn't.

I have also improve libsmartcols to not use unnamed array for the
top-level object. It seems better to use emptry string ("") than
nothing.

> I am not familiar with the codease so I just followed what I saw in lscpu,
> if another name would be prefered I can change it.

Changed to "rfkilldevices".

>  sys-utils/rfkill.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks!

 karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

