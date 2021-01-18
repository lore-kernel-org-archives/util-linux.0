Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BC8C433DB
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 16:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DF422C7E
	for <util-linux@archiver.kernel.org>; Mon, 18 Jan 2021 16:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391509AbhARPQZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 Jan 2021 10:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393346AbhARPPO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Jan 2021 10:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610982827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AtgC9Ts3txNqzTjRm30Ra49lVuX/QY2R1OJWobfSzf4=;
        b=HypqChtzOeH+3GiuW0hgugsWCU5KZIqcWjbevZw9OS5JMYKNJJ+tlx2czPXGxnnc3ziooF
        A0Nf1E6GkI/3BWuo3pzLNZzB8NqFT6JvxlZtGb2g+pVRIxl+SaYSe0+WoyQPMn2vuwM1hP
        XAjX+wptXwWcT+xEZwuMIgch2XVs6GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-_1O3G2P3PF-fyDu5uTGMVQ-1; Mon, 18 Jan 2021 10:13:42 -0500
X-MC-Unique: _1O3G2P3PF-fyDu5uTGMVQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C8C59CDB3;
        Mon, 18 Jan 2021 15:13:41 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5AD560C75;
        Mon, 18 Jan 2021 15:13:39 +0000 (UTC)
Date:   Mon, 18 Jan 2021 16:13:37 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc:     util-linux@vger.kernel.org, ruediger.meier@ga-group.nl,
        sbrabec@suse.com
Subject: Re: [PATCH v2] ipcs: Avoid shmall overflows
Message-ID: <20210118151337.pmczjggyw3wv5oq2@ws.net.home>
References: <2f66f8913a6bb2d70201e46efa369b51817ea243.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f66f8913a6bb2d70201e46efa369b51817ea243.camel@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 15, 2021 at 03:00:11PM +0100, Vasilis Liaskovitis wrote:
>  sys-utils/ipcs.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

...

> +		if (unit == IPC_UNIT_KB || unit == IPC_UNIT_DEFAULT) {
> +			ipc_print_size(IPC_UNIT_DEFAULT,
> +			       _("max total shared memory (kbytes)"), (pgsz / 1024) *
> +			       (uint64_t) lim.shmall, "\n", 0);

I have small disadvantage in this code. There is still possible that
(pgsz / 1024) * lim.shmall is greater than UINT64_MAX. 

It means, we still need to check it. I have added:

   tmp = (uint64_t) lim.shmall * (pgsz / 1024);
   if (lim.shmall != 0 && tmp / lim.shmall != pgsz / 1024)
        tmp = UINT64_MAX - (UINT64_MAX % (pgsz / 1024));

So, now we have separate overflow handling for "kbytes" and for "bytes".

    Karel

> +		}
> +		else {
> +			tmp = (uint64_t) lim.shmall * pgsz;
> +			/* overflow handling, at least we don't print
> ridiculous small values */
> +			if (lim.shmall != 0 && tmp / lim.shmall !=
> pgsz) {
> +			        tmp = UINT64_MAX - (UINT64_MAX % pgsz);
> +		        }
> +			ipc_print_size(unit, _("max total shared
> memory"), tmp, "\n", 0);
>  		}
> -		ipc_print_size(unit == IPC_UNIT_DEFAULT ? IPC_UNIT_KB :
> unit,
> -			       _("max total shared memory"), tmp, "\n",
> 0);
>  		ipc_print_size(unit == IPC_UNIT_DEFAULT ?
> IPC_UNIT_BYTES : unit,
>  			       _("min seg size"), lim.shmmin, "\n", 0);
>  		return;
> -- 
> 2.28.0
> 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

