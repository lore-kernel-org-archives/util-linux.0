Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE428C433E0
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 11:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6176364E92
	for <util-linux@archiver.kernel.org>; Fri, 19 Feb 2021 11:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBSLQC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:16:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36234 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBSLQC (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Feb 2021 06:16:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613733276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SlxoOUA85pxjvjk3vbtZqhAXO+3LJCqXjS1rrm59vvs=;
        b=eK7zlz6nwnrfyS7i7HQ/mW2+0J7DQe1lHcuN3GGkx9liGx7Fa9ZCfXBdPWPS4PRZVgrNkV
        sWRscoq9Acf/dy4aaNfe9RT3Ot6ZeYOhnsntRMHYt8SXr0Sh+q69wcSovAYaLJYKHyarz6
        COTWmOR1KmluZ5SiLInhxJbDhsc/qmw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-zUvtdTT7M7SoU0vfItHStw-1; Fri, 19 Feb 2021 06:14:31 -0500
X-MC-Unique: zUvtdTT7M7SoU0vfItHStw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEC2418449E2;
        Fri, 19 Feb 2021 11:14:30 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 223D1171FE;
        Fri, 19 Feb 2021 11:14:29 +0000 (UTC)
Date:   Fri, 19 Feb 2021 12:14:27 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>
Subject: Re: Suggested changes to util-linux for FHS compliance.
Message-ID: <20210219111427.35z43zib4jn5irkr@ws.net.home>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
 <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
 <f8d10b77-79d9-6a62-50a4-5fb2d1d45655@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8d10b77-79d9-6a62-50a4-5fb2d1d45655@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Feb 18, 2021 at 09:37:21AM -0600, Bruce Dubbs wrote:
> Perhaps another solution would be to make the default for localstatedir be
> /var instead of PREFIX/var.

Ah, I see what do you mean. 

We do not alter $localstatedir in the configure script at all. This is is 
probably the problem you see. For the other directories we default to /bin,
/lib, ... when the default prefix (NONE or /usr) detected.

It seems $localstatedir and $sysconfdir need our care too.

I have committed:
 
  https://github.com/karelzak/util-linux/commit/3d2899651791bcb4ee8fe4e605acc83f3ae3471b

Please, try it. The final summary from ./configure should be also
more verbose about the paths now.

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

