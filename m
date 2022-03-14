Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D2C433EF
	for <util-linux@archiver.kernel.org>; Mon, 14 Mar 2022 09:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbiCNJpo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Mar 2022 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiCNJpn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Mar 2022 05:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BFF527141
        for <util-linux@vger.kernel.org>; Mon, 14 Mar 2022 02:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647251073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dx/Ow/YWqUeC4+NeKmCteKLvEImpJmo/vp57hTG7/Z0=;
        b=IBL9FFi1Q2mOg6Te/7mmtnL4m4hggwlPYQjhQemiFnqneMQSV8LQC6686SurlQP75/zFJz
        PKQcJA5YKPAio/aTlh6WL306F5Ydkf2TAfzlylPIXAF4MZne+u8L9dVKS3djd1oQSrhM92
        TGgMbdrCCjuOSgtxpFhoaWGZIeVv8gg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-KpoLE2WPNhysA5Im6Jc1Ww-1; Mon, 14 Mar 2022 05:44:32 -0400
X-MC-Unique: KpoLE2WPNhysA5Im6Jc1Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF7A12999B23;
        Mon, 14 Mar 2022 09:44:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 642C540FF708;
        Mon, 14 Mar 2022 09:44:31 +0000 (UTC)
Date:   Mon, 14 Mar 2022 10:44:29 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] hardlink: set all locale elements, so that
 messages will get translated
Message-ID: <20220314094429.vijtn4gws3swx24n@ws.net.home>
References: <20220313094357.2546-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220313094357.2546-1-bensberg@telfort.nl>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Mar 13, 2022 at 10:43:56AM +0100, Benno Schulenberg wrote:
>  misc-utils/hardlink.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied (all the patches), thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

