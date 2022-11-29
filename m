Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E2CC4332F
	for <util-linux@archiver.kernel.org>; Tue, 29 Nov 2022 10:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiK2KRO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 29 Nov 2022 05:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiK2KRI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 29 Nov 2022 05:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB212A2
        for <util-linux@vger.kernel.org>; Tue, 29 Nov 2022 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669716967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qbL8kfYj96lLKD8QNCUo/c6iJ5LBKsa7xsrzFi1JBSM=;
        b=QINxP5ghmCR/eV13lMTZJaRUT/e9ofC/BoHz3EppXIuRgWsn2sda7jnRCcda+NhZMatD9u
        W3GW25TGwUIhL1j3Z85fsPOl7vHRuSQ7V0J8Xb78gqTYcgJlKBZWX2Lm6/UmKJlIQclGBK
        aPbJ0twfT6F73zPYbTCXg3gT1azHttk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-HQ26aTpYNs27awY1buo5OA-1; Tue, 29 Nov 2022 05:16:03 -0500
X-MC-Unique: HQ26aTpYNs27awY1buo5OA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 548C61C09C8D;
        Tue, 29 Nov 2022 10:16:03 +0000 (UTC)
Received: from ws.net.home (ovpn-193-199.brq.redhat.com [10.40.193.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C26E1121314;
        Tue, 29 Nov 2022 10:16:02 +0000 (UTC)
Date:   Tue, 29 Nov 2022 11:16:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>,
        John Westerdale <jwesterd@redhat.com>, fhirtz@redhat.com
Subject: Re: [PATCH v2] libmount: use autofs mount hint to ignore autofs
 mount entries
Message-ID: <20221129101600.bzxikojw7chglrjw@ws.net.home>
References: <166928005898.283308.14145999397636040618.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166928005898.283308.14145999397636040618.stgit@donald.themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Nov 24, 2022 at 04:54:19PM +0800, Ian Kent wrote:
>  libmount/src/context.c     |   24 ++++++++++++++++++++++++
>  libmount/src/libmount.h.in |    2 ++
>  libmount/src/libmount.sym  |    3 +++
>  libmount/src/mountP.h      |    7 ++++++-
>  libmount/src/tab_parse.c   |   34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 69 insertions(+), 1 deletion(-)

Applied, thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

