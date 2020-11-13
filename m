Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3BFC4742C
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 10:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35B12078D
	for <util-linux@archiver.kernel.org>; Fri, 13 Nov 2020 10:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd1HMLkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKMKXa (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 05:23:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbgKMKX3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 13 Nov 2020 05:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605263008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e2bQFetl5+PQMH9UrciSOPhEh0lKAZBeG4IwmvOqF+M=;
        b=Nd1HMLkFmT2BLauX1yswWAMJK+ic2mov8FPFTjd4wQkuG9FyRC7s+r4Pm+P4BuFlhmBeP0
        zBvXP8dQpvt7eHYJ9e6zOjGhSnaRZz9JVrGPae0B9K64gliGdWcNuN2ZobKstb2kafzHST
        TA7PIr2TN8i7E2v3m3Yyy5nsHTlHvt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-XWFwI7FKPgWa1VVbetoXpg-1; Fri, 13 Nov 2020 05:23:24 -0500
X-MC-Unique: XWFwI7FKPgWa1VVbetoXpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D287B5F9D1;
        Fri, 13 Nov 2020 10:23:23 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC92560BE2;
        Fri, 13 Nov 2020 10:23:22 +0000 (UTC)
Date:   Fri, 13 Nov 2020 11:23:20 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     util-linux@vger.kernel.org, jbastian@redhat.com, riku.voipio@iki.fi
Subject: Re: [PATCH] lscpu: Even more Arm part numbers
Message-ID: <20201113102320.homlyz7kz7x3w454@ws.net.home>
References: <20201110160504.134143-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110160504.134143-1-jeremy.linton@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Nov 10, 2020 at 10:05:04AM -0600, Jeremy Linton wrote:
>  sys-utils/lscpu-arm.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

