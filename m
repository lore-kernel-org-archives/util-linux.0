Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F417C3526C
	for <util-linux@archiver.kernel.org>; Mon,  7 Feb 2022 10:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiBGKPD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Feb 2022 05:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352382AbiBGKAh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Feb 2022 05:00:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E79D1C043188
        for <util-linux@vger.kernel.org>; Mon,  7 Feb 2022 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644228034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+1y+BQQ93P9meBhx56jWFC27GYU2eVVBK+MHI9yxuw=;
        b=Hp5ZfrjgCRFzb19iseOH+rIovB8Szxnrrh7i9j5zO+ks8Zw0GnKVii0IHcCiTkcDY/grvb
        Qx4qnEWGRM/ZSNbQAUykF6DL7QI73v0lljuQ+MzuNuKVCuOhmulxDxqw94G1qvMmlhl63L
        G7xw79ibDn+qoeiVVRbDCn/3USL56jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-rc09fin_Mt6OYvqLctYfGg-1; Mon, 07 Feb 2022 05:00:31 -0500
X-MC-Unique: rc09fin_Mt6OYvqLctYfGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 429F3100C661;
        Mon,  7 Feb 2022 10:00:30 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 900992A198;
        Mon,  7 Feb 2022 10:00:29 +0000 (UTC)
Date:   Mon, 7 Feb 2022 11:00:26 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Johannes Altmanninger <aclopte@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] newgrp.1.adoc: use bold font for command name in
 synopsis
Message-ID: <20220207100026.7eph3r747agp32sn@ws.net.home>
References: <20220206061158.752262-1-aclopte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206061158.752262-1-aclopte@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Feb 06, 2022 at 07:11:55AM +0100, Johannes Altmanninger wrote:
>  login-utils/newgrp.1.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Applied (all 4 patches), thanks!

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

