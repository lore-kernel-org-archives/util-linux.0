Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6EFC433F5
	for <util-linux@archiver.kernel.org>; Thu, 26 May 2022 07:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiEZH7o (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 May 2022 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiEZH7n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 May 2022 03:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7145A31DC6
        for <util-linux@vger.kernel.org>; Thu, 26 May 2022 00:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653551981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2cEEMoaXD+u/ZxytDSSr/FJS1i79TZ2/2soZYGTXT5I=;
        b=Vd0xjwxyUjZ+BIx2kIFsFrEtaWlTPDRpo+olsxmaX0LZHlEEVG6b1EduDSydL++2TvXDWU
        9k+tv75d2cRljD1TbkMQYc2rhmctuDQD6nP6hQpF+o/5wTkVPYpdQtViAxpqh1Kvx9UzD1
        d9x/xH5ggvd/0JX1Nz2AhMAnJMXkfvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263--1dyuSpUPmype350f05B9A-1; Thu, 26 May 2022 03:59:38 -0400
X-MC-Unique: -1dyuSpUPmype350f05B9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC11A185A79C;
        Thu, 26 May 2022 07:59:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C1511121315;
        Thu, 26 May 2022 07:59:36 +0000 (UTC)
Date:   Thu, 26 May 2022 09:59:32 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Hideki EIRAKU <hdk@igel.co.jp>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: set block_size when using LOOP_CONFIGURE
Message-ID: <20220526075932.xbupsigtr7z2fgt7@ws.net.home>
References: <20220525.122316.1064747285110838277.hdk@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525.122316.1064747285110838277.hdk@igel.co.jp>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 25, 2022 at 12:23:16PM +0900, Hideki EIRAKU wrote:
>  lib/loopdev.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied, thanks.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

