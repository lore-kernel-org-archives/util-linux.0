Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BBC433E4
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AD42065E
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 12:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AhxF6GGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgGXMvE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:51:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29588 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726280AbgGXMvE (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Jul 2020 08:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595595063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=zwbJpb98RpI68lbn/oNMME+u3YSDf2vNrgskLMc0Oic=;
        b=AhxF6GGLQZFbxB2HW+togbf724/pXEJ/i0DSV9+pz8GpkuRzKER2yGgrbKhwu1Sc1gDNW3
        lLL0XkWtbMLjWSNkuhfMsltOoOmZtJ9BhtmHsfqwuJQrlgZnWQmYdpoyISZvJ9koFiaY1L
        CODch7sf3ic+jx5mfrhEfVdy7FmpLE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-NMQ1MemlM9CLogQlhgxStg-1; Fri, 24 Jul 2020 08:51:00 -0400
X-MC-Unique: NMQ1MemlM9CLogQlhgxStg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1AB100AA22
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 12:50:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DB848BEF0
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 12:50:58 +0000 (UTC)
Date:   Fri, 24 Jul 2020 14:50:55 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: next days
Message-ID: <20200724125055.htxyfvgenwbob4yw@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


 Hi all,

I will be on vacation in next 2 weeks. Please, be patient with your
patches and bug reports. Thanks.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

