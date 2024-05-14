Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2B57CBC
	for <util-linux@vger.kernel.org>; Tue, 14 May 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680900; cv=none; b=rW8G91zWd/NTqhNEHJptJynbobdXF/r4SSLL4Q7UvLYXTpYSKWYY18eGDUHglW6FW4xFJr5WN8VKxllWKthozRUq5fmFcWx9Ym41V66vBWZt2mSb7Vsifujm284BpdoQVqxln5WyeYLDb9cawzFKQrgKaULx1oee/vYjtGFcdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680900; c=relaxed/simple;
	bh=0mywUADmZlcVx3F+7tvQvSNuEhhDPp+Npzsd89Bz8Cw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3mVBDaBcYtM+8itvX++VTKqRKtjdB3PUZ2jR9m4Ef84UXXX3ELM4y9bxXelUr7yG2heTOJHItbBSaG9q6P6hWyCtPMQVdR2yEjiZTABBWeTV1bQy6Pq74E/2SJU+1vfF0JKGmmTfkGqJYRUmxLBvBzgTTTwLnhB1TjL7Xi+fgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=OOx2h/c/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YP/JXhRI; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="OOx2h/c/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YP/JXhRI"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 540EE1140178
	for <util-linux@vger.kernel.org>; Tue, 14 May 2024 06:01:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 14 May 2024 06:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1715680896; x=1715767296; bh=1+YbeZ0hwa2rSWAS4JhNSsc7VY5sgp00
	aGeQqGKAgnQ=; b=OOx2h/c/0O3bhjALEGKE32u9TiKku3f0t/Hwal43mcOIwArB
	owQ8i0P3GIL+VbVvI9mTZbCUK8ssyWQnPM+yDFh6pgPxicUzGlBAwap6EcIyr5vc
	1ACWGU42pxsaZ8ltvL123Cbw78w/5et5snSzddnL3JU07Igl/IGijLY2kEKE1oaA
	tDf9+nbsHGCjpLG+NITKaB76zivX/aTFrh7Q0ios76ThmcB5VgP8klVoy5J37sEX
	OMBkSem5wZWfpOcMFqYVY8YhoYlMb6MY/BfhAnBMUxNITDKWSKwr6HeAw45LOVuG
	8PYEwrrg4Wp1hkZPLpISWktwRwARUhoqmwAAwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715680896; x=1715767296; bh=1+YbeZ0hwa2rSWAS4JhNSsc7VY5sgp00aGe
	QqGKAgnQ=; b=YP/JXhRIXXAoShBNy3hlqq/fIb4AgHpXi9pDyAWPzKeJzJbOoCU
	0xUEm/YX1ruInEAmjqD0MqVNEYMbUG+NrlpTEp1yARL7nYtM2H/04WToc7z9Kblh
	FBS8Maj8QrDdCe4Iw4ZwOd/A0TGpeumqay2nCXjITKrmq7uvKpmPWi5bnZHOOn3l
	+Igksfv6tnGOL21m8csBJ5Vx/ROEUcYQqNjvNqm9y6Q7rZqU848xh1Z6qKFaeNpe
	Sep1anhjspF8CeiyjsvSRWKAfZOChITku2ggtKcdhuOjC3DRTrdpH4wKyovRB/t1
	pcpAoQGe9z897fMGUPiNAE66BmCBrzx4Isg==
X-ME-Sender: <xms:gDZDZj0l1KiKSqfNGOZ4yQGkgPTQSC_WX9bzvbrdOXDFzj0q437NMw>
    <xme:gDZDZiHF-v2SKI1NBp2ptHvHu2b1WrKWTaDgcyGvVYI26H-x_0Ko2NxjF-egx-v3v
    TQmr1Sa_ctNuKqFNA>
X-ME-Received: <xmr:gDZDZj7trcANGl7zl01h5frBKYlkZRnAI9y1JLcShzARIKQ2OLecQcAFxt_Usodzw6U4D_NT1iI-g5dZQ_N6g4mQDJ4S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegiedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkgggtsehgtderredttd
    dtnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeen
    ucggtffrrghtthgvrhhnpeegueevhefgleejgfegieduteetkeetheehuedukeeufffffe
    ehtdfghffhkeeujeenucffohhmrghinhepnhhigihoshdrohhrghenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:gDZDZo0jPwvuKJWmNAGQ94QStTwd3PQpXowFFnEf521m0pGBzNAfaA>
    <xmx:gDZDZmGVEswEeucPPzCWYrszWDDg4JWNaKQYmLG5A4iKyEW_M6TB4g>
    <xmx:gDZDZp9ccepsM2fTW7LxkmkEe_3E-HMRtFqtxFkw_9_dVMm7unmQfA>
    <xmx:gDZDZjnbrGIPHBgGWF6VFiW7dy5Q20w-DCiMxz2GaMNexGyvdjndyg>
    <xmx:gDZDZoMz8HswqvXgdVSXKiPzgxsF3FVytvU0__W6yWcXem67D4XnfA-l>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <util-linux@vger.kernel.org>; Tue, 14 May 2024 06:01:35 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 2916D4F3CF0; Tue, 14 May 2024 12:01:34 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: util-linux@vger.kernel.org
