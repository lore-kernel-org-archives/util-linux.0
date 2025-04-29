Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9835946
	for <util-linux@vger.kernel.org>; Tue, 29 Apr 2025 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934942; cv=none; b=cSCLayxocq0AGz5lGdt+XaxHcPUoRdQr1+c7w+97ZJMlIZCWkdvKa02G3Df8MxOD00pmksRRjSssK2De4nA2I4PdhHCxyGCItyWGGII7jbd9U8tJj1dNcuniYIiP0MYwQDspoWFPcbXQqIQYdw2GZ/cA0VzhrA4Aj73OMdAOHLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934942; c=relaxed/simple;
	bh=zWVp9e4IjHoyuB/FzoWUxpp3L3+xAIBtjDViReFu7Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsllHpUhovCz0EILf5MJ2ZpkvGJ0LFYVD6DdUA2Iw1ief9zZjiLGwE9e3JkBVmiMcIlkD1t5Rr/r1v67CxzOIjMqOO5n0/uj/ZVpi22FlAtykhtoHRuoMRmbG+tU0Nyv5U5y7c2qhufJFlvy3QcnbDd+TuU1eG6cpVw6CHTM6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=t/RoPB49; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="t/RoPB49"
X-KPN-MessageId: b7c09f7d-2501-11f0-a82f-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b7c09f7d-2501-11f0-a82f-005056abad63;
	Tue, 29 Apr 2025 15:56:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=zWVp9e4IjHoyuB/FzoWUxpp3L3+xAIBtjDViReFu7Ag=;
	b=t/RoPB49I9KaBu5e1sUbySz7V7oXQhWC0K3ZS0QVxsYfdzSD/GDliW04wHvidowW4NjtRAqbBy+Ux
	 2xKcyU2GPaHDzREw/eTK7/vwye6qSRDyRMgWsqUp1RCmEauX+AsXFw57Qi07X6jYqMkYZhUk3TlLw3
	 tEB8KOlHRWEEmHtY=
X-KPN-MID: 33|Eg6pyV6tWipmxDrSel7woi3yyiFD+rQlFSyzw4j199LP42KKLm51yoa4dgjCtZa
 2rYEQnsoN69SDynigzVShkg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kojh1VX5BlBBAwPIkd03dw3MaBLhT/2oZ8HlDd0XXSmrCxbQbbPW3oB2HLpTa19
 wm8Hcj/wg94xMbWqhM4lFhA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9c2f47c6-2501-11f0-855b-005056ab7584;
	Tue, 29 Apr 2025 15:55:29 +0200 (CEST)
Message-ID: <f3465a40-837f-42e5-934b-09f4d5551909@telfort.nl>
Date: Tue, 29 Apr 2025 15:55:28 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] unshare: make the wording of a message identical to
 that of three others
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vysyGRwH2j02cYo5JKAHA73K"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vysyGRwH2j02cYo5JKAHA73K
Content-Type: multipart/mixed; boundary="------------vXYfoA5fMumZHwmpHDSb0RBN";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <f3465a40-837f-42e5-934b-09f4d5551909@telfort.nl>
Subject: Re: [PATCH 1/7] unshare: make the wording of a message identical to
 that of three others
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>
In-Reply-To: <qf3xkiasm5b5zliten36bjv4ynd4kdzj7nll5x3nq5jsasfegg@evnsrxot4x6j>

--------------vXYfoA5fMumZHwmpHDSb0RBN
Content-Type: multipart/mixed; boundary="------------0XtBmCMUbp0NLj76uy0ifHPe"

