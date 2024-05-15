Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7943144
	for <util-linux@vger.kernel.org>; Wed, 15 May 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789956; cv=none; b=iZH5/rLsEVgtUTcXdO9aHz1O5JkLkBZT7/+kG5mW/q86muhds1ucESxd+/8cVSsDxLVxTtujgWz0KCWaXx0d42VERDpVWlzXajAwTeEB8NuJBWKpxWak5dXIsViUAl9BwihdLRYJMT3yGP9lOCeC419bui57zgN6Ic+eBlNBzS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789956; c=relaxed/simple;
	bh=s46cTOVE1oqgiH0nSJa1vremVh5uFcDI66LXh7GeNT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VZZ46YCImyOs8UTfTmkYX1J8HTwqE5vHThwD2NJboWS81yAv1IFYYsKwyjEviwGixJVP18/tgh5vqs7r7cCyG7gpS57dXdAnNpJxi/U7yDC55cSLdAAhxlNW62DlZy8Y5uDT+n43w/ASjhnBl9t12rN9y+m7XrJmqRkaNkUVB5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=XJdWN7kP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KlM3XMT3; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="XJdWN7kP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlM3XMT3"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7E4BF138015A;
	Wed, 15 May 2024 12:19:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 12:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715789951; x=1715876351; bh=VBomo4ku3z
	G63mbBcA3yswZdMPQ2xkoAZP9pSyZFsfg=; b=XJdWN7kPXPQBT0Lbg7toZG89Eq
	Du5YXm/sj+kz4/UoJ5ZSrqJu4hYT1l4swUG7gq5b87aLpfMtrWZse2QkAAYI8mNV
	UXmvDxoYae1srRlFMQuviNH5cL2+aNZwRoabiWOg6O5kAJO0nbKmafYvxwur00Ds
	D5DE9ICQGvHYcpH1zPvT+H4HLjDRJlSxYCA0zYCA++5TNXslVIvrpGcnHpLXD1/G
	7KTLo4NXsWNRRY3l2DamHsxSz8WU7WCmZl6UYubCEbKwTEx9hKn9Ms4r9RuzGZ5n
	dmI8i30XMEnHZk2ijvxR9DY9rdQKpH9zpTPhUiBdLntRufX2e07PgsInKx1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715789951; x=1715876351; bh=VBomo4ku3zG63mbBcA3yswZdMPQ2
	xkoAZP9pSyZFsfg=; b=KlM3XMT3IlC13VrrxvAalec85r6CUFMd/YI0Eh09xPWH
	cqD+FjxU2UfCs0oZqQi0YQceikrExMjlWD7s5BbKqs7NTIQ5r0su8et4/CmBChhO
	SCHzn8DN35UXlCr5fumYuFcMUzhYz4O2hyoW6ehINAH9lrrFlWlDRmUi++R/nwmB
	yuteMnxNO1l3E/tl+aMw8gdrMscUyG870D99TrL1+36RgInvFaTOnNvJ/AkqY6N4
	SzjSWWVvB/MCfpwkGm8Gi7lxvk2fjC0uniZFKSk7PId0HqeOanGz8p8m/LcL9mnh
	nNJ1vAfi22zUvb4NjP6tjxf/hOiHSua9elcf4R6mxg==
X-ME-Sender: <xms:f-BEZpsS3Yj6IgpIx1OXM9Gb6C_nBvpfcml9qe4ocHQE4BBLcnvj-Q>
    <xme:f-BEZidKsr361AEubWMiqviOmqTISs50-KNc8-qWlnOZlGUD84LcDAxR7JzPsBUSn
    bRO_jZD4MCcd5k94w>
X-ME-Received: <xmr:f-BEZsz03Bhk9va80sBBp71UA5gui1Kr96KU1hQI35DJKGhaCXTSdeVpbyFlL6Nv77MNKclGcAiCp8oGuQjG6wa7Kmh6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegkedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefujghffffkgggtsehgtderredttdejnecuhfhrohhmpeetlhihshhs
    rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeffff
    ejfffgudejueekvedvjeeugfeileffjedtvedtieetvefgieeghfdtgfegjeenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:f-BEZgPv9vJUauJFRukJNxS4akHxQpvzQuygkyDYmO-n7UIbtEbWVw>
    <xmx:f-BEZp866HqqjD8gQJs_UFgQmDki1oxO2wbQHqoBnofGjtRSyKj1WA>
    <xmx:f-BEZgVsBmcCTIs_wFEZkggt8D65auCzXpsmePHx1Ag9HWFwv9aLzw>
    <xmx:f-BEZqcNAgCVeSkrmbRIhc1Jrmkp6cwvvl5DMbSTJr_bfr6pGVXAOg>
    <xmx:f-BEZrJcHgsh2Y-7TcCqVsFETkiq_v12wjln7EJIFiHRebtKPQ0kMwLR>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 12:19:11 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id CC5494F3DA8; Wed, 15 May 2024 18:19:09 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Parallel build failures with util-linux 2.40
