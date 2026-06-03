Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD13F0ABC
	for <util-linux@vger.kernel.org>; Wed,  3 Jun 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517083; cv=none; b=TxyJqEgRX6XNW92jp64IMWKUjKOSp4PFWrcFPz6FN1fFmCKQxrfCq3oJqtp5PWE0iY6mxada42hItGzrvRK95NnfbHiYhvy29AzXKK71hevqp7jbSjZBHNAIoiC2a3FwWA3vo/kYTcwJU4o4g3zx3Ls4r4QfBaIiwepcToH0RNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517083; c=relaxed/simple;
	bh=BWMW6Tv2vsMCQRHWQ0RbfFstwTp8+QCb5ZmscbW9gRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RN4PTHlL4lhqLwtKYhN9R4iS3SsO+RPn5ma6ToiU8RJSUhF1ij2/KlhbbDI2NTjLaOTo+dGS7KH3gUcrph3WviI+Gs9cGPTPvGsa0zIAtUzPolVRJ8XhyQfOzY5z1JfHMIlWm9UWPTU72AIhu2eHsMnxxLvbd69bxqH5gQ7wOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=m4nGrvGs; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="m4nGrvGs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8kGadiHjTi+c//CJ2sUarP9xr4xEkw63Ug/GDF5TaP0=; b=m4nGrvGsJinJQnl5YDPysdwvvG
	ul5UG5uy32dKPLqzy7Br5VNahB1CRs5w4Ftbiu3pig0NBSIEg/wdhIWBWw+1fTM7zOfw6L8NwF7/j
	J+JAPgEPdTKacYBk2aig1+4BRepLkGekO5DeDODWRKoE/ihmwIe++SXVoSiTi/YSWsWCo6APgJCDw
	77dKKAEQ0u83WfdSHvAzf41W4CPyV8X/2Mvcwrtm31mg4Gb/5kRGBYbXaoFFvdoWZdYehLGQ4An+T
	SuPic/TX+vHMJMmG8sgP3rmck/KgamDo7IhNUNt8KRy2SP+6hG4AahVa1OZsByS3QugDZdQCdv1vL
	jgJKH8KQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wUrpO-003z8A-0B;
	Wed, 03 Jun 2026 20:04:38 +0000
Date: Wed, 3 Jun 2026 22:04:36 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: 1138789@bugs.debian.org,
	Johannes =?utf-8?Q?W=C3=BCller?= <johanneswueller@gmail.com>,
	debian-loongarch@lists.debian.org
Subject: Re: Bug#1138789: FTBFS on loong64: mkswap: error: swap area needs to
 be at least 160 KiB
Message-ID: <aiCI1IeBms90Uzy0@per.namespace.at>
References: <aiCHUJ8pmy_Atx2S@per.namespace.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiCHUJ8pmy_Atx2S@per.namespace.at>
X-Debian-User: zeha

Hi Johannes, Karel,

util-linux 2.42.1 apparently fails its mkswap tests on loong64. Given 
it fails in mkswap/mkswap-file-existing, I suspect this is "caused" 
by commit 775729884a3945a53df33e0d3ff2ba263b96b59e / 
6d87ff51568c017a6d08043d554bf0ea8dee5457.

Could you take a look please?

> diff-{{{
> --- /dev/null	2026-05-29 12:41:25.961759630 +0000
> +++ /build/reproducible-path/util-linux-2.42.1/tests/output/mkswap/mkswap-file-existing	2026-06-03 19:26:30.186627085 +0000
> @@ -0,0 +1,3 @@
> +mkswap failed
> +mkswap: error: swap area needs to be at least 160 KiB
> +mkswap -F failed on existing file
> }}}-diff
> 
>  FAILED (mkswap/mkswap-file-existing)
> ========= script: /build/reproducible-path/util-linux-2.42.1/tests/ts/mkswap/mkswap =================
> ================= OUTPUT =====================
>      1	mkswap failed
>      2	mkswap: error: swap area needs to be at least 160 KiB
>      3	mkswap -F failed on existing file
> 


Full build log at:

https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=loong64&ver=2.42.1-1&stamp=1780514831&file=log

Many thanks!
Chris

