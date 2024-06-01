Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5373742A83
	for <util-linux@vger.kernel.org>; Sat,  1 Jun 2024 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717244643; cv=none; b=sIQa6Cn8opoV3m2SZz7lw9Kkm4HZuF5bMUr0zmaP9nmGD02L2wX4c3F4mhzfO6B1zJ4jsKdBk/LMlOs0z20VFIEM6JA5dDyOWRaKWZceUS6tsoy704SXQWocGNozIMTr+Eto5xjeOSz8Ud6f0avw6tM5P5Y3WfHlKNEiBDyeE3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717244643; c=relaxed/simple;
	bh=lgEqM9jkkkjm6B1ugLvsf9yCX4JHiAdmZr6mOpeyEgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmzkGEGSs76XQFZQnzBXT5OfdI5LPoRzv2w2J+X7YWDR/Cx3YeuZ2//sTzfvqKTbgON9oeKdF2XBt8Q0WJTic+2XK4rf2aDh+GoIBacm11SByer3KbWoqXnFtH2JzxlFjfkKNGtY6SzRSZ1YtfvFRq+KtwFoHZWlWN14eaXaopk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlIXggbU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlIXggbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DAAC116B1;
	Sat,  1 Jun 2024 12:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717244642;
	bh=lgEqM9jkkkjm6B1ugLvsf9yCX4JHiAdmZr6mOpeyEgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hlIXggbUesGz/ycZnUp/GKrCHQnfMNg2ILfVFGPJCDY64SiuS2YHt3TRq7gPK9Zdb
	 3rQUSDecMN6zGDJT4DRi+VPxSxxXnGxEoTkHeKW9lPYSeNWKRrFoJED6kgF5BceMiy
	 3A26b7E8reDfi23dk/Y6LzzkvrmLt6FHt4I0aFFhjC0qkNvJxmXWhxJUkgaS2sh7PP
	 2NUmz60j3Z98fWQxk/5A2r5qq2HLl82d6FCMSK/6tv983NYSL+xVQpYKA/XJvFNq9w
	 cGVa3zeszJvb+tNQmXThAduT6QWTEp219Lj5LHp0v15aXrJXICsMB2c5e8RTioadt8
	 LYTvQCvdNQysg==
Date: Sat, 1 Jun 2024 14:23:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	libc-alpha@sourceware.org
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5
 arguments, and avoid casts
Message-ID: <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="csog5lcudkpveduv"
Content-Disposition: inline
In-Reply-To: <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>


--csog5lcudkpveduv
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	libc-alpha@sourceware.org
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5
 arguments, and avoid casts
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
MIME-Version: 1.0
In-Reply-To: <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>

Hi Thomas,

On Sat, Jun 01, 2024 at 01:05:02PM GMT, Thomas Wei=C3=9Fschuh wrote:
> On 2024-06-01 11:31:56+0000, Alejandro Colomar wrote:
> > Since libc's prctl(2) wrapper is a variadic function, arguments must
> > have the right width.  Otherwise, the behavior is undefined.
>=20
> Ack.
>=20
> > Also, the 5 arguments must be specified always, or the behavior is also
> > undefined.  libc reads 5 values and passes them all to the kernel, so if
> > one is uninitialized, the kernel will receive garbagge, which could
> > result in EINVAL (most likely), or worse, a different action.
>=20
> This seems surprising.
>=20
> The kernel should only check the arguments it documents and not more.

Hmmm, some prctl(2) calls don't document a need for passing 0 (probably
for legacy compatibility; you're right.  Only newer prctl(2)s check
those args.

