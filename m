Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF01C433EF
	for <util-linux@archiver.kernel.org>; Fri, 10 Dec 2021 14:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhLJOZj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 10 Dec 2021 09:25:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232310AbhLJOZj (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Dec 2021 09:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639146124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KCNMiqL9MR1Y3KaYZWZvxYMDawQnLUnDRanQXofpZ7Q=;
        b=NXP7Q58WkpuY2FVAemyzrzVKYqXJp7kI03Ko5h+HqEaoAgaIUx2xkEvSHU4mTOHetTHKNl
        6nrII0ooUtREGzztFOBFmCXtEoJ83kQPuGV0uYV/MUB/H69x0xypKtvu6/+HsuCy10Hx6G
        TQ9TVjSr5wXYaKFsbBFiMhxmiHAu3CI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-4Ch_kR7eM8mWb19njkvJSQ-1; Fri, 10 Dec 2021 09:22:00 -0500
X-MC-Unique: 4Ch_kR7eM8mWb19njkvJSQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2F8B1966325;
        Fri, 10 Dec 2021 14:21:58 +0000 (UTC)
Received: from ws.net.home (ovpn-112-12.ams2.redhat.com [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 177B460BF4;
        Fri, 10 Dec 2021 14:21:57 +0000 (UTC)
Date:   Fri, 10 Dec 2021 15:21:55 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     util-linux@vger.kernel.org, jpiotrowski@microsoft.com
Subject: Re: [PATCH] libblkid/src/probe: check for ENOMEDIUM from
 ioctl(CDROM_LAST_WRITTEN)
Message-ID: <20211210142155.rnibkn7j4zdrznqp@ws.net.home>
References: <20211208170953.GA18252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208170953.GA18252@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 08, 2021 at 09:09:53AM -0800, Jeremi Piotrowski wrote:
>  libblkid/src/probe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

