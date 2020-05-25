Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08E9C433DF
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCA32073B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkGJH+25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgEYMRx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:17:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390196AbgEYMRx (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 May 2020 08:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590409072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UYsy5oLwH/40kg3ntL3gtRUQODEwAUeSLi4GhG96jwc=;
        b=PkGJH+25luirKo/6i2lfVeLFO7u1KKGeJZgAVrOP4HWNAvPf2IIC/QIpaC/S2EJ6qCJP1X
        nbuVG/3Ji1QIhe5fxDaUCs/GlkFvc4yu3GGciZ46blzRhE+I+nrbWqKfn++e+rOhGfq8wl
        6c4VFQcLnaF/lZcls3HfEp2owCaw6Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-3GZRbdUdNUq79vMuCLDZTw-1; Mon, 25 May 2020 08:17:50 -0400
X-MC-Unique: 3GZRbdUdNUq79vMuCLDZTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4F08018A3;
        Mon, 25 May 2020 12:17:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7D246062D;
        Mon, 25 May 2020 12:17:48 +0000 (UTC)
Date:   Mon, 25 May 2020 14:17:45 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/9] Manual pages: nsenter.1, unshare.1: update
 references to *_namespaces(7) pages
Message-ID: <20200525121745.rmdn47zlchtf76fh@ws.net.home>
References: <20200523064325.78491-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523064325.78491-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, May 23, 2020 at 08:43:17AM +0200, Michael Kerrisk wrote:
>  sys-utils/nsenter.1 | 6 +++---
>  sys-utils/unshare.1 | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied all 9 patches, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

