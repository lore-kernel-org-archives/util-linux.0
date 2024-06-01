Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A42582
	for <util-linux@vger.kernel.org>; Sat,  1 Jun 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717270337; cv=none; b=l1qack2sDG4L59Ax/ggNgNiYqsntDQXp1jbhpGvrfacYM8fMDkVZ6sHHiBZaQmkw9u+f3oETwoYLN3haKCPH/p0tBltWNZHBCn16cuPk+eL7gAMgM+p5KNL1jM/mhCv9EvS99GYD8UjbMzd7C4JMQeewFeiNCvILOPmImAfV+F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717270337; c=relaxed/simple;
	bh=luUxVaUCC7bIBfM66SZ8XRltV/H5p9t0RpB80RBouQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgdIt+NBW9s5jB+Y36EsyEuwEOiWs3aZUnNQFRxMK/lHJO42wPya3AK1ToAMuRlian4vDBDuroAyISE29MHHK/HK1n+UHzi5AQS41/Vfdka+rVxoQs22Zrd0kV9VxxSB0MR++5t38wzlcl5nWQ17O/bGxJO+h2TrrKnMgngz4Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex9LRg9X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex9LRg9X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150CFC116B1;
	Sat,  1 Jun 2024 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717270337;
	bh=luUxVaUCC7bIBfM66SZ8XRltV/H5p9t0RpB80RBouQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex9LRg9XPQjIVaHlGzICh9+tFye61n6X5eFYxdrKRwCJJ9FQqvbURpmkbpyoW/Nco
	 kRM1aGm8kTjwdU7eR+XpA0QYEq5BEvmzhY2ji2VBGuhHj16xyoVbENd3l+uI1Hou3b
	 gzw0eq5sc4aUcIJYk0ogO5w+LHJAgZBmp8cp0GjkOXS3j9TASyk5JixY9rkqP0iaCI
	 RrFgLmI01IhgF6yZV1qdbLAB/kXghp1CrKsZSx/n8hGB2RVWnsZmqirjQNIte8o2mX
	 I0FaH7mMshM18v9VO/nPdjly06/GjVaxqPYE73zk/WgRbds+Tyqn+12Y9vhYghFtcb
	 dR2xWYJ7MGteQ==
Date: Sat, 1 Jun 2024 21:32:13 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Xi Ruoyao <xry111@xry111.site>, 
	libc-alpha@sourceware.org
Subject: Re: [PATCH v1] Call prctl(2) with long integers, specify 5
 arguments, and avoid casts
Message-ID: <3m7c3aemzupjkfbrcijcxm6zroizsyi4sil3mgtcq2sswbmv7y@zjebioivhzfz>
References: <20240601093150.16912-1-alx@kernel.org>
 <460edfcb-4dc0-418c-9f4d-eb74261701c8@t-8ch.de>
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mgpqebrufcca2qwh"
Content-Disposition: inline
In-Reply-To: <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>


--mgpqebrufcca2qwh
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
 <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>
MIME-Version: 1.0
In-Reply-To: <mbvtkssza7bvvu45wqivbfd2astvpsu3t7u223a222oizrqznm@rv4rxvvkxzct>

On Sat, Jun 01, 2024 at 02:24:03PM GMT, Alejandro Colomar wrote:
> Hi Thomas,
>=20
> On Sat, Jun 01, 2024 at 01:05:02PM GMT, Thomas Wei=C3=9Fschuh wrote:
> > On 2024-06-01 11:31:56+0000, Alejandro Colomar wrote:
> > > Since libc's prctl(2) wrapper is a variadic function, arguments must
> > > have the right width.  Otherwise, the behavior is undefined.
> >=20
> > Ack.
> >=20
> > > Also, the 5 arguments must be specified always, or the behavior is al=
so
> > > undefined.  libc reads 5 values and passes them all to the kernel, so=
 if
