Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93094C433E1
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DE9221E8
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfEGjZ0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGNIvR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:51:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbgGNIvR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 04:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JUACkrsHfp73gfugg+UQOgPEAkpaiyv5Wuc7vsxcvnE=;
        b=DfEGjZ0V4TRyahqfm2+05So5Kjby5Nmyh1dCcuByXpM9muIkhcvsyKnwIhw/NJ9JdtHCrR
        2/p+yJBfscy+nixjwJlQmKjeCwkNHsFEFvxYG3qH+dJAreps2v5W63xAQpW60KNLjW7BKQ
        8xENiUk4kjhl0Oi1U6l9f9WK6LTJ1tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-addpS7dYP0qODbSv7NMnWw-1; Tue, 14 Jul 2020 04:51:13 -0400
X-MC-Unique: addpS7dYP0qODbSv7NMnWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47C34184C5E9;
        Tue, 14 Jul 2020 08:51:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 86883710C1;
        Tue, 14 Jul 2020 08:51:11 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:51:08 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] docs: misc-utils: change "allows to <verb>" to "allows
 <verb>ing"
Message-ID: <20200714085108.ajjmj77p5z3fch4x@ws.net.home>
References: <20200710015341.GA3608@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710015341.GA3608@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jul 10, 2020 at 01:53:41AM +0000, Bjarni Ingi Gislason wrote:
>  misc-utils/findmnt.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

