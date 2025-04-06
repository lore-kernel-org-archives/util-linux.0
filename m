Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37593145FE8
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743938934; cv=none; b=rCiW7or9HmF58YVPnm6MjTv2JNkGF4Qu/mLuWOU35WEbbvtU/pNWkodNydmpvXUBVpXDE7eyXZpdslT2YZCyeivRBh7Tdukm7OM0550krkBgAEyprSyAFPIRiqFsdPP6CPDx2rm3F3tLH3wJyiCYBnKbrrXrGKP1O+zNeLN/3rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743938934; c=relaxed/simple;
	bh=UWGIdZfTiZVnuTrRBHPRtbslntdVM6Q9MI42s3NvTL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TrEG5cPLP/B1r501BAg4rz5eqarBWB1UTKMEs/y6uez/Tv7gRQin1vFkzkzA2iaGCSZAu3APTYl9p+fggZ0Uut5HT6mG05IfBLXxbIh0X6FTnQ+arN09NiPmdICByNeEQsTvjLQwATxAdG/IYyAefZCo401s5A/NB/ejMmZvbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nByYHLWY; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nByYHLWY"
X-KPN-MessageId: 64c7c9ce-12da-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 64c7c9ce-12da-11f0-bc28-005056ab378f;
	Sun, 06 Apr 2025 13:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=UWGIdZfTiZVnuTrRBHPRtbslntdVM6Q9MI42s3NvTL4=;
	b=nByYHLWYQNl22o6ux+VCK8s03LIT4a3+PdBERzG8cHVb5MS6eGJfqDXnPpFaKtWWxscqMNRPNih7d
	 o2y71jqRPGQflngKqnWUb5cqbXTordA5gPALCNqpIKbI8/Fs0ShKJeAwrmjM9FwujAkRGjtvukTjZU
	 52kamFIacN/m+4UE=
X-KPN-MID: 33|fug+Ls62/Y1zgQB09gIsKrQOYeTc8ByNPiQ4aiGrk87ENXEDrBA4YJcV3cxVmHg
 afnIrB/Ps2xBNZaLh/kkdDZZ8x5S2b39xftOkYu2p6fY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vTU3jvmg0K8/w0CC4K27ya2dDiapLinbF6SCGF/CQ4QR2Sjn/YTcC/mrmS/WqbT
 3vPFwWzNfzvzRGC81HKIlpA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4ae1974f-12da-11f0-9599-005056abf0db;
	Sun, 06 Apr 2025 13:28:41 +0200 (CEST)
Message-ID: <1383aff5-c164-433b-85b1-7d368ef424d1@telfort.nl>
Date: Sun, 6 Apr 2025 13:28:41 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Message typos in util-linux-2.41-rc2
To: Petr Pisar <petr.pisar@atlas.cz>, util-linux@vger.kernel.org
References: <Z_JbYZ-SdnjxZB0K@album.bayer.uni.cx>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <Z_JbYZ-SdnjxZB0K@album.bayer.uni.cx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZC6mkMrGNWOtVX6Q0BXQYDcx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZC6mkMrGNWOtVX6Q0BXQYDcx
Content-Type: multipart/mixed; boundary="------------Npj470SuEJUroMzklRlmZWDg";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Petr Pisar <petr.pisar@atlas.cz>, util-linux@vger.kernel.org
Message-ID: <1383aff5-c164-433b-85b1-7d368ef424d1@telfort.nl>
Subject: Re: Message typos in util-linux-2.41-rc2
References: <Z_JbYZ-SdnjxZB0K@album.bayer.uni.cx>
In-Reply-To: <Z_JbYZ-SdnjxZB0K@album.bayer.uni.cx>

