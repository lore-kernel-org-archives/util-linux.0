Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC4CC433EF
	for <util-linux@archiver.kernel.org>; Tue, 15 Mar 2022 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343511AbiCORIx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbiCORIw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Mar 2022 13:08:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A10AF580E5
        for <util-linux@vger.kernel.org>; Tue, 15 Mar 2022 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647364059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=2WaUCzrxodAZtQhbGcr4LBHk4VGIXw8jP2vaDIaAO60=;
        b=fr1hVKL3lNgcM/tU4I08kRDRuXmXP8v9iYITdhPnxURFyLCMKtRlcQDZxdAWIh1ZJ1fwuM
        v0QZNajZHa5vYx/U3m96o+FnGkrwOQPljet1bZ9FYS/ZS3k9ucuVzM3RKnQYrQnp7AX6JU
        XxbEg6FjfpUBtei8Cml8JL2Jk7woYoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-Y7NgeX0NN2-GARYFR94tVg-1; Tue, 15 Mar 2022 13:07:38 -0400
X-MC-Unique: Y7NgeX0NN2-GARYFR94tVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 046F8811E75
        for <util-linux@vger.kernel.org>; Tue, 15 Mar 2022 17:07:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BDF1400F740
        for <util-linux@vger.kernel.org>; Tue, 15 Mar 2022 17:07:37 +0000 (UTC)
Date:   Tue, 15 Mar 2022 18:07:35 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.38-rc3
Message-ID: <20220315170735.knwqf2wqe7tmxlum@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux release v2.38-rc3 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
 
Feedback and bug reports, as always, are welcomed.
 

This rc3 is mostly about man-pages translations. The previous
rc2 was without updated po-man/ files. This problem is fixed now.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

