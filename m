Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B671C433F5
	for <util-linux@archiver.kernel.org>; Tue, 26 Apr 2022 08:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345457AbiDZIlG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345468AbiDZIko (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 Apr 2022 04:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70E191527A9
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650961964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mSRKKOM5anutqXnfY4/no+20Zv/KhzlFmbauQ8iJxg=;
        b=JtoVR9gs1Jh/Ne+qjepErc18CbusuS+R6zOzprScYXwfz725m0uiikDqU5d8vsg6OUi+5F
        8WETIRykjbI2Afpq8XY5IkvKljccJTy0+MxjGOzUMDBxCA59CKEDtTgw6SRCqMRSk75Urd
        4yIkzjUoQDylW7lrHQjt1O1QIXeH5NA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-x8bcUsziNcaie3QN5e5RjA-1; Tue, 26 Apr 2022 04:32:43 -0400
X-MC-Unique: x8bcUsziNcaie3QN5e5RjA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21B141014A66
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 08:32:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97D3941615C;
        Tue, 26 Apr 2022 08:32:42 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:32:40 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] libblkid: add FSSIZE with XFS implementation
Message-ID: <20220426083240.vsatmjbdwzvla6ox@ws.net.home>
References: <20220425150838.151020-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425150838.151020-1-aalbersh@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 25, 2022 at 05:08:36PM +0200, Andrey Albershteyn wrote:
> Andrey Albershteyn (3):
>   libblkid: add interface for FSSIZE field
>   libblkid: implement FSSIZE calculation for XFS
>   blkid: add FSSIZE tag with tests for XFS
> 
>  libblkid/samples/superblocks.c         |  2 +-
>  libblkid/src/blkid.h.in                |  1 +
>  libblkid/src/superblocks/superblocks.c | 11 +++++++++++
>  libblkid/src/superblocks/superblocks.h |  1 +
>  libblkid/src/superblocks/xfs.c         | 10 ++++++++++
>  misc-utils/blkid.c                     |  3 ++-
>  tests/expected/blkid/low-probe-xfs     |  1 +
>  tests/expected/blkid/low-probe-xfs-v5  |  1 +
>  8 files changed, 28 insertions(+), 2 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