And see for example these kernel commit:

	commit e9d1b4f3c60997fe197bf0243cb4a41a44387a88
	Author: Dave Hansen <dave.hansen@linux.intel.com>
	Date:   Thu Jan 8 14:30:22 2015 -0800

	    x86, mpx: Strictly enforce empty prctl() args
	   =20
	    Description from Michael Kerrisk.  He suggested an identical patch
	    to one I had already coded up and tested.
	   =20
	    commit fe3d197f8431 "x86, mpx: On-demand kernel allocation of bounds
	    tables" added two new prctl() operations, PR_MPX_ENABLE_MANAGEMENT and
	    PR_MPX_DISABLE_MANAGEMENT.  However, no checks were included to ensure
	    that unused arguments are zero, as is done in many existing prctl()s
	    and as should be done for all new prctl()s. This patch adds the
	    required checks.
	   =20
	    Suggested-by: Andy Lutomirski <luto@amacapital.net>
	    Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
	    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
	    Cc: Dave Hansen <dave@sr71.net>
	    Link: http://lkml.kernel.org/r/20150108223022.7F56FD13@viggo.jf.intel.=
com
	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

	diff --git a/kernel/sys.c b/kernel/sys.c
	index a8c9f5a7dda6..ea9c88109894 100644
	--- a/kernel/sys.c
	+++ b/kernel/sys.c
	@@ -2210,9 +2210,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,
			up_write(&me->mm->mmap_sem);
			break;
		case PR_MPX_ENABLE_MANAGEMENT:
	+               if (arg2 || arg3 || arg4 || arg5)
	+                       return -EINVAL;
			error =3D MPX_ENABLE_MANAGEMENT(me);
			break;
		case PR_MPX_DISABLE_MANAGEMENT:
	+               if (arg2 || arg3 || arg4 || arg5)
	+                       return -EINVAL;
			error =3D MPX_DISABLE_MANAGEMENT(me);
			break;
		default:

And this one too:

	commit 3e91ec89f527b9870fe42dcbdb74fd389d123a95
	Author: Catalin Marinas <catalin.marinas@arm.com>
	Date:   Thu Aug 15 16:44:00 2019 +0100

	    arm64: Tighten the PR_{SET, GET}_TAGGED_ADDR_CTRL prctl() unused argum=
ents
	   =20
	    Require that arg{3,4,5} of the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl and
	    arg2 of the PR_GET_TAGGED_ADDR_CTRL prctl() are zero rather than ignor=
ed
	    for future extensions.
	   =20
	    Acked-by: Andrey Konovalov <andreyknvl@google.com>
	    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
	    Signed-off-by: Will Deacon <will@kernel.org>

	diff --git a/kernel/sys.c b/kernel/sys.c
	index c6c4d5358bd3..ec48396b4943 100644
	--- a/kernel/sys.c
	+++ b/kernel/sys.c
	@@ -2499,9 +2499,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, =
arg2, unsigned long, arg3,
			error =3D PAC_RESET_KEYS(me, arg2);
			break;
		case PR_SET_TAGGED_ADDR_CTRL:
	+               if (arg3 || arg4 || arg5)
	+                       return -EINVAL;
			error =3D SET_TAGGED_ADDR_CTRL(arg2);
			break;
		case PR_GET_TAGGED_ADDR_CTRL:
	+               if (arg2 || arg3 || arg4 || arg5)
	+                       return -EINVAL;
			error =3D GET_TAGGED_ADDR_CTRL();
			break;
		default:

In the few calls that util-linux makes without specifying all 5 args,
the kernel seems to not do the checks (in some old prctl(2)s they didn't
have that check, and nobody seems to have cared enough to add it), so
it's more like we're lucky (or unlucky, depending on how you see it).

> glibc itself doesn't even specify all five arguments in its own calls to
> prctl().

glibc itself is wrong.  I'm even surprised that the PR_* macros from the
kernel UAPI for arg2 work without specifying the L suffix on them, but
it's probably just luck.

<https://lore.kernel.org/linux-api/20240528114750.106187-1-alx@kernel.org/T=
/#u>

> If all five arguments are really required then prctl() wouldn't need to
> be variadic.

Indeed.  I guess that's for historic reasons, rather than actual
necessity; but I don't know for sure.

