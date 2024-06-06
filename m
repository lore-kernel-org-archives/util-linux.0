Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EA43173
	for <util-linux@vger.kernel.org>; Thu,  6 Jun 2024 07:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658509; cv=none; b=rDzme8ody5d8Dv6NqBFaDXDIfQsXSaCerfZvZ+HZbEvlOlM9Y8agcH0Gj/DHnueCn+zsjZcmRzlXLzLVqsljxyASvgQzcZgDlbsY82k87Rb515LRJJMg7AuXDHRAzipDAMe/TnST85d9rf0X1HeP4eKUdqseXdYUQIyzCPSDtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658509; c=relaxed/simple;
	bh=E8KOLocO05rpZbTx9nweEHlT7+Fd2easOYMpidjBad8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTRP5KdEk7kUzD18fk5UW0bzkfd3HDBAISmms/12XOHCyoeD8sq6vVJShyg7BzqqCChaepggHjgAY28UIPPGcsVRVzfFyPMkR2eFANQUKAqa4UXUU4++l+6/OQOwK/4rU0GG3A3PafVMTDNX+gU4qE22CVGwHvw596Xccv6bMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h+KmIKTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+KmIKTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717658506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C9lsw7172MkERVNS4AmlYsXA6KM24ytUu7Fr6LdWnIA=;
	b=h+KmIKTfUqLd9FeIniY/2K0K5VHN/yxZPJDBZEUczb+kW5ezyiuR06vZZjs9dDnIT0B4I+
	RwKEVqqeT22zl654xFdqEDSFgfnFBT84APiCqVPYk2UrlIBdhrDaoSJcmHWr9H8u64VDLv
	kOSCNXEo0pbcjcwrSEYiXtfoM6sb6TQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-tol-JDm6NySePE6awkDV9w-1; Thu,
 06 Jun 2024 03:21:44 -0400
X-MC-Unique: tol-JDm6NySePE6awkDV9w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F33C29AA387;
	Thu,  6 Jun 2024 07:21:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C872C111F3C6;
	Thu,  6 Jun 2024 07:21:43 +0000 (UTC)
Date: Thu, 6 Jun 2024 09:21:41 +0200
From: Karel Zak <kzak@redhat.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5
 arguments, and avoid casts
Message-ID: <20240606072141.x4lkzu5zhjqtttnl@ws.net.home>
References: <20240601093150.16912-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601093150.16912-1-alx@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Sat, Jun 01, 2024 at 11:31:56AM +0200, Alejandro Colomar wrote:
> Since libc's prctl(2) wrapper is a variadic function, arguments must
> have the right width.  Otherwise, the behavior is undefined.

Created PR to test it by CI:
https://github.com/util-linux/util-linux/pull/3085

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

