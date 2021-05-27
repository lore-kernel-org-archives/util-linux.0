Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A722C4707F
	for <util-linux@archiver.kernel.org>; Thu, 27 May 2021 08:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9882613CA
	for <util-linux@archiver.kernel.org>; Thu, 27 May 2021 08:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbhE0IoW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 27 May 2021 04:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235284AbhE0IoW (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 27 May 2021 04:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622104969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3aI8wcLCEvKvhRjyyFyjbTVzQJD0hb5vmk/E0kwERQ=;
        b=XPEaQgIFvmIHUgVaFs0zu4/Y2IC5nQJ2t4dAbpHNGUq2FehFEZBNjs0bEKD7VtDkWKwG+S
        dHozoSZ98spqSklMRN+XlAAC9Hn3rGjHaza0AeKuE4v6OjV0nV+lr4N9liMaELS76ZvpLO
        Zu1wAGu097PK3j7B8T1pkECResjwgjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-zP8iTJj2NyOOyzxXnRS4Ng-1; Thu, 27 May 2021 04:42:44 -0400
X-MC-Unique: zP8iTJj2NyOOyzxXnRS4Ng-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19CAC107ACF2;
        Thu, 27 May 2021 08:42:43 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 707AB6787B;
        Thu, 27 May 2021 08:42:42 +0000 (UTC)
Date:   Thu, 27 May 2021 10:42:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Petr Pisar <petr.pisar@atlas.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: util-linux-2.37-rc2: "%delta:" is not C-format string
Message-ID: <20210527084239.zpxwitzm2hwzyla7@ws.net.home>
References: <YKgRQPRRbMUYR2d9@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKgRQPRRbMUYR2d9@album.bayer.uni.cx>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 21, 2021 at 10:00:00PM +0200, Petr Pisar wrote:
> when translating util-linux-2.37-rc2, I found that:
> 
> #: sys-utils/irq-common.c:482
> #, fuzzy, c-format
> msgid "%delta:"
> 
> is mishandled by gettext. Because it is marked as c-format, I cannot translatedo

Fixed (I hope) by https://github.com/karelzak/util-linux/commit/b97e2145fa44c754ab78dd20e3ca8c13df68b624

Thanks for your report.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

