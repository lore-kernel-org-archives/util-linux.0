Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A2225A8
	for <util-linux@vger.kernel.org>; Tue, 10 Sep 2024 07:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952034; cv=none; b=fBOU+qZpjMsYtAczYuNKY6OVIZhG2E+Cx02epLTS+udOycfLyyU7iL2RfqG1k2zh0UfdbgqtQSMUl+0+YU9YaKBn9tBvRGkQfMRP1OJDlq3MISG1dDvLH8KhQ3c0xJ0q02lG6H0pHrPoExuUQPdPynH+XhPMx1OlH8KEoAouT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952034; c=relaxed/simple;
	bh=vfWW9FgzaWOkIZOzY1y4ttI4fb3wQA2ptRLG+X6+Mqo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ExzNivxRrsoVsMO2jaBTYHFfPO0OAfL6dcNylzaZgVJBIiy89eGnhTOD+uLWAGZ/mWRv1nTJgJ7LQiNBD9NRwtfiw9UiL8pBpdDS8kH9fvOjRIDdRNCC6N6h0x9d7cdKgVKbtEtJZq4dgLJu9ovfaI3wHZhdSqUmHZ5G9Pfu93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Js9SfM2e; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Js9SfM2e"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B36914812F6;
	Tue, 10 Sep 2024 09:07:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1725952029; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding; bh=+t7KdFRKdVPI6+h5XZ0lPr/DguRo5baJtLLPfKYHMtw=;
	b=Js9SfM2e8904kfMuiq3ceISa8YZVyLpDnSog02L9/GjzUbKL0oIuOWSmPNvZ341zdpd4iY
	NrQUuW3BEmjG7eVPagW99Ll9J/Jyla+1/SXV5orYaEiGLB27qG5N2P5Ensv2hdfY1+EfoX
	p05Xv2lENDIxHGpE3DBOiNXH4k3DBMrgk2S441Ivv6g/lUiaNQCrUb0r4kjrCc+bJx7t59
	cyrXj1levSZgMM0e+8u8QUUqy3sdb5i3hW6pf+KXKToct23VW++ZsYA+F5CvB4U52qzPvz
	ZHKfz5RStLjd0eAbdvXSnlvPuMHcZaM+1sCVFynEV0w4YprNNdbnD7j45xxR5A==
Date: Tue, 10 Sep 2024 09:07:01 +0200
From: Alexander Dahl <ada@thorsis.com>
To: util-linux@vger.kernel.org, ptxdist@pengutronix.de
Subject: util-linux build error with meson and older glibc
Message-ID: <13593969.uLZWGnKmhe@ada-pc>
Mail-Followup-To: util-linux@vger.kernel.org, ptxdist@pengutronix.de
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-KMail-Identity: 600738659
X-KMail-Transport: 2015100914
X-KMail-Templates: 123
X-KMail-Identity-Name: Alexander Dahl (thorsis, en)
X-KMail-Transport-Name: thorsis.com
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

building util-linux with ptxdist [1] here.  After switching to meson
build [2], compiling util-linux fails with OSELAS.Toolchain-2020.08.0
which contains gcc-10.2.1 and glibc-2.32.  Building for architecture
arm-v5te-linux-gnueabi here, console output below.

Autotools build was fine.  Build with a more recent toolchain
(OSELAS.Toolchain-2023.07, gcc 13.2.1, glibc 2.37) is successful.

=46rom looking at the linker options I suspect -lutil missing?
According to manpage that's a BSD function present in glibc.
I suspect a change in glibc 2.34 integrating libutil in core glibc,
which makes it work with recent version 2.37.  So this is probably a
flaw in meson build not setting the necessary linker options for glibc
up to 2.33?  Could anyone point me how to fix this or does anyone by
chance already have a patch for this?  (Disclaimer: I have zero
experience with meson.)

    % p -v -j1 compile util-linux
   =20
    --------------------------
    target: util-linux.compile
    --------------------------
   =20
    ptxdist: executing: PATH=3D/home/adahl/Work/bsp/thorsis/ncl/tmp/platfor=
