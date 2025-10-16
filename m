Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C11DDC1D
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611916; cv=none; b=qSoONo6Yb1NsqPcY2Ul4WvJCEarDcuhotXA4rjvFdv0dkHTMDx8p2LhZKExf6z75n4jYye85UX12frb4oEqyitGD4y6GWdKfIHOKfgM9hYprKzTdvu8Z0Trol76qWkYSbAeHUtL/B2ty82IqqHuW8MpfR2oNj8YzeeU3LTJEiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611916; c=relaxed/simple;
	bh=9HXvGsuUE2NXIITawHoKkhAsvai7jtnlVJzfVvmFvwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+wyX7nyajZhKMhPC+QQ8Jqy9d2JkEBZ5O7xTLvl/NXV3BPCT9CB+A0SUmu/EX8XZBVuc/vBUoDvBh19buAqVzhURkTHpQBf72Irkiitk8nEPaEypD7SMQVaDp+cjPSPcPzVOn3yyUwt1OnlCJF/Bv+6nhgwW1WhBYMECmJXNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PeY+UUYw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeY+UUYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760611913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWJhw+2GpysWEGh7Ev4iprcusUHlJol4RQFc1pXSzfQ=;
	b=PeY+UUYwGB+DM/T37r9xIT1R9EsPqCUI3XKyL0qFie1QkFIH7o2QTmg/P648oMc7T0CbZ4
	qMBdY+0g8hT5fhDKhXWjC+5s82HvTtv4yPgAJOW6Qnhml5edKiF/mRuTkmfconWPgZO/aO
	PiBM23mqBwbE0Ga87WU/GFmoTQyWohk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-cva_FuhhPP-abDXjF9mMjw-1; Thu,
 16 Oct 2025 06:51:51 -0400
X-MC-Unique: cva_FuhhPP-abDXjF9mMjw-1
X-Mimecast-MFC-AGG-ID: cva_FuhhPP-abDXjF9mMjw_1760611910
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4066D195608D;
	Thu, 16 Oct 2025 10:51:50 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FED11800579;
	Thu, 16 Oct 2025 10:51:49 +0000 (UTC)
Date: Thu, 16 Oct 2025 12:51:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/6] lsmem: display global memmap on memory parameter
Message-ID: <qdeva54xge5ksrhpwcfe4dd2wv6x5re2ue5fkcguffs2ebvwgk@hk5yjjhv7p2p>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-2-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016101701.552597-2-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 16, 2025 at 12:16:48PM +0200, Sumanth Korikkar wrote:
> Display the output of global memmap-on-memory parameter for memory
> hotplug. Retrieve the details via
> /sys/module/memory_hotplug/parameters/memmap_on_memory.
> 
> lsmem
> RANGE                                 SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x00000001ffffffff   8G online       yes  0-63
> 
> Memory block size:                128M
> Total online memory:                8G
> Total offline memory:               0B
> Memmap on memory parameter:        yes
> 
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>  sys-utils/lsmem.1.adoc |  2 ++
>  sys-utils/lsmem.c      | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/sys-utils/lsmem.1.adoc b/sys-utils/lsmem.1.adoc
> index d588051a8..9c9397631 100644
> --- a/sys-utils/lsmem.1.adoc
> +++ b/sys-utils/lsmem.1.adoc
> @@ -28,6 +28,8 @@ Not all columns are supported on all systems. If an unsupported column is specif
>  
>  Use the *--help* option to see the columns description.
>  
> +Memmap on memory parameter output displays the globally enabled memmap-on-memory setting for memory_hotplug. This is typically set on the kernel command line via memory_hotplug.memmap_on_memory.
> +
>  == OPTIONS
>  
>  *-a*, *--all*::
> diff --git a/sys-utils/lsmem.c b/sys-utils/lsmem.c
> index 39967bfc9..ea818d6dc 100644
> --- a/sys-utils/lsmem.c
> +++ b/sys-utils/lsmem.c
> @@ -306,8 +306,25 @@ static void fill_scols_table(struct lsmem *lsmem)
>  		add_scols_line(lsmem, &lsmem->blocks[i]);
>  }
>  
> +static int get_memmap_mode(char *res, char *src, int len)
> +{
> +	if (!strncmp(src, "Y", 1))
> +		strncpy(res, "yes", len);
> +	else if (!strncmp(src, "N", 1))
> +		strncpy(res, "no", len);
> +	else if (!strncmp(src, "force", 5))
> +		strncpy(res, "force", len);
> +	else
> +		return -1;
> +	return 0;

In other places, we translate these strings, so it should be
N_("yes"), etc, and use _() in the final printf().

> +}
> +
>  static void print_summary(struct lsmem *lsmem)
>  {
> +	const char *path = "/sys/module/memory_hotplug/parameters/memmap_on_memory";

We rarely use hardcoded paths directly in code in util-linux. How
about adding #define _PATH_SYS_MEMMAP_PARM or something similar.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

