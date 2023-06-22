Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675DEEB64D8
	for <util-linux@archiver.kernel.org>; Thu, 22 Jun 2023 08:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjFVIb1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Jun 2023 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFVIbX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Jun 2023 04:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C392695
        for <util-linux@vger.kernel.org>; Thu, 22 Jun 2023 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687422599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ervIp0i6HhoI0ri754QQ8MZmL8bObPtfmgL7LLBEWPY=;
        b=JVgju+YkkatGdW7SMpDYET9NKX0OtGd2aRrN1TPxC3kNrxpz2FClomb+zft0HMZJotaX+f
        uQTMnpL43ZBD33Af7y/+8KT6bfpjdMnPpzsAa05R3Wu5lFWJC1wqKrLBFlRe6+f64K2o7w
        VQ/rFBzvCSiiAhzrfQZ69Z3xY/qCD9A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-7MVj5r1mO76QgGhyw11WUg-1; Thu, 22 Jun 2023 04:29:55 -0400
X-MC-Unique: 7MVj5r1mO76QgGhyw11WUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 599813C0010E;
        Thu, 22 Jun 2023 08:29:55 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D6F94492B01;
        Thu, 22 Jun 2023 08:29:54 +0000 (UTC)
Date:   Thu, 22 Jun 2023 10:29:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] hwclock: add support for RTC_VL_READ/RTC_VL_CLR ioctls
Message-ID: <20230622082952.almvpc4kxitnxco4@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613101428.294827-1-rasmus.villemoes@prevas.dk>
 <20230621201823.874883-1-rasmus.villemoes@prevas.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jun 13, 2023 at 12:14:28PM +0200, Rasmus Villemoes wrote:
>  sys-utils/hwclock-rtc.c | 86 +++++++++++++++++++++++++++++++++++++++++
>  sys-utils/hwclock.c     | 35 +++++++++++++++++
>  sys-utils/hwclock.h     |  5 +++
>  3 files changed, 126 insertions(+)


>  bash-completion/hwclock  | 2 ++
>  sys-utils/hwclock.8.adoc | 5 +++++
>  2 files changed, 7 insertions(+)

Applied, thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

