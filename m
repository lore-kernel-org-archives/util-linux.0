Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6C2148850
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2024 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467760; cv=none; b=LFoQTXukdnQC/F5Mfbv/QUCX/RLSq1h9DFIxBdOucanStXn3dyc3MbGMZZfGrZPaIWuXzWjrUcsCCOsc9fqzh1ygjz/IM9B3bzU8cKtQOdzJ5DosY9NlXJkiHRw8JiJbtUAysM2ciMKpnBaVoUb1qHECXdiCtW3lEiVuE2YafJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467760; c=relaxed/simple;
	bh=8VZNk5HwZZmS0i2BJ6H5rGi5tk63l13NnRJnnLNKNPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWYNJ+fSGHKUswsfuitzCHqLIbHxr1XV3mA+aZ+m8orkDzLLipeSZNHvqPJyzEPBLmjUj0Bs/Kv6RaXf0S/wIRaff1Qc8qnJ7NYivRbT+zBo2kc3LTrUUsFDqOrEwb/1+7+IqVQvjeQJoOm3XQRd64Nrvz1b14alpn2Ph6nuWmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=td2twgTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gk6EeSXp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="td2twgTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gk6EeSXp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 64F7711401C3;
	Tue, 17 Dec 2024 15:35:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 17 Dec 2024 15:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734467757;
	 x=1734554157; bh=T1tMnhDZHQ3tt8L7QYP4mk6nz85st/CGqDCPfusn0DM=; b=
	td2twgTMcfJ1lyTH0Mo9SvQWP998VS5ct2C49CTedQAghj01MJA8wIuvIXU6Wif8
	7qTKBGgSzMmYlH8glOa22ySE290+FIZPlCzrDm/3NWSXUGHeHbXZClKvf430zaRW
	SQer4l4guGqqsoDHoE4SPMwcqfsGhhrf9CHwUrccCjsvmhB2Cmzao8MNChM29tgr
	9wcPPPv0tUHjZpLKP+xGjKMxUW/wVFZngxOeJqd8SrgycAe27K38g0PW2/Iup3sq
	t9xHKY4w8LA3qDg1Tg8Nf5wo6AwDj7QfUNDCVmDHb370aXcPWgKzeJ7q5gJG6ZMw
	cj/g9v4mNmpUbdwEgYqznw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734467757; x=1734554157; bh=T1tMnhDZHQ3tt8L7QYP4mk6nz85st/CGqDC
	Pfusn0DM=; b=Gk6EeSXpOmlkHmT0CBZ0/50AjsQ4G1BJbT/sCMhU1hSTYzSqUHD
	ozkujCu/+F/8INlnfkoYWSu9JesEV3WxghWcSYicg/Q5oKp59fx02RVXdvaFM8Fs
	cPYFFuyRMP+n1qhEd+Eduvxr6fTCEemtYW98LaBMllnSdu8NZy/XXlBDtAgdJXBf
	1fAzKfeRhpK7GuuBOIIwX4XZASHICm1N4oHTuo1N7rLzrCBz9+CC5L0fG7gI1bHO
	HCXNEk61b7fREMu1qrxJaO6UZGg48R1DmzhbScv1N8UlCsd3idtnxiVAwMZMmGe7
	5IBOrqFv+i3BDqZo90c6HdK1r/TmtHN2SPQ==
X-ME-Sender: <xms:rOBhZ0C1rB467ZBO0twsEIFMRD6fQvJBOMckTcMy1Y2KvI87qH8MMA>
    <xme:rOBhZ2jIVhmSD1cIduRW7XjOgaUtYnCvQEGIJtnZnOtEiitU4MQnQFscXwzrGJ07j
    Vt6sMMHvi64UcI>
X-ME-Received: <xmr:rOBhZ3kcQakUrA93PSoBkm0SOUN3K7bXUH9jzw7ZPEmFmh2bWclHBAbsNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddugeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomhepffgvmhhiucforghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvih
    hsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepudeileef
    ueetvdelheeuteffjeegjeegffekleevueelueekjeejudffteejkeetnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhs
    ihgslhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepiiguvghnvghkrdhkrggsvghlrggtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhlrghsshdrshhusehsuhhsvgdrtghomhdprhgtphhtth
    hopehhvghmihhnghdriihhrghosehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhlvhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmhgthhgrnhhgse
    hsuhhsvgdrtghomhdprhgtphhtthhopehgrhhusgdquggvvhgvlhesghhnuhdrohhrghdp
    rhgtphhtthhopehuthhilhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rOBhZ6xBvQKWG0CFK3FRldkqbdvn9CXG2gNtedrtxK6A48nWs9IAjQ>
    <xmx:reBhZ5RCaSL3fyMCtYum3mCa6gfe1ek3GL75mEDRPBmHGl6tBAa6FA>
    <xmx:reBhZ1bt-HEJHEE9lTPXiV61fTjNM-G1nWAQgjEdKz9jDMdPulqHiA>
    <xmx:reBhZyTjHf4VLrGMjXwxxZGnh2ZdAelOwIB90RA-g81vfcE-g3sl1g>
    <xmx:reBhZ6Q8I959EBa49SpaSNGFPNL13BMuWikyhuHJx2nOxFYkkW4KmGrc>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:35:56 -0500 (EST)
Date: Tue, 17 Dec 2024 15:32:50 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>, Glass Su <glass.su@suse.com>,
	Heming Zhao <heming.zhao@suse.com>
