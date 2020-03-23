Return-Path: <SRS0=nY5j=5I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37E5C4332B
	for <util-linux@archiver.kernel.org>; Mon, 23 Mar 2020 10:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9779F2072E
	for <util-linux@archiver.kernel.org>; Mon, 23 Mar 2020 10:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwPhsu81"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCWKdV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:33:21 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:32568 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727810AbgCWKdV (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 23 Mar 2020 06:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584959600;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JuOvdjNn9GBFfy6lm1WEBvMxWt6sKnolAGlQPmsuZTQ=;
        b=MwPhsu81s+BuIO6osdfVS51HfysQ+bAYFVnwdZj+UV7Ep7KsTfbMG4Zskjzr2HHj4H8zHS
        Y+IwTuqq1FHQWRd5fyTb1aSuF9+89iYvC9bGBrPds1LtoJAqx6oVE2hBRTqtfUd/in2tE2
        vGi6RZh8k007huXh6GXC+fTUyGF67Ic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-NWQv_XPiM9KmWHvsswfuFg-1; Mon, 23 Mar 2020 06:33:15 -0400
X-MC-Unique: NWQv_XPiM9KmWHvsswfuFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85698024D5;
        Mon, 23 Mar 2020 10:33:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BABD260BE0;
        Mon, 23 Mar 2020 10:33:09 +0000 (UTC)
Date:   Mon, 23 Mar 2020 11:33:05 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     util-linux@vger.kernel.org,
        Benno Schulenberg <bensberg@justemail.net>
Subject: Re: [PATCH] libblkid: Add support for zonefs
Message-ID: <20200323103305.uhlc3d7i4famwq5p@ws.net.home>
References: <20200320045543.2053382-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320045543.2053382-1-damien.lemoal@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Mar 20, 2020 at 01:55:43PM +0900, Damien Le Moal wrote:
>  libblkid/src/Makemodule.am             |  1 +
>  libblkid/src/superblocks/superblocks.c |  3 +-
>  libblkid/src/superblocks/superblocks.h |  1 +
>  libblkid/src/superblocks/zonefs.c      | 87 ++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100644 libblkid/src/superblocks/zonefs.c

Applied (with a small change), thanks.

> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;

We use standard integer types rather than this kernel-ism ;-) Fixed.

It would be nice to have a test image for zonefs, something small what
we can add to tests/ts/blkid/images-fs/ ;-)


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

