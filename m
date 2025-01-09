Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66F8F510
	for <util-linux@vger.kernel.org>; Thu,  9 Jan 2025 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736383950; cv=none; b=NgPhlTyy3v77qMD5cdtMKMSc9fGKSEEHm3Iee+cLTohaLXkL+BMQ4tPk1z/BV2CYLdOupf7Y+b7MXS0ofDmEKdrpmfamjpLS6i0Bp1AMX9Xcg5HlOF4hDlKPC6ekYjy9dFJ1LYzzbaZU1M5w++DYrgDaks6ngYU1oqcoWjT04n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736383950; c=relaxed/simple;
	bh=BxvRJB7kjySWAVQUNTR7/neE+UYWVZQg4LdVr1lLl+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKvs8mopDrFVAph53n3TWNuKq6j8ifRFpDLzI0QfDpREajgv1dkhC4xjAnj+LS4hDLF6B/IRqZLJ2VQMaMcf1+p76KAlv5boJqCRRhsrpwDjw5FkvqrMnZFsIIImyXux09ITFdGzHIjpJ9EtsFMhHLHfmvzzcTguzwBnski9b3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HEoFmjp0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HEoFmjp0"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-71e29a0dfd6so43726a34.1
        for <util-linux@vger.kernel.org>; Wed, 08 Jan 2025 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736383948; x=1736988748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRpviP/9EPmDdLynizIbzE/pzoqQq3bn43NLlpJ8Pm0=;
        b=HEoFmjp09zxbghQjWm/Ii5zJg43P6GZvqZz/KEVtcF1kLaKSaXILEvCt9Aiys/56MZ
         6qc+DNF2b/ZfxkNSPD996ycSrQps3FpkDiBQlrmrRrMgWaFo4fp/O1uPAz7b8UD0UXQT
         xTFu0JT9I7kjbMAcybepp1vqua0n4E12/XcZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736383948; x=1736988748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRpviP/9EPmDdLynizIbzE/pzoqQq3bn43NLlpJ8Pm0=;
        b=xItOCpxoucyOZoEASmPDvh/ldzpQj1jteVqjkKnGJg9t0hbwzQrg2iMyId7SxyfjFs
         hnXCjPCW49LUT0SS5l/5CfFj9T+frjq8aMtCTfJMVZP0JxL+Juqx863SnZhW0Odg0Xp9
         C5EhfDxRTf+xnFCuq7A2ibaERh0LOe3o+DLt2hPXg1mXTNBC9nnJkqFljiBrEOC1ms4l
         jzh3UZe7RY4JtVmlgnHIdf6Zo8RuW0ek5fz73jfTMTjEgD+ohTWOm7i8jSHUaUWQFY1W
         mPrwrOdThz/Fukt1lyW9G/KnFT3hHbToTYrMurAv6uPXoAg/xpwhCJgWmDISeZxZMbSh
         lgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1/1wd5RurXijVAX+hPG/dsoxfYYzH3+mCCNBNTHqcUg5JszDfYbdx6+osHOPJ9fYlmbmGTe2YJufl@vger.kernel.org
X-Gm-Message-State: AOJu0YylmVD4OeYU0dHp5g46GM2X8PuDIma41IsmctE4WLZTLG/WOVGE
	9M8CB99Ib4Rd2Nj2BzHatVIaLDUtTtOf27Of/uAc36ZQtEse6r2+CtfYggecjPQ2juZpekf+PD3
	+njSPFw1vxY5WVIPmKbebMz+bgqC6Gqx5nj0a
X-Gm-Gg: ASbGncuLQY3xFmqbSprtlgxE7BHWS2n0UI5qotlyhGUVZ+tvc6WIOopywLFS3v08Ahn
	8QWWKly0a5UjljphW5l2FzGlC/8ULHm6runxvnhR1RRf0IqzAwXX+Ta3eSTrm9gxwl7s=
X-Google-Smtp-Source: AGHT+IF/r8GuAZJ5UF5KGd00VuKU3XVnKtoUciIyuz24H6sb0Yk5EDr8vGFhP6Oop4+wxNF7wPN8CGn3gVgdrtmDnr4=
X-Received: by 2002:a05:6870:4f0f:b0:29e:43da:f5da with SMTP id
 586e51a60fabf-2aa06975f9amr891798fac.9.1736383947719; Wed, 08 Jan 2025
 16:52:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103140148.370368-1-glaubitz@physik.fu-berlin.de> <202501081442.AB725C7D0@keescook>
