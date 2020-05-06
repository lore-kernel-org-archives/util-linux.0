Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6E3C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A487206D5
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvF8kX6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgEFNQO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:16:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37056 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727969AbgEFNQN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588770973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kc33gD+Bh697Zxe+kQK0G0SJ3vyj0qT3ml3hy6xUBlM=;
        b=GvF8kX6qrGXpgOZ+h7N321OXoBXCCvcgF3+e49pqJV66lLkoXhUx3sNI3nzXcW91AgH1Gn
        s1yLgkMWvCQTu93thR6YsRII51EgY8bBfeLdYa5JPgIFNhthflSsrGr69TGANuQjWCYLGt
        Jiu6/5OWrwR9hLDQ/Gv7QLFA2Q7HiXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-YHaY8L5lMsGFNzjYiDBkKA-1; Wed, 06 May 2020 09:16:11 -0400
X-MC-Unique: YHaY8L5lMsGFNzjYiDBkKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E231083E81;
        Wed,  6 May 2020 13:16:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D187E60BEC;
        Wed,  6 May 2020 13:16:08 +0000 (UTC)
Date:   Wed, 6 May 2020 15:16:06 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org, Mark Hindley <mark@hindley.org.uk>
Subject: Re: [PATCH] Fix for misc/fallocate test build failure.
Message-ID: <20200506131606.gaj6v4jguhrxdyib@ws.net.home>
References: <20200505192854.2194308-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505192854.2194308-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 05, 2020 at 09:28:55PM +0200, Chris Hofstaedtler wrote:
>  tests/ts/misc/fallocate | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

