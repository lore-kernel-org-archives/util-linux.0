Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E9C432BE
	for <util-linux@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB3B600D4
	for <util-linux@archiver.kernel.org>; Tue, 31 Aug 2021 13:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236497AbhHaNWw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 31 Aug 2021 09:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235961AbhHaNWw (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Aug 2021 09:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630416116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTMlFWYqHP2SAfmPSIA4TrxL9QWURglyauDW74e3OwA=;
        b=NIKQ4xuKWIwdFtfhSH3Bsw+xtqPlz8KDUcaG3FZSrxlCIvUP5AdJNcSrxkdEljttSyl7l3
        lJ127pBndEKD45Fg6qqi3KlNERjYBxYFDd2dX+NIWQXh3rP0Flvi5x780ZJdBn/hrPcbbP
        tyjZYtYHkYSQ5g1nZMxGAYGNhxfcHlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-lPc63twHN76Rsy242G2GzQ-1; Tue, 31 Aug 2021 09:21:55 -0400
X-MC-Unique: lPc63twHN76Rsy242G2GzQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39B90101C8A6;
        Tue, 31 Aug 2021 13:21:54 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EB7C60C9F;
        Tue, 31 Aug 2021 13:21:53 +0000 (UTC)
Date:   Tue, 31 Aug 2021 15:21:50 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Skip lsns/ioctl_ns test if unshare fails
Message-ID: <20210831132150.dd4epdcksrkpjyrl@ws.net.home>
References: <20210820103050.1636810-1-zeha@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820103050.1636810-1-zeha@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Aug 20, 2021 at 10:30:50AM +0000, Chris Hofstaedtler wrote:
> +$TS_CMD_UNSHARE --user --pid --mount-proc true || ts_skip "Namespace support failure"

The --pid requires --fork, fixed and committed:
https://github.com/karelzak/util-linux/commit/597ccb7bf564f65bb059bfe420224cab0fba46ac


Thanks
   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