--------------Npj470SuEJUroMzklRlmZWDg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIZWxsbyBQZXRyLA0KDQoNCk9wIDA2LTA0LTIwMjUgb20gMTI6NDUgc2NocmVlZiBQZXRy
IFBpc2FyOg0KPiAjIEZJWE1FOiBXcm9uZyBtYW51YWwgc2VjdGlvbjogc2V0dWlkKDEpDQo+
ICM6IGxzZmQtY21kL2xzZmQuYzoyMTk3DQo+IG1zZ2lkICIiDQo+ICIgICAgIC0tX2Ryb3At
cHJpdmlsZWdlICAgICAgICAodGVzdGluZyBwdXJwb3NlKSBkbyBzZXR1aWQoMSkganVzdCBh
ZnRlciINCj4gInN0YXJ0aW5nXG4iDQoNCkhlcmUsIHRoZSAiKDEpIiBkb2VzIG5vdCByZWZl
ciB0byB0aGUgbWFuIHBhZ2Ugc2VjdGlvbiwgYnV0IGluZGljYXRlcyB0aGUNCmFjdHVhbCBw
YXJhbWV0ZXIgdGhhdCBpcyBwYXNzZWQgdG8gc2V0dWlkKCk6DQoNCiAgIGh0dHBzOi8vZ2l0
aHViLmNvbS91dGlsLWxpbnV4L3V0aWwtbGludXgvYmxvYi9tYXN0ZXIvbHNmZC1jbWQvbHNm
ZC5jI0wyNjQ1DQoNCg0KPiAjIEZJWE1FOiBTdXBlcmZsdW91cyBcdFx0XHRcdA0KPiAjOiBz
eXMtdXRpbHMvaXBjcm0uYzpbLi4uXQ0KDQpBbGwgb2YgdGhlc2UgdGFiIHRoaW5ncyBoYXZl
IGFscmVhZHkgYmVlbiBmaXhlZDoNCg0KICAgaHR0cHM6Ly9naXRodWIuY29tL3V0aWwtbGlu
dXgvdXRpbC1saW51eC9jb21taXQvM2Q5NTczYjk4MQ0KDQoNCj4gIyBGSVhNRTogbWlzc2lu
ZyAidGhhbiBpbiBodW1hbiByZWFkYWJsZSBmb3JtYXQiDQo+ICM6IHN5cy11dGlscy9sc2lw
Yy5jOjM0MA0KPiBtc2dpZCAiIC1iLCAtLWJ5dGVzICAgICAgICAgICAgICBwcmludCBTSVpF
IGluIGJ5dGVzIHJhdGhlclxuIg0KDQo+ICMgRklYTUU6IFR5cG8gaW4gLS1zZWNjb21wLWZp
bHRlciBvcHRpb24gbmFtZQ0KPiAjOiBzeXMtdXRpbHMvc2V0cHJpdi5jOjEwMjgNCj4gbXNn
aWQgImR1cGxpY2F0ZSAtLXNlY2Njb21wLWZpbHRlciBvcHRpb24iDQoNClRoYW5rcy4gIFdp
bGwgZml4Lg0KDQoNCkJlbm5vDQoNCg==

--------------Npj470SuEJUroMzklRlmZWDg--

--------------ZC6mkMrGNWOtVX6Q0BXQYDcx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfyZWkFAwAAAAAACgkQUUu+Lrjhlh97
lBAAiGfyHmxKdk2uk66FEmSFejoY78oavyLl66qq+G5XD9jRkDkPL//e7QatiWDv/hcCyDDut1Ot
7HvvSJl6CAIgAdHYPfGGQraZ05ZwbY2BQXZqM/BC/ouaLdL2Ot/X40GeGkLtLruZ4U5LnbuFIpoS
8R1E5tROcjSgoepV+oVgK/BEP1gfzPHkJnsTN5oTuUgfZaPuh9fXJgitHK9LpSHQl/s+k5hQffYU
W01OwN//rlEGDGWM3cncOmH2KSPl1IogWMXv68TtpBbI1E2b/RYO4ue17S9JS73PqgFwkCDRRpb3
PGDp5Z/nZYBS+evCO63lSdkQ5KDg7uCklyQsyG7RIOBZ5ah6iP/XyHdxYK+tXUEFDwrRV2BHeYTa
J187iPW18rEZopuqlyw+uZq+T0Ks04qUrP2W/uuycsgYU7AUQ+9jmPKM41HUvImLnHak6y+2ZM55
QsiZPuGgcbnCnHX14D82hyVQZWb/NVJrMjp6h+iST7nhn1EXyy6rmQm0Hen46Ju01Gh69XDr4C8X
TqcyCQOHE599NW7wW1/X3ItcgxvSV8zbZU7zgbZ9UzjnTQ+qXJIOf/gNSFKgrYW6oYYmVaWMXz5R
DfZvzPTlIZxPTM4sAhzeQqHqJeilJBFYyAvS7AggVPKIXYOu0jCIN7XwDb3vrMTucIdmNLNXXC5m
MOI=
=8FKA
-----END PGP SIGNATURE-----

--------------ZC6mkMrGNWOtVX6Q0BXQYDcx--
