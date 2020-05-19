Return-Path: <SRS0=ZMjy=7B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA46C433E0
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 10:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C35206D4
	for <util-linux@archiver.kernel.org>; Tue, 19 May 2020 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8rLMg9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESKSP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 May 2020 06:18:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21279 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbgESKSO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 May 2020 06:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589883494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rpnDukgXWlM3xP3N2sbeFMXSURaHp0XKCJpFjMvjbhk=;
        b=X8rLMg9cJmm69dVNjif4NoxonaaB+NBsMq4flxIUkAJzwgU/Nx9gfleh/Gf8MK9JoNRMYV
        1m+pomY0AGP/LGccKvp9aAsiKjRDogUqkDMRceTSiou/9WdXvs/hKzLaHRlmsLLyavPzYk
        9sQc7jXK1K4evEphw1BYCCPsGAX9ts8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-VaDPKv8LOBKOf42e9372ug-1; Tue, 19 May 2020 06:18:09 -0400
X-MC-Unique: VaDPKv8LOBKOf42e9372ug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3D09460;
        Tue, 19 May 2020 10:18:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2DEA619C0;
        Tue, 19 May 2020 10:18:06 +0000 (UTC)
Date:   Tue, 19 May 2020 12:18:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org, Helge Kreutzmann <debian@helgefjell.de>
Subject: Re: [PATCH] Global fix to manual pages: remove double quotes (") in
 .SH lines
Message-ID: <20200519101804.ojyulethxbtl5mj3@ws.net.home>
References: <1ac1c5eb-a2db-ed1d-9c3e-147bfe65a591@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac1c5eb-a2db-ed1d-9c3e-147bfe65a591@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 19, 2020 at 10:31:19AM +0200, Michael Kerrisk (man-pages) wrote:
>  69 files changed, 120 insertions(+), 120 deletions(-)

Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

