Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE40C433DB
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 11:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7280622A83
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 11:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbhAEL55 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 06:57:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbhAEL54 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 06:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609847791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/QtghMGxFIQzTtgG6MeJv9PH0fuQ68/tb0F1ctRBB4w=;
        b=YvminJ5NV4B/RNYtLrLZARFklA48pL1fkjT0kfcq1TPQ9wIv9qUtL65ALq/4mn6PHfAtsB
        /EEA5rDkCPjm6h8AQnZiw1zjQi+PkFqP5tya+pxhchr2qVrMKlDFpIP4nMAc19P1sFQGEY
        Cq+4n8ve2t5XyN3UvK9Fed8sC6W541k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-nWN5vDJFOjizdFMzuixUzA-1; Tue, 05 Jan 2021 06:56:26 -0500
X-MC-Unique: nWN5vDJFOjizdFMzuixUzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33526800D53;
        Tue,  5 Jan 2021 11:56:25 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 82AA319C46;
        Tue,  5 Jan 2021 11:56:24 +0000 (UTC)
Date:   Tue, 5 Jan 2021 12:56:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] cfdisk: show Q option when choosing label type
Message-ID: <20210105115621.q4ib7dvtpjuv3wlo@ws.net.home>
References: <20201228000233.3971550-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228000233.3971550-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Dec 28, 2020 at 12:02:33AM +0000, Chris Hofstaedtler wrote:
>  disk-utils/cfdisk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

