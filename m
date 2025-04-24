Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F2186A
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488516; cv=none; b=cVtuYFTROGk6Dxd5qIQnmjldukAGgAq+N9DRicPkNaJzXSvaSEVNHenTNtG1Wnc+lI39K39qgo5z6jzrhO5y9na0UbcgZpDRZmDYjozmVs8b7ruaz9npfJ/t1LB9xyQUD24aJYDWz6mUNK8SCmcr2hsWg8lW3O5tTOr1un6khgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488516; c=relaxed/simple;
	bh=oW49fqe3SsmSGewr9GkCp9swgSEmB49xFD861Xt49xE=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fbzuYEE/IW8h5P2yQA95fX8w3a/Rhkf2CmUKFq4EAlf0k8uAKIbikpBIFLWkxs/2q1dHej8ZVVDPk4KShrth1jFrGyrsDb5/oyATTsy/wvdl8cVzs/HHcLfEvntK/SnTEkksll2VGNIlc80Zvc5VHDEPjLNYw0c3tOFa9MT3uRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e/xPUOHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e/xPUOHn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745488513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e4szA9jGEiKQA4XVNANHLr9cayHuKJybbfG21khRHBk=;
	b=e/xPUOHnitl/EqNeh8Y5rmwYTqRNb3VTFV+UMYGlFPHYcN+0+GL+VUBaAWdp26moNmhoxY
	TF088Dns6wEXMp0HHk27JzkShC5QNdYlg61jGt3aFKorDgTkEwXWjd6fIXl7TLn/y2V250
	tVafIHQoXPxAdYJRG7R33wVQ2Yr1IqE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-8Pwp1np5OiW03C34uyzAKQ-1; Thu,
 24 Apr 2025 05:55:09 -0400
X-MC-Unique: 8Pwp1np5OiW03C34uyzAKQ-1
X-Mimecast-MFC-AGG-ID: 8Pwp1np5OiW03C34uyzAKQ_1745488508
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81C2E1800261;
	Thu, 24 Apr 2025 09:55:08 +0000 (UTC)
Received: from localhost (unknown [10.64.240.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F9981956095;
	Thu, 24 Apr 2025 09:55:06 +0000 (UTC)
Date: Thu, 24 Apr 2025 18:55:05 +0900 (JST)
Message-Id: <20250424.185505.855258258029883426.yamato@redhat.com>
To: bensberg@telfort.nl
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20250424093237.6432-3-bensberg@telfort.nl>
References: <20250424093237.6432-1-bensberg@telfort.nl>
	<20250424093237.6432-3-bensberg@telfort.nl>
Organization: Red Hat Japan, K.K.
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

> Also, use dots instead of "(s)" to indicate possible multiple arguments,
> and don't use "<when>" when the possible arguments differ from "always",
> "never", "auto".
> 
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
> ---
>  lsfd-cmd/lsfd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lsfd-cmd/lsfd.c b/lsfd-cmd/lsfd.c
> index 2eb53935c..3610de8dd 100644
> --- a/lsfd-cmd/lsfd.c
> +++ b/lsfd-cmd/lsfd.c
> @@ -2190,14 +2190,14 @@ static void __attribute__((__noreturn__)) usage(void)
>  	fputs(_(" -o, --output <list>          output columns (see --list-columns)\n"), out);
>  	fputs(_(" -r, --raw                    use raw output format\n"), out);
>  	fputs(_(" -u, --notruncate             don't truncate text in columns\n"), out);
> -	fputs(_(" -p, --pid  <pid(s)>          collect information only specified processes\n"), out);
> +	fputs(_(" -p, --pid <pid>...           collect information only for specified processes\n"), out);

This change implies that --pid 1 2 3 works.
However, specifying multiple pids to one --pid doesn't work.

   # lsfd --pid 1 $$
   Try 'lsfd --help' for more information.

Only --pid "1 2 3"  or works. See double-quote chars.

   # lsfd --pid "1 $$"

Maybe a correct fix is rename --pid to --pids.

Masatake YAMATO

>  	fputs(_(" -i[4|6], --inet[=4|=6]       list only IPv4 and/or IPv6 sockets\n"), out);
>  	fputs(_(" -Q, --filter <expr>          apply display filter\n"), out);
>  	fputs(_("     --debug-filter           dump the internal data structure of filter and exit\n"), out);
>  	fputs(_(" -C, --counter <name>:<expr>  define custom counter for --summary output\n"), out);
>  	fputs(_("     --dump-counters          dump counter definitions\n"), out);
> -	fputs(_("     --hyperlink[=mode]       print paths as terminal hyperlinks (always, never, or auto)\n"), out);
> -	fputs(_("     --summary[=<when>]       print summary information (only, append, or never)\n"), out);
> +	fputs(_("     --hyperlink[=<when>]     print paths as terminal hyperlinks (always|never|auto)\n"), out);
> +	fputs(_("     --summary[=<mode>]       print summary information (append|only|never)\n"), out);
>  	fputs(_("     --_drop-privilege        (testing purpose) do setuid(1) just after starting\n"), out);
>  
>  	fputs(USAGE_SEPARATOR, out);
> -- 
> 2.48.1
> 
> 

