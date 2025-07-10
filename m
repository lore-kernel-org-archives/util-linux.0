Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489728B7FC
	for <util-linux@vger.kernel.org>; Thu, 10 Jul 2025 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135130; cv=none; b=QbKqsO3RZhxboi7HjgNiTR3hWZ0K4UDuvL/LI8BiTN2cMN/uiwOESH8SUBE9NytaMcnPw87lI54UecS/cInqcHqBGx8Fr5X48G36hV3f3dY03WYu3eNgT7iz2pk3SXkPOk3l1eAE5iO/wMq1fNFuLZpJGJnnEW23OMnFcVV0Hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135130; c=relaxed/simple;
	bh=+F+4rfUyWjp/qRuQ2Am98cH94v7ovivyuOW/93dXWUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJmNxI9KnPn1nUcXUp0JL42t6IgDfJtCN9Z2rn24WRUDIvLh+DdNMCbHlUT4nk2HDji/F0cWv4kLsPm3oFOrrx7PJVZpiuPwZHwSkverUgPZFuc+iUQdU+VPFbVrEjGHXZwkVoO59PswiPIJTmvh+NyyD5WQnRBfyniXP74YXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=lg6SYXiI; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="lg6SYXiI"
X-KPN-MessageId: c3e045d0-5d65-11f0-86d5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c3e045d0-5d65-11f0-86d5-005056aba152;
	Thu, 10 Jul 2025 10:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=+F+4rfUyWjp/qRuQ2Am98cH94v7ovivyuOW/93dXWUU=;
	b=lg6SYXiIb6Cbi56KXN/tMjOdXe9oyM7yOXnKcdfcI8WoHp7PShzvbwzBiCaWB/988lpuNRSiBf0qW
	 0shOCvbVV5F22TgL0ifhsmtcdhN+BQWMyo5rgXgdsODs7Ds+JL73WrkwvUd/0a1ec5dZZywEuKriY6
	 RRMBVp5Oo2npY3ko=
X-KPN-MID: 33|CkbU0zid2K0zQqEiIsHwIL3Cf16hfjRAJ69u14QJ6KKjXr+kJZHuyCPJa04GPs9
 tm0rLjHZCZYONZR7fLttZtobT4ViK8fZKc0B2dXWrHBg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|e7Pvn+wSJl2VDiTMsf1tpa/f3hNctIZMcODQPmNtnflXurCeTk0c7NsrjXXyjBi
 SLRy+l+sH5K4791o4TaH1fw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8cd32ff7-5d65-11f0-95bb-005056abf0db;
	Thu, 10 Jul 2025 10:11:58 +0200 (CEST)
Message-ID: <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
Date: Thu, 10 Jul 2025 10:11:58 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chrt from git segfaults
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Rq8reOOJIe08DUVRAshtEabC"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Rq8reOOJIe08DUVRAshtEabC
Content-Type: multipart/mixed; boundary="------------hkHiD2U7P3NQ0gQAqHkPOIeM";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Message-ID: <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
Subject: Re: chrt from git segfaults
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
In-Reply-To: <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>

--------------hkHiD2U7P3NQ0gQAqHkPOIeM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwOS0wNy0yMDI1IG9tIDIwOjQ1IHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IENvdWxkIHlvdSBzcGluIG9mZiBhIHBhdGNoIHRvIG1ha2Ugc3VyZSB0aGUgcHJpb3Jp
dHkgYXJndW1lbnQgaXMNCj4gb3B0aW9uYWwgZm9yIHBvbGljaWVzIHRoYXQgZG9u4oCZdCBu
ZWVkIGl0LCBldmVuIHdoZW4gLS1waWQgaXMgbm90IHVzZWQ/DQoNCk5vLiAgWW91IGJyb2tl
IGl0LCB5b3UgZml4IGl0Lg0KDQoNCkJlbm5vDQoNCg==

--------------hkHiD2U7P3NQ0gQAqHkPOIeM--

--------------Rq8reOOJIe08DUVRAshtEabC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhvdc4FAwAAAAAACgkQUUu+Lrjhlh9i
BhAAoO2btkBNw1YgeHKwICIIG4Fr3Ngba5TyQ6LC0ya/AQvpP4HzYcDuyVmmmM1D4QSmW/+v+Z6i
qZFeAxBxeg/k5PY3PsHNgfNiYC/Edo2JzD7HW740vXDVwAkuC8zHBnG3WzSlEFpqiyUU34zSLZSL
wC8IBGKq2kXJ6Dkg5LO73QKsgCRCp4l3J1BbV8x+JYgMKT+mkSdI2D8nFFLXh0/6rkv4Ymo7Btx/
/onucWH2MU4IztzO+jQN5rvUcecm17MPVOFU4B0xhUdGF4YoCVYpzw9X33V0QGo/tUq4yoE7E2/I
A+qVCJ9MazVFY7+0eAn89BbyeYqXDz1Om7Hj96dyOTO2O4NWWYgcFk4jp+qr1nk5yDlCm8rtVzmg
fZgdEEh1NfYSPzGP9Z/9Kuuu98OCcZa+W4B2Keha4DdCNaAcWloonUPOLAtPRxgz6eP+V312sW+Q
cKAtAOq2Es5UnDYgdp3CmLt9dBxjfvUy9TomVqcqqrduUUHJ3oHoRMjwEzkknca848WwJT9Xgq8E
OSKQ2G2+vGoHHNNU55Szv3op3XHvT7EBcxnNNPnuKPeQjKRmqi2Bccr5dbTt9zc36+5zq60fUHYZ
hsj8OrAjYWBKJAKkp6WtnD4VmYPKBRT9pYrUdpzxJZ0FqpBaaSuuJtKMetQ/gDUdzUGVPyCZ6gl5
FQY=
=mVcu
-----END PGP SIGNATURE-----

--------------Rq8reOOJIe08DUVRAshtEabC--
