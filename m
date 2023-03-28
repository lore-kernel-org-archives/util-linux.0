Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2EBC76196
	for <util-linux@archiver.kernel.org>; Tue, 28 Mar 2023 17:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjC1RFD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 28 Mar 2023 13:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjC1REt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 28 Mar 2023 13:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B52F758
        for <util-linux@vger.kernel.org>; Tue, 28 Mar 2023 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680023039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MctA0YDSDrk9RmCMrLQMsRUpjWHV72OjJJFzsy6t9OE=;
        b=ZPrHIPkocoS/JEwIxBQX+1vQ44XGKZlEuOJyQRw3mOMfnS5kwEpytvnscTslOSF3qXPTYH
        pHij0V5Ci8ZF3l4Vu5SHv3azukXr6ha4KhCBee6D5sSoyXSBtAQZjCFWTkgZcG8dnPSmDE
        ypOBmbdhYsYQI/Tarw/33HXzpXeyjuU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-qtcVXhyfP7ioa5qkO9l4yg-1; Tue, 28 Mar 2023 13:03:55 -0400
X-MC-Unique: qtcVXhyfP7ioa5qkO9l4yg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 517001C08962;
        Tue, 28 Mar 2023 17:03:55 +0000 (UTC)
Received: from ws.net.home (ovpn-192-12.brq.redhat.com [10.40.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A880FC15BA0;
        Tue, 28 Mar 2023 17:03:52 +0000 (UTC)
Date:   Tue, 28 Mar 2023 19:03:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Enze Li <lienze@kylinos.cn>
Cc:     util-linux@vger.kernel.org, enze.li@gmx.com
Subject: Re: [PATCH] setarch: add loongarch support
Message-ID: <20230328170350.sbw4gtu3wqceb35r@ws.net.home>
References: <20230327082520.292468-1-lienze@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327082520.292468-1-lienze@kylinos.cn>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 27, 2023 at 04:25:20PM +0800, Enze Li wrote:
> Signed-off-by: Enze Li <lienze@kylinos.cn>
> ---
>  sys-utils/setarch.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

That seems so trivial that we can use it for already frozen
v2.39 (-rc2).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

