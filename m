Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC882EB64DD
	for <util-linux@archiver.kernel.org>; Tue, 11 Jul 2023 09:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjGKJ4G (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jul 2023 05:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbjGKJ4E (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Jul 2023 05:56:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AF2BE
        for <util-linux@vger.kernel.org>; Tue, 11 Jul 2023 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689069315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYIoVaChdhi6jGNerhgyNZneDpwy/5McbhTXqqmfizk=;
        b=Ugswq8cNl2SNV3vAxtsPVSDwjVCK+jrBBUl759lfZ4hu6Ib7JEwq5tVFNieyuoM2T1sQHt
        /ZorFTD60sdK45F3y0pcX0Pw02Bo7Iz8X4260fzRbKNhM/JCnwhqwYIwBqrCkfqTXs3Nyy
        LcQfbSmUKfZFLnbW/+O2Defpr3sUvKo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-4JZyjCQCPBWshoF2jMXzTA-1; Tue, 11 Jul 2023 05:55:12 -0400
X-MC-Unique: 4JZyjCQCPBWshoF2jMXzTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B43E8851840;
        Tue, 11 Jul 2023 09:55:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FBE063F3C;
        Tue, 11 Jul 2023 09:55:11 +0000 (UTC)
Date:   Tue, 11 Jul 2023 11:55:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] dmesg: Delete redundant pager setup
Message-ID: <20230711095509.v7ptu2rjhe2x5tat@ws.net.home>
References: <20230704091430.3555428-1-dsimic@manjaro.org>
 <20230704091430.3555428-2-dsimic@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704091430.3555428-2-dsimic@manjaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 04, 2023 at 11:14:29AM +0200, Dragan Simic wrote:
> The setup of the pager is already performed a few lines of code above,
> so it's safe to delete the repeated setup, which actually does nothing.
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  sys-utils/dmesg.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
> index 02358e449..971712b56 100644
> --- a/sys-utils/dmesg.c
> +++ b/sys-utils/dmesg.c
> @@ -1646,8 +1646,6 @@ int main(int argc, char *argv[])
>  		/* only kmsg supports multi-line messages */
>  		if (ctl.force_prefix && ctl.method != DMESG_METHOD_KMSG)
>  			ctl.force_prefix = 0;
> -		if (ctl.pager)
> -			pager_redirect();

I have removed the initial (global) pager_redirect() call, because it
makes sense only for the section when it prints kernel messages.

https://github.com/util-linux/util-linux/commit/0619aa8fda39e40776dd2a73346bd7cc5ab4a33f


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

