Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0898475
	for <util-linux@vger.kernel.org>; Sat,  1 Jun 2024 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717239907; cv=none; b=KyJSU93gt1JYiGAcKHIq4wqGtAHvmqwLybjLCMr6hudgka27aXLSaDvQ7WKFPJvQcWYQrkgVAsCROnytr2rPk5MRpxVtugcF3vs3XSNzgRKvsnqWUV00XcexwkI4/8Yh9vzVh18thzw4hpjt5uQ4kqWmwcoiFsEQkPSgKTDybuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717239907; c=relaxed/simple;
	bh=3bTDO+oKQjsKOV0UPlGJmg6tuWITwz9m/9hEdC+UCsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUWUSsFzGNwfa6Xy3ySaeqs9UqX5ww5PiYhDOIZMgU27xh9Hd1G4OW1kQRLh0C3KfhGIQYs1QM9Rsn4EpOzXmeNEAwhziSkmhczTZZEpkPev8hyK0bgillGDRyhctWnBvWZ4YQhmLYFogNWE2ms3C8+bUCZrbgFGCB4mX589XXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=WATxR19x; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="WATxR19x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1717239902; bh=3bTDO+oKQjsKOV0UPlGJmg6tuWITwz9m/9hEdC+UCsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WATxR19x70kEz2biKp3ekuaxlbPsMoq4BatUOwc835dTnWRZGbcR6E5HJkHpHMD3X
	 NG/AC93tdQXlNQ5uEIt8gTXGXygz0W03DMQfXuutzUMiVuTybkgOmATd6IEOcnkOnG
	 XlCI4Fo3id1I0KVj0HoD2qWehobr1sV99qP0j1oU=
Date: Sat, 1 Jun 2024 13:05:02 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Alejandro Colomar <alx@kernel.org>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5
 arguments, and avoid casts
Message-ID: <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
References: <20240601093150.16912-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601093150.16912-1-alx@kernel.org>

On 2024-06-01 11:31:56+0000, Alejandro Colomar wrote:
> Since libc's prctl(2) wrapper is a variadic function, arguments must
> have the right width.  Otherwise, the behavior is undefined.

Ack.

> Also, the 5 arguments must be specified always, or the behavior is also
> undefined.  libc reads 5 values and passes them all to the kernel, so if
> one is uninitialized, the kernel will receive garbagge, which could
> result in EINVAL (most likely), or worse, a different action.

This seems surprising.

The kernel should only check the arguments it documents and not more.
glibc itself doesn't even specify all five arguments in its own calls to
prctl().

If all five arguments are really required then prctl() wouldn't need to
be variadic.

How is random non-zero data less valid than a essentially random zero?
And if the kernel actually validates this, how has it ever worked before?

Other popular software like systemd or opendjk also don't specify unused arguments.

So it doesn't really seem "broken".
If the patch is more about "being on the safe side", then this should be
spelled out.
(Plus the cases where documented, required arguments are missing)

> Also, avoid some casts to unsigned long, by changing the type of the
> parameter to some local wrappers.
> 
> And use consistently 0L.  0UL is basically the same, and uses one more
> character.  Keep it short.
> 
> Link: <https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/commit/?id=6698b096a6f5342cb9b338c237ed875a8635497a>
> Link: <https://lore.kernel.org/linux-man/ddbdyaiptesjalgfmztxideej67e3yaob7ucsmbf6qvriwxiif@dohhxrqgwhrf/T/#med306b5b003f9cc7cc2de69fcdd7ee2d056d0954>
> Cc: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> Range-diff against v0:
> -:  --------- > 1:  afd73139e Call prctl(2) with long integers, specify 5 arguments, and avoid casts
> 
>  include/seccomp.h            |  2 +-
>  lib/caputils.c               |  4 ++--
>  lib/env.c                    |  4 ++--
>  misc-utils/enosys.c          |  4 ++--
>  schedutils/coresched.c       |  6 +++---
>  sys-utils/setpriv-landlock.c |  2 +-
>  sys-utils/setpriv.c          | 34 ++++++++++++++++------------------
>  tests/helpers/test_mkfds.c   |  2 +-
>  8 files changed, 28 insertions(+), 30 deletions(-)

<snip>
