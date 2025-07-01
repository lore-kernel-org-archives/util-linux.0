Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E8148FE6
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377933; cv=none; b=oFmvVuVdQyYET1B5qiS8aovUrDpeM5yi2sw3l/fHjMn2BwmdhZjNhCWvfqfaPTcporC0aEgwoRlr1q6UQY37jYC0nK6gMyk0UMOTBxg3mZGzw29wSTtVDryJjlUPCVmV0jmmwiZ46kFzQ5mLQQGeM0wJJjetfLTCnowceMa+Ic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377933; c=relaxed/simple;
	bh=ttWYa6oq9eaFQBCSbbVgQFthdh1BNn5p2GLTiQH0ldU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q5OCoeA/8d4VZseFeg7pgSgSj0ZYSK4ZSUA2RAqkvKj1R8wlYeHDrA7rGCwNnBP2ADFjZMvySNJJZ1kpQMAegBLsBwapnPUHqHlj+irY54sVTo8oQQpe8kfMXhcu/0PsbFx/KQBZFFqpeG0txz/V6M2lQd4GFT2Q03K+0f98BmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=K94568XP; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="K94568XP"
X-KPN-MessageId: c62cbc0e-5682-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c62cbc0e-5682-11f0-b9a4-005056abbe64;
	Tue, 01 Jul 2025 15:53:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=ttWYa6oq9eaFQBCSbbVgQFthdh1BNn5p2GLTiQH0ldU=;
	b=K94568XPCwiBKfKJhrVcvlrDQbppiQ+ypvfvx1eGXARwrkZ5D959AcS8f4NCfNpxLdObOUWjpYK1U
	 ZXagO/3X8p7gbFJXFEQlY2kD+3VXpB2A1rSb4fHaIS8ioGEaHxNpCkDDrASn/kz6Wc1HhNiur0Zxwu
	 GSdBweILDeO8P2fk=
X-KPN-MID: 33|gamOijxnzypNPnpLONBL9t5BhKizgDoEY7mvn+hhzJnyCxSZoYicjrN2evPNPLg
 JbaRngXXgUw/hYMbrW1s2Gw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Rtgv6uOUZNeQyw0xP8PGDnFLXvxuVoY+ANewykEAnbgPdluEbT79ICPB6yLo0hT
 ro0MYtL5Wtm4i7YtWpe5sXg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 94e9897a-5682-11f0-95b7-005056abf0db;
	Tue, 01 Jul 2025 15:52:09 +0200 (CEST)
Message-ID: <f2a1d52d-db90-4ef5-909e-8a857b6ee233@telfort.nl>
Date: Tue, 1 Jul 2025 15:52:07 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] chrt: do not try to interpret any other option as a
 PID either
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-4-bensberg@telfort.nl>
 <500d8587-136f-46a9-b34e-ca4456f754a0@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <500d8587-136f-46a9-b34e-ca4456f754a0@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------wevJrjjO2pwLfeRudA0Bykpu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------wevJrjjO2pwLfeRudA0Bykpu
Content-Type: multipart/mixed; boundary="------------VOtnOIjo5dGXMRnRX59Grz3x";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <f2a1d52d-db90-4ef5-909e-8a857b6ee233@telfort.nl>
Subject: Re: [PATCH 4/4] chrt: do not try to interpret any other option as a
 PID either
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-4-bensberg@telfort.nl>
 <500d8587-136f-46a9-b34e-ca4456f754a0@linux.ibm.com>
In-Reply-To: <500d8587-136f-46a9-b34e-ca4456f754a0@linux.ibm.com>