> > > one is uninitialized, the kernel will receive garbagge, which could
> > > result in EINVAL (most likely), or worse, a different action.
> >=20
> > This seems surprising.
> >=20
> > The kernel should only check the arguments it documents and not more.
>=20
> Hmmm, some prctl(2) calls don't document a need for passing 0 (probably
> for legacy compatibility; you're right.  Only newer prctl(2)s check
> those args.
>=20
> And see for example these kernel commit:
>=20
> 	commit e9d1b4f3c60997fe197bf0243cb4a41a44387a88
> 	Author: Dave Hansen <dave.hansen@linux.intel.com>
> 	Date:   Thu Jan 8 14:30:22 2015 -0800
>=20
> 	    x86, mpx: Strictly enforce empty prctl() args
> 	   =20
> 	    Description from Michael Kerrisk.  He suggested an identical patch
> 	    to one I had already coded up and tested.
> 	   =20
> 	    commit fe3d197f8431 "x86, mpx: On-demand kernel allocation of bounds
> 	    tables" added two new prctl() operations, PR_MPX_ENABLE_MANAGEMENT a=
nd
> 	    PR_MPX_DISABLE_MANAGEMENT.  However, no checks were included to ensu=
re
> 	    that unused arguments are zero, as is done in many existing prctl()s
> 	    and as should be done for all new prctl()s. This patch adds the
> 	    required checks.
> 	   =20
> 	    Suggested-by: Andy Lutomirski <luto@amacapital.net>
> 	    Suggested-by: Michael Kerrisk <mtk.manpages@gmail.com>
> 	    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> 	    Cc: Dave Hansen <dave@sr71.net>
> 	    Link: http://lkml.kernel.org/r/20150108223022.7F56FD13@viggo.jf.inte=
l.com
> 	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>=20
> 	diff --git a/kernel/sys.c b/kernel/sys.c
> 	index a8c9f5a7dda6..ea9c88109894 100644
> 	--- a/kernel/sys.c
> 	+++ b/kernel/sys.c
> 	@@ -2210,9 +2210,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
> 			up_write(&me->mm->mmap_sem);
> 			break;
> 		case PR_MPX_ENABLE_MANAGEMENT:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error =3D MPX_ENABLE_MANAGEMENT(me);
> 			break;
> 		case PR_MPX_DISABLE_MANAGEMENT:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error =3D MPX_DISABLE_MANAGEMENT(me);
> 			break;
> 		default:
>=20
> And this one too:
>=20
> 	commit 3e91ec89f527b9870fe42dcbdb74fd389d123a95
> 	Author: Catalin Marinas <catalin.marinas@arm.com>
> 	Date:   Thu Aug 15 16:44:00 2019 +0100
>=20
> 	    arm64: Tighten the PR_{SET, GET}_TAGGED_ADDR_CTRL prctl() unused arg=
uments
> 	   =20
> 	    Require that arg{3,4,5} of the PR_{SET,GET}_TAGGED_ADDR_CTRL prctl a=
nd
> 	    arg2 of the PR_GET_TAGGED_ADDR_CTRL prctl() are zero rather than ign=
ored
> 	    for future extensions.
> 	   =20
> 	    Acked-by: Andrey Konovalov <andreyknvl@google.com>
> 	    Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> 	    Signed-off-by: Will Deacon <will@kernel.org>
>=20
> 	diff --git a/kernel/sys.c b/kernel/sys.c
> 	index c6c4d5358bd3..ec48396b4943 100644
> 	--- a/kernel/sys.c
> 	+++ b/kernel/sys.c
> 	@@ -2499,9 +2499,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long=
, arg2, unsigned long, arg3,
> 			error =3D PAC_RESET_KEYS(me, arg2);
> 			break;
> 		case PR_SET_TAGGED_ADDR_CTRL:
> 	+               if (arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error =3D SET_TAGGED_ADDR_CTRL(arg2);
> 			break;
> 		case PR_GET_TAGGED_ADDR_CTRL:
> 	+               if (arg2 || arg3 || arg4 || arg5)
> 	+                       return -EINVAL;
> 			error =3D GET_TAGGED_ADDR_CTRL();
> 			break;
> 		default:
>=20
> In the few calls that util-linux makes without specifying all 5 args,
> the kernel seems to not do the checks (in some old prctl(2)s they didn't
> have that check, and nobody seems to have cared enough to add it), so
> it's more like we're lucky (or unlucky, depending on how you see it).
>=20
> > glibc itself doesn't even specify all five arguments in its own calls to
> > prctl().
>=20
> glibc itself is wrong.  I'm even surprised that the PR_* macros from the
> kernel UAPI for arg2 work without specifying the L suffix on them, but
> it's probably just luck.
>=20
> <https://lore.kernel.org/linux-api/20240528114750.106187-1-alx@kernel.org=
/T/#u>
>=20
> > If all five arguments are really required then prctl() wouldn't need to
> > be variadic.
>=20
> Indeed.  I guess that's for historic reasons, rather than actual
> necessity; but I don't know for sure.
>=20
> > How is random non-zero data less valid than a essentially random zero?
> > And if the kernel actually validates this, how has it ever worked befor=
e?
>=20
> They only added validation for (all) new prctl(2) calls, plus maybe some
> old ones, but not all.  In the ones used in util-linux that don't
> specify zero, I've checked now that the kernel doesn't validate.
>=20
> However, a call such as
>=20
> 	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)
>=20
> (this call exists in util-linux)
> actually means
>=20
> 	prctl(PR_SET_NO_NEW_PRIVS, 1L, 0L, random, random)
>=20
> and it supposedly has been working so far.  Those random bits are
> probably 0 most of the time, for some reason.  And the kernel does check
> this one:
>=20
> 	$ sed -n /PR_SET_NO_NEW_PRIVS/,+2p <kernel/sys.c
> 		case PR_SET_NO_NEW_PRIVS:
> 			if (arg2 !=3D 1 || arg3 || arg4 || arg5)
> 				return -EINVAL;
>=20
> > Other popular software like systemd or opendjk also don't specify unuse=
d arguments.
>=20
> I've also checked that the ones that systemd uses without specifying all
> 5 args, they are not checked by the kernel.
>=20
> > So it doesn't really seem "broken".
> > If the patch is more about "being on the safe side", then this should be
> > spelled out.
>=20
> Still, libc reads those values (on x32) which results in Undefined
> Behavior inside glibc.  Which is a bad thing.  Not broken, because the
> compiler has little information to exploit that UB, but not a good thing
> either.
>=20
> 	$ grepc __prctl .
> 	./include/sys/prctl.h:extern int __prctl (int __option, ...);
> 	./sysdeps/unix/sysv/linux/x86_64/x32/prctl.c:int
> 	__prctl (int option, ...)
> 	{
> 	  va_list arg;
> 	  va_start (arg, option);
> 	  unsigned long int arg2 =3D va_arg (arg, unsigned long int);
> 	  unsigned long int arg3 =3D va_arg (arg, unsigned long int);
> 	  unsigned long int arg4 =3D va_arg (arg, unsigned long int);
> 	  unsigned long int arg5 =3D va_arg (arg, unsigned long int);
> 	  va_end (arg);
> 	  return INLINE_SYSCALL_CALL (prctl, option, arg2, arg3, arg4, arg5);
> 	}

