Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB47C4332F
	for <util-linux@archiver.kernel.org>; Tue,  7 Nov 2023 10:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjKGK1X (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 7 Nov 2023 05:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjKGK1X (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 7 Nov 2023 05:27:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4265ED
        for <util-linux@vger.kernel.org>; Tue,  7 Nov 2023 02:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699352795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/E4aPhDfzamZvD7SLj9dl8fgslEoUPe/pisD3NhDyo=;
        b=LiI5rjls0Rq1Q4jyXrCq8fkXXnMZD752efCKigwkAauvbqfmYnGC9csVzY8+17HhwV3nbZ
        KmprpDLyvul/NAruwU2yuebLpGGN0FxZcLMQhldLZsjif/QenSaXtPZnSknCSfDI8PzaaS
        ym3wyY3vUhwMBuk2/+HlGkmwSkde3/c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-Bdzd5tP1OAW5vCqfqgB7rA-1; Tue,
 07 Nov 2023 05:26:31 -0500
X-MC-Unique: Bdzd5tP1OAW5vCqfqgB7rA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A37B1C068D2;
        Tue,  7 Nov 2023 10:26:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.1])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA4CA502A;
        Tue,  7 Nov 2023 10:26:30 +0000 (UTC)
Date:   Tue, 7 Nov 2023 11:26:28 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim.8: -v doesn't take an argument
Message-ID: <20231107102628.znpvny77zjp67aep@ws.net.home>
References: <kvjsrwxmn5rtxniy5jdceoo4s2l4fqfyarz5jdifsip75ydhlf@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kvjsrwxmn5rtxniy5jdceoo4s2l4fqfyarz5jdifsip75ydhlf@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Nov 04, 2023 at 05:51:55AM +0100, наб wrote:
> ---
> Based on 2.38.1.

It seems already fixed by commit

commit ca25874fad41d5f8c27e3646970ed28d397958b3
Author: Seth Bromberger <sbromberger@users.noreply.github.com>
Date:   Mon Dec 12 09:23:40 2022 -0500

    Update fstrim.8.adoc


released in v 2.39.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

