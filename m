Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36A1E3DEB
	for <util-linux@vger.kernel.org>; Wed, 30 Oct 2024 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285730; cv=none; b=VWGFH+2gPW031QJ3naGh+Vb+wWBrSUtrkO3++TMXdvXztUU2TYLMJqPx4ujjL8hmgi95xeDU0S3vaOcw0IH7bjo294i9xSZ++6O10MVVfUqiBgnLbiKPT9SOENJE3/84b+5zJKJu2Rg8rVv70HDm4F3KACTB8IZaVfiTvSZfvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285730; c=relaxed/simple;
	bh=hq5ww0eOpoHEDm6Lry9qtdO6/lzvZr/PdGmGM99qPLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DykpKq1YH4VZ6JbklL7MH39pKy7tR19mr9TJ2fchNqUJCbM1hrNyVXTnH+8rQix1N8uPNDWaeMt9jNdx2mqFwNmfRL8Lz1rA3wL9v3dGksQ8YUcUoILaK1jfKoK50QkuQrfEqbtj4aIH68gNVPfCKSOGvsPXiPo6rKrhP7RzNWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5ZkkO7E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5ZkkO7E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730285726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RfU3XeNIE7k4B+XkNeM+PjmFaVKea7TwPWAEm4QDKD8=;
	b=K5ZkkO7EHEDdoNRVzG6kSLRAqWBAS2qvD+WoMMWuguClop+NZyGCNFGfwG+CPxKu+X1yfB
	EOcNnIYE6d/DdIR/IcvYi1pb9Ua/JuVIikwgGJ6OmSS3H0ZCAVEbvG7KW4DHhiaj/xcQzy
	EpGpLazP1WH4ZOZaKUg19R1Veolnf10=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-IQE_IrFpMP62q-j7kLRqkg-1; Wed,
 30 Oct 2024 06:55:23 -0400
X-MC-Unique: IQE_IrFpMP62q-j7kLRqkg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BB5B19560A2;
	Wed, 30 Oct 2024 10:55:22 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2C45300018D;
	Wed, 30 Oct 2024 10:55:20 +0000 (UTC)
Date: Wed, 30 Oct 2024 11:55:17 +0100
From: Karel Zak <kzak@redhat.com>
To: Anjali K <anjalik@linux.ibm.com>
Cc: util-linux@vger.kernel.org, anushree.mathur@linux.vnet.ibm.com
Subject: Re: [PATCH] lscpu: fix incorrect number of sockets during hotplug
Message-ID: <psbp7ofmppegfcgz6w4jzaqx5ek5yeoc7zqeoh7k5bmdpp4ivg@4xkmw5pmsp4t>
References: <20241018104335.3481856-1-anjalik@linux.ibm.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018104335.3481856-1-anjalik@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


 HI,

 sorry for delay with review.

On Fri, Oct 18, 2024 at 04:13:35PM GMT, Anjali K wrote:
>  /* add @set to the @ary, unnecessary set is deallocated. */
> -static int add_cpuset_to_array(cpu_set_t **ary, size_t *items, cpu_set_t *set, size_t setsize)
> +static int add_cpuset_to_array(cpu_set_t **ary, size_t *items, cpu_set_t *set, size_t setsize, int maxcpus)
>  {
> +	cpu_set_t *common_cpus_set;
>  	size_t i;
>  
>  	if (!ary)
>  		return -EINVAL;
>  
> +	common_cpus_set = CPU_ALLOC(maxcpus);
> +	if (!common_cpus_set)
> +		return -EINVAL;

Would be better to allocate this only once in cputype_read_topology()
and reuse it for all the arrays and CPUs? 

The rest looks good. Thanks!

 Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

