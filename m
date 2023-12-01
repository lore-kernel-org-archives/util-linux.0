Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="I/UORJgF"
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD212A
	for <util-linux@vger.kernel.org>; Fri,  1 Dec 2023 00:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1701420615; bh=q79QbmG/hJjHz1+s1GaIIurz+RvXPp9v1y65uksV97g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/UORJgFVj83wEN8NSxYxjZb3e+bd4S6E+9QR1WCHgS0qCZM6yEczLpN3k5Clpc+0
	 hfbVwPpQ7JOVFSGG8nuSv+j4xO3oIx74sC7agfLAeGC2iFJmkwnG1D9kvpS5DGU713
	 LWxJZjd5NKYZBYg7JrhjvM0tKdty8mICR1f2e1m8=
Date: Fri, 1 Dec 2023 09:50:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: util-linux <util-linux@vger.kernel.org>, 
	Michael Cree <mcree@orcon.net.nz>, Sam James <sam@gentoo.org>
Subject: Re: util-linux fails to build on alpha due to test_enosys
Message-ID: <18771e2f-ff82-4c76-a9f6-193ee6faa605@t-8ch.de>
References: <9211accf8670f28778166a1acdc186e8dd28f2e8.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9211accf8670f28778166a1acdc186e8dd28f2e8.camel@physik.fu-berlin.de>

Hi Adrian,

thanks for the report!

On 2023-12-01 09:17:20+0100, John Paul Adrian Glaubitz wrote:
> Since version 2.39.2, util-linux fails to build from source since tests/helpers/test_enosys.c
> is built even though alpha is not supported by libseccomp and does not have AUDIT_ARCH_NATIVE:
> 
> gcc -DHAVE_CONFIG_H -I.  -include config.h -I./include -DLOCALEDIR=\"/usr/share/locale\" -D_PATH_RUNSTATEDIR=\"/run\" -D_PATH_SYSCONFSTATICDIR=\"/usr/lib\"   -Wdate-time -D_FORTIFY_SOURCE=2 -fsigned-
> char -fno-common -Wall -Wextra -Waddress-of-packed-member -Wdiscarded-qualifiers -Wimplicit-function-declaration -Wmissing-declarations -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs -
> Wno-missing-field-initializers -Wold-style-definition -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstrict-prototypes -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunused-but-set-
> variable -Wunused-parameter -Wunused-result -Wunused-variable -Werror=sequence-point -g -O2 -ffile-prefix-map=/<<PKGBUILDDIR>>=. -Wformat -Werror=format-security -c -o tests/helpers/test_enosys.o
> tests/helpers/test_enosys.c
> In file included from tests/helpers/test_enosys.c:30:
> ./include/audit-arch.h:67:6: error: #error Unknown target architecture
>    67 | #    error Unknown target architecture
>       |      ^~~~~
> 
> Full log available in [1].
> 
> Sam James from Gentoo suggested this might due to test_enosys being built unconditionally [2]
> while enosys requires AUDIT_ARCH_NATIVE [3]. On the other hand, we're not seeing this issue
> on sparc64 which currently doesn't have libseccomp support either.

Some clarifications:

test_enosys on the master branch is not the same as test_enosys in the
2.39.2 release.
The old test_enosys got promoted to a proper "enosys" utility and
test_enosys is now only a very simple test helper for that that has no
platform dependencies.
So the provided links are a bit off.

libseccomp is not involved at all.
ensys does seccomp the hard way.

> 
> Any suggestions?

Please try [0] on top of 2.39.2.

And maybe also [1] with the misc/enosys testsuite on top of master.

[0] https://github.com/util-linux/util-linux/pull/2612
[1] https://github.com/util-linux/util-linux/pull/2613 

> > [1] https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.39.2-1&stamp=1692576237&raw=0
> > [2] https://github.com/util-linux/util-linux/blob/master/meson.build#L3414
> > [3] https://github.com/util-linux/util-linux/blob/master/meson.build#L2947

Thomas
