Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD1BC433F5
	for <util-linux@archiver.kernel.org>; Mon, 14 Mar 2022 09:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiCNJoi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiCNJoh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2022 05:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF27EBC33
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2022 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647251006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=80QK1BGKefdGlz6NACdYsQRer0RThTJwBj5D+Lx5T/8=;
        b=XKqI/MEvOMy9Q40+Jzn8qnD70VRhL0XJz+rMrotvRtOJhcN+bLtF1DstVwkoB4aMCuqUKT
        o4KJY69l6zk04iSjnI1oh0MAqMjPCFvwTZJnpOStUZr0IVCDrkjAJG27osQrFTg+ByZRcE
        vyJ+6PFaK7ZBryMWJ8itsBpvMgoEk/s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-CDGpSF7aOceSrjR5lGS48A-1; Mon, 14 Mar 2022 05:43:25 -0400
X-MC-Unique: CDGpSF7aOceSrjR5lGS48A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2C5F2999B2E;
        Mon, 14 Mar 2022 09:43:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57B0F145D37F;
        Mon, 14 Mar 2022 09:43:24 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:43:21 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Petr Pisar <petr.pisar@atlas.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: A mistake in "failed to cache size" message
Message-ID: <20220314094321.362v57sshtxxcaxi@ws.net.home>
References: <YiyH3zt/z206Hs3K@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiyH3zt/z206Hs3K@album.bayer.uni.cx>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Mar 12, 2022 at 12:45:35PM +0100, Petr Pisar wrote:
> while translating util-linux-2.38-rc2, I noticed that this message:
> 
> #: misc-utils/hardlink.c:1262
> msgid "failed to cache size"
> 
> should read:
> 
> msgid "failed to parse a cache size"

Thanks for your report. Fixed by Benno's patch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

