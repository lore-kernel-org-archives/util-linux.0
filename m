Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C4C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60970206D5
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQuyNlMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEFNQv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:16:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42157 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728081AbgEFNQu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588771010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zw4NMdVd36o7slCtodbrrIZp6nknO9jyBeZQSbdU7uY=;
        b=EQuyNlMm8RF/pjdhTMAkjpeKVPOvJVBRSXFhNfO9imSvwKDXBiK+cEhyALx/WE8m0AD5UD
        0K51oDmTJEkuM6TeBjRKlAvEg81eaQiGBqlVJrUkBhlnanAZ0Pndxs3FBJ3Z0UxyLyLCYC
        SIYpo/jn6/0/PKiuhiAaZNpZ9QYfpFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-BdF-hy1uNauM0IwLbhBaNA-1; Wed, 06 May 2020 09:16:46 -0400
X-MC-Unique: BdF-hy1uNauM0IwLbhBaNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82451468;
        Wed,  6 May 2020 13:16:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF84F60F8A;
        Wed,  6 May 2020 13:16:41 +0000 (UTC)
Date:   Wed, 6 May 2020 15:16:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] fdisk: specify in '--help' that we can have multiple
 devices with '-l'
Message-ID: <20200506131639.c5gbv3gv3ypucplw@ws.net.home>
References: <20200506103750.2587-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506103750.2587-1-wsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 12:37:50PM +0200, Wolfram Sang wrote:
>  disk-utils/fdisk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