In-Reply-To: <202501081442.AB725C7D0@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 8 Jan 2025 16:52:16 -0800
X-Gm-Features: AbW1kvaw4LahAK84nRdCDCyPzls5Ud4781ZovookCnr71OmvJWfmEf_oRypDNgA
Message-ID: <CABi2SkU9YDH6U7M3+A5gg=FrRm=hb6mcNna5xT9O_V9ayBBHyw@mail.gmail.com>
Subject: Re: [PATCH] alpha: Fix personality flag propagation across an exec
To: Kees Cook <kees@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, Eric Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-alpha@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, 
	Sam James <sam@gentoo.org>, "Maciej W . Rozycki" <macro@orcam.me.uk>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, Chris Hofstaedtler <zeha@debian.org>, 
	util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 2:49=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Fri, Jan 03, 2025 at 03:01:46PM +0100, John Paul Adrian Glaubitz wrote=
:
> > It was observed that on alpha, the misc/setarch test of
> > the util-linux testsuite failed with the following error:
> >
> >    misc: setarch                        ...
> >           : options                     ... OK
> >           : uname26                     ... OK
> >           : uname26-version             ... FAILED (misc/setarch-uname2=
6-version)
> >           : show                        ... OK
> >      ... FAILED (1 from 4 sub-tests)
> >
> > Running the setarch binary manually confirmed that setting
> > the kernel version with the help --uname-2.6 flag does not
> > work and the version remains unchanged.
> >
> > It turned out that on alpha, the personality flags are not
> > propagated but overridden during an exec. The same issue was
> > previously fixed on arm in commit 5e143436d044 ("ARM: 6878/1:
> > fix personality flag propagation across an exec") and on powerpc
> > in commit a91a03ee31a5 ("powerpc: Keep 3 high personality bytes
> > across exec"). This patch fixes the issue on alpha.
>
> Good catch!
>
> >
> > With the patch applied, the misc/setarch test succeeds on
> > alpha as expected:
> >
> >    misc: setarch                        ...
> >           : options                     ... OK
> >           : uname26                     ... OK
> >           : uname26-version             ... OK
> >           : show                        ... OK
> >      ... OK (all 4 sub-tests PASSED)
> >
> > However, as a side-effect, a warning is printed on the kernel
> > message buffer which might indicate another unreleated bug:
> >
> > [   39.964823] pid=3D509, couldn't seal address 0, ret=3D-12.
>
> This is from mseal vs MMAP_PAGE_ZERO in fs/binfmt_elf.c
>
>                 error =3D vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EX=
EC,
>                                 MAP_FIXED | MAP_PRIVATE, 0);
>
>                 retval =3D do_mseal(0, PAGE_SIZE, 0);
>                 if (retval)
>                         pr_warn_ratelimited("pid=3D%d, couldn't seal addr=
ess 0, ret=3D%d.\n",
>                                             task_pid_nr(current), retval)=
;
>
> -12 is ENOMEM, which implies, I think, that check_mm_seal() failed. I
> note that "error" isn't being checked, so if the vm_mmap() failed, I
> think the do_mseal() would fail with ENOMEM?
>
Yes. do_mseal would fail with NOMEM if the address was not found.

It is likely that alpha doesn't allow creating a page on zero address
? i.e.  MMAP_PAGE_ZERO personality never worked on alpha.

-Jeff

> > Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> -Kees
>
> > ---
> >  arch/alpha/include/asm/elf.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.=
h
> > index 4d7c46f50382..81f8473bb7c0 100644
> > --- a/arch/alpha/include/asm/elf.h
> > +++ b/arch/alpha/include/asm/elf.h
> > @@ -138,8 +138,8 @@ extern int dump_elf_task(elf_greg_t *dest, struct t=
ask_struct *task);
> >  })
> >
> >  #define SET_PERSONALITY(EX)                                  \
> > -     set_personality(((EX).e_flags & EF_ALPHA_32BIT)         \
> > -        ? PER_LINUX_32BIT : PER_LINUX)
> > +     set_personality((((EX).e_flags & EF_ALPHA_32BIT)        \
> > +        ? PER_LINUX_32BIT : PER_LINUX) | (current->personality & (~PER=
_MASK)))
> >
> >  extern int alpha_l1i_cacheshape;
> >  extern int alpha_l1d_cacheshape;
> > --
> > 2.39.5
> >
>
> --
> Kees Cook
>
