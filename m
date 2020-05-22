Return-Path: <SRS0=7FR5=7E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D834C433DF
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 08:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB75207FB
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 08:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkAVJiGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEVI2f (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 May 2020 04:28:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58462 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728814AbgEVI2e (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 May 2020 04:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590136113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ek20QZFjJTIN2p0fW6ykvp79K0ydhGptqartoy7wdMU=;
        b=dkAVJiGcqnVmS/OBjfNEsq9IfBvPYFaj+/WHsOZOTeNqh7VGqpbOTo/7f2hPuTa9EKoxhd
        En6/vPCFdc0fO0m1y1Kc1uyXN3RU++WN4Rs/124Kb8OULkx93feO+cd5gsggqewNG2/+MJ
        NE9ZOWTD9cJrKEQ3hbOY5zsid5dg+6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-kobTZLwvOoGsOholm0vOLg-1; Fri, 22 May 2020 04:28:29 -0400
X-MC-Unique: kobTZLwvOoGsOholm0vOLg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68229100CCC0;
        Fri, 22 May 2020 08:28:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3B9F6C776;
        Fri, 22 May 2020 08:28:27 +0000 (UTC)
Date:   Fri, 22 May 2020 10:28:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] Manual pages: order AUTHORS / COPYRIGHT / SEE ALSO /
 AVAILABILITY consistently
Message-ID: <20200522082824.iiomsxyequzwoenv@ws.net.home>
References: <265058f0-3091-4f7f-1853-59f634210c33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265058f0-3091-4f7f-1853-59f634210c33@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, May 21, 2020 at 09:28:21AM +0200, Michael Kerrisk (man-pages) wrote:
>  71 files changed, 367 insertions(+), 367 deletions(-)

All 4 patches applied.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