Subject: Parallel build failures with util-linux 2.40
Date: Tue, 14 May 2024 12:01:23 +0200
Message-ID: <87le4c1zm4.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Since updating from util-linux 2.39.3 to 2.40.1 in Nixpkgs, we've been
seeing intermittent parallel build failures like the following:

libtool: warning(B: relinking 'pam_lastlog2.la'(B
libtool: install: (cd /build/util-linux-2.40.1; /nix/store/306znyj77fv49kwn=
kpxmb0j2znqpa8bj-bash-5.2p26/bin/bash "/build/util-linux-2.40.1/libtool"  -=
-silent --tag CC --mode=3Drelink gcc -fsigned-char -fno-common -Wall -Wextr=
a -Waddress-of-packed-member -Wdiscarded-qualifiers -Wformat-security -Wimp=
licit-function-declaration -Wmissing-declarations -Wmissing-parameter-type =
-Wmissing-prototypes -Wnested-externs -Wno-missing-field-initializers -Wold=
-style-definition -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstrict=
-prototypes -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunus=
ed-but-set-variable -Wunused-parameter -Wunused-result -Wunused-variable -W=
vla -Walloca -Werror=3Dsequence-point -I./liblastlog2/src -g -O2 -module -a=
void-version -shared pam_lastlog2_la_LDFLAGS +=3D -Wl,--version-script,./pa=
m_lastlog2/src/pam_lastlog2.sym -o pam_lastlog2.la -rpath /nix/store/ri9wph=
sskq6ygxigvlbahb9mz379qiz5-util-linux-2.40.1-lib/lib/security pam_lastlog2/=
src/la-pam_lastlog2.lo liblastlog2.la )
libtool: warning(B: 'libmount.la' has not been installed in '/nix/store/ri9=
wphsskq6ygxigvlbahb9mz379qiz5-util-linux-2.40.1-lib/lib'(B
libtool: warning(B: '/build/util-linux-2.40.1/libblkid.la' has not been ins=
talled in '/nix/store/ri9wphsskq6ygxigvlbahb9mz379qiz5-util-linux-2.40.1-li=
b/lib'(B
libtool: install: /nix/store/php4qidg2bxzmm79vpri025bqi0fa889-coreutils-9.5=
/bin/install -c .libs/mount /nix/store/v6ff7704fchg30kj4z422693lgnnmmbn-uti=
l-linux-2.40.1-bin/bin/mount
/nix/store/bgcaxhhxswzvmxjbbgvvaximm5hwghz1-binutils-2.41/bin/ld: cannot fi=
nd -llastlog2: No such file or directory
collect2: error: ld returned 1 exit status
libtool: warning(B: 'libmount.la' has not been installed in '/nix/store/ri9=
wphsskq6ygxigvlbahb9mz379qiz5-util-linux-2.40.1-lib/lib'(B
libtool: warning(B: '/build/util-linux-2.40.1/libblkid.la' has not been ins=
talled in '/nix/store/ri9wphsskq6ygxigvlbahb9mz379qiz5-util-linux-2.40.1-li=
b/lib'(B
libtool:   error(B: error: relink 'pam_lastlog2.la' with the above command =
before installing it(B
make[3]: *** [Makefile:7598: install-securelibLTLIBRARIES] Error 1

Full log:
https://cache.nixos.org/log/pp817g4wf18pn7hrn4a7377yxf06bprw-util-linux-2.4=
0.1.drv

Alyssa Ross

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmZDNnMACgkQ+dvtSFmy
ccB7oxAAjDUNKpMddeaBzVff7rJwNkSLp+XNaYtgVMOnX2WTCJme7nu38sb1w8qk
oxVxwVmAANyUhmIxtSPbGhTuTZ8i1kKV7b4nJrxWN3aKo9hoLuwJ88JrCGhbM9J5
2UdFKHaD1tOWKhVhZ0NPXDhov05BtuCPKW7XZwbNSXm8eozykC13A7Ye9QKL7BEn
KK59bnDNA43mrQ5fQy+tsx4Eq4eGjULjmws4OvJCN1ZynUN87jbo9jwoZ8jJeOyI
nqfOQMkYBHGHM3IUBgrZMG3ntZYEyiWjrGNRV9nCP8hscPBvNIowTPnaqntJZHSX
lvMZZsXv5eVyDpKlmueCuLUy2EgIMU+Eh32YUacWIJVcSX7IDfowFsa3qB4K7Pvb
lQQG5ur5VeTsc5iV3ttSw0f1SLpxpfiqpzPgkQGLff+Qsda+/GfrIqRDQNz+nUV6
sAi/RE9myfudPUlr15VGvR7nk/Nn8Z0coi1Z57o8wqsdS3OxI7Qm/rTLe9OaPUBW
yMxCkM0Vt1POnEZuSLhTLdCz9WfjQYxnsCTS4SsQqBONF1937fgw3P5gOUBxtiCb
8iysq1sGsElrEeAqy78PfMmXsTMauKhMekQt9bECnpFIKtOdPOLG3h2sC8L3a6zP
WTMbprLrs5WNE4/ebyNW3+b6/wIBY0d+OvDuR270By/dj5C1s+c=
=OdBn
-----END PGP SIGNATURE-----
--=-=-=--
