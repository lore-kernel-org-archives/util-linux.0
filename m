Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5E81AA7A3;
	Thu,  9 Jan 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409704; cv=none; b=caZERqDhK5FoxptcN4h1QW019wF5NLajOopYklgIBRzNjag+WzzwzmbxeOcQaf98MWltr3Vk7SfUOT1VT2nAnQ7EqKq9z8/FWgCcuLY9SERULXJKHBeD3mM+wq/UDU9qyh/gTs+f8MrrfZa0J8X5ZMg6NZPO8x2NWs1tUEhIYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409704; c=relaxed/simple;
	bh=49kM64pmw9W03Ssd0l/CybZF+pL8bNl9/xqHdcwdD2U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=tSjU+h/JXCKfcH0+lL09glr70m1QHLBeFHfPy4bQPtubiy1iH9HjbTEeOaD00qDMFsxRefyeEChj+pNXOlb3OwPh/5WUkI7G+zgNJgbBaP5FSvG2ELnPjVPN2rSTFNF/KnS5oacGVMqntFDvAkvV0I0X0V+HP6JPtmk3bZvjZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=idfXzhzs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mSWSZd4J; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="idfXzhzs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mSWSZd4J"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B3BF1140186;
	Thu,  9 Jan 2025 03:01:39 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Thu, 09 Jan 2025 03:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1736409699;
	 x=1736496099; bh=tFSSeUXYGNqQ+vXMO+NtKtoTW4NWCD4E4zHzGSE66xc=; b=
	idfXzhzsNV3OJmvRYDQHElHD0EZI30mNFlK4a6sKSvOwC+cM7mUo+Tu2EChs//7z
	OqGmxXNMWAtqSEwDfUKoZEjLn0qswldKl9DVhGv/o1txJEnfHYd5jjwJyZFWBJt/
	2akjGizAD4CnNX5n/okJEnuwDXZCUmLJ/AUzZo6VHEmGBxiB97E2OsIcU8TXQyc/
	SBlQ7EJ8HaGOPitsgeMn9a4TbNLUffyK3OMQ0SpnYK1RWguLZSMZ3F3aqS5ABM76
	/E8NaDqFqH36YfDz2E2OfN1GZGpCtLKI0l+wmpoEQrAUHA8nUF7sz9uj5KyEBWm2
	HwAAv2bVeHtxkDvzM+CdgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736409699; x=
	1736496099; bh=tFSSeUXYGNqQ+vXMO+NtKtoTW4NWCD4E4zHzGSE66xc=; b=m
	SWSZd4JPiP5Wsny3BuhBD/td3EP/2rzmVykp5Iyp1aTqrA2sTQWHH33RbcywlDWU
	7tilA75DZgzM5IqdnJuBv+NfmXmb/xmix6yzuF01+N475EM+OR36nYFxlsufBHbd
	CuWGURmmuC9gEF1gBt4NGMLhPFX/LEwiklCoTBo2GK/EZOK9zHbaDqKCahXFSsxI
	UqQ99a9ljbAHWbGjBz94NZhcH4f/Pj4Cer+wBn8dZLvKV4ucMuknqzwu8/NBqAwh
	70sRtDaHpns1DBbpNdMuYU9IE8CnY3EMV7ThNEb/RzkiAi0QwE3bc2AU8RG+cFDx
	jPzTINTljpmv3q6Y3G6qQ==
X-ME-Sender: <xms:YYJ_ZwNgw7E3rbkR_fmZVa1eSo9T7itT4fB3tWXLglWq1yiETBPMPw>
    <xme:YYJ_Z2-vLJ39rrl6gN9eiFzOC20wd4kpCMbKPy2vdxyt9cQwY07oNTs_JnvLiwDRs
    yzjyWMU4vIQsfl_OSE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiigvhhgrseguvggsihgrnhdroh
    hrghdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehmrght
    thhsthekkeesghhmrghilhdrtghomhdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprhhitghhrghrug
    drhhgvnhguvghrshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghgvvghrthes
    lhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehmkhgrrhgthh
    gvrhdrughirghluhhprdhfuhdqsggvrhhlihhnrdguvg
X-ME-Proxy: <xmx:YYJ_Z3TEWAVi9c40y2dndwxZNis_2rPCGgaysxS2ss-vK8326XTquA>
    <xmx:YYJ_Z4tJH_-lclsU2nbv237jWNrIG0GfqO4R7-kN9Lt0K6KxmTB1Xg>
    <xmx:YYJ_Z4f2zE4Mt8gIhgAS1Dm9M253_0ulgMC0nzNivOs-qoNfDer3cw>
    <xmx:YYJ_Z83dHIoEsfEujV4ZIPmHFXXAemCLG1NV6yRvjOA8ZBga-ID_dQ>
    <xmx:Y4J_Z8_hj_Yx_j5MBx4uzGFBKzZzA2ztIAvda0o5ufDQBT4UpUp51_r_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3E4372220072; Thu,  9 Jan 2025 03:01:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jan 2025 09:01:16 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Matt Turner" <mattst88@gmail.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, "Kees Cook" <kees@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-alpha@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "Michael Cree" <mcree@orcon.net.nz>, "Sam James" <sam@gentoo.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Michael Karcher" <kernel@mkarcher.dialup.fu-berlin.de>,
 "Chris Hofstaedtler" <zeha@debian.org>, util-linux@vger.kernel.org
Message-Id: <24f03227-1b55-4e50-b6e9-7ac74fda2602@app.fastmail.com>
In-Reply-To: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de>
References: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] alpha: Fix personality flag propagation across an exec
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jan 3, 2025, at 15:01, John Paul Adrian Glaubitz wrote:

> 
>  #define SET_PERSONALITY(EX)					\
> -	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
> -	   ? PER_LINUX_32BIT : PER_LINUX)
> +	set_personality((((EX).e_flags & EF_ALPHA_32BIT)	\
> +	   ? PER_LINUX_32BIT : PER_LINUX) | (current->personality & (~PER_MASK)))

This looks wrong to me: since ADDR_LIMIT_32BIT is not part of
PER_MASK, executing a regular binary from a taso binary no longer
reverts back to the entire 64-bit address space.

It seems that the behavior on most other architectures changed in 2012
commit 16f3e95b3209 ("cross-arch: don't corrupt personality flags upon
exec()").

At the time, the same bug existed on mips, parisc and tile, but those
got fixed quickly.

There are two related bits I don't quite understand:

- Do we still care about EF_ALPHA_32BIT? I see that it gets set by
 "alpha-linux-ld.bfd --taso", but could not find any documentation
 on what that flag is actually good for. On all other architectures,
 the address space limit gets enforced through a per-thread setting
 like TIF_32BIT, not through the personality that gets inherited
 by the child processes.

- all architectures other than x86 mask out the lower byte. Why
  not that one?

       Arnd