> How is random non-zero data less valid than a essentially random zero?
> And if the kernel actually validates this, how has it ever worked before?

They only added validation for (all) new prctl(2) calls, plus maybe some
old ones, but not all.  In the ones used in util-linux that don't
specify zero, I've checked now that the kernel doesn't validate.

However, a call such as

	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)

(this call exists in util-linux)
actually means

	prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, random, random)

and it supposedly has been working so far.  Those random bits are
probably 0 most of the time, for some reason.  And the kernel does check
this one:

	$ sed -n /PR_SET_NO_NEW_PRIVS/,+2p <kernel/sys.c
		case PR_SET_NO_NEW_PRIVS:
			if (arg2 !=3D 1 || arg3 || arg4 || arg5)
				return -EINVAL;

> Other popular software like systemd or opendjk also don't specify unused =
arguments.

I've also checked that the ones that systemd uses without specifying all
5 args, they are not checked by the kernel.

> So it doesn't really seem "broken".
> If the patch is more about "being on the safe side", then this should be
> spelled out.

Still, libc reads those values (on x32) which results in Undefined
Behavior inside glibc.  Which is a bad thing.  Not broken, because the
compiler has little information to exploit that UB, but not a good thing
either.

	$ grepc __prctl .
	./include/sys/prctl.h:extern int __prctl (int __option, ...);
	./sysdeps/unix/sysv/linux/x86_64/x32/prctl.c:int
	__prctl (int option, ...)
	{
	  va_list arg;
	  va_start (arg, option);
	  unsigned long int arg2 =3D va_arg (arg, unsigned long int);
	  unsigned long int arg3 =3D va_arg (arg, unsigned long int);
	  unsigned long int arg4 =3D va_arg (arg, unsigned long int);
	  unsigned long int arg5 =3D va_arg (arg, unsigned long int);
	  va_end (arg);
	  return INLINE_SYSCALL_CALL (prctl, option, arg2, arg3, arg4, arg5);
	}

It's arguably less broken than the missing 'L', though.

> (Plus the cases where documented, required arguments are missing)

None of the cases where we omit the arguments are checked by the kernel.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--csog5lcudkpveduv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZbEtkACgkQnowa+77/
2zLaoxAAp6KQF+2vGiJGD1v425YkBP0x298xd5/9ElG1zmff7B2lN45onlzqXc5m
AbGiCAxrQc1C0T+QwDkv0k0u3N0OpzMr/SjmmvE20fqrynQEy34k8hnUFp81dTAS
njway6lmIcSq6xn64+16YbuacpOLwLpMLhjve+Hm38uDGZEnKVzSDKX4/I1EdM53
aythhH8zNIRM44bcL8kNKPKewfNAHDIL80aoBQqe8ktwStLnNImkv5sSougHOXSQ
g+IRN71W3fCeV0VKplxz/okHk5+y1WKeeckGFfatgPMCZgTk9siRRS5sLxLaDIoN
EKqn19rhCgKnwshPPEpuM6XpUeP3P4yhFqivu+cFaTQqRLwZ9W89Eei5XJb+/uPB
T5AYQUDBq9ZgxSfkGZBOjcQkZgBDy0aYL/Qi3hLdwxgRGHUyYgqobV35PZUzYwNR
QK4C0SA0fq246EQGQUyhfHXTiRjbTYQlwdeBiINE/b5hOrqABNSHh5fIalV1uO0W
fVXVkNcUAxNi5zBUPKxD881q11gpvWlZfPAJg8zs1Y+dROz4+HD0tIxLyY+4LvYr
Jwnxl8WkX9yaq2QNUJGToAYRctm3KufYdsUqNjZ90O2ZTtCnbiygsBbz4A384SEJ
MUvLvuWPn5kCH18Mh8M6yaSMlkrEzSSf14OEB4ESVB5berH32a0=
=1w6u
-----END PGP SIGNATURE-----

--csog5lcudkpveduv--
