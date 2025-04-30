Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232F6AD3
	for <util-linux@vger.kernel.org>; Wed, 30 Apr 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001236; cv=none; b=f8qlVEUqaQI9hm8rKQJtNz92aIiKak04sldVLhofRHJufh+cCpU3d3mC2dGUA14UmZJMK3nGVSwB41Mlj92lmZsYXUyzmk4QgooDIdN+Kk9dHy83+v1rkKKNtBdXbOPSPrThCpOhp2bEVza4hNYvsMidmBjBeLbhDq/aDiuS5qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001236; c=relaxed/simple;
	bh=hFNcBLjpbL5MyVMaryocyRBp2/TisKtr9PPQsA9W/oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJdliYT5Evdjwnlc6bZ+AVQ9YIggNJHZdBcPdtced7IFeoOHsD4XJq2vi2tg/ShbBOZ6bizmDiFG+2qBoCg8xxr2FBtBePYn1PeOU9HOOZsIiogu7DH8WY3F7QfLSiiZN4rB5FJbud977pbr6EBE0pG3tNw48qOnCgTc6I4RYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=SQlmNcEl; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="SQlmNcEl"
X-KPN-MessageId: 0feed721-259c-11f0-86cd-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0feed721-259c-11f0-86cd-005056aba152;
	Wed, 30 Apr 2025 10:21:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=hFNcBLjpbL5MyVMaryocyRBp2/TisKtr9PPQsA9W/oI=;
	b=SQlmNcElxwUpF1tYvsUUsfTqbD+VQBF+GP5MTyEiNUeDT7/zia0bgUtZYluVDj6m7eI40P2mjU8Xr
	 BgDPNp+sZaeNqB+xbwd8TSwp3Yo/5Twz2SekbpVXQA+vXwPRvYCOVGmOGesUyiap2xvv6Yhjm5839C
	 JcOn95cMPxmZyQZY=
X-KPN-MID: 33|9Cj9APxRWVFiNPJkJE5mG/u1wXJLyBDo/PcUsk48ttYMoWQDL5zyaPJplHtzis2
 FtrrCrBWrnbpOYvdt1ObhHQfunoi7BTgFnyxqFvELSCo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ajBJGKVUtFexjAHHdYIfAMWa77qg6OhMe76SB1gGAE0l4n8DXrpv8S2rV2+kbAK
 EZi5Dm3o4mKCWllNU3Vll/w==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f69e9cda-259b-11f0-95a9-005056abf0db;
	Wed, 30 Apr 2025 10:20:23 +0200 (CEST)
Message-ID: <c1e07ead-7bfb-4911-a05b-2fc687469847@telfort.nl>
Date: Wed, 30 Apr 2025 10:20:23 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
To: Masatake YAMATO <yamato@redhat.com>, kzak@redhat.com
Cc: util-linux@vger.kernel.org
References: <20250424093237.6432-3-bensberg@telfort.nl>
 <20250424.185505.855258258029883426.yamato@redhat.com>
 <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
 <20250430.045441.583220097476882528.yamato@redhat.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20250430.045441.583220097476882528.yamato@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------g84a6twYrv4dZEzbMFBFQK5g"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------g84a6twYrv4dZEzbMFBFQK5g
Content-Type: multipart/mixed; boundary="------------yKixxwVAy9UcS4rCA9QJQCc5";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Masatake YAMATO <yamato@redhat.com>, kzak@redhat.com
Cc: util-linux@vger.kernel.org
Message-ID: <c1e07ead-7bfb-4911-a05b-2fc687469847@telfort.nl>
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
References: <20250424093237.6432-3-bensberg@telfort.nl>
 <20250424.185505.855258258029883426.yamato@redhat.com>
 <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
 <20250430.045441.583220097476882528.yamato@redhat.com>
In-Reply-To: <20250430.045441.583220097476882528.yamato@redhat.com>

--------------yKixxwVAy9UcS4rCA9QJQCc5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOS0wNC0yMDI1IG9tIDIxOjU0IHNjaHJlZWYgTWFzYXRha2UgWUFNQVRPOg0KPiBT
aW1wbGlmeWluZyB0aGUgb3V0cHV0IG9mIC0taGVscCBpcyBuaWNlDQo+IEhvd2V2ZXIsIGZy
b20gdGhlIG1hbiBwYWdlLCBJIHdhbnQgdG8ga2VlcCB0aGUgZGVzY3JpcHRpb24gb2YgLXAN
Cj4gc3VwcG9ydGluZyB3aGl0ZXNwYWNlIGFzIGEgc2VwYXJhdG9yLg0KDQpPa2F5LiAgSSB3
aWxsIGFkZCB0aGF0IGJhY2sgd2hlbiB0aGUgY3VycmVudCBQUiBoYXMgYmVlbiBtZXJnZWQu
DQoNCg0KQmVubm8NCg0K

--------------yKixxwVAy9UcS4rCA9QJQCc5--

--------------g84a6twYrv4dZEzbMFBFQK5g
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmgR3UcFAwAAAAAACgkQUUu+Lrjhlh+p
rQ/+PKJMENG5FWm8jpAdQ/zMWg5/RiQArCZ+ImLgt3YSMq3mFEm/4ZlNf5aDJbGQ9nkRM4kpDa/t
2mNeRXKxcpZrZFm67PZGYOmudyEOMdjpDn4aoeddKhXwTb+RppRU4NsuF5HSoHL2CExMDP98vQIx
dbzAG3/4Fzco2E/qZXN9CovWWXDX1mmtZkQEtRamJc5yDtuY+1RYYXEiomuO7ljSt2mbHGYZqHmF
DL3R9W081sQMDMXx29uHWLGDkhPvW43AqGEy57iHfgeynjsLNbSjJu3Jc06JgIOv8QTHy5acBdoi
3Z5OL1Ub1qqh3qgewfyF5Lrt+hV0e6elAsRSxXIZHN3JWlj/e1h+WslKYyLWnrhI53wQZ0aluooe
rD93Hvrfyj4PuoCQzQiOChXl+SAg5YYqD384vJf39Q9X86M/pUzEMwoFyryV9pYsaC3poFXvUKU0
Z/5dIm316xIitFKaGE5RiaTByp3Elvbcjh6nICP/Y8v3ADbmnQ/ptkIAx6mauwEbbjGBtOj7dRHt
ebrs0HbCJR323ta6YM6arnVpYngeicSzL5VAcxefRphy3LpWyP/7jVW5BO/ZnKRVLjtHAu4GBPE7
9fqc13VJu0+iXIXLMsMwPMMvosvY95+GGFVMaP63K1sqwqlRezrnZjCkXEpUgGDC99iMgzyZAYI6
OtQ=
=eBO1
-----END PGP SIGNATURE-----

--------------g84a6twYrv4dZEzbMFBFQK5g--
