Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C743E1862B8
	for <util-linux@vger.kernel.org>; Tue, 10 Sep 2024 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725966100; cv=none; b=N8Zq8/YnCzWWdDO0JyEnLSWAeaw3xx2u9bjPI5ptfcSNC7ncigaRNpnduKlo7QIvGzikJX3p2lXCmB/TL6rVe3W+4/X5XZutxCrExecGPHkEhKM7p+7EO+yXWyWHlFAXBkHSrQsn+EY6QSMRycvOtZVncdjwlg6q/nHWwUfw8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725966100; c=relaxed/simple;
	bh=sqYeBQEr36J0KsYVDQh0JpSD9Zf3Z+2uA8c+UNjrTu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgtmSj48vYekDY9dLeqdlwFhJm4/wARlW4Gp8f3b/uNA/i41/BAjK2iRV9OrcDO73dCMkBfdEVwBgf8fMylWOgLxf7Gm1HiXued+TxXfcrphd0I8RwMauFDhx0pGU9PSQrlMBrkQF5eDKHBIPLeZgIcNjOXpJGrhsIiqy7p5IWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=saau85bb; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="saau85bb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2E07A1486493;
	Tue, 10 Sep 2024 13:01:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725966094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Gc5KmOv4zbF1zqd7AIkO1slaqYr6Y/7MddixmV+xg+o=;
	b=saau85bbiDUokemX0aVEeuqh0H+bnBRVmTUe31d15kUqAtnWZApoSaYORAfYKQbNWqF0S8
	wJ3Qx2fvW90/e0vUpsAYmyL5Hr7o2LAPGKgH7IBreIxvM+F0ZdV1n1PXx1SW9yds5VfWHF
	kkD1LPCvDIz4yJckocMBAbDMfVu5MRwYJyj4/BqcN/KAABv4POxPmK+QdH52OxiiRKgail
	CGpwk9klAwAu+Nhi0erSBEt2q9JCbPiWEojDEdvn6ngvp1r6vIWQgIoJafOjspTJ4nh73B
	BbKs7LnVEQ7VORh+OaxHIaIW5PjPYk1mXESLDcFvAVLhXz4hRmka6gCdlTqhhg==
Date: Tue, 10 Sep 2024 13:01:33 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michael Olbrich <m.olbrich@pengutronix.de>
Cc: util-linux@vger.kernel.org, ptxdist@pengutronix.de
Subject: Re: [ptxdist] util-linux build error with meson and older glibc
Message-ID: <20240910-skiing-ecologist-7192a4c5636d@thorsis.com>
Mail-Followup-To: Michael Olbrich <m.olbrich@pengutronix.de>,
	util-linux@vger.kernel.org, ptxdist@pengutronix.de
References: <13593969.uLZWGnKmhe@ada-pc>
 <ZuAYutgoVwik51tk@pengutronix.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZuAYutgoVwik51tk@pengutronix.de>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello,

Am Tue, Sep 10, 2024 at 12:00:26PM +0200 schrieb Michael Olbrich:
> On Tue, Sep 10, 2024 at 09:07:01AM +0200, Alexander Dahl wrote:
> > Hello everyone,
> >=20
> > building util-linux with ptxdist [1] here.  After switching to meson
> > build [2], compiling util-linux fails with OSELAS.Toolchain-2020.08.0
> > which contains gcc-10.2.1 and glibc-2.32.  Building for architecture
> > arm-v5te-linux-gnueabi here, console output below.
> >=20
> > Autotools build was fine.  Build with a more recent toolchain
> > (OSELAS.Toolchain-2023.07, gcc 13.2.1, glibc 2.37) is successful.
> >=20
> > From looking at the linker options I suspect -lutil missing?
> > According to manpage that's a BSD function present in glibc.
> > I suspect a change in glibc 2.34 integrating libutil in core glibc,
> > which makes it work with recent version 2.37.  So this is probably a
> > flaw in meson build not setting the necessary linker options for glibc
> > up to 2.33?  Could anyone point me how to fix this or does anyone by
> > chance already have a patch for this?  (Disclaimer: I have zero
> > experience with meson.)
>=20
>=20
> There is a -Dlibutil=3Ddisabled in rules/util-linux.make. Maybe try to
> enable that?

