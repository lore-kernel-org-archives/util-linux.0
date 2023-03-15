Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B17BC6FD1D
	for <util-linux@archiver.kernel.org>; Wed, 15 Mar 2023 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjCOOdx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Mar 2023 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjCOOdt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2023 10:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC457AB0
        for <util-linux@vger.kernel.org>; Wed, 15 Mar 2023 07:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678890780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDERO48x9nMNW3BRY+rFUSn7s2L8e0TGFu/0UxsDTR0=;
        b=YZskDsyQpaVi0aXPHrfoSnjY+lPVJC7uVjeQrz6x8YAuEHwcIyx+XwiA0jq8pp/z/nUNeS
        gkYDa7izQop6ge0FL/9x5zjrBAtmLJ0HRS8YoGfjrc16ePPK5O4OgkAESksJHPLYgxbIH4
        xUZT7mJg9+5xVvIAPwYgRELd/rbqD6o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447--9GhVPDgOPOcLgcTS_0jVA-1; Wed, 15 Mar 2023 10:32:59 -0400
X-MC-Unique: -9GhVPDgOPOcLgcTS_0jVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAC3729ABA12;
        Wed, 15 Mar 2023 14:32:58 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11F2C40C6E68;
        Wed, 15 Mar 2023 14:32:57 +0000 (UTC)
Date:   Wed, 15 Mar 2023 15:32:55 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>, fhirtz@redhat.com,
        John Westerdale <jwesterd@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
Subject: Re: [PATCH 1/2] libmount: dont ignore autofs mounts by default
Message-ID: <20230315143255.if5idh3cpd7or3a3@ws.net.home>
References: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Mar 13, 2023 at 09:42:56AM +0800, Ian Kent wrote:
> so we can't make this the default behaviour in libmount.

I see ;-) Applied (both patches).

What about findmnt? I think it should follow "ignore" by default too
(if --all no specified).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