In-Reply-To: <20240515142226.oyp37o3fkajvpoal@ws.net.home>
References: <87le4c1zm4.fsf@alyssa.is>
 <20240515142226.oyp37o3fkajvpoal@ws.net.home>
Date: Wed, 15 May 2024 18:18:58 +0200
Message-ID: <87eda31219.fsf@alyssa.is>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karel Zak <kzak@redhat.com> writes:

> On Tue, May 14, 2024 at 12:01:23PM +0200, Alyssa Ross wrote:
>> Since updating from util-linux 2.39.3 to 2.40.1 in Nixpkgs, we've been
>> seeing intermittent parallel build failures like the following:
>
> What does it mean "parallel build"? make -j ?

Yeah.

>> libtool: warning(B: relinking 'pam_lastlog2.la'(B libtool: install:
>> (cd /build/util-linux-2.40.1;
>> /nix/store/306znyj77fv49kwnkpxmb0j2znqpa8bj-bash-5.2p26/bin/bash
>> "/build/util-linux-2.40.1/libtool"  --silent --tag CC --mode=3Drelink
>> gcc -fsigned-char -fno-common -Wall -Wextra
>> -Waddress-of-packed-member -Wdiscarded-qualifiers -Wformat-security
>> -Wimplicit-function-declaration -Wmissing-declarations
>> -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs
>> -Wno-missing-field-initializers -Wold-style-definition
>> -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstrict-prototypes
>> -Wtype-limits -Wuninitialized -Wunused-but-set-parameter
>> -Wunused-but-set-variable -Wunused-parameter -Wunused-result
>> -Wunused-variable -Wvla -Walloca -Werror=3Dsequence-point
>> -I./liblastlog2/src -g -O2 -module -avoid-version -shared
>> pam_lastlog2_la_LDFLAGS +=3D
>
> I'm not sure, but it seems like you're being affected by an extra "+=3D"
> in the LDFLAGS. This should be fixed by...
>
>     https://github.com/util-linux/util-linux/commit/290748729dc3edf9ea1c6=
80c8954441a5e367a44
>     https://github.com/util-linux/util-linux/commit/597e8b246ae31366514ea=
d6cca240a09fe5e1528
>
> Can you try your use case with the latest git tree?

Thanks for pointing these out =E2=80=94 I've applied the patches to our bui=
ld,
but since the failure only happened intermittently, I'm not going to be
able to tell if it's fixed the issue right away.  We'll just have to
wait and see, and no news will be good news.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmZE4HIACgkQ+dvtSFmy
ccA77g/8DQaxjWg+9nXvHWHZE9npZi4CApP6ayS6lVt9VIZvcyXpyvrYWGMNDyky
a4xmlFzbDWi5YtY5cOMSwhGag8Nq2W/fnZbVygHmJ7ZVBQd/BaQX6/gc9KFo2GKb
3VXPPqI4iII9g9qRTG8dmJjRZdOoemu/2AE7ltiYC3rwsmil2siU7wokX2mp5swe
ea6mn0s/eZC2PfivxE1UWl0zNbEubsm+VyCV2sN+6io1Oo6tphV2jW8eY2f2gSAV
/42Q22Cv1zcE1QvsjFfe39lhvCKKfVtzFvlUCY6WGC6OhhTWX77db6k9BRydoJv9
sSGTzfD6aMlYf7sIRoGxEKmot9yZkDKZej/MXQywVygOu1+gcvOXYZE18u2jjUvF
x3VTVPvz2EgBLSPNp+I5NOV9Hj4Gaj8SKP3bzc2oMo4bjINDEEEswhnLMVHlX3LJ
leVdVQRy7a7DGvaygtafFpbm4535XwlkRMfUacfMqiJ8dUVfBYew63LPQoNV7DgI
EfVLy4MGIKN3eM8KR7fNJQ3OJt7NROs02Me5f21xJ2MBs8StAXXcH684nkvZwwVL
2c/yDm4wLj0m1LRSbczDen2jDdw2oVhiTh0+zdLzlQUHqoxqN3sV6kRiAYULHZ3O
QyltR6b7JzK0wg+zpRlc7NFWK/amFMUihXz3wCEYee+JoVoHnOI=
=r6PR
-----END PGP SIGNATURE-----
--=-=-=--
