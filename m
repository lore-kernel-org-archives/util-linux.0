Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE82AC6FD1D
	for <util-linux@archiver.kernel.org>; Tue,  4 Apr 2023 12:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjDDMvg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 4 Apr 2023 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjDDMvd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 4 Apr 2023 08:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F11B3
        for <util-linux@vger.kernel.org>; Tue,  4 Apr 2023 05:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680612638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fYg6UHJnGNa3r4nOIjucv7D4OMd5PduN9PZmiAqJNcA=;
        b=KT+NvcV+COUi2wyNz3q4U8mMPegsCrqLQcCXgkHoc/gNzrN3221nm23qLC04XHEpEqszrX
        Oofa2voT7xG/t19NsZyEWmQk3qnwm3438twQBJaly7db4EwmOQVhFvwgjRUVzmPryRkzlr
        DfRyQZzrh37zmoyOgeRfx3AVvvdlLrc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-Yx7G_4h6Pmydi9Vn4uRM5A-1; Tue, 04 Apr 2023 08:50:37 -0400
X-MC-Unique: Yx7G_4h6Pmydi9Vn4uRM5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD4CF3C0D85B;
        Tue,  4 Apr 2023 12:50:36 +0000 (UTC)
Received: from ws.net.home (ovpn-192-2.brq.redhat.com [10.40.192.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 416AA40C6EC4;
        Tue,  4 Apr 2023 12:50:36 +0000 (UTC)
Date:   Tue, 4 Apr 2023 14:50:34 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39-rc2
Message-ID: <20230404125034.vd5gypujnprzwful@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux release v2.39-rc2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

