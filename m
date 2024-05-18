Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F616214E
	for <util-linux@vger.kernel.org>; Sat, 18 May 2024 19:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716062095; cv=none; b=Ruwi4EqYv3LEraodhTWvyElAe8F9aALeIEy8f8YYpuvaN7A1meeovImdl/iXe6EB3n5tQeVdNLgwLHXzbIYzOsquMoP4MjawXw2aPrbLxcRjkXYprpqw/N68G50GD1RJI6xdSytJ5K8rNOwAQAeovLSg91gPtMlkT9N4p1WGFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716062095; c=relaxed/simple;
	bh=GNqgZwvMN4yIENTV8bKP50laNUJ+qP328ArTtAr3JeY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nj/4XF4ul28QtPXlNLE3bKZIFegugoX2X/Hkj2253ha0KLbK0AoRr23etogriYdsjrzZDhz2KGgEnlntxwe+9EXR2AsxPWI2Q4qOUFN3s3mO6KgxIUQQX4gzKAWkSrHceA78bSQj19l+EogYuRFugwUYH9irmWEyFp+xYCbYPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=sIpBh0in; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ObZt5DNi; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="sIpBh0in";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ObZt5DNi"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id D5E311C000B9;
	Sat, 18 May 2024 15:54:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 18 May 2024 15:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1716062090; x=1716148490; bh=RCe+9XsPhP
	ifOp34M0qfxpQyqaG+swY4u7IjyLDHCto=; b=sIpBh0injYYxfnKeGQ05HpzFJ9
	0zFV8VtnJSvfRrihB2ecTjbuOgFbwsc8muXI5BOXp8Gf8Qdmwce/zqtBEv95GXZG
	ULlJdh/wcv4nPPrJPzAu8LPTKgOxqbmMaXvsmk9KpmWldpYKo0xJOyTVkal3p+UO
	4misX4BBk+A4XtGtp2/4z4YpmfJ/1S3trvzayMF/OU4hHnVTtsq+XQccSppTv/rD
	NYBYlWgg13hS+lRZRUViGwA5A8tw5MxtPbiQrMREJa8kAr6kK/endCkRYPvn3KhC
	vRsD9DgsakJixivvnyqUehpBXo4d3Iu4gTpujqb3h4V6GRLFalcBt9ZHICHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716062090; x=1716148490; bh=RCe+9XsPhPifOp34M0qfxpQyqaG+
	swY4u7IjyLDHCto=; b=ObZt5DNiReSCjdZLvS7cTQLRQ8B9Nd9JbVyYRAfW/qFx
	v8Z6vtzrM2kXP83fkbhd7Np2DoHiSkrr9gSpEhhbNQyEvoc1tAQlizPxCk+aQxzO
	9UwHWcim70iqRUS7A7Eu9s3kjYPumgtsMI/bEwucbyfsbJCAf6TQpe1oZyMm3RiT
	JNytv2Nh8pKbKnzsU/0NupahRW0nqCO8az6FK+hNgCSEP7GkocaHCaJPlUdUFBJr
	GINvcioWrXfV93LcNo/7zeRaaAS0Aohmyk/Hx/+ajP09ssEMjQYOiVbXgZd/u+kn
	2+5vDpvX/vZNTKIYuiC2+JQJIHK/XBuLWfguePPjyg==
X-ME-Sender: <xms:igdJZkhOWsxICFaXRpy-kjgdSPpc6P2i67kd_GYs-EdQ_0enoSqCng>
    <xme:igdJZtAgHget8cX5EHe5TAilT93JZUietp99KcEE41SfXd7ykI0mHecZfVV7mMcFS
    jttSQ4nVY28MUl7aA>
X-ME-Received: <xmr:igdJZsEwb7BIKBMrpgmsWnWc6Bgw7Xvq3EWQR606zWfLJYhWou9rGMAx010QEKs9vk0woWYNygNxBqg-_HsqJFBaIudb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehiedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepfe
    duudduffelgeduveffieegtedtieegffdttdfggfevudejvedtffeitdeuhfeunecuffho
    mhgrihhnpehgihhthhhusgdrtghomhdpnhhigihoshdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:igdJZlSU9JlNwX9Ss7jyoqa9oDU1vvvijXYnx_DHNo1_RpYQvDRr-w>
    <xmx:igdJZhxkGhwMBQzW3LjFyQzZqc5hf3W38_XGbFkWbl1xL-bpx4kojA>
    <xmx:igdJZj5k5L-9w6BSXCBRrDpUA2lkTq3REFDdSMPKNNTMtwhwzxDzBg>
    <xmx:igdJZuzzE4YKSovcNLxqguFmQ-dGV-21AgwSifbo8HFN9sLRFMEbBg>
    <xmx:igdJZs9Ya5zjZDlXaV126qtoOAVOXZn2dRIQQDGaYNMPaxXSJFUxUpZL>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 May 2024 15:54:49 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 14CF84F41C6; Sat, 18 May 2024 21:54:47 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Parallel build failures with util-linux 2.40
