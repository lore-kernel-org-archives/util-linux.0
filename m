Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05871C636D4
	for <util-linux@archiver.kernel.org>; Fri,  3 Feb 2023 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjBCMJ0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Feb 2023 07:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjBCMJZ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Feb 2023 07:09:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE29DCAF
        for <util-linux@vger.kernel.org>; Fri,  3 Feb 2023 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675426118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAcC3coxREQOyE0v8N35WYYjcjGORMNgZ9uVM7JlJoA=;
        b=dWyUzIdCDYSK2PI2hxBk5777lZMKUriW9rqxVh/hJKonTMwqlg0VYzq5SYTLEdPjTjlutT
        Wz4pMh9RHPhX1fRlYsFbIz47Eh+glH/mY6e0sUhRKvcax+0iYlizGPZRonysLnwCss6ZlS
        agNuWcJYaF2o5rhSXT613Dg6GQuLhMo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-_s2l1uXgORuRHMfcGQGOOQ-1; Fri, 03 Feb 2023 07:08:35 -0500
X-MC-Unique: _s2l1uXgORuRHMfcGQGOOQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1A4D185A7A4;
        Fri,  3 Feb 2023 12:08:34 +0000 (UTC)
Received: from ws.net.home (ovpn-193-32.brq.redhat.com [10.40.193.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46594140EBF4;
        Fri,  3 Feb 2023 12:08:34 +0000 (UTC)
Date:   Fri, 3 Feb 2023 13:08:32 +0100
From:   Karel Zak <kzak@redhat.com>
To:     yegorslists@googlemail.com
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] git: ignore m4/libtool.m4.orig
Message-ID: <20230203120832.4iamsirkbjpvgge3@ws.net.home>
References: <20230130103453.1080-1-yegorslists@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130103453.1080-1-yegorslists@googlemail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 30, 2023 at 11:34:53AM +0100, yegorslists@googlemail.com wrote:
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

