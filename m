Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE73DD51F
	for <util-linux@vger.kernel.org>; Wed,  3 Jun 2026 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510629; cv=none; b=uKI8Xjm0Y4IeTuNxI52LAs1pY7FRN0IcgcBMRGItCSRKsxOU1WsxbrJ+spMfAi2qSJCWX2Cvx6jiui5tRaz2wpm6rz3p5xl67XNLWAW2TFVQ95N6fY3M8uSSCERSxMyJc3AApLI+3MuYrFx7Ylqi1JNJ0Ja9Asm1VY1ZjXPsuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510629; c=relaxed/simple;
	bh=Scj8WfI1ah1QJqk/Sp6V7jCfCPO7BVhaa3ULA2uM+jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6vCrXaRBc3dEVJjQep94O/AZJIBIrqmfFYVrsmj22uerxqSqb1b4gDSvemuy1BRD86Eoum7u9j/kFqCc5qHr2BxzWzePoDpyFFVdHixRZapjKFtfcqsZfp9diudHgS52Z94TkZjKbwCFJ+KzP2W1ktu5Er0rR5Sy+F6VsYPl+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=GbHyEOd3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="GbHyEOd3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ltLnJWiwf786iFBzZhCLsgXhgR46GtVszfAfwpp9QdQ=; b=GbHyEOd3mRQ/T84Yfz8NEi3LqK
	h2rpTsgfpkWovo50AxTXqO7bxEVSf8IWBZJTJDQl1zlcAag1AyHXmgk7WY+hWIwMR+8H4AuKbJyQz
	k8YOMfWcX7CcSd4dcQQWOrrpwJA5FRC60SzPHYLwWWcVVnnz3rQ10O/ifsBFBhBjtgUPswzPyGXyx
	qD8wVA/aeuw6FjJGb0hO5QycuRDa3V8wwujf3h3HJGxy86z6pX7lroS23SYWNcYdNeXH8Qzs1N6tl
	Rjaeb+on9/Poi1K0NZ97U4x0UY+kUomO1+CjPvKeTRJDKPeEhQRSq3WYH0h+h3CGCQxrt1Vl1QtBD
	M3CCXkOQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wUq9H-003vPO-0R;
	Wed, 03 Jun 2026 18:17:03 +0000
Date: Wed, 3 Jun 2026 20:17:01 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: Ralph Ronnquist <ralph@selfhost.au>, 1134639@bugs.debian.org
Subject: Re: Bug#1134639: nsenter -t 1 -m escapes mount and pid namespaces
Message-ID: <aiBvnWAjX7uu8ydx@per.namespace.at>
References: <aejkWHDXmpCX7Gh7@smyga.hemma>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aejkWHDXmpCX7Gh7@smyga.hemma>
X-Debian-User: zeha

Hi Ralph,

sorry for the late reply. I am not an expert on namespaces, and have 
thus forwarded your bug to the upstream mailing list.

On Thu, Apr 23, 2026 at 01:08:08AM +1000, Ralph Ronnquist wrote:
> I observed this ina simple test setup, with on ordinary filesystem
> built with {debootstrap --variant=minbase sid FS ...}
> 
> First: {unshare -m -p -f chroot FS} will change root into that
> filesystem with unshared mount and pid namespaces.
> 
> Next: {mount -t proc proc /proc} will mount the procfs for that pid
> namespace. We see with {ls -l /proc/1/ns/mnt} the identity of the
> unshared mount namespace, which is different from the identity before
> chroot.
> 
> But: {nsenter -t 1 -m -- ls -l /proc/1/ns/mnt} shows the identity of
> the host mount namespace -- the outer namespace.
> 
> Thus {nsenter -t 1 -m} "escapes" from the unshared namespace to the
> containing namespace. And for example: {nsenter -t 1 -m /bin/sh}
> starts a shell in the outer mount and pid namespace(s)!
> 
> This seems to be a severe bug.
> 
> Apparently {nsenter -t 1 -m} finds pid 1 in the outer namespace rather
> than in the call pid namespace.

Hopefully someone from upstream can shed a light :-)

Chris