--------------VOtnOIjo5dGXMRnRX59Grz3x
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMS0wNy0yMDI1IG9tIDA3OjIxIHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IE9uIDMwLzA2LzI1IDE0OjEwLCBCZW5ubyBTY2h1bGVuYmVyZyB3cm90ZToNCj4+IFdo
ZW4gZG9pbmcsIGZvciBleGFtcGxlLCBgY2hydCAtLXBpZCAtLW1heGAsIGl0IHdvdWxkIHJl
cG9ydDoNCj4+DQo+PiAgICBjaHJ0OiBpbnZhbGlkIFBJRCBhcmd1bWVudDogJy0tbWF4Jw0K
Pj4NCj4gDQo+IEJ1dCAtLW1heCBpcyBwYXJ0IG9mIG9wdGlvbnMgcmlnaHQ/DQo+IA0KPiBB
Y2NvcmRpbmcgdG8gaGVscCB0ZXh0LA0KPiBjaHJ0IFtvcHRpb25zXSAtLXBpZCA8cHJpb3Jp
dHk+IDxwaWQ+DQo+IA0KPiBJdCBzaG91bGQgY29tZSBiZWZvcmUgLS1waWQgcmlnaHQ/DQoN
ClN1cmUuICBCdXQgdGhlIHN5bm9wc2VzIG9mIGEgY29tbWFuZCBvZnRlbiBkb24ndCAob3Ig
ZXZlbiBjYW5ub3QpDQpmdWxseSBleHByZXNzIGFsbCBwb3NzaWJsZSBhcnJhbmdlbWVudHMg
b2Ygb3B0aW9ucyBhbmQgYXJndW1lbnRzLg0KU28gdGhlIHVzZXIgb3VnaHQgdG8gYmUgZm9y
Z2l2ZW4gKHdoZW4gcG9zc2libGUpIGZvciB0cnlpbmcgc29tZQ0KdW5zcGVjaWZpZWQgb3Jk
ZXIuDQoNCihXaGVuIEkgZm9yZ2V0IHRoZSBleGFjdCBpbnZvY2F0aW9uIG9mIGEgdG9vbCwg
SSBub3JtYWxseSB0YWNrIGENCi0taGVscCBvbnRvIHRoZSBwcmV2aW91cyBhdHRlbXB0LCBh
bmQgdGhpcyB1c3VhbGx5IHByaW50cyB0aGUgaGVscA0KdGV4dCwgaWdub3JpbmcgYW55IG90
aGVyIG9wdGlvbnMuICBJdCB3b3VsZCBiZSBuaWNlIGlmIHRoYXQgd29ya2VkDQpoZXJlIHRv
by4pDQoNCkFsc28sIHRoZSAnLS1tYXgnIGlzIG9idmlvdXNseSBhbiBvcHRpb24sIHdoeSB0
cnkgdG8gaW50ZXJwcmV0IGl0DQphcyBhIFBJRD8gIFdoeSBtYWtlIHRoZSB0b29sIG9idHVz
ZXIgdGhhbiBpdCBuZWVkcyB0byBiZT8NCg0KDQpCZW5ubw0KDQo=

--------------VOtnOIjo5dGXMRnRX59Grz3x--

--------------wevJrjjO2pwLfeRudA0Bykpu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhj6AcFAwAAAAAACgkQUUu+Lrjhlh/r
0hAA1QVM4IMb6J8JFCMza4vQ1b84c0d7tUjXRyPLPCTOt0wpwnrgkA+EzAMsZxiAYRCATzhE7fQi
BFTcbUa5RRLFrlX3wrwQgst7zJiR4ZMAwKzQKhV2Vtx02G4pxLzKdUBPvaGLKIK/FKzGXkOt0YZV
X9EcIgFrQROPipLxA+pYhMw2serLLjOEpGOVr975QwIf0qXXiIE8drWW2qhnECYXNnOj2h7cIwsR
B9t8pJ3ZKVQQtn/6X8HIVwiDZN5Rku74LntX8w6z3FcHYhC3oK/IXTzrI+sBj2zx9p78ZIUqyuN2
JFZT+TGPcf3QftHp+zktGQAbPUgC37TOjQVaOjYr7SSf6RLkdhmpWTAg+BCkqmn0eS9A+SKS1f8G
ejn/fednsFc4sAe30wQJj9IIz04toKP9YNUVYH1C4VMszBT3OBy/6oe+f9oFD5aFu75x9h8QyxTQ
umKBlAFP7qSK3cz2mOk5Rlxd9DhDMHux9Vpcm7+cspIremVDzeW5JjpdceJ4oZZcrXj3HkuNmN06
mhEnf7lA2sm0x60vpAzruC+O+VrsSge0cVqv7SxwKkP3eqLriexhrc800Hav1SrsdUpCke/oLQ4V
+nC0NRt+ypwVJ9QnSvpVYVb4WgZX5hzkZlCXU5KN77SaEW3n5ECv8Ojb7RdCW8ZfjMqTk3Yxq560
T2c=
=s/ls
-----END PGP SIGNATURE-----

--------------wevJrjjO2pwLfeRudA0Bykpu--
