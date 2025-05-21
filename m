Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CF199EAF
	for <util-linux@vger.kernel.org>; Wed, 21 May 2025 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747814326; cv=none; b=KofVfJBxv2UVJQjYbdRZnjw6ak3vZIaChS9LnqHS9LHg24rljFNBqg7l3NAia2hXa6lCbYqfg4qiAwOdjcaaM6m/Es4/FuEEk5KHFFDmsaSUHzPEnduMJ3BY5ESsLEoKQwlTR5juo5mIaqdBaOLArecJLg/0TmeE7zAER8hj0z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747814326; c=relaxed/simple;
	bh=eFnpmrd+hzxXCt/YNFtpqJ0655sYr7AQgz2sJl5eU9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7frcoGGNbppeXSYh9IcXJi3wK/WpuiFCJa64ubGPNcOD4ACZM/O8PRa/ltjeQX2kxRyNJ8deJadUUFj8+V3S9jdu7TO+shCR7Dw2K3v44iRaH7RWbE/qaRBnixjZQTKipWRHRL/+yo52lTo8Nv1N6xHvYR/eAIr3PTdsWzAqjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4OFGw2O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4OFGw2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747814323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1FUDf5LHNTnRu6Dp+bIz8kcBbg1C4aY2GBJBo1Nmgys=;
	b=T4OFGw2OPCx8gMCnZF64Pb88Rl2bgIO34uioETFKHRMVHoJZts7xDjZiCAQV39TcmYh6JY
	atHF8zwOUCUwaiNWkiE29Os5jo38lG3mC+qq2M+uVIK16jLg8Y0Cpw0hyrV4BQXdoyC6KG
	/MhMXYdCgQ3BqcuW3tqTbOVEKNrDASg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-FVANjjHoPPi0A6ry3wsk9A-1; Wed,
 21 May 2025 03:58:40 -0400
X-MC-Unique: FVANjjHoPPi0A6ry3wsk9A-1
X-Mimecast-MFC-AGG-ID: FVANjjHoPPi0A6ry3wsk9A_1747814319
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11CC31800447;
	Wed, 21 May 2025 07:58:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.128])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A36FD19560AB;
	Wed, 21 May 2025 07:58:37 +0000 (UTC)
Date: Wed, 21 May 2025 09:58:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org, Stefan Schubert <schubi@suse.de>
Subject: Re: [PATCH] libblkid: Fix crash while parsing config with libeconf
Message-ID: <tgnclztj4vkiyqmaxitjxuwtx5hjzc5sdls27xc2lugerfcph2@nmzzqzakgf44>
References: <20250516013111.1099053-1-sbrabec@suse.cz>
 <da40323d-e642-4535-9a9a-ce9054de0241@suse.cz>
 <3p3ennukohxmst4qpalg6t43udyyyijwj6ddbmrpb72yeehxw4@qvj3bdyj3h7h>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3p3ennukohxmst4qpalg6t43udyyyijwj6ddbmrpb72yeehxw4@qvj3bdyj3h7h>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, May 21, 2025 at 08:55:37AM +0200, Karel Zak wrote:
> On Tue, May 20, 2025 at 04:24:07PM +0200, Stanislav Brabec wrote:
> > Stanislav Brabec wrote:
> > > As the whhole econf_file structure is freed by econf_free(file) at the end
> > 
> > > of blkid_read_config, econf_file structure cannot be defined as static and
> > > initialized only once. The econf_free() is not robust enough and keeps a
> > > pointer to the garbage after the first call. And if /etc/blkid.conf does
> > > not exist, it is called second time.
> > 
> > However the patch is correct and fixes the crash, there are still open questions:
> > 
> > - Why blkid_read_config() and econf_readConfig() are called twice with the same parameters? Is it intended behavior?
> 
> This code pattern (e.g., libblkid/src/evaluate.c):
> 
>      conf = blkid_read_config(NULL);
>      ...
> 
>      cachefile = blkid_get_cache_filename(conf);
>      rc = blkid_get_cache(&c, cachefile);
> 
> If blkid_get_cache_filename() returns NULL, then blkid_get_cache()
> reads the configuration again. Additionally, blkid_get_cache_filename() can read the
> configuration if 'conf' is NULL.
> 
> Yes, it's not elegant.

Added to TODO:
https://github.com/util-linux/util-linux/issues/3580

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

