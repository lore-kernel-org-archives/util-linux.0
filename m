Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3408DC433EF
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351240AbiAYQdI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 11:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1451628AbiAYQav (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 25 Jan 2022 11:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643128250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s7S8OYChLdaSSJ0DwA7fFc+FUHpPzp8K3s76IWbYb1E=;
        b=I2hcvSPn73YBXJXcdOkPA6eXncdFxkI+qLP90k0IUeb2zC+yfBQNnC2XoTppNAdORyB49u
        o7a1OPnCfakQXmmJmoOVQWXLGSEpQN5ji6UhfAxvMNJhCs+4sLLjs/Phv49JgBLJaMQ3ld
        a/UyoAOjNE6d7xwXmZI6ZVUXOTFi1oU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-132-bLQWWgUCNfWsglG1_wc2gg-1; Tue, 25 Jan 2022 11:30:48 -0500
X-MC-Unique: bLQWWgUCNfWsglG1_wc2gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55A08593AE;
        Tue, 25 Jan 2022 16:30:47 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DDA798C1;
        Tue, 25 Jan 2022 16:30:45 +0000 (UTC)
Date:   Tue, 25 Jan 2022 17:30:42 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     util-linux@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: [PATCH] mount: Fix race in loop device reuse code
Message-ID: <20220125163042.owskf5455qlil7xk@ws.net.home>
References: <20220120114705.25342-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120114705.25342-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jan 20, 2022 at 12:47:05PM +0100, Jan Kara wrote:
>  libmount/src/context_loopdev.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied, thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

