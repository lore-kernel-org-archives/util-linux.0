Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B6557311
	for <util-linux@vger.kernel.org>; Wed, 14 Feb 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920631; cv=none; b=IQKDpwJzHfceBLPzvlA1Umb4LQi81MllxbPeWM2gR06Li8rpF3uG+OFQslDV3Q4a1R+jp6daQnDEq44pe/v/Bqh1u7gBNs3Ixib29e/XmYWPG3HfREaXHKLgocMyY5pg2Njzy9azYEpT5eWWG+DCczmrQ2/ltB+vf/Nkhkd0Apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920631; c=relaxed/simple;
	bh=RG2SLVNd7OSMCwX8pfiL6s3LhPOT8nft7v7tHIlBJ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhNDAVXIxRRGzR35wGFCXuVo3ubJj4peEbPaSwJxG0NAmo2p9ddiKjK8SgqrMXDVT+7BxRvzXIg2OHlU3oyPz6hRV9eepN6WDtt6ZmMdGODPHb6TKr0Gt6HT/5YaC6sxf5YX2J4LPjU/jT0sQJDXO6WKGabSXtzPkj2qH2fmn3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xh8X2HiG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xh8X2HiG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707920628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ze+UwOzykD9Mbpycq687IgznJPlGXPNmX2DJnWtpjv8=;
	b=Xh8X2HiGu+WX71mNijnsr1DqpvkYfpW8dF2TRSubYQ0ikuF9QL1RCNPDOwln/6UFiDGxrW
	WlwwIDUxaXwrdbcnel0iOl4vBGFRZdEyJHpJLnSfzhWJJ9vZVq9twjk6fxLW9u7pF1M8sa
	OUh/t3tpXD6PbEH1jjseLY4OX/OQAag=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-oBPGxkEFNX2KfKmPjBYfqA-1; Wed,
 14 Feb 2024 09:23:45 -0500
X-MC-Unique: oBPGxkEFNX2KfKmPjBYfqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 060471C07F3A;
	Wed, 14 Feb 2024 14:23:45 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8836040C9444;
	Wed, 14 Feb 2024 14:23:44 +0000 (UTC)
Date: Wed, 14 Feb 2024 15:23:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Mention systemd implementation of fsck
Message-ID: <20240214142342.x24dioosah2i27na@ws.net.home>
References: <adf1f630-a264-4db7-9777-d4e2de2bad3b@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf1f630-a264-4db7-9777-d4e2de2bad3b@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Feb 14, 2024 at 01:17:46PM +0100, Stanislav Brabec wrote:
> systemd uses its own implementation of fsck with a slightly different
> behavior (e. g. fsck -A checks noauto volumes, systemd-fsck does not).

systemd calls fsck from util-linux, but a new instance (with -l) for each device.
It would be nice to be more explicit and explain it, because "it has its
own implementation" sounds like fsck from util-linux is completely out
of game :-)

> +== NOTES
> +*systemd* does not call *fsck -A*, but it has its own implementation
> *systemd-fsck*(8).

What about:

systemd does not invoke fsck -A to check all devices; instead, it
calls fsck individually for devices selected based on the logic
implemented in systemd-fsck.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

