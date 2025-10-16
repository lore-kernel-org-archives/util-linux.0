Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E870305E3F
	for <util-linux@vger.kernel.org>; Thu, 16 Oct 2025 11:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760613080; cv=none; b=V1RcewzhBsv1X3xi/SRyTbEj+lQsLWrkRkybEqodKEfV6PHZTbKt5/3VVwPHrDrK5ZbhIHuaULNf1075WhHFCJMb6arRoWiI7Vp9y4Dml4TIgUgGj+1ezYxoBP01REnFHCWKqN7LkvXAlUaxDsxEC2d6PVQ4Ygp2fbw9citDHKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760613080; c=relaxed/simple;
	bh=2jmjPsmOgkkkKbbYGb3Aezn5ppy3wOl5F/gHTjRaMoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4z70YVME4rrXHVVRiw3QMnq/1MOHWgdPS1AHSrHv2CyTmh+s75AjRahHEvkWNdEK2O5fSQZQfSbAQ/hQ+ADzVFlFDJwJ/4isJvsnPIPP6lBifeZjil7oQ4YaIWBtUjCVHJKncU3LaUnaWytRosPUt4GRYvL7UBSEgyw7UXPbcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iyK7R5pE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyK7R5pE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760613077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nv+/dnNZtQ/R30kHiCMIRIeHHWW6CrO9dq3lDTFfTd4=;
	b=iyK7R5pEsVH8nEuM0MEfJ/YcLoWRBQkIdNdDWw9UevpQ9qtvBRjxbsW03V9JSKd6w7tZco
	J4N0jd9+5rN351vW2gIZ52/93zzgLL4YfL5KJj2WpVaEWGn7ZxaUIF0c8u6nX5eGqNrevT
	ePHB268pVNGpF0dzY+pz7XbZZBGkFK4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-c-oKcVmiMVGCUYsu8A3whA-1; Thu,
 16 Oct 2025 07:11:14 -0400
X-MC-Unique: c-oKcVmiMVGCUYsu8A3whA-1
X-Mimecast-MFC-AGG-ID: c-oKcVmiMVGCUYsu8A3whA_1760613073
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75DAE195609D;
	Thu, 16 Oct 2025 11:11:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EFB71800451;
	Thu, 16 Oct 2025 11:11:12 +0000 (UTC)
Date: Thu, 16 Oct 2025 13:11:09 +0200
From: Karel Zak <kzak@redhat.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/6] lsmem: add support to display dynamic
 (de)configuration of memory
Message-ID: <irmgnf4pymv5mjk25fhkdyxobdpe5k5mgd5n4wh6n5wufyp2gs@md2vikulk3jy>
References: <20251016101701.552597-1-sumanthk@linux.ibm.com>
 <20251016101701.552597-3-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016101701.552597-3-sumanthk@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Oct 16, 2025 at 12:16:49PM +0200, Sumanth Korikkar wrote:
> +static bool skip_memconfig_column(struct lsmem *lsmem, int i)
> +{
> +	struct coldesc *ci = get_column_desc(i);
> +
> +	if (!strcmp(ci->name, "MEMMAP-ON-MEMORY") || !strcmp(ci->name, "CONFIGURED")) {

Using column name strings seems fragile. It's better to use column ID
macros to ensure the compiler verifies them.

    int id = get_column_id(num);

    if (id == COL_MEMMAP || id == COL_CONFIG)  

> +		if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") == 0)
> +			return false;

Do we need this access call? It seems like a duplicate of
lsmem->have_memconfig, which you initialized in read_basic_info()
using the same access() call.

...

> +static void read_memconfig(struct lsmem *lsmem)
> +{
> +	char dir[PATH_MAX];
> +
> +	if (ul_path_access(lsmem->sysmemconfig, F_OK, "memory0") != 0) {

The same applies if (lsmem->have_memconfig) is sufficient.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

