Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAC57E777
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654070; cv=none; b=oJ0RGJqTYWiKh6gE9XkwymLL0IO35frGiHrA7UyrchlRJcNYxT/koYnGfPQ24IdP3vCS5OuboIHn3S1gfBRIm7L+Tbb61ZIF43KSCBOA+I4iLCjIqcAqC0v2crWXsmJa8wMVtF0iTNDntOhu7LC01M/hBv9ZerpFzYCmznevhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654070; c=relaxed/simple;
	bh=BeqSL4TKWIK5e+ABXQT1/Ey8kZv0nEWRl+0Oyv2+iAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9de84rhIQtiWMhVybAdTuJ8O6bTlUCj9cv9Xiyjmun1hI4Mw7Fa1PQ8HJGhZQuigwGFe2Bg0yuCJo7uFmcWnvx109XfrCIkjQ9Eu7YYJURi7egAX/JmbKmBZ8ypVCOZMFZyaIsX5hIFGHfCzzqrAXh9xohoY0T73jlR+YUrd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=EjgKxVmB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="EjgKxVmB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1712654065; bh=BeqSL4TKWIK5e+ABXQT1/Ey8kZv0nEWRl+0Oyv2+iAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EjgKxVmBuQxPYu3kmlUvk1mA38vqs8O77PupP3hhNX7IlGeY40UnAND9jDory/MI5
	 Is2KhXdacRlgkyBbjjdOV6hEUtDq6Kf7tI2dfwIE3yjrJwxwqw+saaP/5MP8aBatBc
	 HmeDFrsMGImdXgangggIidD1/9VI/ZGk20CSkCVU=
Date: Tue, 9 Apr 2024 11:14:24 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] audit-arch.h: add defines for m68k, sh
Message-ID: <c55188bc-8f95-476a-a8f0-91ec4d97784f@t-8ch.de>
References: <20240409083459.346888-1-zeha@debian.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409083459.346888-1-zeha@debian.org>

On 2024-04-09 10:34:59+0200, Chris Hofstaedtler wrote:
> John Paul Adrian Glaubitz points out that libseccomp needs to release 2.6.0,
> too.

For the record: util-linux does not use libseccomp.

> Signed-off-by: Chris Hofstaedtler <zeha@debian.org>

Reviewed-by: Thomas Weißschuh <thomas@t-8ch.de>

> ---
>  include/audit-arch.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/audit-arch.h b/include/audit-arch.h
> index ade182417..9afc663cd 100644
> --- a/include/audit-arch.h
> +++ b/include/audit-arch.h
> @@ -35,6 +35,8 @@
>  #    endif
>  #elif __powerpc__
>  #    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PPC
> +#elif __m68k__
> +#    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_M68K
>  #elif __mips__
>  #    if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_MIPS
> @@ -47,6 +49,12 @@
>  #    else
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_ARCV2
>  #    endif
> +#elif __sh__
> +#    if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SH
> +#    else
> +# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SHEL
> +#    endif
>  #elif __sparc__
>  #    if __SIZEOF_POINTER__ == 4
>  # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SPARC
> -- 
> 2.39.2
> 
> 
