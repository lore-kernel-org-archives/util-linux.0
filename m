Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4CC77B6F
	for <util-linux@archiver.kernel.org>; Tue, 11 Apr 2023 10:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjDKK6X (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Apr 2023 06:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjDKK6Q (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Apr 2023 06:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6501982
        for <util-linux@vger.kernel.org>; Tue, 11 Apr 2023 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681210651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ybJ1YwKXVzZ4IwIZ9kCc7Ntrt5ZwqJU5Qp2xmvvJZuc=;
        b=V6Tv26os0VQd28CeSpZ5KfLQqzVTKxE/7FPc3a+mhRTs9di0YCL4A3bVV8YjbAy5IGrCfQ
        elb3DiLS1fqxjvhvgFaE7/+voVXWt9DPqe9CATWuTcDG6pLP9fNq4XQNw9zCPZzNRccnDt
        orZYX0r6sgqsUNCNHC/AVWWX0MlnWnE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-HDkpQSXyMkWhDCIF_gwgng-1; Tue, 11 Apr 2023 06:57:26 -0400
X-MC-Unique: HDkpQSXyMkWhDCIF_gwgng-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CD67384D021;
        Tue, 11 Apr 2023 10:57:26 +0000 (UTC)
Received: from ws.net.home (ovpn-192-11.brq.redhat.com [10.40.192.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D5460492B03;
        Tue, 11 Apr 2023 10:57:25 +0000 (UTC)
Date:   Tue, 11 Apr 2023 12:57:23 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix mmap/ioctl(3p) references in manual
Message-ID: <20230411105723.3unfkgtwsqzlve6y@ws.net.home>
References: <xirr7enxyybsuyjjroo3v452yjio3b3bfw4hdmctzhundq4wgg@ymt5yxyrni3q>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xirr7enxyybsuyjjroo3v452yjio3b3bfw4hdmctzhundq4wgg@ymt5yxyrni3q>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 07, 2023 at 04:48:06PM +0200, наб wrote:
> mmap(3p) is passable, inasmuch as it does actually describe mmap(2).
> 
> ioctl(3p), on the other hand, describes XSI STREAMS, which bear no
> relation to ioctl(2) under Linux, much less ioctl_console(2).
> 
> Both live in the non-free manpages-posix-dev.

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