In-Reply-To: <87eda31219.fsf@alyssa.is>
References: <87le4c1zm4.fsf@alyssa.is>
 <20240515142226.oyp37o3fkajvpoal@ws.net.home> <87eda31219.fsf@alyssa.is>
Date: Sat, 18 May 2024 21:54:30 +0200
Message-ID: <87v83auc95.fsf@alyssa.is>
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

Alyssa Ross <hi@alyssa.is> writes:

> Karel Zak <kzak@redhat.com> writes:
>
>> On Tue, May 14, 2024 at 12:01:23PM +0200, Alyssa Ross wrote:
>>> Since updating from util-linux 2.39.3 to 2.40.1 in Nixpkgs, we've been
>>> seeing intermittent parallel build failures like the following:
>>
>> What does it mean "parallel build"? make -j ?
>
> Yeah.
>
>>> libtool: warning(B: relinking 'pam_lastlog2.la'(B libtool: install:
>>> (cd /build/util-linux-2.40.1;
>>> /nix/store/306znyj77fv49kwnkpxmb0j2znqpa8bj-bash-5.2p26/bin/bash
>>> "/build/util-linux-2.40.1/libtool"  --silent --tag CC --mode=3Drelink
>>> gcc -fsigned-char -fno-common -Wall -Wextra
>>> -Waddress-of-packed-member -Wdiscarded-qualifiers -Wformat-security
>>> -Wimplicit-function-declaration -Wmissing-declarations
>>> -Wmissing-parameter-type -Wmissing-prototypes -Wnested-externs
>>> -Wno-missing-field-initializers -Wold-style-definition
>>> -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstrict-prototypes
>>> -Wtype-limits -Wuninitialized -Wunused-but-set-parameter
>>> -Wunused-but-set-variable -Wunused-parameter -Wunused-result
>>> -Wunused-variable -Wvla -Walloca -Werror=3Dsequence-point
>>> -I./liblastlog2/src -g -O2 -module -avoid-version -shared
>>> pam_lastlog2_la_LDFLAGS +=3D
>>
>> I'm not sure, but it seems like you're being affected by an extra "+=3D"
>> in the LDFLAGS. This should be fixed by...
>>
>>     https://github.com/util-linux/util-linux/commit/290748729dc3edf9ea1c=
680c8954441a5e367a44
>>     https://github.com/util-linux/util-linux/commit/597e8b246ae31366514e=
ad6cca240a09fe5e1528
>>
>> Can you try your use case with the latest git tree?
>
> Thanks for pointing these out =E2=80=94 I've applied the patches to our b=
uild,
> but since the failure only happened intermittently, I'm not going to be
> able to tell if it's fixed the issue right away.  We'll just have to
> wait and see, and no news will be good news.

Hi, I'm afraid we're still seeing similar failures with those two
patches backported on top of 2.40.1:

	  /nix/store/3c54hwp1zji0h8yl66860cp8zp2vsrzv-bash-5.2p26/bin/bash ./libto=
ol   --mode=3Dinstall /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils=
-9.5/bin/install -c login dmesg mount umount wdctl mountpoint lsblk findmnt=
 kill lsfd pipesz '/nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-util-linux-m=
inimal-2.40.1-bin/bin'
	libtool: warning: relinking 'pam_lastlog2.la'
	libtool: install: (cd /build/util-linux-2.40.1; /nix/store/3c54hwp1zji0h8y=
l66860cp8zp2vsrzv-bash-5.2p26/bin/bash "/build/util-linux-2.40.1/libtool"  =
--silent --tag CC --mode=3Drelink gcc -fsigned-char -fno-common -Wall -Wext=
ra -Waddress-of-packed-member -Wdiscarded-qualifiers -Wformat-security -Wim=
plicit-function-declaration -Wmissing-declarations -Wmissing-parameter-type=
 -Wmissing-prototypes -Wnested-externs -Wno-missing-field-initializers -Wol=
d-style-definition -Wpointer-arith -Wredundant-decls -Wsign-compare -Wstric=
t-prototypes -Wtype-limits -Wuninitialized -Wunused-but-set-parameter -Wunu=
sed-but-set-variable -Wunused-parameter -Wunused-result -Wunused-variable -=
Wvla -Walloca -Werror=3Dsequence-point -I./liblastlog2/src -g -O2 -module -=
avoid-version -shared -Wl,--version-script,./pam_lastlog2/src/pam_lastlog2.=
sym -o pam_lastlog2.la -rpath /nix/store/dsxjv3a5aj1f4pifv5a6rvpj7zk00vyx-u=
til-linux-minimal-2.40.1-lib/lib/security pam_lastlog2/src/la-pam_lastlog2.=
lo liblastlog2.la )
	libtool: install: /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils-9.=
5/bin/install -c login /nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-util-lin=
ux-minimal-2.40.1-bin/bin/login
	libtool: install: /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils-9.=
5/bin/install -c dmesg /nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-util-lin=
ux-minimal-2.40.1-bin/bin/dmesg
	libtool: warning: 'libmount.la' has not been installed in '/nix/store/dsxj=
v3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.40.1-lib/lib'
	libtool: warning: '/build/util-linux-2.40.1/libblkid.la' has not been inst=
alled in '/nix/store/dsxjv3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.=
40.1-lib/lib'
	libtool: install: /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils-9.=
5/bin/install -c .libs/mount /nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-ut=
il-linux-minimal-2.40.1-bin/bin/mount
	libtool: warning: 'libmount.la' has not been installed in '/nix/store/dsxj=
v3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.40.1-lib/lib'
	libtool: warning: '/build/util-linux-2.40.1/libblkid.la' has not been inst=
alled in '/nix/store/dsxjv3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.=
40.1-lib/lib'
	libtool: install: /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils-9.=
5/bin/install -c .libs/umount /nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-u=
til-linux-minimal-2.40.1-bin/bin/umount
	libtool: warning: 'libsmartcols.la' has not been installed in '/nix/store/=
dsxjv3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.40.1-lib/lib'
	libtool: install: /nix/store/dm0wz420s9n1nbp3731y9iqya0zswyy8-coreutils-9.=
5/bin/install -c .libs/wdctl /nix/store/hxd66fx3rvq1km5hjq6dgx8a6yw7czyd-ut=
il-linux-minimal-2.40.1-bin/bin/wdctl
	/nix/store/8qjkvnam69dm0r9lhirxy1ngzbsh6a8z-binutils-2.41/bin/ld: cannot f=
ind -llastlog2: No such file or directory
	libtool: warning: 'libmount.la' has not been installed in '/nix/store/dsxj=
v3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.40.1-lib/lib'
	collect2: error: ld returned 1 exit status
	libtool: warning: '/build/util-linux-2.40.1/libblkid.la' has not been inst=
alled in '/nix/store/dsxjv3a5aj1f4pifv5a6rvpj7zk00vyx-util-linux-minimal-2.=
40.1-lib/lib'
	libtool:   error: error: relink 'pam_lastlog2.la' with the above command b=
efore installing it
	make[3]: *** [Makefile:7603: install-securelibLTLIBRARIES] Error 1

Full log:
https://hydra.nixos.org/build/260133082/nixlog/11/raw

I wish I could provide more helpful information, but since it doesn't
happen consistently it's hard to collect any.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmZJB3YACgkQ+dvtSFmy
ccA76A/+I1tGGafvVqL6AlkUbHBbzRO0uKzLnZYg/hqhwsrG65vUWQgMCOptjOzx
9rU+xkvl9I27Rb/PrQr8HXnQkbGjhE7oNm7v2mWu1kJ7OHTVPYO7jqmBuz/V/3MM
uMGIdSRHEH+tdz8X/QZJq+Wf54pUioxZkMDFuhKxDMhaosjSyHn+dsgwi1kZ+Ia2
4E57yUey6ABiCmO1oSt3oZWU5rFa7RDLca6cB8XQAXteGWL3IRN3B8HEJJMIkl9j
OX96qW8xj5IbV8RK2iCKNTFY06MgRRL9aTCGyhcpaIMyUprqiJsogWTnXrRfmQSd
3sVXfx+BVpFL4ATRc/nmfjlkZpcNEJBuMt2ZcVKernyqZHFSVN/0L50oCdDSJKeE
71MbFtjWtTGOPVSs3S6tnYWhumalZ0L3WkmjOB60kDdSzUqat4cdtT1/SK598zpj
i2NmLN2qiYSZZVMqUNBgGnisBXQqBDkEbyoMLeCJbBYMekSFFJybIxss2FTkRnCc
CWx/o7fsUop7FLO151jLMs4sFMpUbWwnnE5zDJnbU6q1EzgFYs/Pxos06Cq8Ucyw
PaefwEJaps9PnPWr/oEHuCOzwWVyUd0DJGvRxxMmSz7nuWFcZ3gfCJf2ZwRn7S/7
ouzOCSwtExpC12fG7d6jZExekDfaHXsFrqJ4wkxRDrFyNlULRjY=
=Kt25
-----END PGP SIGNATURE-----
--=-=-=--
