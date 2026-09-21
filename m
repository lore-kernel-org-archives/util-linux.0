Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525A3403EA
	for <util-linux@vger.kernel.org>; Mon, 21 Sep 2026 07:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974425; cv=none; b=X9UVsv3mnX6Rsxfxf2oNvQFnqcdjDPGh17d0uu2tUfqh7nJ7eax02vbIYd8f41N9xVfiEWY9UUMvATEx5RDiAUMujS/T6WF40KnxI1G8GsGGiQYZAn0mfMo73bB312DRR6SCMf2B60OCWBM87qIHgFZYz84Ts2fegsIRgZT1aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974425; c=relaxed/simple;
	bh=DWUHMCgZhqoyLZSz59laT2KE/sQy9I309wUZKQ+Cxdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYNecsu7QEsLNZj1cIkshNrr91ObwPPNyZCPrsegKLNBcJMhKljkrRUWN7T7dvYeq+vq0FSlyouxl8UCIttdMbv4aAm/Tvo4MoZ88qgy5o+drV7UckqMae1jphobnTUQ1vmcXcRMx/F17B9RLq70izMSj0/XxGtePTQTnFEY8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LExHB03Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LExHB03Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789974421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gVSczTHB5L4lG52EkZ7J6FnbYfJKHdsnd3Gr/4416BQ=;
	b=LExHB03Q4sqkL5S6mWo475iWNYNhhL33QBQzu9krmIks8m93WxcgGKga5KxXpMgpeLaqay
	722lviwNGEluz6INGFXWTcTjpbpcYNAJ7Wby7INYHb8+l9gCADELxVUtaSBBSXHT2uFBz3
	W7ZYTXNO1j/1Ti5aaQSP5x+bqniFtJE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-hETNKZN8OY2o9GUmbZkpVg-1; Mon,
 21 Sep 2026 03:06:59 -0400
X-MC-Unique: hETNKZN8OY2o9GUmbZkpVg-1
X-Mimecast-MFC-AGG-ID: hETNKZN8OY2o9GUmbZkpVg_1789974418
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8E67195608B;
	Mon, 21 Sep 2026 07:06:58 +0000 (UTC)
Received: from ws (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6F0A427;
	Mon, 21 Sep 2026 07:06:57 +0000 (UTC)
Date: Mon, 21 Sep 2026 09:06:54 +0200
From: Karel Zak <kzak@redhat.com>
To: Tianyi Chen <hi@tychen.cc>
Cc: util-linux@vger.kernel.org
Subject: Re: [RFC] libmount: explicit loop direct I/O requests
Message-ID: <zxpnm3dbgy6vv64gockhcl5egfpe2qpld7jlkgg3enr5jbfha2@q27vjqxnocmb>
References: <178981850377.1262776.17938790502420524863@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178981850377.1262776.17938790502420524863@tychen.cc>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On Sat, Sep 19, 2026 at 07:48:23PM +0800, Tianyi Chen wrote:
> Hi Karel,
> 
> Following https://github.com/util-linux/util-linux/issues/3464, I'd like
> to implement X-loopdev.direct-io=on|off with these semantics:
> 
> - Omitted: preserve existing behavior, including reuse of either mode.
> - Reused device: require the effective mode to match; do not change it or
>   create another overlapping mapping.
> - New device: read back the effective mode and fail on a mismatch or query
>   error rather than silently accepting a fallback.

Now, losetup simply opens with O_DIRECT, and if the open operation
fails, it returns an error. I believe it's the kernel's responsibility
to verify the usability of LOOP_SET_DIRECT_IO.

loopcxt_setup_device() should be ready; we just need to ensure that
the flags match on loopdev reuse.

> Failure cleanup would release only resources acquired by this mount,
> without detaching reused devices. This would not add live mode switching
> or remount reconfiguration.
> 
> Does this behavior and option name look reasonable?

Yes.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

