Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52955C433DF
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 07:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323F42074D
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 07:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuwmBeto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgE2HqV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 03:46:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58783 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgE2HqV (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 May 2020 03:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590738380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S/3JSu4IPvXdi28ohTE/rb92fF1fxQX13vBY+PxkSuY=;
        b=HuwmBetoHOEjysnDqvCF9RxDPgX+xnQwmeKCcty0fTvzywkAnw3PAuaIU5fd1RW+EUUHDM
        0rzNFKOcMnFYoBDMb+2liv5/1bFcFFNM+pbCXB4xE49BFd0g+dBwb6/O8pn2LLVZAXl73W
        brH5DKC/g2A5WhQFM9vFxFIQI2KoveE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-8FaalXGYMo-wjVLNkri8jQ-1; Fri, 29 May 2020 03:46:15 -0400
X-MC-Unique: 8FaalXGYMo-wjVLNkri8jQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D70C0107ACF2;
        Fri, 29 May 2020 07:46:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E3E860C81;
        Fri, 29 May 2020 07:46:13 +0000 (UTC)
Date:   Fri, 29 May 2020 09:46:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 01/10] Manual pages: unshare.1: EXAMPLES: improve
 persistent mount namespace example
Message-ID: <20200529074611.kjzmhxyvee6jxe7g@ws.net.home>
References: <20200528145823.978508-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528145823.978508-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 28, 2020 at 04:58:15PM +0200, Michael Kerrisk (man-pages) wrote:
>  sys-utils/unshare.1 | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

All 10 patches applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

