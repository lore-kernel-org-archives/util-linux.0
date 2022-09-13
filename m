Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C195ECAAD8
	for <util-linux@archiver.kernel.org>; Tue, 13 Sep 2022 18:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiIMSpe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 13 Sep 2022 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiIMSpP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 13 Sep 2022 14:45:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1336E2656A
        for <util-linux@vger.kernel.org>; Tue, 13 Sep 2022 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663093485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4sa0jf4/8082/kceMTmYJ3U5LeUBqnkAWcScP+Vkpsg=;
        b=PxoeudXKGApLmeXVMchPvlN5mZQRqnReEOTOu+e/1qwhcSmWugcHFsdv7I656KGMjX/1IX
        +jzdmZqI8fn4kyXTQ+F61tZPvVYxEuf7BLDF8ies/Q4beeV/xAbboLK2SjX7MZBRPOZX26
        XnzHo1wOmEPuvEyWdqEGgw4DhzzMotU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-szU4B6lVNPevS9RyXTuA1Q-1; Tue, 13 Sep 2022 14:24:44 -0400
X-MC-Unique: szU4B6lVNPevS9RyXTuA1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AC07101AA46;
        Tue, 13 Sep 2022 18:24:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B459B40C6EC3;
        Tue, 13 Sep 2022 18:24:43 +0000 (UTC)
Date:   Tue, 13 Sep 2022 20:24:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/timeutils: Require '@' prefix for seconds since the
 Epoch timestamp
Message-ID: <20220913182441.2vat5obehs7dfbzq@ws.net.home>
References: <20220907054141.15608-1-peter.ujfalusi@linux.intel.com>
 <20220912122337.nmoc7tpzuxes4ejj@ws.net.home>
 <b89d8afb-75fb-8917-cb13-dff5fc589ae7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b89d8afb-75fb-8917-cb13-dff5fc589ae7@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 13, 2022 at 02:26:58PM +0300, Péter Ujfalusi wrote:
> 
> 
> On 12/09/2022 15:23, Karel Zak wrote:
> > On Wed, Sep 07, 2022 at 08:41:41AM +0300, Peter Ujfalusi wrote:
> >>  lib/timeutils.c | 14 ++++++--------
> >>  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > Applied, let's use '@' prefix :-) Thanks.
> 
> I will try to look at documenting the supported time formats within
> util-linux...
> 
> My guess would be to add a new file:
> man-common/timestamp-formats.adoc
> 
> and link it in dmesg for example?

Yes, sounds good. 

We also use parse_timestamp() in rtcwake, cal and last.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

