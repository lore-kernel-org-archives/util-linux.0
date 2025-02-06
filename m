Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4F239577
	for <util-linux@vger.kernel.org>; Thu,  6 Feb 2025 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738862059; cv=none; b=ir1IcWebjN3oqOeKtCA0JUYE+8uH3ewN0dJ6Tx/QZQp+yXFigpbCGEihd/Cus1/KymhwudbNTFsmk0yLQlR6Fn//vAXHJ9qCLKZvAO7/wwP9ph/lZe3+ZUDKrkOVavAH0NZX9VBCMzCutpMOOrLMo351JW4z3n+9uaZ7vU4QuXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738862059; c=relaxed/simple;
	bh=Ytm3h7UGtst43LZZftYDUTsyKjuBuzyAn/bvEMMiZ4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdGJ3n5fRVDggmV0qFf4nwsfO1cSNGLA+VKcUPxGwViBnw8uy1SsC9YE9p1UQBrerXsmk+EXRrop4ehyIvn21k9oDZwFnDWKN9hUzlfOJmlaEFL5oEA8PvsXrfn0iF3sU3BBQBCZMe8rIs6W5amhdA3OYiSph7Epn+fCHhSAoZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o8wJxKnU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="o8wJxKnU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zlK8+LU0+w6zQjOKP/VAHbyTINOcHQEnD4Rd5p8N/2M=; b=o8wJxKnUFbfUehwJL1drX7+3jn
	oU0PrqTPmuWnziksoa9Bb/5fDjvq5ENBQG/5J28kd6z5a29RIl4in4r8cUesAPiNnZDIICdBpoObc
	ZudwjGGYHNgg112IhgvzE+Y4BcH4wmtodoqBj67U9wNxLkMVALmSWO298PB7NtWZi+1l19ArrZz+d
	6u71XZy3Ynjz0LNUfRisLSVoine3HH3CC3mtbs/LAYgwAdMQRcYEWIBSJViz+Ccp+gM+VUbEuHzpd
	Fg/TZ7cZiDsP/999Iof3+R91n10KmRBua3AbJenC9EtGHDO9AaHZkZuiilR1byNIwiYIkIK+fZoXp
	KvqzqjIg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tg5S4-002u0l-21; Thu, 06 Feb 2025 17:14:08 +0000
Date: Thu, 6 Feb 2025 18:14:06 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <i6vtlijvb4u6osfrnm7bple7vd3x2htbsrs5ejyt3ixeyeyibz@rsbrbvhncawx>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
 <ezn7omtjktebuobk6jmfxy3s6t6whoiiqcm62faqocnamybvtk@dsvj5df6qj76>
 <7duwc3kj5anayedj2irumtdz7t3vpdxfr5qu2t2pa644qnoqym@7er3y4jnov3b>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7duwc3kj5anayedj2irumtdz7t3vpdxfr5qu2t2pa644qnoqym@7er3y4jnov3b>
X-Debian-User: zeha

* Karel Zak <kzak@redhat.com> [250206 16:15]:
> On Thu, Feb 06, 2025 at 12:51:41AM GMT, Chris Hofstaedtler wrote:
> > * Karel Zak <kzak@redhat.com> [700101 01:00]:
> > > The next release, v2.41-rc1, is expected to be released at the end of
> > > December or in January.
> > 
> > I guess this got a bit delayed :-)
> 
> Yes, I had a 14-day vacation in December.

Hope it was good and relaxing!

> > Do you think 2.41 final will show up before 2025-03-07? Then I could
> > still put it into Debian trixie.
> 
> This date seems like a challenge. I'm not sure, but I'll give it a
> try:
> 
>   rc1   2025-02-10
>   rc2   2025-02-24
>   final 2025-03-05
> 
>  We will see ... :-)

Much appreciated.

If it doesn't work out, we'll just have 2.40.x.  Not a big deal.

Thanks!

Chris

