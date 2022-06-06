Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF9C433EF
	for <util-linux@archiver.kernel.org>; Mon,  6 Jun 2022 10:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiFFKYg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiFFKYf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2022 06:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7695F21257
        for <util-linux@vger.kernel.org>; Mon,  6 Jun 2022 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654511070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hhlreJ5pCRxk06nDOuLC/GziCeOJ2XZ/dWJZ43hIYuI=;
        b=EuSh8LrfrUjhkU6dxPiuc8Hzan5sZw3m48jNzevRhAy/lMTeGnJMCC8jsJ8c1Ln1nTL6Bb
        1pkVNco7lF2F6DKmOJILaWPAypsNeRyXJWQNZatbh2vrlH7wPgaGerhmu36qZp3D/quygc
        VCKHFGhNM7vJbXodZM4vbtVb5aERs3w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-w7RD2OI8O1iCsQ77r0lG3A-1; Mon, 06 Jun 2022 06:24:29 -0400
X-MC-Unique: w7RD2OI8O1iCsQ77r0lG3A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 060E5101AA47;
        Mon,  6 Jun 2022 10:24:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B85B40EC002;
        Mon,  6 Jun 2022 10:24:28 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:24:26 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Nathan Sharp <nwsharp@live.com>
Cc:     util-linux@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>
Subject: Re: [PATCH] pipesz: use native PAGE_SIZE in tests
Message-ID: <20220606102426.vmxud5slnzmuee5g@ws.net.home>
References: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
 <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 03, 2022 at 08:00:22PM -0600, Nathan Sharp wrote:
>  tests/expected/misc/pipesz-get-fd   |  2 +-
>  tests/expected/misc/pipesz-get-file |  2 +-
>  tests/ts/misc/pipesz                | 10 ++++++++--
>  3 files changed, 10 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