--------------0XtBmCMUbp0NLj76uy0ifHPe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOS0wNC0yMDI1IG9tIDEzOjExIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBDcmVhdGVk
IGEgcHVsbCByZXF1ZXN0IGF0DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS91dGlsLWxpbnV4L3V0
aWwtbGludXgvcHVsbC8zNTUwIHRvIHRlc3QgdGhlIHBhdGNoZXMNCj4gdmlhIENJLiBJIGhv
cGUgSSBoYXZlIGFwcGxpZWQgdGhlIGNvcnJlY3QgdmVyc2lvbnMgb2YgdGhlIHBhdGNoZXMg
OikNCg0KVGhlIGxhc3QgcGF0Y2ggKCJkb2NzLHVzYWdlIikgcHJvYmFibHkgbmVlZHMgdGhl
IGF0dGFjaGVkIGV4dHJhIGRpZmYgdG8NCnBhc3MgdGhlIHRlc3RzLg0KDQooSSdtIHN1cnBy
aXNlZCB0aGF0IHRoZSBidWlsZCBzeXN0ZW0gZG9lcyBub3QgYXV0b21hdGljYWxseSBtYWtl
IHJ1bGVzDQpmb3IgYWxsIHRoZSAuYWRvYyBmaWxlcyBpbiBtYW4tY29tbW9uLikNCg0KDQpC
ZW5ubw0KDQo=
--------------0XtBmCMUbp0NLj76uy0ifHPe
Content-Type: text/x-patch; charset=UTF-8; name="po4a-hyperlink.diff"
Content-Disposition: attachment; filename="po4a-hyperlink.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3BvLW1hbi9wbzRhLmNmZyBiL3BvLW1hbi9wbzRhLmNmZwppbmRleCAy
NWRmNTM4YTMuLjk1OWRkYjhiZiAxMDA2NDQKLS0tIGEvcG8tbWFuL3BvNGEuY2ZnCisrKyBi
L3BvLW1hbi9wbzRhLmNmZwpAQCAtNyw2ICs3LDcgQEAKIFt0eXBlOmFzY2lpZG9jXSAuLi9t
YW4tY29tbW9uL2Zvb3Rlci1saWIuYWRvYyAgICAkbGFuZzokbGFuZy9tYW4tY29tbW9uL2Zv
b3Rlci1saWIuYWRvYyAgICBvcHQ6Ii0ta2VlcCAwIgogW3R5cGU6YXNjaWlkb2NdIC4uL21h
bi1jb21tb24vZm9vdGVyLmFkb2MgICAgICAgICRsYW5nOiRsYW5nL21hbi1jb21tb24vZm9v
dGVyLmFkb2MgICAgICAgIG9wdDoiLS1rZWVwIDAiCiBbdHlwZTphc2NpaWRvY10gLi4vbWFu
LWNvbW1vbi9oZWxwLXZlcnNpb24uYWRvYyAgJGxhbmc6JGxhbmcvbWFuLWNvbW1vbi9oZWxw
LXZlcnNpb24uYWRvYyAgb3B0OiItLWtlZXAgMCIKK1t0eXBlOmFzY2lpZG9jXSAuLi9tYW4t
Y29tbW9uL2h5cGVybGluay5hZG9jICAgICAkbGFuZzokbGFuZy9tYW4tY29tbW9uL2h5cGVy
bGluay5hZG9jICAgICBvcHQ6Ii0ta2VlcCAwIgogW3R5cGU6YXNjaWlkb2NdIC4uL21hbi1j
b21tb24vaW4tYnl0ZXMuYWRvYyAgICAgICRsYW5nOiRsYW5nL21hbi1jb21tb24vaW4tYnl0
ZXMuYWRvYyAgICAgIG9wdDoiLS1rZWVwIDAiCiBbdHlwZTphc2NpaWRvY10gLi4vbWFuLWNv
bW1vbi90cmFuc2xhdGlvbi5hZG9jICAgJGxhbmc6JGxhbmcvbWFuLWNvbW1vbi90cmFuc2xh
dGlvbi5hZG9jICAgb3B0OiItLWtlZXAgMCIKIAo=

--------------0XtBmCMUbp0NLj76uy0ifHPe--

--------------vXYfoA5fMumZHwmpHDSb0RBN--

--------------vysyGRwH2j02cYo5JKAHA73K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmgQ2lEFAwAAAAAACgkQUUu+Lrjhlh9J
URAAt2yEmw5wUheYiwq9GGVGxYWww09QJsz4VkV/4HH02LfhzVfwa4t0JA/JNhGfEMDUr98VzyuL
kUsCn/s8R9g1vx7eVam7TJOol1Uc3d8r8ZkIJTSEmzCOxNSnJrpwPTIHueml4fNQHKlxWKfEKe4x
3oo6RB58tHb/BTKvAVv8mcynASIE43QrW9wCR0DfvuM2I2+kmdzSv+zfmVRj6WStVkv4asqqFilM
sxOzuaRyxFKPbcNomGeEkPifMWF6msGyqXZ95oRYtS9+2mNrYXh8ou7f9558RnRGkiiqEfGFQox0
L7RaQifluFePWEgWjK4cC8dVzl0og7IgWC9tNpLDJvJBAOW8OZkoOHDjGYZc8K50jWlcGhJTEG+I
feo4+kasiKQBL9HqjZlWLd+L/Y2MEZ9qn64KYZfZFP1K2t4H8nWKoOnMnBqqJP4kPA9R7JEdfxGh
BDuCd4FEtYazlqn/l5cepSl0svab2o6qgfKwVldDZXnREyDCt1owXho7CxbYDipUf+m8osbleasX
eNItTqYbbAzq6BvnLRfNN1H4gWxMkviyhtuIQcJT/6YH3CqYvgOCUDVrC7/jyRw5J5QaszzY41la
g+6U5mWfVhBaXhIJ4RaT0jqbE23dLRNHWSRVdZGKFXhSeotC3EOly9s0UEhEmxzaJesEoojSzSbS
R0o=
=gUs8
-----END PGP SIGNATURE-----

--------------vysyGRwH2j02cYo5JKAHA73K--
