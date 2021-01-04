Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB83C433E9
	for <util-linux@archiver.kernel.org>; Mon,  4 Jan 2021 12:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE74207B1
	for <util-linux@archiver.kernel.org>; Mon,  4 Jan 2021 12:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbhADMW2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 4 Jan 2021 07:22:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725840AbhADMW2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 4 Jan 2021 07:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609762862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vBbAhRcfWgoouoY9p5t7bntvTEnn6JUoZ9VGRnVm9tA=;
        b=cFleD0sWCpbAa65XLjytloGOPtfKGN397eCGKcX2ufXOfqe2l/p2KQZRn6s2Gqq51QPDcq
        H44yKnRFCNAeJu5vQY362oqAa9ZSpY2UMwtUdV4/yslwtYVYdlJ755oREnTSRxzDbeHZZF
        RfTL8rvOjAfwHusBmVvTcUjujGNn1yE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-KzWFhTVBOkmdOAc69rNJQA-1; Mon, 04 Jan 2021 07:20:57 -0500
X-MC-Unique: KzWFhTVBOkmdOAc69rNJQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 426C1100C600;
        Mon,  4 Jan 2021 12:20:56 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E94135D9C6;
        Mon,  4 Jan 2021 12:20:54 +0000 (UTC)
Date:   Mon, 4 Jan 2021 13:20:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc:     util-linux@vger.kernel.org, ruediger.meier@ga-group.nl,
        sbrabec@suse.com
Subject: Re: [PATCH] ipcs: Avoid shmall overflows
Message-ID: <20210104122052.aoonb4l72c7crkso@ws.net.home>
References: <aa7c757636594db8f122185293393e326652e53d.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa7c757636594db8f122185293393e326652e53d.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 16, 2020 at 03:54:29PM +0100, Vasilis Liaskovitis wrote:
> Avoid computing the number of bytes in shmall, by only
> computing the number of Kbytes. This improves some
> overflows, e.g.
> 
> $ echo "4503599627370496" > /proc/sys/kernel/shmall
> $ ipcs -l | grep 'max total shared memory'
> Before:
> max total shared memory (kbytes) = 18014398509481980
> After:
> max total shared memory (kbytes) = 18014398509481984
> 
> $ echo "99993599627370500" > /proc/sys/kernel/shmall
> 99993599627370500
> $ ipcs -l | grep 'max total shared memory'
> Before:
> max total shared memory (kbytes) = 18014398509481980
> After:
> max total shared memory (kbytes) = 399974398509482000
> 
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  sys-utils/ipcs.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
> index fc6fba4a6..544a3adcc 100644
> --- a/sys-utils/ipcs.c
> +++ b/sys-utils/ipcs.c
> @@ -216,13 +216,9 @@ static void do_shm (char format, int unit)
>                 ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
> unit,
>                                _("max seg size"), lim.shmmax, "\n", 0);
> 
> -               tmp = (uint64_t) lim.shmall * pgsz;
> -               /* overflow handling, at least we don't print
> ridiculous small values */
> -               if (lim.shmall != 0 && tmp / lim.shmall != pgsz) {
> -                       tmp = UINT64_MAX - (UINT64_MAX % pgsz);
> -               }
> -               ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
> unit,
> -                              _("max total shared memory"), tmp, "\n",
> 0);
> +               ipc_print_size(IPC_UNIT_DEFAULT,
> +                              _("max total shared memory (kbytes)"),
> (pgsz / 1024) *
> +                              (uint64_t) lim.shmall, "\n", 0);

It means that --bytes and --human command line options will be 
ignored for shmall ... it would be probably better to use

 if (unit == IPC_UNIT_KB || units == IPC_UNIT_DEFAULT)
    ipc_print_size(IPC_UNIT_KB, ("max total shared memory"), lim.shmall, "\n", 0); 
 else {
   tmp = (uint64_t) lim.shmall * pgsz;
   /* overflow handling, at least we don't print ridiculous small values */ 
   if (lim.shmall != 0 && tmp / lim.shmall != pgsz)
       tmp = UINT64_MAX - (UINT64_MAX % pgsz);
   ipc_print_size(unit, _("max total shared memory"), tmp, "\n", 0);
 }

 Right? If yes, update the patch, please.

   Karel
    

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

