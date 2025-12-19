Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B6246B5
	for <util-linux@vger.kernel.org>; Fri, 19 Dec 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766144444; cv=none; b=iMj8n/BoheHIjDrSTu/vLq8zdm6G9OyWcvBuwv1oA8X7akLfxjlO+u86g5vQ/pRaVMpnKtPcIkwxvhO4RKo+bWbCxT0uSbrZRHCSgxneksgkjT2iqwXyVhW4IwTyIYkyGOtVDtmVQ7Td2+pf2YLUqpb3DdVJIQD5ZtcAgqkPEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766144444; c=relaxed/simple;
	bh=cdLzz1ZclBphn2Nc8XoJYJH6RcoShdio9jFpOQA23T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddFgetrl0ng6utLF129F8AVG+EEqmXYYzPu4TtzpIkDN05rEsHg9gr1K8TuzGBsKSHSyCP7ieVas29arDDrRxQA/YxYCvXtb7+MPKYHqke+ugn8wTqPrFukV86nRGtkEUW79BgLlozQWTC0hwniqHyZ6diOJOdX3aIvi9D0+zhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=dPdZn5R2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="dPdZn5R2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1766144435; bh=cdLzz1ZclBphn2Nc8XoJYJH6RcoShdio9jFpOQA23T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPdZn5R27zxS0ph0lTeceDugYa8so2lix0T+knubF1CK3Txbuh2Um7r6EOKZmwU6h
	 XI6yrOm/E4K5wLQ/1e1l02IsAkz+6BisOK/F2aeL8UvM6euNoe76lXoBcj/XID+fOq
	 wgh6eq/XXPW87aqKaVSrv9cdnO2+eclXYrn7LxCo=
Date: Fri, 19 Dec 2025 12:40:34 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Kiran Rangoon <kiranrangoon0@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH v3 1/2] libuuid: Refactor UUID time conversion for
 pre-epoch dates
Message-ID: <9c4332f5-7aad-4804-b8f5-783e06572533@t-8ch.de>
References: <9dc90e33-30e2-48c3-8602-00fce280f9ef@t-8ch.de>
 <20251218213121.4961-1-kiranrangoon0@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218213121.4961-1-kiranrangoon0@gmail.com>

Hi Kiran,

On 2025-12-18 16:31:21-0500, Kiran Rangoon wrote:
> I revised the code in response to your feedback.

Thanks!

> > Looking at this more closely: __uuid_time() is directly exposed to users
> > of libuuid as uuid_time(). This means that any change of the function's
> > contract would break all external users and should be avoided at all
> > costs. 
> 
> Reversed the change there.

Your new revision is based on top of your old series.
Instead it should always be based on upstream code.
In this case the util-linux master branch.

> > Fortunately it turns out that the timestamps embedded in UUIDs
> > only use 60 bits. This means that the calculation can be performed in an
> > int64_t without any risk of over- or underflow. Please try to implement
> > it that way instead. 
> 
> I'm using signed int64_t here as suggested.
> 
> > It might be useful to change the signature of gregorian_to_unix() to
> > "static void gregorian_to_unix(uint64_t ts, struct timeval *tv)".
> 
> I revised the code to use a struct timeval now. 

That looks good. However that refactoring should be in its own commit.
More on that below.

> > Also please perform each logical step in a dedicated commit.
> 
> I made two commits, one for the code change and the other for tests, but
> if there is a way you would perfer me to do it I could change it.

The test is a bad candidate to split out. After each commit the
repository needs to be in a consistent state, which means that the code
builds and the tests pass. As the code change breaks the existing test,
the test needs to be adapted in lockstep.

I see the following commits:

1) Switch to the simpler constant definition
2) Pass 'struct timeval' to gregorian_to_unix()
3) Fix the overflow, adapt the existing test
4) Add a hand full of additional testcases.

Also this patch now lost its useful commit message which got replaced by
our discussion. This should not happen. Each commit should explain why
it is being done.

> ---
>  libuuid/src/uuid_time.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
> index f0d2c8f36..293fc7e68 100644
> --- a/libuuid/src/uuid_time.c
> +++ b/libuuid/src/uuid_time.c
> @@ -60,34 +60,29 @@
>  /* prototype to make compiler happy */
>  time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
>  
> -static int64_t gregorian_to_unix(uint64_t ts)
> +static void gregorian_to_unix(uint64_t ts, struct timeval *tv)
>  {
> -    const uint64_t offset = 0x01B21DD213814000ULL;
> +	const uint64_t offset = 0x01B21DD213814000ULL;
> +	int64_t t = (int64_t) ts - (int64_t) offset;

Whitespace corruption?

> -    if (ts < offset) {
> -        errno = EOVERFLOW;
> -        return -1;
> -    }
> -
> -    return ts - offset;
> +	tv->tv_sec = t / 10000000;
> +	tv->tv_usec = (t % 10000000) / 10;
>  }

(...)


Thomas
