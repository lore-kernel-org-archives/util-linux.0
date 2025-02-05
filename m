Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0418A6BA
	for <util-linux@vger.kernel.org>; Wed,  5 Feb 2025 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799507; cv=none; b=QO2zHhza3to1PGW3qUVSGcsx4RJ5TyMGCpyFyn2yQ+94T979Nx8b84QngE3h+Jj1njL9rQ7avaxrFV7oyKgs4kRo12wf8y2Rh6pxtCXCGmVhzIs0ZkaRtyDLMDUGm7yja/magV0GFgRK/teS3Ufrf+nHlQX3ebgQ52NsCGmMne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799507; c=relaxed/simple;
	bh=PCBlUCmRsNba4QWry0yfOxupqw26iNKjCHFYIyJlIAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjiGgsPtNp+iYY2s+6cP/cpkGMKW+OWSEolewhkhtifP6U21i/JFR9CPiYjZMAKiWr9C7F5GZiT3gwJ87p6rGec6NhGG+AcbZcVW4zzcTBGclJrQwQ3GuP707wjs5k7MjAvHXyErK2rGGXFjM+5AGw95qnmexjRBKYa8Pou5ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Lj7U44dL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Lj7U44dL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PCBlUCmRsNba4QWry0yfOxupqw26iNKjCHFYIyJlIAA=; b=Lj7U44dLQP1QhSC+UW5Nyh3Qha
	WRAxG7NPhqgkTX9Rx4hKVah39Ao0qPvHf7ccev7lhdYs4LVJn/cNF6V8RjFP40DGywg+BzswQD6QW
	6pKy5wOUNWPU8uGui7volHozw6pLJzgZ2uJuggpZW8Xjl/5ZEqqbKVmnr6ZyR3XSMFYaJYqL94ZNW
	umLGw8bW6WhuhbL1w4AQgEUjRLobTtj7luBv74hDZk2ntZrwRop3LNgZQZeglPkX0RWvlOLFkOAPM
	gWihbb5lQJevSslBmhVWr/WcHSF/HoSJGeDTbfVYviLqXDwM0YJpDMrDLWcIexlSDukcu/913w8+G
	K0oZxP/A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tfpBH-002IYq-RM; Wed, 05 Feb 2025 23:51:44 +0000
Date: Thu, 6 Feb 2025 00:51:41 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: v2.40.3 plan
Message-ID: <ezn7omtjktebuobk6jmfxy3s6t6whoiiqcm62faqocnamybvtk@dsvj5df6qj76>
References: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4wnkdjqtwlx5pjeknj7wqmk5bgftoyzpqijqguekcepcdyrgmn@pofpabk4awvg>
X-Debian-User: zeha

Hi Karel,

* Karel Zak <kzak@redhat.com> [700101 01:00]:
> The next release, v2.41-rc1, is expected to be released at the end of
> December or in January.

I guess this got a bit delayed :-)

Do you think 2.41 final will show up before 2025-03-07? Then I could
still put it into Debian trixie.

Thanks,
Chris

