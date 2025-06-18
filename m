Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EBD2DFF2F
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249767; cv=none; b=pXVea+/CzF9AeViAeHkbk1fWTfruLPzv2wkmB76+K9Ic48FTkU5RDpVTt7yayNiuBZrHKBv8fIO7xyqaIvNTccNbqYOJbRq57quiXzwUYORi/dsudjNNZNL8wvGaJLdKDWujrwaBItshNQc9CGaEIdSTPuIVgWWbpk8vkNDH5Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249767; c=relaxed/simple;
	bh=I0H0jH39RzSMpLh1+VJXtJJF+bFCwnG21M1Y6NQhgY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lKLoFKGmnrLXyexF3ejKr//avYC+nQ8fcjdtXfzvzdFMisOm//6cfBT85zIY0IFuq2QeTjcxbnKABLPBZ/BX8ZQO9EE5fmPnCJew/XGXTvJnhGRX4wJoiAJcvpnJuLioL2jO6T7V79ONhnGe+Z9F4DeBB9UgOMhqdCSTtHScOQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=c8rZSTbW; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="c8rZSTbW"
X-KPN-MessageId: f8fd638a-4c3f-11f0-bc2d-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f8fd638a-4c3f-11f0-bc2d-005056ab378f;
	Wed, 18 Jun 2025 14:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=I0H0jH39RzSMpLh1+VJXtJJF+bFCwnG21M1Y6NQhgY0=;
	b=c8rZSTbWbAgu2yqKxnxsOsQZjyr5nc29aMiqdPSBBPLtlsBi3Wcg/EwRw2kfKVj30Fp4c91onnd8K
	 tO3TOkQSziCar33xQ55juwNDRRURnu7MgUF285ODZnft8RM9u0N9XNANCb8qWcA38xUCSF/cc4pviM
	 zs29aO8/BJBHwT/o=
X-KPN-MID: 33|iQLn/ZV4GbMZLCACdr3QA1GL+ZopSJWDncG1jGWjqH7cQ6jyj74ly1t7WSHe+85
 HdJBIh8ywqyo3wFFkdSvTYmX+vzzQ6k5Hay3ggiiB3lA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ipqM9otbwNhWtXyMCoNUOIygJtMReSkRWgjKln8D7ol42llFvm5uQ+A6f06Qb2U
 k5u2v0mJfB7zZ8bA2Pb5ElA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id dc6eafb8-4c3f-11f0-9c0a-005056ab1411;
	Wed, 18 Jun 2025 14:29:21 +0200 (CEST)
Message-ID: <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
Date: Wed, 18 Jun 2025 14:29:20 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------z7850qavebR7E4B99ruprhYM"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------z7850qavebR7E4B99ruprhYM
Content-Type: multipart/mixed; boundary="------------0stBIruqyxXuT2esoYpj0mtq";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
In-Reply-To: <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>

--------------0stBIruqyxXuT2esoYpj0mtq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxOC0wNi0yMDI1IG9tIDExOjUxIHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IE9uIDE4LzA2LzI1IDE0OjQ4LCBLYXJlbCBaYWsgd3JvdGU6DQo+PiBPbiBXZWQsIEp1
biAxOCwgMjAyNSBhdCAxMDoxODoyOUFNICswMjAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3cm90
ZToNCj4+Pg0KPj4+ICAgIEdldCBwb2xpY3k6DQo+Pj4gICAgIGNocnQgW29wdGlvbnNdIC1w
IDxwaWQ+DQo+Pg0KPj4gSSByZWFsbHkgZG9uJ3QgbGlrZSB0aGUgdXNlIG9mICItcC4iIFdl
IHNob3VsZCB1c2UgIi0tcGlkIiBldmVyeXdoZXJlDQo+PiAoaW4gLS1oZWxwLCBtYW4gcGFn
ZSwgYW5kIGV4YW1wbGVzKS4NCj4gDQo+IEkgY2FuIHNwaW4gb2ZmIGEgc2VwYXJhdGUgcGF0
Y2ggdG8gY29uc2lzdGVudGx5IHVzZSAtLXBpZCBpbnN0ZWFkIG9mIC1wDQo+IGluIHRoZSBo
ZWxwIHRleHQsIG1hbiBwYWdlLCBhbmQgZXhhbXBsZXMuDQoNCkl0IHNob3VsZCBhbHNvIGRy
b3AgdGhlICJbb3B0aW9uc10iIHBhcnQgZnJvbSB0aGUgYWJvdmU6DQoNCiAgICAgR2V0IHBv
bGljeToNCiAgICAgICBjaHJ0IC0tcGlkIDxwaWQ+DQoNCkFzIEthcmVsIHNheXMsIHNwZWNp
ZnlpbmcgYW4gb3B0aW9uIGxpa2UgLS1vdGhlciBvciAtLWZpZm8NCnNob3VsZCBhbHdheXMg
YmUgdW5kZXJzdG9vZCBhcyBhIG1vZGlmaWNhdGlvbiByZXF1ZXN0LCBub3QNCmFzIGFuIGlu
Zm8gcmVxdWVzdC4NCg0KDQpCZW5ubw0KDQo=

--------------0stBIruqyxXuT2esoYpj0mtq--

--------------z7850qavebR7E4B99ruprhYM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhSsSEFAwAAAAAACgkQUUu+Lrjhlh+T
+RAAhSkEm7YbzrFl9sX3JESEZNPIDvZVioNilw+nZG+FwLqhmYvqmcp1fqZu8NKpdOI2GrXsKoWv
/x35AfC++66uYYwGZVvxIXcZiG8cTNHC8CNjD1va5e/dmXRuSmAW51qqljDdFPYtjxiIBqFVwUnD
ox5ox8kZcdZ1CLP0iVpaEeZU+ASL55D9VzferEJJUNUm5FHX6JXsb4O2QrsOR2wVs3p8nB21PvIO
DIDmNxRlH9zyD9UU4XOGlvY6KHSSOg9r6BrnHC8DkjXMWcnuHzsn5PQ664LEENEZWZkAg5y7lros
oFqxSVtNms7DqYwcKC0Cd4MCvw7Qb1HJ0mLw+qXQNGQRY7EAJhDGCJnUeyPhMk2kDtmmvV20vJpA
tUtTptT8Ko0bDVU5UbtsfhnbL66Yb2r+rjFgfGAKTDsQclqQeIs1VR6NSfs0w3KwkhNAQgy6jG/E
3QN6amtiMDc+/LoDQvOzWXRuJYTlrANz+oQbvXg81IdujJbpTGP/T0OnMO5p9D4tawsbg62jlmEu
aU09E/fuV3YWQc6HPZT53HokUuTXjM9UOQyL+z80n/Rk+QKtRA7v8Z81roQkG8ns7fDlwWFvZ4AW
8rypiOTOnEgzVVA7rSENUMYGXEM9PP1rdsnpKhQNodXssGCZ3/njishcYyVzc3Wi4SZHU4Vs9fV6
jbk=
=jMJT
-----END PGP SIGNATURE-----

--------------z7850qavebR7E4B99ruprhYM--
