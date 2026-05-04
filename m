Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3613E715C
	for <util-linux@vger.kernel.org>; Mon,  4 May 2026 18:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920822; cv=none; b=M+D+KXHGpdk7COD6vdVyTpZ9M61Ju4M2XrD/UyTBNN0WguOuHxqBnXmSNb3bwvh0UPeLAU2FCz0IxG11U3MBpm4I8wB/9KxSMKapTFFjWlDUOUdV64dQxxMpeOuUSPUchZCGS6vMqBwivEo8rXlwiEgHTFcSC8t/4U1pexY/iYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920822; c=relaxed/simple;
	bh=Xgt6sdhDFxwcDdQAI3prtGYf+mhT0lZMShOPxEk79yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9u461hX6pEIzkqceLabI+EC1KCt2Sr3SSwxyGKj8PK8k3Lg7VTty0sFaS4F61Ios37T+xC0WQ2bWhd4wWPbASPJ5PcH+81Qs1jDv8KS9wQfFr24p3nVDSKoYvk3oPhrj7IKNGeCFFXti25o5Pwf+1LQUd9+xhz2imWG1u73UdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=eYkWNhtn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="eYkWNhtn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MkCEHNvyxYyba3D80dp1BbEgiDMw7+TvGl+67TBk79g=; b=eYkWNhtneMTqqToIJWPIcxZPEN
	2hL4JfB32PktbMfev7T/riZLnXGu8FzNqgaofllu6sKjS6K8EWgX/OJ9sm/shYBYssxI5x7FbM7jw
	w326mI+quKMsIWjkRyc7WOgJBevEq1n9+J72Q79ACP7L7Q/RlWQZDc3+8Lwu/sRgNvx1FWNhmXk0B
	dOhP/JYfZAsRGf5lvYfEA7csQ6v3S/84CRZTU3nP2Bf7m865MslLKvgeMiEdtYyWyrE63TYXeP6vG
	YISmn2FE2ESLza4eVaV5agwmjXK04yoIlrHZl3zTZN4VpSZX+WiFtDiDxshuBl/eCOkM0IW0zOaNZ
	/IG3dYjA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wJyQ9-002EvG-1F;
	Mon, 04 May 2026 18:53:33 +0000
Date: Mon, 4 May 2026 20:53:30 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Werner Fink <werner@suse.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Secure login and sulogin on S390x
Message-ID: <afjqh57bXkLJ_FKr@zeha.at>
References: <20260429092825.17623-2-werner@suse.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20260429092825.17623-2-werner@suse.de>
X-Debian-User: zeha

* Werner Fink <werner@suse.de> [260429 11:30]:
>Some remarks: on S390x architecture of modern zSeries the hypervisor
>does log the console I/O.  For both the 3215 half duplex line mode as
>well as the 3270 full-screen/block mode console type the I/O is logged
>on the hypervisor's side.  To control this there are command send via
>/dev/vmcp to tell the  z/VM control program of the hypervisor not to
>log during entering the password.  For the 3215 console also automatic
>scroll is enabled which avoid to press CLEAR to get the password prompt
>if on the next block.

[..]
> 9 files changed, 436 insertions(+), 12 deletions(-)

This seems to add a lot of code to util-linux. I was wondering if 
sulogin is the only place that needs this log filtering. What 
about su, sudo, doas and so on? Note that there are different su 
(and probably doas) versions in use across distributions.

Wouldn't it be better if the hypervisor would not log input if the 
terminal output was disabled? That seems like behaviour commonly 
found in other virtual terminal emulators.

Best,
Chris

