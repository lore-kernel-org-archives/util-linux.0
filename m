Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23EBC433E0
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 15:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB84D23101
	for <util-linux@archiver.kernel.org>; Tue, 26 Jan 2021 15:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406232AbhAZP0l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32514 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405997AbhAZP0e (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 26 Jan 2021 10:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611674708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=8C+tPO54xzPrKUGz9lfrTTCLbntRLg6cxzu/NsvgweU=;
        b=QzfBE+3B+/fxBw1IFjVK5KufD4XFyk+D9Wbvw/LA2sfsluXqkKtQbG2prrWpqm2Cupg0fD
        wWEjvxsHqiAMyBQYaD0GSg+xdOHiXgbTuCXVZ9npHOHKxyd9/DeIYtjLgt+JgLKX31ob0m
        +t2gnGVVoY/qG+ANc4ngLPa1obouCLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-rCRulNojOYyb7OI0Ad4xYw-1; Tue, 26 Jan 2021 10:25:05 -0500
X-MC-Unique: rCRulNojOYyb7OI0Ad4xYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB1F719251A0
        for <util-linux@vger.kernel.org>; Tue, 26 Jan 2021 15:25:04 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA8D60C5F
        for <util-linux@vger.kernel.org>; Tue, 26 Jan 2021 15:25:04 +0000 (UTC)
Date:   Tue, 26 Jan 2021 16:25:01 +0100
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: GitHub Actions as Travis-CI replacement
Message-ID: <20210126152501.ur64ifbesuppw7b2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org



 Hi all,

GitHub Actions seem very usable, readable, and user-friendly, and it
will be probably our replacement to Travis-CI as it seems Travis is
going to be more focused on paying customers, and migration from
travis-ci.org to travis-ci.com is required. etc.

Unfortunately, nothing is perfect, so for now GitHub Actions does not
support scsi_debug kernel module which we heavily use in our
regression tests. I have reported this issue, let's hope it will be
resolved.

TODO:
    - try enable build on MacOS

    - add GitHub Action to enable Coverity scan (it seems it works for
      example for systemd repo)

    - add extra "make distcheck" step to .github/workflows/cibuild.yml
      (already implemented in .github/workflows/cibuild.sh), but execute
      it for example once per week only

    - volunteers? ;-)


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

