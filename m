Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694CBC433EF
	for <util-linux@archiver.kernel.org>; Thu, 21 Apr 2022 10:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiDUKXJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 21 Apr 2022 06:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388388AbiDUKWr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 21 Apr 2022 06:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F35B6168
        for <util-linux@vger.kernel.org>; Thu, 21 Apr 2022 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650536396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dg0HyUwJfwTSvuoOdsJD1vTCx/by2RO94hLDhY+6b9k=;
        b=WE4ZHbg+nEQVP7mB1MGzBiKMZlUlfyOZX1Vxcq0auYy2y6QSmIqp4jPojoRjNlsHHToqCb
        rYRC96/4ceB6zppioe2DYhMEPOe4PVPQWo1+1Y2gZX3h2jzHiXdi3JAU1JsZXVF5DcVmg3
        F06ajsR8wRapueZwaz9ZVKp1KlKwNKM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-pCgAbw7wO3G8vx-rVCedvQ-1; Thu, 21 Apr 2022 06:19:52 -0400
X-MC-Unique: pCgAbw7wO3G8vx-rVCedvQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DC71185A79C;
        Thu, 21 Apr 2022 10:19:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2373C404D2E8;
        Thu, 21 Apr 2022 10:19:52 +0000 (UTC)
Date:   Thu, 21 Apr 2022 12:19:49 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v3] libmount: accept X-mount.{owner,group,mode}=
Message-ID: <20220421101949.4zc7kojyujdiv2lb@ws.net.home>
References: <20220406113814.twdo4mwkevwuayht@ws.net.home>
 <20220407183913.kvchb7hbrfhyxjoc@tarta.nabijaczleweli.xyz>
 <20220419111341.7n2jhxlf4446rmle@ws.net.home>
 <20220419145607.wk3wpsmudkmkdqvg@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220419145607.wk3wpsmudkmkdqvg@tarta.nabijaczleweli.xyz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 19, 2022 at 04:56:07PM +0200, наб wrote:
>  libmount/src/context.c             |  12 ++-
>  libmount/src/context_mount.c       |  87 +++++++++++++++++++-
>  libmount/src/libmount.h.in         |  13 ++-
>  libmount/src/mountP.h              |   7 ++
>  libmount/src/optstr.c              |  19 +----
>  libmount/src/utils.c               | 126 +++++++++++++++++++++++++++++
>  sys-utils/mount.8.adoc             |   6 ++
>  tests/expected/mount/set_ugid_mode |   1 +
>  tests/ts/mount/set_ugid_mode       |  65 +++++++++++++++
>  9 files changed, 315 insertions(+), 21 deletions(-)
>  create mode 100644 tests/expected/mount/set_ugid_mode
>  create mode 100755 tests/ts/mount/set_ugid_mode

Applied. Thanks for all the work and patience. I think the result is
pretty usable and readable :-)

I did some additional small changes to the code:
https://github.com/util-linux/util-linux/commit/24e896c1400c2328b8bdffde674a3d74429acdf1

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

