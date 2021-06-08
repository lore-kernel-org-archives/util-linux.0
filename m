Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0100C47082
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B0E61359
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhFHOBv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jun 2021 10:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35903 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233142AbhFHOBv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 8 Jun 2021 10:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623160798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhOXcbPAqBYSN+vd7KRjXmx+/u/rB+Hhify0d2FzdPQ=;
        b=iKaj1JCjbSNbyB+V6S1JI7pykmGACtOTcXabZNhPj665LVWLKKITV5vj2UuVepi6DfRy31
        L512Xw4DUKx36HmCXsEbdMfDPheGVmOZJUFccPUDrz8mVq+J2o51U3AN6OpSSNOjAN1T4V
        Muq5Se+QN2L6pmP6iPlKcGcoxJq+c5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-20iJ5ggQNTS7K-8JgZm90g-1; Tue, 08 Jun 2021 09:59:56 -0400
X-MC-Unique: 20iJ5ggQNTS7K-8JgZm90g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4C964167;
        Tue,  8 Jun 2021 13:59:55 +0000 (UTC)
Received: from ws.net.home (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A3FC60853;
        Tue,  8 Jun 2021 13:59:54 +0000 (UTC)
Date:   Tue, 8 Jun 2021 15:59:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] uclampset: Fix left over optind++
Message-ID: <20210608135952.wtod2sjhf4ksthjk@ws.net.home>
References: <20210607161111.3071084-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607161111.3071084-1-qais.yousef@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 07, 2021 at 05:11:11PM +0100, Qais Yousef wrote:
> Sorry not sure how this slipped through. I'm sure I tested it before I posted
> the patches but something must have gone wrong in my testing :(

And I've been not careful enough with code review ;)

>  schedutils/uclampset.c | 3 ---
>  1 file changed, 3 deletions(-)

Applied, thanks.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

