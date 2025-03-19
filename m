Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A7414A09E
	for <util-linux@vger.kernel.org>; Wed, 19 Mar 2025 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742399836; cv=none; b=C6RjALHKQKuKdAlRuhx7PTgRkgjK9lRcTECdbRQce/GmFciZ9hIm0P9fmS4JBVKrDbqikTKPjTcAokhQOEzZnyyR2CRh2BT3MEYf7Mmfn4KKVbq8fi17tcTtZIzmyvYg5nRmHEP3cxgeZK4owQARHoIqfgSNjSTGHfuCmc6+5lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742399836; c=relaxed/simple;
	bh=CgDOH+dXS8WA9bGmFIkv32ZBNWhVW81S7U1BwrgVsgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BlsB2V3lbdSTS9QU0tJt8iN42HoU0FQm2TnTdg4kG0OO2RUDUj6kYuw7xfwIyGfkRxJ9+pJBy5YyGFe68iUGL2y0w/xZNOmhdS12o/OvEbhdF0fBDpSu9ltDWu+/5VDkP7AfxK3b43WINo6L8/F8C8zOIHC324H/HTwPuFpU10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=S9tSbhOa; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="S9tSbhOa"
X-KPN-MessageId: db2abd4e-04da-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id db2abd4e-04da-11f0-bc28-005056ab378f;
	Wed, 19 Mar 2025 16:57:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=CgDOH+dXS8WA9bGmFIkv32ZBNWhVW81S7U1BwrgVsgA=;
	b=S9tSbhOaH/g3LhTo+9Ii0mpWFtCm3ujRBAlzwGSx8YBS9TduN5u7Mqbvr3F+PJW2mvFI9dMjjjwlk
	 Idjsu4VIDpssWSUcQtPneS8MFVS8CF/vtB5GUSPJNAFi/KI7d7LSBPqVUDYdLhExZlNGvjzRlDgYOP
	 RirLmiCXHBXZ6yUk=
X-KPN-MID: 33|gMCHvfzP6My4z6YtRlSIEkuS49kGcN6H852N+PQ0P8wEWQKLMalDKnO40Al5OBN
 +EiYxrKzNlQ35qPmsfZ927/ndxulzzs1Vtil6WqUhMs4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fQXOdWezXPY11cTgZXdHcYnbR3dt7oBxqvGr4Orb8DQG7AX3ww0z5vbjWWtbFuV
 OArlKfkH/1e2NChXiM8oTTQ==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id cd2379cf-04da-11f0-9591-005056abf0db;
	Wed, 19 Mar 2025 16:57:04 +0100 (CET)
Message-ID: <7dee12c4-9650-42be-812d-adc8a51bed80@telfort.nl>
Date: Wed, 19 Mar 2025 16:57:03 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] more: ensure that on larger terminals 'h' shows only the
 in-app help text
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250318110108.5086-1-bensberg@telfort.nl>
 <ev7vif5l3j45bcw7td4w4qehujwnrj7n2leg2y4324k4mrive5@fhd7i3wyezwg>
 <xecv6hdqkiyaaoudwlyvnxpqpyjbrqfueoe53f5euorvoefyg6@zgt43jzq6tqj>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <xecv6hdqkiyaaoudwlyvnxpqpyjbrqfueoe53f5euorvoefyg6@zgt43jzq6tqj>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------X8L95WbTFbT7BW0shzqKQXSR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------X8L95WbTFbT7BW0shzqKQXSR
Content-Type: multipart/mixed; boundary="------------XiXyh0zS0VS8wx3vGKwj80F9";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <7dee12c4-9650-42be-812d-adc8a51bed80@telfort.nl>
Subject: Re: [PATCH] more: ensure that on larger terminals 'h' shows only the
 in-app help text
References: <20250318110108.5086-1-bensberg@telfort.nl>
 <ev7vif5l3j45bcw7td4w4qehujwnrj7n2leg2y4324k4mrive5@fhd7i3wyezwg>
 <xecv6hdqkiyaaoudwlyvnxpqpyjbrqfueoe53f5euorvoefyg6@zgt43jzq6tqj>
In-Reply-To: <xecv6hdqkiyaaoudwlyvnxpqpyjbrqfueoe53f5euorvoefyg6@zgt43jzq6tqj>

--------------XiXyh0zS0VS8wx3vGKwj80F9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxOS0wMy0yMDI1IG9tIDE1OjEwIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBOb3RlIHRo
YXQgSSBhZ3JlZSB0aGUgb3V0cHV0IGlzIG5vdCB2ZXJ5IHJlYWRhYmxlLCBhbmQgaXQgd291
bGQgYmUNCj4gYmV0dGVyIHRvIHN0YXJ0IHRoZSBlbnRpcmUgaGVscCBvdXRwdXQgd2l0aCBh
IHNlcGFyYXRvciwgc29tZXRoaW5nDQo+IGxpa2U6DQo+IA0KPiAgIHN0YXRpYyB2b2lkIHJ1
bnRpbWVfdXNhZ2Uodm9pZCkNCj4gICB7DQo+ICsJcHJpbnRfc2VwYXJhdG9yKCctJywgNzkp
Ow0KDQpZZXMuICBJIGhhZCB0aGF0IGF0IGZpcnN0LiAgOikgIEJ1dCB0aGVuIHRob3VnaHQg
b25lIGNvdWxkIGRvIGJldHRlciBzdGlsbC4NCg0KDQpCZW5ubw0KDQoNCg==

--------------XiXyh0zS0VS8wx3vGKwj80F9--

--------------X8L95WbTFbT7BW0shzqKQXSR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfa6U8FAwAAAAAACgkQUUu+Lrjhlh+c
Eg//c64OshT7lWC0qLRHLnhoR8ZZkXp6eYI9NuySZRKGUV9e+ILnU8pQkjk8hoyDP6hnG1tUDbvx
3LG1Z/K69GLRUL/2tH+aINKwWMft5DVoZtbeGnedyq7kAe1pFWUmbVhHKJ3zPVvW8nhHO2PkaMiS
wBqaN7OWUSHFuxzKJp5bB0p5S9KFPUfDmKGBhxc1uLQv5MEBQUxR92niwtmDyXZbaUth3jcP10XV
aGhp06xiFVUTg/AYAlEvgN2R0MFtmbnEXyAKp0wE/GXBeUD3jy0A1Y/XUPgVvGmTuC/BWDbt1HS8
2ZuXCJ33XUdIlvYWF8rseaGszxVJoCIwz+iftyWcd1yrMlvAnaf/1AUtC8+PTp93Ohu+2ySAeRzC
gLboN0Fb/Nc6AJeEHtN1Gjf9gJICs6wfFFGwiE/9e0eMFg7X9uOIHIxlAdE0bGWB4DTEaKNAnjLD
90+IEoOBxoLBN8ljX7Pzh6lLvXcz9+rzX7CDiquB+fNtfsHBkiaYDJnVxRPi31KgMuPfxA4ZrNBG
tkeC3W3TNRJ+vut9vHHGZQWo3iFFtdGWSeJouroWjXE9PiO8l6xf3vMbYXQ8d9x1pPXjdxS3FTPc
FS9VOtyJ6OKe0A9d/jmON4VNRxxQpHZ2GA/rt8JmNmgTDS3WjYq84mOC7t7z7pqO1/gRhiRsZS1O
+hk=
=wt95
-----END PGP SIGNATURE-----

--------------X8L95WbTFbT7BW0shzqKQXSR--