m-ncl/sysroot-cross/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform-n=
cl/sysroot-cross/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl=
/sysroot-host/usr/lib/wrapper:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform=
-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl=
/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/selected_toolch=
ain:/usr/local/lib/ptxdist-2024.05.0/bin:/home/adahl/Work/bsp/thorsis/ncl/t=
mp/platform-ncl/sysroot-host/usr/bin:/home/adahl/Work/bsp/thorsis/ncl/tmp/p=
latform-ncl/sysroot-host/usr/sbin:/home/adahl/Work/bsp/thorsis/ncl/tmp/sele=
cted_toolchain:/usr/local/lib/ptxdist-2024.04.0/bin:/home/adahl/bin:/home/a=
dahl/.local/bin:/usr/local/bin:/usr/bin:/bin:/usr/games HTTPS_PROXY=3DPTXDI=
ST-UNALLOWED-DOWNLOAD HTTP_PROXY=3DPTXDIST-UNALLOWED-DOWNLOAD https_proxy=
=3DPTXDIST-UNALLOWED-DOWNLOAD http_proxy=3DPTXDIST-UNALLOWED-DOWNLOAD PKGCO=
NFIG_WHITELIST_HOST=3D'' PKGCONFIG_WHITELIST_TARGET=3D'' PKGCONFIG_WHITELIS=
T_SRC=3D'util-linux' SYSROOT=3D'/home/adahl/Work/bsp/thorsis/ncl/tmp/platfo=
rm-ncl/sysroot-target' V=3D1 VERBOSE=3D1 LC_ALL=3D'C.utf8' KBUILD_BUILD_TIM=
ESTAMP=3D2020-08-01T00:00:00+00:00 KBUILD_BUILD_USER=3Dptxdist KBUILD_BUILD=
_HOST=3Dptxdist  ninja -C /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl=
/build-target/util-linux-2.40.2-build -v  -j1=20
   =20
    ninja: Entering directory `/home/adahl/Work/bsp/thorsis/ncl/tmp/platfor=
m-ncl/build-target/util-linux-2.40.2-build'
    [1/75] arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-sessi=
on.c.o test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined -Wl,=
--start-group lib/libcommon.a -lm -lrt -Wl,--end-group
    FAILED: test_pty=20
    arm-v5te-linux-gnueabi-gcc  -o test_pty test_pty.p/lib_pty-session.c.o =
test_pty.p/lib_monotonic.c.o -Wl,--as-needed -Wl,--no-undefined -Wl,--start=
-group lib/libcommon.a -lm -lrt -Wl,--end-group
    /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-glibc=
-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi/10.=
2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: test_pty.p/lib_pty-session.c=
=2Eo: in function `ul_pty_setup':
    platform-ncl/build-target/util-linux-2.40.2-build/../util-linux-2.40.2/=
lib/pty-session.c:198: undefined reference to `openpty'
    /opt/OSELAS.Toolchain-2020.08.0/arm-v5te-linux-gnueabi/gcc-10.2.1-glibc=
-2.32-binutils-2.35-kernel-5.8-sanitized/lib/gcc/arm-v5te-linux-gnueabi/10.=
2.1/../../../../arm-v5te-linux-gnueabi/bin/ld: platform-ncl/build-target/ut=
il-linux-2.40.2-build/../util-linux-2.40.2/lib/pty-session.c:188: undefined=
 reference to `openpty'
    collect2: error: ld returned 1 exit status
    ninja: build stopped: subcommand failed.
    make: *** [/usr/local/lib/ptxdist-2024.05.0/rules/post/ptxd_make_world_=
compile.make:20: /home/adahl/Work/bsp/thorsis/ncl/tmp/platform-ncl/state/ut=
il-linux.compile] Error 1

Greets
Alex

[1] https://www.ptxdist.org/
[2] https://git.pengutronix.de/cgit/ptxdist/commit/?id=3D18c9c0f89c4148f300=
7b9fcc7833d99af60084dc
