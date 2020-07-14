Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB7C433DF
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279B32075B
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4vPd3zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgGNItT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:49:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725955AbgGNItT (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Jul 2020 04:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BYVXdxaPghJ/2q1LT5ukdb+QbW5+ZlKESQyyLcc6rm4=;
        b=U4vPd3ziAqZUeFnT/4aE8QXbMCUIkPF0oLaMMv3RDGAFMvbAiEdN9SX8NJG/YlACmBTxni
        LIh+jNhxrJagNGYBre2jzIXNK7WjyFnkNmJuxDrMvDtEOqxAIPv7u4y6IUVYn0DT/dhc37
        I4+jopSif10j9tlk7KoUQahNqyCMat8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-oP7SERhsP0iiyRxmTT7jzw-1; Tue, 14 Jul 2020 04:49:16 -0400
X-MC-Unique: oP7SERhsP0iiyRxmTT7jzw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA9301009456;
        Tue, 14 Jul 2020 08:49:15 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0069E61471;
        Tue, 14 Jul 2020 08:49:14 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:49:12 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Subject: docs: change from nofill to fill mode
Message-ID: <20200714084912.jw3vhhwhyfsyhajn@ws.net.home>
References: <20200709235026.GA29712@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235026.GA29712@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jul 09, 2020 at 11:50:26PM +0000, Bjarni Ingi Gislason wrote:
>  misc-utils/uuidd.8.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

