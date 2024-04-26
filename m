Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB913BAFA
	for <util-linux@vger.kernel.org>; Fri, 26 Apr 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118501; cv=none; b=o/eu/sgFWKvG3qa/pZ7oESdmc1hSdeQfD7z22LOUiEdhIqsWpWkLg6ndtLQUKkP2L+ekaH/OHDqZXmEABMzzBDZ1wOdMRbgU2eZ6e6feGePQ8PiQ2IC8vl8V0zKjS3dIn6RRRh5om/6wvozkGzuKKpMErSuea9g9N4zId+uF+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118501; c=relaxed/simple;
	bh=rRtjyz0bi8GeAWIpvK0pObnifEVpiQJ7bppqpWmhwG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liULcL2SrWuImF8KdYsIrbbVzg/efgzCRw7aKST2vuBd+Nt2o9eVbm9bPIcgoJjEHfy7FiqLkZAkGTnlx57B8w/oFyJEWhnPT0vsMA+LgGYH6EjLEvdu+LRZ4Isbb8wZlwwao0UY4mXnPrVidT2UdkWqYOQzQ4ruADDhJ5dmxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OnUIA3wD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnUIA3wD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714118498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mMIyX2aI2ICYIUGr056rJQnYTFWVso6eB1Kz4UOwp7Q=;
	b=OnUIA3wDFbQN1BLNYbeLfDjQINAwUsuoknSzd3fwa1SI+30mowRmfzVz9okcA2pzrmzBbr
	oyLdQEPtaimI+ygKMxdL6PydYRG3pk9sgAhJKGcIq2jVxswtWU6W0Ov2Rcc42eLgkkcsx7
	KHyGZE7MWRQz+GZ/hv01J0jnAR/Yus8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-SYF9eeTIOk6fOvGh7NhXpw-1; Fri, 26 Apr 2024 04:01:34 -0400
X-MC-Unique: SYF9eeTIOk6fOvGh7NhXpw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A201F812C39;
	Fri, 26 Apr 2024 08:01:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 09FD9151EF;
	Fri, 26 Apr 2024 08:01:33 +0000 (UTC)
Date: Fri, 26 Apr 2024 10:01:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: util-linux@vger.kernel.org, Masatake YAMATO <yamato@redhat.com>
Subject: Re: [PATCH v3] flock: add support for using fcntl() with open file
 description locks
Message-ID: <20240426080132.ik7utluevivb4iqn@ws.net.home>
References: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425094417.1174162-1-rasmus.villemoes@prevas.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Thu, Apr 25, 2024 at 11:44:17AM +0200, Rasmus Villemoes wrote:
> v3:
> 
> - Replace configure-time checking for F_OFD_ by just hard-coding the
>   proper values in flock.c if the system headers don't provide them.
> 
> - Consequently, drop all HAVE_FCNTL_OFD_LOCKS guards.

PR updated: https://github.com/util-linux/util-linux/pull/2993

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

