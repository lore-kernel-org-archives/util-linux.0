Return-Path: <SRS0=158e=7V=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E6C433E0
	for <util-linux@archiver.kernel.org>; Mon,  8 Jun 2020 07:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B1C206D5
	for <util-linux@archiver.kernel.org>; Mon,  8 Jun 2020 07:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9MpsyeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgFHH4J (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:56:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729023AbgFHH4J (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Jun 2020 03:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591602968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=966SKOS3fp4dngI2RYx425Saj2ocoqpe9AlomZCI874=;
        b=Z9MpsyeFxdgXiw6y3aDz5AmyjTwNYj8bxDoRfqdrlbFYucMFILOdJtHr7a0X8ajv2Ixq9W
        oNeFuiyjqSAywfkef7KYPXXm9lbNtHCiKyVoPUmjJxAh2KMPGXQAbPo0xsoRk2lZnGVuoD
        Y6Dyz4HHrYaQz4ZLazbiwyPDlI+zUuU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-jnCFqMyWMBiU9xZiNN2aRA-1; Mon, 08 Jun 2020 03:56:05 -0400
X-MC-Unique: jnCFqMyWMBiU9xZiNN2aRA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E15681F09E;
        Mon,  8 Jun 2020 07:55:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F63D10013D0;
        Mon,  8 Jun 2020 07:55:57 +0000 (UTC)
Date:   Mon, 8 Jun 2020 09:55:55 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     util-linux@vger.kernel.org, heiko.carstens@de.ibm.com,
        tmricht@linux.ibm.com, svens@linux.ibm.com
Subject: Re: [PATCH] lscpu: Add shared cached info for s390 lscpu -C
Message-ID: <20200608075555.vidolanraeu5qndh@ws.net.home>
References: <20200605161510.17641-1-sumanthk@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605161510.17641-1-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 05, 2020 at 06:15:10PM +0200, Sumanth Korikkar wrote:
>  sys-utils/lscpu.c | 169 +++++++++++++++++++++++++++-------------------
>  1 file changed, 101 insertions(+), 68 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

