Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553BECAAD5
	for <util-linux@archiver.kernel.org>; Mon, 12 Sep 2022 12:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiILMXq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 12 Sep 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiILMXp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 12 Sep 2022 08:23:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353E222BC0
        for <util-linux@vger.kernel.org>; Mon, 12 Sep 2022 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662985424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HCzoabKv1STC6JK6KjHlBD+zXt2/Dwq4+AUEmQx0uxw=;
        b=ZNfRSv3Fwn1y2Gkqf0oP69sN90LZMEChHM4bHqd/s9vamTBSjXuR4ewqZNHhAFOAS9Dlqk
        Q1ieyErXm4FOh6QaUbxOj0J17ojPXrdLVKwMDGYC4YM6RhYYSAhOxEiyijUpw4ECWbAxM8
        mFZ35Q1WH8V8dQ8pvCzjJy3a9DYY2Ds=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-mgHke133P5i2S5bn3U4z6Q-1; Mon, 12 Sep 2022 08:23:41 -0400
X-MC-Unique: mgHke133P5i2S5bn3U4z6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C95D585A589;
        Mon, 12 Sep 2022 12:23:40 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E93D140EBF3;
        Mon, 12 Sep 2022 12:23:40 +0000 (UTC)
Date:   Mon, 12 Sep 2022 14:23:37 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/timeutils: Require '@' prefix for seconds since the
 Epoch timestamp
Message-ID: <20220912122337.nmoc7tpzuxes4ejj@ws.net.home>
References: <20220907054141.15608-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907054141.15608-1-peter.ujfalusi@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Sep 07, 2022 at 08:41:41AM +0300, Peter Ujfalusi wrote:
>  lib/timeutils.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Applied, let's use '@' prefix :-) Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

