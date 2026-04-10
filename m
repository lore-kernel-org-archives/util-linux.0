Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034593ACF13
	for <util-linux@vger.kernel.org>; Fri, 10 Apr 2026 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810545; cv=none; b=Chz065mPpee0Dsw/1Bn/stVMIEtNQ1TqAhKyhTWI7oyxvjuPCcAlMATOY3ENpNvDomp+G8QenOg/996DKWAs+Gfc7dJ82oFrBpKYygjzmF+3xtu/njHb1FcdK63zNF6U4waDj9mjWgn5NV18EG6TZd2aYfIK7CJhVMxbbown60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810545; c=relaxed/simple;
	bh=vePbohoB5UYKlKyDpqXz560blimOiW57qe6SzaPsqkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxlLv5F0hvMc/EI8RD2puEoe5aoX1fZYjlXoXKqLMY6vu9znapmrk0EM8TJFANP6H//5XX/4E04PwxeCyB32LNo+3oJ6g6GCHpW5RNdIkeVh3b7bC5hOtJ9uxfHBmY0JmCaNyQXLsojqqq0Stmj3d6LMrmxjm2rIkEMdSNZ5Bbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=hENc7Zqv; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="hENc7Zqv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tZgp26yq4j4web/8Mm+xdg+4CT1SWvhvU44slQ2/spU=; b=hENc7Zqv+m4woZjF2FLoHSeVDN
	2r+lcf5t/APa/rV5TUlzikSyt5QkCZ478ZOKt9CSsP2d9SCw4zWdetPO78bJCrsu49FosNl98TEmZ
	9MXnKX1IQtiFrJW8hL4CgAM1nocD8gs4bKhQlcHMF0lcn/QUXUw2DYF4fgY/jvHYotFCB3tpgibot
	XQHEADE+xrJso7qbF8/rAbYH5IRHWVE6XtvZ45PFrcLTK0K2U/r8r01IcRsAHYwnOIgnhdj8vZduL
	cFdaCZmCAGYVt0FvmAROUPkOZszEn/Z0PgNUYGqa+44+lh7QSLwCCoi0wNIyTKrO8RA8mynarz9te
	awTsHTNg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wB7RR-009rDA-0w;
	Fri, 10 Apr 2026 08:42:17 +0000
Date: Fri, 10 Apr 2026 10:42:15 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>, 1132887@bugs.debian.org
Cc: Evgeny Kapun <abacabadabacaba@gmail.com>, util-linux@vger.kernel.org,
	wanbingjiang@webray.com.cn
Subject: Re: Bug#1132887: script: "script file -c command" stopped working
Message-ID: <adi3573O-5gr9m2q@per.namespace.at>
References: <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
 <adS9qeW8w0bmUukR@per.namespace.at>
 <88e0b54d-3c86-46ca-ab3f-e116073216d6@gmail.com>
 <x7m64hxjjld7rkfjwuta75hzmj3f6en57mpvdfttzdliebdqxn@ym5mhuzim23o>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <x7m64hxjjld7rkfjwuta75hzmj3f6en57mpvdfttzdliebdqxn@ym5mhuzim23o>
X-Debian-User: zeha

On Tue, Apr 07, 2026 at 03:26:58PM +0200, Karel Zak wrote:
> On Tue, Apr 07, 2026 at 10:17:45AM +0200, Chris Hofstaedtler wrote:
> > thank you for the report, CC'ing upstream.
> > 
> > On Tue, Apr 07, 2026 at 07:07:59AM +0300, Evgeny Kapun wrote:
> > > If I run script(1) as "script file -c command", it returns an error:
> > > 
> > > script: unexpected number of arguments
> > > Try 'script --help' for more information.
> > > 
> > > It used to work in earlier versions, so now scripts that rely on the old
> > > behavior are broken.
> 
> I have created bugfix for this, see https://github.com/util-linux/util-linux/pull/4201

I've applied this fix to Debian as 2.42-2.

> Seems we will need v2.42.1 ASAP :-)

:-)


Thank you!
Chris

