Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE411C433E4
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5E22074B
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 12:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DG6Yi4Ok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgGXMny (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:43:54 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgGXMny (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Jul 2020 08:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595594633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0y0uDBHdP6tBKdSuIr0SPVdqV3fiJLkJV9/MHUfcVQQ=;
        b=DG6Yi4OkzPG9zzfVDHXTr1qZIrDWgo3+K3OCn9v/gFBug3x1NSOAWXZik1AFv2L3dH6jWo
        sWOyFgNNzJrntQvMxI6MuEuXjYcVGghI+d3XDsygrB7Eku1Nn2Nvhq5eB+4Ln9j6MX22nw
        E0M58iZqwo9zofTGwKFoDOHEbMVmgSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-1UYE3COMOumPbY9dk80DBQ-1; Fri, 24 Jul 2020 08:43:49 -0400
X-MC-Unique: 1UYE3COMOumPbY9dk80DBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF73A58;
        Fri, 24 Jul 2020 12:43:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.188])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0852B78465;
        Fri, 24 Jul 2020 12:43:47 +0000 (UTC)
Date:   Fri, 24 Jul 2020 14:43:45 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 01/12] Manual pages: blockdev.8: Minor wording and
 formatting fixes
Message-ID: <20200724124345.vln5lj3pbhb2jool@ws.net.home>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jul 24, 2020 at 12:06:07PM +0200, Michael Kerrisk (man-pages) wrote:
>  disk-utils/blockdev.8 | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)

 All patches merged. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

