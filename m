Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E49C43334
	for <util-linux@archiver.kernel.org>; Mon, 18 Jul 2022 11:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiGRLoi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Jul 2022 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiGRLoi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2022 07:44:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1612B72
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2022 04:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658144676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qd06cmBqy5f4FozYBaEIVCNtZRCdyU8m/eKA9blD7YE=;
        b=XkjRZSSwlr5lxSk3gDf8pcBJ5dLdY2i2BXT1XTPimaDLpSV/D11uH4JHKcG3shzdse7LEP
        d/a42Ab162GIzCJ2/2jp6E8RCRnnH9BEixrZy8L4+GwfpiZ6eEv258M55Gp0Bkk3Nck9Ml
        +IL5Xz08Yhxwm5V5LKg9qfd+eehYVAY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-xi2UGkTdO5moivtF_HJmmw-1; Mon, 18 Jul 2022 07:44:34 -0400
X-MC-Unique: xi2UGkTdO5moivtF_HJmmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3C19928004A1
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2022 11:44:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6942C15D67;
        Mon, 18 Jul 2022 11:44:33 +0000 (UTC)
Date:   Mon, 18 Jul 2022 13:44:31 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andrew Price <anprice@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] uuid_copy: (man) Add missing parenthesis
Message-ID: <20220718114431.impjasehjwxlz4xy@ws.net.home>
References: <20220715145513.469044-1-anprice@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715145513.469044-1-anprice@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jul 15, 2022 at 03:55:13PM +0100, Andrew Price wrote:
>  libuuid/man/uuid_copy.3.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

