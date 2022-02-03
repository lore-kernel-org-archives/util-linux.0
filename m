Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A9FC433F5
	for <util-linux@archiver.kernel.org>; Thu,  3 Feb 2022 10:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347962AbiBCKzt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 3 Feb 2022 05:55:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243664AbiBCKzt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 3 Feb 2022 05:55:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643885748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4N/1MEtQArY3WtwrVILZf83gfYEOY4cDsa0VrJrI7w=;
        b=SWNERnC8D4JWpMbapvv1NrvtbaH1bDDaqbkEdTFiJ/2RF58ZU8tEolQaqKW8/7i0IWTxve
        P+VkwjoaiAOyuZyv10cukWa3ju4CX/qPTwyzGYBOKOtC9PZpnWiplL2MhfChcY7PnQq3rC
        VoFqBiNqdW+hjPV86QHTc0z5myCrYbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-uGqfNB4lN9SILE8ZqmII5g-1; Thu, 03 Feb 2022 05:55:45 -0500
X-MC-Unique: uGqfNB4lN9SILE8ZqmII5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30EED835BC3;
        Thu,  3 Feb 2022 10:55:44 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DAB108DF;
        Thu,  3 Feb 2022 10:55:43 +0000 (UTC)
Date:   Thu, 3 Feb 2022 11:55:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     1003095@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#1003095: /usr/bin/script: hangs when child doesn't read
 input fast enough
Message-ID: <20220203105540.kfyn625ioaxts354@ws.net.home>
References: <20220103230422.syzm2ryzcixuhl7r@tarta.nabijaczleweli.xyz>
 <20220104162454.3agbsfqfpvaxr5ny@percival.namespace.at>
 <20220104173124.lv2fyxuxuvc34jdo@tarta.nabijaczleweli.xyz>
 <20220108145406.vkiuvl6iji4oypay@tarta.nabijaczleweli.xyz>
 <20220113232811.puu3pbtzjvzgys3o@tarta.nabijaczleweli.xyz>
 <20220202144938.eypexs65ujillsrg@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202144938.eypexs65ujillsrg@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 02, 2022 at 03:49:38PM +0100, наб wrote:
> Bumping this patch after 2ish weeks :)

Sorry for my delay. 

Your solution seems elegant, but it seems to late for the next release
v2.38 (now rc1). I'll play with it next week and prepare it for v2.39.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

