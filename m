Return-Path: <SRS0=qobI=74=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B99C433DF
	for <util-linux@archiver.kernel.org>; Mon, 15 Jun 2020 09:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C800E2065F
	for <util-linux@archiver.kernel.org>; Mon, 15 Jun 2020 09:36:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CeettLso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgFOJgy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:36:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48239 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728815AbgFOJgy (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 15 Jun 2020 05:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592213813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCAXThaJjkktrGt4FF5BH2UY1zYHY/cHBPDCDvH5YHI=;
        b=CeettLsoHzIbNIpDrKrcw38KE5TKA94Cv7oRkmqQ3F4IT9QO5xUNxN6W2loWLc7GpkOP7h
        0MyF6ZkW1oAHpk4TcJTBZ1QX6VBhED9i8NkU9BnJ4JkgRRPZFIfn9JGx6Lol2BTdnbnYHb
        CpEfBX1/moPAAlcv43m2e9t6s5moVeg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-mnj-_B-kPuG_53t-CDakmw-1; Mon, 15 Jun 2020 05:36:46 -0400
X-MC-Unique: mnj-_B-kPuG_53t-CDakmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66F3E18A2663;
        Mon, 15 Jun 2020 09:36:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A624F60C47;
        Mon, 15 Jun 2020 09:36:43 +0000 (UTC)
Date:   Mon, 15 Jun 2020 11:36:40 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] doc: disk-utils/*: Fix some warnings from "mandoc -T
 lint"
Message-ID: <20200615093640.gi43verr7oq6oph5@ws.net.home>
References: <20200610214910.GA18305@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610214910.GA18305@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 10, 2020 at 09:49:10PM +0000, Bjarni Ingi Gislason wrote:
>  disk-utils/fsck.minix.8 | 1 -
>  disk-utils/isosize.8    | 1 -
>  disk-utils/sfdisk.8     | 2 +-
>  disk-utils/swaplabel.8  | 1 -
>  4 files changed, 1 insertion(+), 4 deletions(-)

 Bjarni, all your 8 patches applied. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

