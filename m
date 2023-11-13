Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAACFC4332F
	for <util-linux@archiver.kernel.org>; Mon, 13 Nov 2023 13:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjKMNy7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 Nov 2023 08:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjKMNy6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Nov 2023 08:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AD2D54
        for <util-linux@vger.kernel.org>; Mon, 13 Nov 2023 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699883647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J7uBNVkmF3GsLxbF+sNJx1SRQKNO/NgOukk66ulWkK8=;
        b=eXADbUJYRhQnqZlAPwZRSYk5w07SLpPbHE4h75r7s+O/0Ss6GdxU27JS2p0rxoE2i2Pu5V
        NQxIU4oYkb4wDK9BFkIbeFuG0igeoqWHVoHBURHOc9lF6FEWvAVr6OSytxi+eIQbswwrrB
        Q013g+rpQxH9IJORRheBU22+2jqjLUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-YfUZVi3DPKyyJz8_pOS1Xg-1; Mon, 13 Nov 2023 08:54:04 -0500
X-MC-Unique: YfUZVi3DPKyyJz8_pOS1Xg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18B7E916D62;
        Mon, 13 Nov 2023 13:54:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.94])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B4F4502C;
        Mon, 13 Nov 2023 13:54:03 +0000 (UTC)
Date:   Mon, 13 Nov 2023 14:54:01 +0100
From:   Karel Zak <kzak@redhat.com>
To:     "Trapp, Michael" <michael.trapp@sap.com>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libuuid: avoid truncate clocks.txt to improve performance
Message-ID: <20231113135401.wa3nm6hfulon3wig@ws.net.home>
References: <i4fuwkw2hvj6gge3uhuy3jlq5gg4ls7djibygcb5duxhumvllx@cernuqwwl7pi>
 <20231107103302.paeetyxxlu36me57@ws.net.home>
 <AS4PR02MB85506893B87E53BFF5276BFAF9AFA@AS4PR02MB8550.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR02MB85506893B87E53BFF5276BFAF9AFA@AS4PR02MB8550.eurprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 09, 2023 at 02:17:43PM +0000, Trapp, Michael wrote:
> Could you please apply this patch to util-linux?

Applied.

> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> >
> > ---
> >  libuuid/src/gen_uuid.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)


Thanks Goldwyn and Michael.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

