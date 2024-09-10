Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4DD18F2FF
	for <util-linux@vger.kernel.org>; Tue, 10 Sep 2024 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962430; cv=none; b=FKqVz4HMHcDPukQO4cVaeNQA0pWlbr3atLcr5YD9342V4fh1L+YGDoFsN8iXMNyDK5DnQSLjzrhzxrQ/nAKHiuWtEeBeGpvj1awSX2iTgtlHezoX6A11/Yuf0Gb5eJBNBGKt0CtqUYnF4OfucjZjXq/Q0jRL2Q0zLkAV4WZpTjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962430; c=relaxed/simple;
	bh=MxF4rx37ceaEl6AWfbdNFF6jAfHNZofQIcH2hc8YtnM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gquHwYmN+4o21YF6e22+RtHe8hz8uL7XSkbdM4MaXitjap6VOhP6bCkFKbwOWMHQdlciJz5Cq49TdRXiYsKiq/Nfur7TvNDVKMwEuKVsgrb8b1/xM/tXHHKAardc6Jdmy37g8nJliKF8NkB2jnSszJaffC/U1RmE2KrQ6oCDuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mol@pengutronix.de>)
	id 1snxfe-0007CG-Ie; Tue, 10 Sep 2024 12:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mol@pengutronix.de>)
	id 1snxfe-006rkI-5l; Tue, 10 Sep 2024 12:00:26 +0200
Received: from mol by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mol@pengutronix.de>)
	id 1snxfe-002PmR-0Q;
	Tue, 10 Sep 2024 12:00:26 +0200
Date: Tue, 10 Sep 2024 12:00:26 +0200
From: Michael Olbrich <m.olbrich@pengutronix.de>
To: util-linux@vger.kernel.org, ptxdist@pengutronix.de
Subject: Re: [ptxdist] util-linux build error with meson and older glibc
Message-ID: <ZuAYutgoVwik51tk@pengutronix.de>
References: <13593969.uLZWGnKmhe@ada-pc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <13593969.uLZWGnKmhe@ada-pc>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: util-linux@vger.kernel.org

On Tue, Sep 10, 2024 at 09:07:01AM +0200, Alexander Dahl wrote:
> Hello everyone,
>=20
> building util-linux with ptxdist [1] here.  After switching to meson
> build [2], compiling util-linux fails with OSELAS.Toolchain-2020.08.0
> which contains gcc-10.2.1 and glibc-2.32.  Building for architecture
> arm-v5te-linux-gnueabi here, console output below.
>=20
> Autotools build was fine.  Build with a more recent toolchain
> (OSELAS.Toolchain-2023.07, gcc 13.2.1, glibc 2.37) is successful.
>=20
> From looking at the linker options I suspect -lutil missing?
> According to manpage that's a BSD function present in glibc.
> I suspect a change in glibc 2.34 integrating libutil in core glibc,
> which makes it work with recent version 2.37.  So this is probably a
> flaw in meson build not setting the necessary linker options for glibc
> up to 2.33?  Could anyone point me how to fix this or does anyone by
> chance already have a patch for this?  (Disclaimer: I have zero
> experience with meson.)


There is a -Dlibutil=3Ddisabled in rules/util-linux.make. Maybe try to
enable that?

Michael

>     % p -v -j1 compile util-linux
>    =20
>     --------------------------
>     target: util-linux.compile
>     --------------------------
>    =20
>     ptxdist: executing: PATH=3D/home/adahl/Work/bsp/thorsis/ncl/tmp/platf=
orm-ncl/sysroot-cross/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform=
-ncl/sysroot-cross/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform-n=
cl/sysroot-host/usr/lib/wrapper:/home/adahl/Work/bsp/thorsis/ncl/tmp/platfo=
rm-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform-n=
cl/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/selected_tool=
chain:/usr/local/lib/ptxdist-2024.05.0/bin:/home/adahl/Work/bsp/thorsis/ncl=
/tmp/platform-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp=
/platform-ncl/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/se=
lected_toolchain:/usr/local/lib/ptxdist-2024.04.0/bin:/home/adahl/bin:/home=
/adahl/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/games HTTPS_PROXY=3DPTX=
DIST-UNALLOWED-DOWNLOAD HTTP_PROXY=3DPTXDIST-UNALLOWED-DOWNLOAD https_proxy=
=3DPTXDIST-UNALLOWED-DOWNLOAD http_proxy=3DPTXDIST-UNALLOWED-DOWNLOAD PKGCO=
NFIG_WHITELIST_HOST=3D'' PKGCONFIG_WHITELIST_TARGET=3D'' PKGCONFIG_WHITELIS=
T_SRC=3D'util-linux' SYSROOT=3D'/home/adahl/Work/bsp/thorsis/ncl/tmp/platfo=
rm-ncl/sysroot-target' V=3D1 VERBOSE=3D1 LC_ALL=3D'C.utf8' KBUILD_BUILD_TIM=
ESTAMP=3D2020-08-01T00:00:00+00:00 KBUILD_BUILD_USER=3Dptxdist KBUILD_BUILD=
_HOST=3Dptxdist  ninja -C /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl=
/build-target/util-linux-2.40.2-build -v  -j1=20
>    =20
>     ninja: Entering directory `/home/adahl/Work/bsp/thorsis/ncl/tmp/platf=
orm-ncl/build-target/util-linux-2.40.2-build'
>     [1/75] arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-ses=
sion.c.o test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined -W=
l,--start-group lib/libcommon.a -lm -lrt -Wl,--end-group
>     FAILED: test_pty=20
>     arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-session.c.=
o test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined -Wl,--sta=
rt-group lib/libcommon.a -lm -lrt -Wl,--end-group
>     /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-gli=
bc-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi/1=
0.2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: test_pty.p/lib_pty-session=
=2Ec.o: in function `ul_pty_setup':
>     platform-ncl/build-target/util-linux-2.40.2-build/../util-linux-2.40.=
2/lib/pty-session.c:198: undefined reference to `openpty'
>     /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-gli=
bc-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi/1=
0.2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: platform-ncl/build-target/=
util-linux-2.40.2-build/../util-linux-2.40.2/lib/pty-session.c:188: undefin=
ed reference to `openpty'
>     collect2: error: ld returned 1 exit status
>     ninja: build stopped: subcommand failed.
>     make: *** [/usr/local/lib/ptxdist-2024.05.0/rules/post/ptxd_make_worl=
d_compile.make:20: /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl/state/=
util-linux.compile] Error 1
>=20
> Greets
> Alex
>=20
> [1] https://www.ptxdist.org/
> [2] https://git.pengutronix.de/cgit/ptxdist/commit/?id=3D18c9c0f89c4148f3=
007b9fcc7833d99af60084dc
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
