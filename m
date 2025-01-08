Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312119EEBF;
	Wed,  8 Jan 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376560; cv=none; b=p3zCCg81q0nAWvFNBI1+Nfjw+oE6d1HdKh43hfchpAW+uS3dB6oLpjeBCG9d5mvNLIszKCFTs4z43Mzk9JdaFWqXPFk/XTLo7WvWgmxHwVXFF/Ld1usUb2aapyCrB7Prn7p6ZHmc2NymEUFTav9rXqYKp/cyraJchA+58brm7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376560; c=relaxed/simple;
	bh=JtlegMtrYXynM9nQlMgM7w4yvF7zQXRu3KOrxEAb3eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC2Si/49lEWrJPHPLGLaGHIAMaV1Ph0W28eSUdUsTU8txabNAJlo/k2iY0IGl7BqhVBg+jhiz5y0Eg1rQzSKGclQEM4uGglMnJpUZhUmju1TtkzQtPAq9s/6KxG2PYuUREDuTcJbzItzt+1JXoUh2NSjagsz818paLTlYgmYydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTBAJcaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTBAJcaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD61C4CED3;
	Wed,  8 Jan 2025 22:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736376557;
	bh=JtlegMtrYXynM9nQlMgM7w4yvF7zQXRu3KOrxEAb3eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTBAJcaOVwI0YXSwLMBA3XjmeqBXseFwWMGSBik1I7JsENkWmYaNIlAgCtM5RaQjJ
	 4w/Oe9VbBTNjVXSnyJre2QH4Z7JRHWGjYWhfT0RF7yZoVl869J7RK0ekhtP+tkd96I
	 JvhhMgiJT2IO1MfOHRg8LEgzXhbBGYsNF7QjgMjKd2v5YWL1EjdfwjSgqtjZgMyCgs
	 gAa5DTaFAcDAvi/ZtiYj2KjUkTei3wxtBtPoBASwmJ2VKj8Mq3gFuIAKZNOo8FVwfK
	 RRrLg4Sfoz1W1Hf+3KWHjNzqXVBB8CWhnFmc0b27HQYJPxYj+KTY1KPwcU/LH1DsnG
	 37ufhMPGbU5Iw==
Date: Wed, 8 Jan 2025 14:49:14 -0800
From: Kees Cook <kees@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>, Jeff Xu <jeffxu@google.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-alpha@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Sam James <sam@gentoo.org>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Chris Hofstaedtler <zeha@debian.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] alpha: Fix personality flag propagation across an exec
Message-ID: <202501081442.AB725C7D0@keescook>
References: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de>

On Fri, Jan 03, 2025 at 03:01:46PM +0100, John Paul Adrian Glaubitz wrote:
> It was observed that on alpha, the misc/setarch test of
> the util-linux testsuite failed with the following error:
> 
>    misc: setarch                        ...
>           : options                     ... OK
>           : uname26                     ... OK
>           : uname26-version             ... FAILED (misc/setarch-uname26-version)
>           : show                        ... OK
>      ... FAILED (1 from 4 sub-tests)
> 
> Running the setarch binary manually confirmed that setting
> the kernel version with the help --uname-2.6 flag does not
> work and the version remains unchanged.
> 
> It turned out that on alpha, the personality flags are not
> propagated but overridden during an exec. The same issue was
> previously fixed on arm in commit 5e143436d044 ("ARM: 6878/1:
> fix personality flag propagation across an exec") and on powerpc
> in commit a91a03ee31a5 ("powerpc: Keep 3 high personality bytes
> across exec"). This patch fixes the issue on alpha.

Good catch!

> 
> With the patch applied, the misc/setarch test succeeds on
> alpha as expected:
> 
>    misc: setarch                        ...
>           : options                     ... OK
>           : uname26                     ... OK
>           : uname26-version             ... OK
>           : show                        ... OK
>      ... OK (all 4 sub-tests PASSED)
> 
> However, as a side-effect, a warning is printed on the kernel
> message buffer which might indicate another unreleated bug:
> 
> [   39.964823] pid=509, couldn't seal address 0, ret=-12.

This is from mseal vs MMAP_PAGE_ZERO in fs/binfmt_elf.c

                error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
                                MAP_FIXED | MAP_PRIVATE, 0);

                retval = do_mseal(0, PAGE_SIZE, 0);
                if (retval)
                        pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
                                            task_pid_nr(current), retval);

-12 is ENOMEM, which implies, I think, that check_mm_seal() failed. I
note that "error" isn't being checked, so if the vm_mmap() failed, I
think the do_mseal() would fail with ENOMEM?

> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

> ---
>  arch/alpha/include/asm/elf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
> index 4d7c46f50382..81f8473bb7c0 100644
> --- a/arch/alpha/include/asm/elf.h
> +++ b/arch/alpha/include/asm/elf.h
> @@ -138,8 +138,8 @@ extern int dump_elf_task(elf_greg_t *dest, struct task_struct *task);
>  })
>  
>  #define SET_PERSONALITY(EX)					\
> -	set_personality(((EX).e_flags & EF_ALPHA_32BIT)		\
> -	   ? PER_LINUX_32BIT : PER_LINUX)
> +	set_personality((((EX).e_flags & EF_ALPHA_32BIT)	\
> +	   ? PER_LINUX_32BIT : PER_LINUX) | (current->personality & (~PER_MASK)))
>  
>  extern int alpha_l1i_cacheshape;
>  extern int alpha_l1d_cacheshape;
> -- 
> 2.39.5
> 

-- 
Kees Cook
