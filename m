Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375BFC74A5B
	for <util-linux@archiver.kernel.org>; Fri, 17 Mar 2023 10:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCQKvV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 17 Mar 2023 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCQKvU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 17 Mar 2023 06:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523FCC97FF
        for <util-linux@vger.kernel.org>; Fri, 17 Mar 2023 03:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679050233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cWHeKjCW3EtkDpVsuQmg/wnXutUDmjLGyg4FVywlfo=;
        b=AcH/4RBqgCSS4VK4WaMq0r934oJ41rhvj60FcUrsBLipPIdxYxpv+4UAPNRjPIftmUBQsx
        elSesCvgDzF1DRmCV6Uh4f+FeLUBPjjyBSk7LO462IpL49pcGIG5WdeGc1z+oNgoip4BlG
        /9+ESkB7v4jb0vI2XJT+TdLy7eLpkho=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-TS9OfIEvNpaqQ62wVvVd0A-1; Fri, 17 Mar 2023 06:50:31 -0400
X-MC-Unique: TS9OfIEvNpaqQ62wVvVd0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 799331C075B7;
        Fri, 17 Mar 2023 10:50:31 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE1126B597;
        Fri, 17 Mar 2023 10:50:30 +0000 (UTC)
Date:   Fri, 17 Mar 2023 11:50:28 +0100
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] write: correctly handle wide characters
Message-ID: <20230317105028.sgu5722ry2kqzdsx@ws.net.home>
References: <20230315141649.d7d4ybcg3evyelpo@ws.net.home>
 <3b606a113f36256be6486bd3130944acf88777d7.1678893303.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b606a113f36256be6486bd3130944acf88777d7.1678893303.git.nabijaczleweli@nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 15, 2023 at 04:16:31PM +0100, наб wrote:
>  include/carefulputc.h | 60 +++++++++++++++++++++++++++++++------------
>  login-utils/last.c    |  4 +--
>  term-utils/write.c    | 25 +++++-------------
>  3 files changed, 52 insertions(+), 37 deletions(-)

Applied (all 3 patches), thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

