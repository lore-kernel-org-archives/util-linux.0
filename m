Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24761C433E0
	for <util-linux@archiver.kernel.org>; Thu, 25 Feb 2021 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82A264E20
	for <util-linux@archiver.kernel.org>; Thu, 25 Feb 2021 08:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhBYIgc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 25 Feb 2021 03:36:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46466 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235168AbhBYIgb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 25 Feb 2021 03:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614242104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vFcSpCsL1mTIInnFJmjhQbyRRykxN+1i+s4svk888FY=;
        b=UUzKQPjARvmmPJqA/9XptN8WmcYE8X6C6NmfgcAt13jgG9d/0KWFBgTFqbNNOOdebtbZae
        Llc4hifwEXa/+jRoGa3zdadS2VILZ6c2LzpGL6/9kl0JgFFeYe3gaf2qdEyR3TVEnJJJ0a
        4mkA144fXlYGzethygs1Yw4zwomfPBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-BlbB81T7MTO8eHYdr0t51Q-1; Thu, 25 Feb 2021 03:35:00 -0500
X-MC-Unique: BlbB81T7MTO8eHYdr0t51Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 753441966323
        for <util-linux@vger.kernel.org>; Thu, 25 Feb 2021 08:34:59 +0000 (UTC)
Received: from ws.net.home (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 960ED19C79;
        Thu, 25 Feb 2021 08:34:58 +0000 (UTC)
Date:   Thu, 25 Feb 2021 09:34:56 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <snemec@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] su: fix man page typos
Message-ID: <20210225083456.lamxe4qnwqfxmz5z@ws.net.home>
References: <20210223152554.2649033-1-snemec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210223152554.2649033-1-snemec@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 23, 2021 at 04:25:54PM +0100, Štěpán Němec wrote:
>  login-utils/su.1 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