This did it.  Sent a patch already:

Link: https://lore.ptxdist.org/ptxdist/20240910105459.3468520-1-ada@thorsis=
=2Ecom/T/#u

Thanks and Greets
Alex

>=20
> Michael
>=20
> >     % p -v -j1 compile util-linux
> >    =20
> >     --------------------------
> >     target: util-linux.compile
> >     --------------------------
> >    =20
> >     ptxdist: executing: PATH=3D/home/adahl/Work/bsp/thorsis/ncl/tmp/pla=
tform-ncl/sysroot-cross/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platfo=
rm-ncl/sysroot-cross/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform=
-ncl/sysroot-host/usr/lib/wrapper:/home/adahl/Work/bsp/thorsis/ncl/tmp/plat=
form-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform=
-ncl/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/selected_to=
olchain:/usr/local/lib/ptxdist-2024.05.0/bin:/home/adahl/Work/bsp/thorsis/n=
cl/tmp/platform-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/t=
mp/platform-ncl/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/=
selected_toolchain:/usr/local/lib/ptxdist-2024.04.0/bin:/home/adahl/bin:/ho=
me/adahl/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/games HTTPS_PROXY=3DP=
TXDIST-UNALLOWED-DOWNLOAD HTTP_PROXY=3DPTXDIST-UNALLOWED-DOWNLOAD https_pro=
xy=3DPTXDIST-UNALLOWED-DOWNLOAD http_proxy=3DPTXDIST-UNALLOWED-DOWNLOAD PKG=
CONFIG_WHITELIST_HOST=3D'' PKGCONFIG_WHITELIST_TARGET=3D'' PKGCONFIG_WHITEL=
IST_SRC=3D'util-linux' SYSROOT=3D'/home/adahl/Work/bsp/thorsis/ncl/tmp/plat=
form-ncl/sysroot-target' V=3D1 VERBOSE=3D1 LC_ALL=3D'C.utf8' KBUILD_BUILD_T=
IMESTAMP=3D2020-08-01T00:00:00+00:00 KBUILD_BUILD_USER=3Dptxdist KBUILD_BUI=
LD_HOST=3Dptxdist  ninja -C /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-n=
cl/build-target/util-linux-2.40.2-build -v  -j1=20
> >    =20
> >     ninja: Entering directory `/home/adahl/Work/bsp/thorsis/ncl/tmp/pla=
tform-ncl/build-target/util-linux-2.40.2-build'
> >     [1/75] arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-s=
ession.c.o test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined =
-Wl,--start-group lib/libcommon.a -lm -lrt -Wl,--end-group
> >     FAILED: test_pty=20
> >     arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-session.=
c.o test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined -Wl,--s=
tart-group lib/libcommon.a -lm -lrt -Wl,--end-group
> >     /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-g=
libc-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi=
/10.2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: test_pty.p/lib_pty-sessi=
on.c.o: in function `ul_pty_setup':
> >     platform-ncl/build-target/util-linux-2.40.2-build/../util-linux-2.4=
0.2/lib/pty-session.c:198: undefined reference to `openpty'
> >     /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-g=
libc-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi=
/10.2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: platform-ncl/build-targe=
t/util-linux-2.40.2-build/../util-linux-2.40.2/lib/pty-session.c:188: undef=
ined reference to `openpty'
> >     collect2: error: ld returned 1 exit status
> >     ninja: build stopped: subcommand failed.
> >     make: *** [/usr/local/lib/ptxdist-2024.05.0/rules/post/ptxd_make_wo=
rld_compile.make:20: /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl/stat=
e/util-linux.compile] Error 1
> >=20
> > Greets
> > Alex
> >=20
> > [1] https://www.ptxdist.org/
> > [2] https://git.pengutronix.de/cgit/ptxdist/commit/?id=3D18c9c0f89c4148=
f3007b9fcc7833d99af60084dc
> >=20
> >=20
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>=20
