Return-Path: <SRS0=c7ae=57=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBB4C2BA19
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 09:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECF52074F
	for <util-linux@archiver.kernel.org>; Wed, 15 Apr 2020 09:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQfGglu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895593AbgDOJc7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:32:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895564AbgDOJc5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 15 Apr 2020 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586943176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NchDNbu/oJyW08nDX9LgdXjYcWQL72E51GtxtfvCmvc=;
        b=XQfGglu2ipT3ni1NtjJIIsnnvJuOFZxFU0HOs5p8cZKmh8Bnzc2vSt8kKpG02xJ1qhrt+b
        WGTA6FunTLr+uKL+ADkc9dKSCWarTsCq/7PcCVD5CLhaLBgnKHpC78Xbzqd3SbGedznQmF
        WGyQE7NMGl1I3dO7HqovRX+nKcj5MF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-hF5cR9LcNs67Z2hWa4iNoA-1; Wed, 15 Apr 2020 05:32:53 -0400
X-MC-Unique: hF5cR9LcNs67Z2hWa4iNoA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95042800D5B;
        Wed, 15 Apr 2020 09:32:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F6195D9E5;
        Wed, 15 Apr 2020 09:32:51 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:32:49 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Patrick Oppenlander <patrick.oppenlander@gmail.com>
Subject: Re: [PATCH] blkdiscard: (man) offset and length must be sector
 aligned
Message-ID: <20200415093249.koq247jc4wakx73t@ws.net.home>
References: <20200415070812.25574-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415070812.25574-1-lczerner@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 15, 2020 at 09:08:12AM +0200, Lukas Czerner wrote:
>  sys-utils/blkdiscard.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

