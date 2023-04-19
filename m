Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C062C6FD18
	for <util-linux@archiver.kernel.org>; Wed, 19 Apr 2023 09:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjDSJgs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjDSJgr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 19 Apr 2023 05:36:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF521258A
        for <util-linux@vger.kernel.org>; Wed, 19 Apr 2023 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681896940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=L4v7zrylHwuRp2YWTbCpqw/6xWeZNu0GBQgJfjNAz/Y=;
        b=I2K9l2hTV0XPs4+EOH9eD3YONC8cCFM4XCcKS1iFmV0MFGTsHMHdCu0Z3CEWiCBDkZnwu2
        AJnrabPEF+XaOCQ36juAFDi47J/+4tsT9rsP4muUAWhMSKI9Bv0yYIk5Xqhst68talBVRn
        TcFIJo6o4wkG7tB6/pDzOr1+4ffAsMA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259-J12118u3OJ-DeEPOVg5lvA-1; Wed, 19 Apr 2023 05:35:37 -0400
X-MC-Unique: J12118u3OJ-DeEPOVg5lvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6BF91C0755E;
        Wed, 19 Apr 2023 09:35:36 +0000 (UTC)
Received: from ws.net.home (ovpn-192-7.brq.redhat.com [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D05C2166B33;
        Wed, 19 Apr 2023 09:35:36 +0000 (UTC)
Date:   Wed, 19 Apr 2023 11:35:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39-rc3
Message-ID: <20230419093534.hdksjs3jp4nsbmlo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The util-linux release v2.39-rc3 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39
 
Feedback and bug reports, as always, are welcomed.
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