Cc: "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>,
	mchang@suse.com, grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types
Message-ID: <Z2HgqxuHQ0elvy8T@itl-email>
References: <826b5136-7ee1-4664-98d6-a3441883f53e@suse.com>
 <43D73CB9-32E4-405E-93A9-E985C94F4A9E__33327.0934455626$1734427189$gmane$org@suse.com>
 <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IMQ1vNhaMg9QkojH"
Content-Disposition: inline
In-Reply-To: <ec0d03c0-40b0-4719-a020-9bae7a3241ec@gmail.com>


--IMQ1vNhaMg9QkojH
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Dec 2024 15:32:50 -0500
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>, Glass Su <glass.su@suse.com>,
	Heming Zhao <heming.zhao@suse.com>
Cc: "linux-lvm@lists.linux.dev" <linux-lvm@lists.linux.dev>,
	mchang@suse.com, grub-devel@gnu.org, util-linux@vger.kernel.org
Subject: Re: is it possible to add a new filter to detect unusable partition
 types

On Tue, Dec 17, 2024 at 11:21:26AM +0100, Zdenek Kabelac wrote:
> Dne 17. 12. 24 v 10:13 Glass Su napsal(a):
> >=20
> > > On Dec 17, 2024, at 16:34, Heming Zhao <heming.zhao@suse.com> wrote:
> > >=20
> > > Hi LVM2 maintainers,
> > >=20
> > > One of SUSE's customers encountered an issue with LVM2. The user crea=
ted several partitions, one of which was marked as "BIOS boot" (4) instead =
of "LINUX LVM" (8E). Subsequently, the user ran pvcreate/vgcreate/lvcreate =
on this partition. During a system update, grub2-install installed GRUB2 in=
 the "BIOS boot" partition, resulting in LVM2 metadata corruption.
> > >=20
> > > The root cause of this issue is that grub2-install targets the "BIOS =
boot" partition when this lvm2 device is specified for installation. If the=
 user had initially marked the partition as "LINUX LVM", grub2-install woul=
d not have chosen this partition.
> > >=20
> > > On the other hand, it would be beneficial if LVM2 could implement a n=
ew filter or a filter function to detect and exclude the "BIOS boot" partit=
ion from being considered a valid target for LVM2 device creation. This cou=
ld involve issuing a warning or error message to alert the user of the pote=
ntial conflict. This may also help user to notice the issue more easily.
>=20
> Hi
>=20
> lvm2 is using  blkid to detect 'present' signature on a block device - and
> normally prompt to confirm wiping such signature.
>=20
> We may possibly add similar logic for 'partition signatures'.
>=20
> However there is still the plain fact that lvm2  with  --force  or even j=
ust
> '--yes' option is assumed to simply proceed  and clean&clear such
> conflicting signatures and simply makes the block device to be a PV.
>=20
> All that said IMHO primary bug here is within  'grub2-install'  which sim=
ply
> should not be blindingly overwriting  block device which is in use - this
> should be fixed ASAP as there is the biggest risk of data loss, although I
> guess everyone is using  'grub2-install --force'  - as without this option
> (even in my personal experience) is typically refusing to do any work....
>=20
> And same applies to most UI tools I've seen that use lvm2 - all seem to be
> pushing  '--force & --yes' with each it emitted lvm2 command...

If prompts were in a machine-parsable format, tools that used lvm2 could
differentiate between ones that should automatically be responded to
with "yes" and ones that should not.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--IMQ1vNhaMg9QkojH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmdh3/oACgkQszaHOrMp
8lPXHg/+MNPwDkHJXtmyUeG0MhCMYu+2dLMiCx+wYbmPy3D6OwMgD9umCjJDfD8m
6oMAv4uyFSgXnVw3Jh/jA9O7P9C3355Hkj3hDOLAIZt0D6tdiLfNG6dZi5SbI4Rl
/f6CRUEfnMgH/UwSvlu/F2VDsxvZsWTuoqQnNfp6tCGUuYkua1V3xcIF3QTnJR6D
IJY6SWPPXKsh/bp2yQM57G7es/wm2fvNmOPaCMji2dt571Sd4r2VtIUmqhWHxmlh
m8A/seGRpH+p18DAkixDUfvzqoSV0BBcK7xkxD0cnNlhCBhBytvXyaBfYzs/zfHy
tz8+usnjrQxDkr45uDmC2rBRHrWxFzLJCd/mu1p0kIjFjkuI3SzePFAUCxm6kewx
trYvYRmj9SGTParNlpkq67tELMG2KJUNaWjKctPh+8Z+43faWwzJtFIoPOofQ5oZ
Axwc3x75Y4Dr3YxU2K+VinWwwq20CVc2j59ntULBztcj39o3Arzg8AyBm8Z5MPfl
eh0UZToBEVnXiSQrf4n2oQpbbZ8Age92GeqQ7zIOGC84zOrf59j226+aAigJYJ1r
pU2aMi5ac7QYrKn3R5RD/C1/zn3Tqm/i9U/pGQMh3sqX8avntXQ7tXpHARLU+gYN
kpzyuhFTbgbyJ70TnvRlkjsA8P3z7KUPwbP+ydscldHbML+yc4w=
=hJ+p
-----END PGP SIGNATURE-----

--IMQ1vNhaMg9QkojH--
