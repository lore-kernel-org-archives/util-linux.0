Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E151281503
	for <util-linux@vger.kernel.org>; Mon,  3 Nov 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180982; cv=none; b=HOokEtrhDroIfOGlgCQ/18QLba/jr3MrrV2RMan5Iu7tyCrpv11lxORHxPjPyC+zg0zqKKaPO3c2ZR/6Fi4yDL3oYpN6txZyXO7DaK0PZuai4EgjHmvF68QLZEjwyOzwILiNeLvhsnnU5+mGSD+WUOKncJoQ6UFE6oWpRFt4ub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180982; c=relaxed/simple;
	bh=ewQAy/AphAG+H9Zx5EzTmi3ciAwkElm3081kRtIgAEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYNd6J/ZqoQr0kit4GhRS5vhshD1WE8D3cui7LIUkSDvWScChK3Wy8gN2fmE2jhfIxBCCLBI2dur9jwx9yt5FiLcAyJjk7zIYbq6yKHiQhEmXqlhuHXmh1ODMmDLJbQJEWpmgfRU6enDX0AZQUeobvW8XhMG/ODsrNF160IjdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=kJnh5NIg; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="kJnh5NIg"
X-KPN-MessageId: 8aa5757f-b8c3-11f0-9c78-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8aa5757f-b8c3-11f0-9c78-005056ab378f;
	Mon, 03 Nov 2025 15:44:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=ewQAy/AphAG+H9Zx5EzTmi3ciAwkElm3081kRtIgAEU=;
	b=kJnh5NIgrDxDm7XCZWTeMkoNYhEU4ezcRsaMpwBysbt96Vb3XYjIvOJJTQbAB7yoiJLhpiGx+JBMh
	 tvaTvLp0/3o0fsLt1YrOmxwLC+Su4Q1MLRTirMnI6zhQSH6/YrjBVDcjJWMKgY3yV8i73+7Eqpk1jW
	 Dp4C6k6jCCB8BivI=
X-KPN-MID: 33|oSHaR/OgQW2eekJrIWEH+pWjjDe7+Icm9RfZPUrVD5v89ZRUEAr6NGyrnZToR9s
 j9JOcDqIgsD4Ah/xzm3Bo6aM9uTl8ZcJ4xz/UjqA5RqE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|o8H03CR2eeJpkppjWDMwhDNlzIWcLfoyUgEaGoBOfHQXpn5+EodrXHSf4y5Xk5J
 I70Nr8eHuvo1SlgLXfAxJDQ==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5f840a39-b8c3-11f0-a6c9-005056abf0db;
	Mon, 03 Nov 2025 15:42:51 +0100 (CET)
Message-ID: <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
Date: Mon, 3 Nov 2025 15:42:50 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
 <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
 <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TqZ1aCs0UR43a7OmKHWf9LLg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TqZ1aCs0UR43a7OmKHWf9LLg
Content-Type: multipart/mixed; boundary="------------DVP6jRhP7RzNBQevhT2cqEiU";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Message-ID: <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
 <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
 <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
In-Reply-To: <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>

--------------DVP6jRhP7RzNBQevhT2cqEiU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMy0xMS0yMDI1IG9tIDEzOjQ5IHNjaHJlZWYgS2FyZWwgWmFrOg0KPj4gICAgIyAu
L2xvc2V0dXAgLS1yZW1vdmUgLS1maW5kIC0tYWxsDQo+PiAgICBsb3NldHVwOiBvcHRpb25z
IC0tcmVtb3ZlIGFuZCAtLWZpbmQgY2Fubm90IGJlIGNvbWJpbmVkDQo+ICAgDQo+IEltcGxl
bWVudGVkOg0KPiAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS91dGlsLWxpbnV4L3V0aWwtbGlu
dXgvcHVsbC8zODM1DQoNClRoYW5rcyEgIEhvd2V2ZXIuLi4NCg0KCWZwcmludGYoc3RkZXJy
LCBfKCIlczogb3B0aW9ucyAiKSwgcHJvZ3JhbV9pbnZvY2F0aW9uX3Nob3J0X25hbWUpOw0K
CXVsX3ByaW50X29wdGlvbihzdGRlcnIsIHN0YXR1c1tlXSwgb3B0cyk7DQoJZnB1dHMoXygi
IGFuZCAiKSwgc3RkZXJyKTsNCgl1bF9wcmludF9vcHRpb24oc3RkZXJyLCBjLCBvcHRzKTsN
CglmcHV0cyhfKCIgY2Fubm90IGJlIGNvbWJpbmVkLlxuIiksIHN0ZGVycik7DQoNCkZvciB0
cmFuc2xhdGFiaWxpdHksIHRoZSBhYm92ZSBzaG91bGQgYmUgbGlrZToNCg0KCWZwcmludGYo
c3RkZXJyLCBfKCIlczogb3B0aW9ucyAlcyBhbmQgJXMgY2Fubm90IGJlIGNvbWJpbmVkIiks
IC4uLik7DQoNCg0KU2VlIGZvciBleGFtcGxlIGBpbmZvIGdldHRleHQgcHJlcCBwcmVwYCwg
c2F5aW5nIHRoYXQgdHJhbnNsYXRhYmxlIHN0cmluZ3MNCnNob3VsZCBiZSBlbnRpcmUgc2Vu
dGVuY2VzLg0KDQoNCkJlbm5vDQoNCg==

--------------DVP6jRhP7RzNBQevhT2cqEiU--

--------------TqZ1aCs0UR43a7OmKHWf9LLg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmkIv2oFAwAAAAAACgkQUUu+Lrjhlh9D
+hAAwYDescLvqzl5A9b1nL05zlBrnH0f+jARL4/yFjrFFQQRq/pkTFYdoevyZA/a+khAWFmL1bIr
I2/Jo1sihtlVjXznuZ+evhLvvtO1JsXi7+EMnVjHqEBtiulbWx3NsVKa9Na78YInF2XYgLU+cHYO
nOszQKSt/H8o6O4C6WJvqgl5NGzX+YcjmwBzG4ZTEvaHbWKJ1rHoGVnZFdfobo6J1ro7JyKJG0gn
2nUhf/cg8J8+BOoebjM35oV03Qv8GTZKfyiiFf2YqF1wB66Cwh72HssCMkVyp1NQn0k+56BGWPyD
JkKrtK/odTSkU7ePA/sf9R4suqU/P1Ai7DnfPXta8HBKPEKxiKHepoF377WfcKTjAHnGv5/bSIlN
7rHszK5kGVkFldRkTqL4btbLbv6KhsL4I6EmskvPkhwn4A5hMRFMbvzIeip1CjgYDOuHBZxrTdbm
+WEIQfCg0zXdcwULI7mxBhfdBb4eH4pTpaEN7N6ZqUp7hw9TdyOzGLy4mu0LPEydOcVl39teXvio
sAtWA79pcuT+JJpukhWputURIvc+24opIQE0/lDSJModIWDO8SgYTwMAAfdGMzt+jiQSmWl6cgUX
6eFZZhZjGqBwZ2bZpEBqigRNX3P1DBTRtSKOf3K7/YcxfwqD7Lsf7g+6RQeQmFkjxFlJQ5V5kSVb
100=
=g4lA
-----END PGP SIGNATURE-----

--------------TqZ1aCs0UR43a7OmKHWf9LLg--
