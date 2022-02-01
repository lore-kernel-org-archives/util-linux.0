Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EB1C433EF
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 13:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiBANCI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 08:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238187AbiBANCI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 08:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643720527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U8vFT/Xnd+QerYyN7SxNNYg6k0OzEVPzUx0N5Q3ZSwg=;
        b=W3RCMLUvd21To6zflOsiwwWCRXUHyzn9LloL3aG5Nq2UGEbRsKVoJ0ClsldJYpjNpW1QPj
        FQRcPBXUzeinz3NmAcrJ9s+NVYBqIjdeaXLgi0Xp0NcEOJgKRzA9DN/W3P+D2slvf6DMF/
        KOj6+eWhl6ol5tKgOGm251E7uzIHMug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-c3HdONyFMla7oW8f5rkztg-1; Tue, 01 Feb 2022 08:02:04 -0500
X-MC-Unique: c3HdONyFMla7oW8f5rkztg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DAEB100C661;
        Tue,  1 Feb 2022 13:02:03 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8757D716;
        Tue,  1 Feb 2022 13:02:02 +0000 (UTC)
Date:   Tue, 1 Feb 2022 14:01:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Samuel Thibault <samuel.thibault@aquilenet.fr>,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220201130159.ghzkvwj6epo5pdaq@ws.net.home>
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
 <20220131182030.ci3q6puznrwt6vst@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131182030.ci3q6puznrwt6vst@begin>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jan 31, 2022 at 07:20:30PM +0100, Samuel Thibault wrote:
> diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c

prlimit should be marked as Linux-only in configure.ac
(UL_REQUIRES_LINUX([prlimit])).

   Karel

> index ca69ccf98..34f635b1e 100644
> --- a/sys-utils/prlimit.c
> +++ b/sys-utils/prlimit.c
> @@ -82,11 +82,15 @@ static struct prlimit_desc prlimit_desc[] =
>  	[LOCKS]      = { "LOCKS",      N_("max number of file locks held"),      N_("locks"),     RLIMIT_LOCKS },
>  	[MEMLOCK]    = { "MEMLOCK",    N_("max locked-in-memory address space"), N_("bytes"),     RLIMIT_MEMLOCK },
>  	[MSGQUEUE]   = { "MSGQUEUE",   N_("max bytes in POSIX mqueues"),         N_("bytes"),     RLIMIT_MSGQUEUE },
> +#ifdef RLIMIT_NICE
>  	[NICE]       = { "NICE",       N_("max nice prio allowed to raise"),     NULL,            RLIMIT_NICE },
> +#endif
>  	[NOFILE]     = { "NOFILE",     N_("max number of open files"),           N_("files"),     RLIMIT_NOFILE },
>  	[NPROC]      = { "NPROC",      N_("max number of processes"),            N_("processes"), RLIMIT_NPROC },
>  	[RSS]        = { "RSS",        N_("max resident set size"),              N_("bytes"),     RLIMIT_RSS },
> +#ifdef RLIMIT_RTPRIO
>  	[RTPRIO]     = { "RTPRIO",     N_("max real-time priority"),             NULL,            RLIMIT_RTPRIO },
> +#endif
>  	[RTTIME]     = { "RTTIME",     N_("timeout for real-time tasks"),        N_("microsecs"), RLIMIT_RTTIME },
>  	[SIGPENDING] = { "SIGPENDING", N_("max number of pending signals"),      N_("signals"),   RLIMIT_SIGPENDING },
>  	[STACK]      = { "STACK",      N_("max stack size"),                     N_("bytes"),     RLIMIT_STACK }


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

