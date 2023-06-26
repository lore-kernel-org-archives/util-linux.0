Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B5DEB64DA
	for <util-linux@archiver.kernel.org>; Mon, 26 Jun 2023 11:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFZLbq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 26 Jun 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFZLbp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 26 Jun 2023 07:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F710C
        for <util-linux@vger.kernel.org>; Mon, 26 Jun 2023 04:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687779058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sPGqkuTSC7oqqv5ZeKE+nFaTB2RoFbQ+Cl7ERYijFPw=;
        b=H/Gr5Ha+peptkS4HOnt8jfl3hasYP5GYUSJcAhBDSSjxjb/NRvahDRDy4TOZq4t24pbS5I
        5DcvgSrAQCaqrlDECCApfQMMxJdIZWfvt2XxRFqw/QwVuY2euOoYwPN6SUeoX0huaF7u1s
        3MybWyH9g6kH5FjjYJUAeGlbhFt6sCU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-mRxPTSKONdWHLnI5R_xLCQ-1; Mon, 26 Jun 2023 07:30:55 -0400
X-MC-Unique: mRxPTSKONdWHLnI5R_xLCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBD4A3C11A10;
        Mon, 26 Jun 2023 11:30:54 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A580112132D;
        Mon, 26 Jun 2023 11:30:54 +0000 (UTC)
Date:   Mon, 26 Jun 2023 13:30:52 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Florian Zimmermann <florian.zimmermann@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] cfdisk, fix behavior after writing changes
Message-ID: <20230626113052.gzluriz2qsqmjk4a@ws.net.home>
References: <CAJed8sMYhw9iYSBN5XqdJiJkiqrciT+yudDBZBRhN8pnfc6CaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJed8sMYhw9iYSBN5XqdJiJkiqrciT+yudDBZBRhN8pnfc6CaA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Jun 25, 2023 at 01:31:33PM +0200, Florian Zimmermann wrote:
> diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
> index 2e29421d7..a05a50f3e 100644
> --- a/disk-utils/cfdisk.c
> +++ b/disk-utils/cfdisk.c
> @@ -2530,6 +2530,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
>                         else
>                                 fdisk_reread_partition_table(cf->cxt);
>                         info = _("The partition table has been altered.");
> +                      ui_menu_goto(cf, 2); /* after writing reset
> next action to Quit by default */
>                 }

It seems that 'Quit' does not have to be the second item in the menu in
all cases. I have applied a little bit different version of  the patch:
https://github.com/util-linux/util-linux/commit/b0d4d093796c3a3776b155e4ec7e2aa7cb09677d

 Thanks!

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

