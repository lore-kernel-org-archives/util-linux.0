Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C201649CF
	for <util-linux@vger.kernel.org>; Wed,  1 May 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714596790; cv=none; b=eWFgBjUJra8Zm1Bm9tsweFihEzqXi4b+y561/WfNQzlIaWV6tdaNUVWG4/y3R8rmQ8PxWgUdaHxu4ncb/nF0/Q/DpYt8S0AAfC/0GCU0tj0kFnoKx+QuYflz45A33sNh0hyCViT+ukWYt2zoEAMX6aN3hvenCeenG9MiEDIty/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714596790; c=relaxed/simple;
	bh=6usVWVmHomw7SqeVNb1DnZXiRea/vVxElkndVy8TH0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZ+sySiFpN/HQlOoKFVeLuSLcDy3j0JYrwMTM5SDZs8C7ptclistgOqb4475klp41TnAS9UJPYHw04xyTxy74GnylKqZ2RaY5KdEiE9BowAyTc561Z4dgCb0as/C3B4ZwCswqn0YfBqywEkrXDIrN7X9yBc9QL3f0Nlf/VHVqjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+Qb5SYx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+Qb5SYx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714596787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=McI5dD4CD/GIwubnamPurN3HSmyhc0a0lufY2bT71QQ=;
	b=L+Qb5SYxKVMXef881uzStm1J1lwqH1xWA9leWBnEgYIlAo5IiYTo5CG4qIv3T7hG73R85p
	JiUxGUEhCdpo3vq4Ky2HzQUVJl3EIt6IKNj5nAd195XCH96MK6W2DF5IHlTtoeCQYnfr3I
	EkYhUO1O2l3nzNvUuJ/xKGdGN3M4VRs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-XLwjPPtCMnWON0LUJu41XA-1; Wed,
 01 May 2024 16:53:05 -0400
X-MC-Unique: XLwjPPtCMnWON0LUJu41XA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CE2E3C0009D;
	Wed,  1 May 2024 20:53:05 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.191])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2C88492BC7;
	Wed,  1 May 2024 20:53:04 +0000 (UTC)
Date: Wed, 1 May 2024 22:53:02 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@telfort.nl>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
Message-ID: <20240501205302.5u5nfxfitrlsnwtt@ws.net.home>
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
 <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
 <20240429193802.cflzk47hgjrlsq5f@ws.net.home>
 <9397da62-de57-429c-9f3d-9be26ec1cd76@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9397da62-de57-429c-9f3d-9be26ec1cd76@telfort.nl>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Tue, Apr 30, 2024 at 04:07:28PM +0200, Benno Schulenberg wrote:
> Looking forward to the URL of the stable rc1 tarball

https://mirrors.edge.kernel.org/pub/linux/utils/util-linux/v2.40/util-linux-2.40.1-rc1.tar.xz

    Karel



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