Or one could say this is not a user problem, and just an implementation
detail of libc.  For those calls that the kernel ignores the argument,
omitting the argument sounds reasonable as a user.  I guess the kernel
won't expand those APIs, since that would be dangerous (for this precise
reason).

>=20
> It's arguably less broken than the missing 'L', though.
>=20
> > (Plus the cases where documented, required arguments are missing)
>=20
> None of the cases where we omit the arguments are checked by the kernel.

--=20
<https://www.alejandro-colomar.es/>

--mgpqebrufcca2qwh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZbdz0ACgkQnowa+77/
2zKSXxAAgfsQ7Za0ofWGN5V1gXIDqajsOjFxuGIW4A1HVN8UKf+tLkCOzoDTq5z5
uYOsJieml9LB+X8VTg9wi1+s5nqLXPpWNllA2xl6/MN8oA4I0Yd63G4RGZbtomO9
BbN23GmxQrtG2PlnEgDuYy1qZSnxGFEkJpdhulzlzl7P6LFJjuLPmnDQYrXdE7Y2
KAhO77x2E5aELzejfUZiqMXvcymLsr5BFt07II0aOnyHrdcpereJQZwv+pNcuK52
3R/xT5dA3xYd404kRc2moXLngaJP+PMBeeq4uYanXu3/RN/UlqNx1gtLNReOWhRY
WDgMe5w6LQysWHTKxP1kQa5r0EwolILiHgwDhfUKIj2/o9/C2gYg1IM1bwlqpkk0
t68sVzmJyv8sTxl14TzXmpZ1VZ4zXbLbu4EH/W93kdEjv4nE2kEwuR6CgTLoRCHQ
C/nSe9TLYfridLLkzcBMVC7GZ+l+xmjy7UXm9klBfnym/TB8WUS6RxCwavV3gPHR
aILKBTTNIoQdumHx38nfWjfGJUqnUP1lA0OFjg9ed4be6lSVdoMPAZWBDg2oIOsE
AxjxBVj8QRg3CyOGGc4NWIU+7eYohDsEfM4cG90dsbcpfopqyr+RFWHFeJgV3kAc
LRrTzLT6T58IZgs1/lWEJH5GEJVpOvJB1tSu2jNICIPx4RJZbLw=
=GZoN
-----END PGP SIGNATURE-----

--mgpqebrufcca2qwh--
