Return-Path: <SRS0=l+by=AU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864DC433DF
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 13:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1B92074B
	for <util-linux@archiver.kernel.org>; Thu,  9 Jul 2020 13:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brbz+Ad7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGINuC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Jul 2020 09:50:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726775AbgGINuC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Jul 2020 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594302601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wU/IYW624cTJ+phT8QcHfdGdebh3N/uM3T5RVMhvW8A=;
        b=brbz+Ad7T8EOeKhL4IGH6aopE7Zt4vTtc/qc2sW+g6Wb9P3DYLsEooI/78gtbGL7/gdfkZ
        XmPTiHfA6Xq28CXZud1c8TYspBWs1suzZXSg2xs/6SN7LF3p00YOYy2eQf5bekpJw9tgXX
        HE8SaDKt5sYtEzgH6GZZGKzWA2lB/24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-wK33q6onO3WVT8WIpOKZrA-1; Thu, 09 Jul 2020 09:49:58 -0400
X-MC-Unique: wK33q6onO3WVT8WIpOKZrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F455100CC84;
        Thu,  9 Jul 2020 13:49:57 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7098C5D98A;
        Thu,  9 Jul 2020 13:49:56 +0000 (UTC)
Date:   Thu, 9 Jul 2020 15:49:53 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.36-rc2
Message-ID: <20200709134953.ist5schagi3hjhs7@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


The util-linux release v2.36-rc2 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.36
 
Feedback and bug reports, as always, are welcomed.
 
  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

