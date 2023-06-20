Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A761EB64D8
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 09:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjFTJ2P (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjFTJ1c (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 05:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93919A2
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687253193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sKxS2+r318ZFVma6aUZjPV9r//TOW9WumMJVNSB9xeM=;
        b=IJzwdxXEXwucqtP0PfRdlezgaME1kvl+GVZaXKbcgv3SKccYOsehTBXPw/L7AQtqm5+QOG
        661xerKN2C/u0HnsCDx3nCcOWleH+jn3eTSI6n6/5ZRLEba6pYDBeLe/3hKQdXyVcoCYMe
        Zq06h1qd3np1Ckv0gjp4Jfi3dRTobz0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-TSSZbOVeNdyIEJqbErs0WQ-1; Tue, 20 Jun 2023 05:26:32 -0400
X-MC-Unique: TSSZbOVeNdyIEJqbErs0WQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE2D42A59550;
        Tue, 20 Jun 2023 09:26:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46AEB422B0;
        Tue, 20 Jun 2023 09:26:31 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:26:28 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Message-ID: <20230620092628.klpqbr5qw2rdysqh@ws.net.home>
References: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 13, 2023 at 12:14:28PM +0200, Rasmus Villemoes wrote:
>  sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
>  sys-utils/hwclock.c     | 35 +++++++++++++++++
>  sys-utils/hwclock.h     |  5 +++
>  3 files changed, 126 insertions(+)

The patch looks good. Can we also get something for sys-utils/hwclock.8.adoc
(man page) and bash-completion/hwclock? ;-)

Thanks!
   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

