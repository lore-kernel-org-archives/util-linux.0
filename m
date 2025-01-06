Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01BB136E37
	for <util-linux@vger.kernel.org>; Mon,  6 Jan 2025 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175543; cv=none; b=VEG7TdNEo6cCE6ul7CpHHwDioo8x/Jn3fvjmZkeIHONuFECsOmjQ5ikN/yc/QwQ19xmYjNSDp2ZF6LfLN/iY4bsbgPWROJnf3knrsuEesFH2eMLWjSNF8IjYoYRhVvH2tbyM+yXRhPikT2FNCtOW1YV7gJVNvt5aCBHCHCUJU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175543; c=relaxed/simple;
	bh=Wv5y7vaetlGmAKGlyoaBihIgLWEIGavyrWJ743NwsPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPdpq6w8aSEQ/ihkS2JlM9GpOlI432Qw8+6SLjQMFe869RKI+HwMJ8ogIOqvQlYjKTXC9A3sZNd4e/Eaz7Y40jMHe4MjUx5+kssLFef0/p1ho8pkpc6h1DwyThP6WA4IwLx4KHN5YrQagfYkZJkOGkNIDQCpb4OFo3RnfTfdVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CL/kKhsg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CL/kKhsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736175540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c4zkQjrzGZcShKWfrw7Icus8jItv2u+edthUHkU60Kg=;
	b=CL/kKhsgnLaR+kBxTjpbrZ675gsOn/pIwx7EutL92FuKGIFHuv4okBY8at7YWnbwBIs+dc
	sRtw03OKkSnOx4Pu6FUqdmtbczCI/bI+Dgp5wtR6aoCJGg6BGxQH5oidCcj7K4/0C2l+lV
	alQgUPbBO2DZLB3x5pSbQ381J9BN+0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-wp00RuFvPfO_IJSypf7iSw-1; Mon,
 06 Jan 2025 09:58:57 -0500
X-MC-Unique: wp00RuFvPfO_IJSypf7iSw-1
X-Mimecast-MFC-AGG-ID: wp00RuFvPfO_IJSypf7iSw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D4691955EA7;
	Mon,  6 Jan 2025 14:58:56 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7DE03000197;
	Mon,  6 Jan 2025 14:58:55 +0000 (UTC)
Date: Mon, 6 Jan 2025 15:58:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <ewc6glghupyk4koka764ymyjzuedczl4uknucujc6vlj3ohgpb@rw5jgn5dxzqe>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
 <e0544e22-d8a3-4e13-908b-97a07cbff40b@suse.cz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0544e22-d8a3-4e13-908b-97a07cbff40b@suse.cz>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sat, Jan 04, 2025 at 05:27:05PM GMT, Stanislav Brabec wrote:
> These would be nice iin 2.40 branch:
> 
> Merge branch 'PR/libmount-vfs-ro' that makes mountfd usable in most cases
> (but still not fully compatible):
> 4095c5bb6757b506acbe47a8bc60d8ebd04ba8a5
> libmount: implement ro[=vfs,fs]
> and
> 03b2e73ae649a957a4f695df4f44c2cbce8d5f92
> libmount: improving readability

Yes, I understand, but in my opinion, it's too intrusive for the .3
release. I would prefer to only have minor changes and actual bug
fixes, rather than new features.

> 20b405c0fea29675e1fb54b894eb1c18459f9d50
> agetty: Prevent cursor escape
> Cosmetic fix, but visible.
> 
> 50a3efab6d126b28fcdcc28f1a0cd5cd596ae357
> lscpu: Skip aarch64 decode path for rest of the architectures
> Ensures proper lscpu behavior.
> 
> fc67f18be51f57ee9a59a0f8f7ad16f284a24a3e
> umount, losetup: Document loop destroy behavior
> Just a doc update that explains unexpected behavior.

Looks good, all three have been backported to the v2.40 branch.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

