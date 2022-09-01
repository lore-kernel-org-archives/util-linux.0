Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD867ECAAD1
	for <util-linux@archiver.kernel.org>; Thu,  1 Sep 2022 09:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiIAJb0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbiIAJbT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Sep 2022 05:31:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E62EDDA86
        for <util-linux@vger.kernel.org>; Thu,  1 Sep 2022 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662024667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3pxUuvqLzGr2pUV7S/+o2PCKArOqA5WY2pB7NhveRQ4=;
        b=EmR5HgeCRGHvUP3aYk85QOLf2VHFnATWbLnrmcdOuwzRmSYgu4uTl/vu/GDetMOpsXvI5A
        h4gxEByZmi4NBDk41iyIPwqmO3c94C5kDUM8Uf+2THDXpDHfSbokwxcWqgaUenIMadcsyf
        msrTc+8DvXEmmgvjfxAZrSlCM2IuJ8k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-xwQPNvZTOY-eAP3seTfCEA-1; Thu, 01 Sep 2022 05:31:06 -0400
X-MC-Unique: xwQPNvZTOY-eAP3seTfCEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4F583C0E237;
        Thu,  1 Sep 2022 09:31:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 279C71415125;
        Thu,  1 Sep 2022 09:31:03 +0000 (UTC)
Date:   Thu, 1 Sep 2022 11:31:01 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Webb <chris@arachsys.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] unshare: Don't waste an ID when -r is used with
 --map-auto
Message-ID: <20220901093101.unhmf3ljmna4rele@ws.net.home>
References: <5e2a06cda7e0449aa2a1ce63ee069f942546e73b.1661341169.git.chris@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e2a06cda7e0449aa2a1ce63ee069f942546e73b.1661341169.git.chris@arachsys.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Aug 24, 2022 at 12:52:55PM +0100, Chris Webb wrote:
>  sys-utils/unshare.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

