Return-Path: <SRS0=6rrA=4M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFECFC11D2F
	for <util-linux@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AE320838
	for <util-linux@archiver.kernel.org>; Mon, 24 Feb 2020 15:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NccovxpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgBXPsP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:48:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50925 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727299AbgBXPsO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 24 Feb 2020 10:48:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582559294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MocXDB8F8aioH5+jau+w9jbt3YBiZunDQwEfyEGW4Ms=;
        b=NccovxpRrMrcSmeDRTpEznLHqWu4gq7zaEj3V7xZajJ+rOToewGm9NrDQKT8M7MJleRKvt
        39AbGhF7DOK9zN0m24AIsQ89UvylmOsEi71UOkIgZy/yPI/Cvog+OymeBwJVZrTvdT7buP
        CB0/MHNSLABPH3ffB7cWptwwrNEK3ZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-QCPFlqF7PEyF2rbPjnkN4A-1; Mon, 24 Feb 2020 10:48:06 -0500
X-MC-Unique: QCPFlqF7PEyF2rbPjnkN4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DAC718C8C04;
        Mon, 24 Feb 2020 15:48:05 +0000 (UTC)
Received: from ws.net.home (ovpn-204-202.brq.redhat.com [10.40.204.202])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 72CF5909F0;
        Mon, 24 Feb 2020 15:48:04 +0000 (UTC)
Date:   Mon, 24 Feb 2020 16:48:01 +0100
From:   Karel Zak <kzak@redhat.com>
To:     J William Piggott <elseifthen@gmx.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [v2 PATCH] hwclock: make glibc 2.31 compatible
Message-ID: <20200224154801.ujnl7cahzr6crzcr@ws.net.home>
References: <20200222010347.2743-1-elseifthen@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222010347.2743-1-elseifthen@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 21, 2020 at 08:03:47PM -0500, J William Piggott wrote:
>  sys-utils/hwclock.c | 71 +++++++++++++++++++++++----------------------
>  1 file changed, 37 insertions(+), 34 deletions(-)

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

