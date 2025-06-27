Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57D214801
	for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751024026; cv=none; b=B7gxgaqbaB5LuHbvZag2zJBgXsfDigxAsXm5rYXh3ZYpk7xz0VRA5AVuSzOc2sXDFKqHsivtzIjgVxAWMQQ8MJRA25dn4pwUjQ02GIfF+ui9DwqvITpfvSb0OGAXo71S2bxjMLd1hyQ4w8ADjQ6vkcMrOSFHKKoB8gaW+yMFR8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751024026; c=relaxed/simple;
	bh=+xFYLtP0nF431RpHNEXuk1r+47LBjSczY+wUP+1px5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Huc3GSjxhAepzB5acLmmqiLWP6O04YllRqpb8+E1h1kWC3f5xwR7nBvcCL0hIyMFPIQLqcanvf6u0qIWiHz592esO6e9HA9vRGzaRvEIAcgPF5eCcxDUBbgVokBHXDqBpsyX//1YqP7lD132NSRA82lmmBNmnlfd/kybvOJuNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=LxmPS2s6; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="LxmPS2s6"
X-KPN-MessageId: 8514f27b-534a-11f0-a832-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8514f27b-534a-11f0-a832-005056abad63;
	Fri, 27 Jun 2025 13:33:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=+xFYLtP0nF431RpHNEXuk1r+47LBjSczY+wUP+1px5s=;
	b=LxmPS2s6usm/V6hkLz7IT1nX0bqPTKgKj+m2AtFdgN0Rx3R1E9Mk6Ce1yXCzJlANWh1J7hmernWC1
	 cGrV5Y7r8mzRyfFU1ZBVCCwh19X9iuLdisSCDA5JS3zurI1IVorRClpT/2O7xWZNYfVb5imGTS8/kO
	 4qlj8mG4dvIKqdM0=
X-KPN-MID: 33|4GJMZf0ENV/wU3z3IZEM8bVMgTy0p6bQ9fYGpeWvhu27T3e9EVKltQpD8NzNjRh
 kpO7rtK+eV+uYwHHOpB6WPQhPKXWu3r7ZMFYwIj6FAo0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|l3AxHDogvKWCtGIyXwGlS5LFhyVZOxHwUcuPo6K4o/gc8SwHXfy6EC8dtbo4brH
 pQ3yO+7v687BaXbf2ehJV7Q==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 6a89e8e6-534a-11f0-9c24-005056ab1411;
	Fri, 27 Jun 2025 13:32:33 +0200 (CEST)
Message-ID: <568493ee-0541-46e5-bd3c-b916af454808@telfort.nl>
Date: Fri, 27 Jun 2025 13:32:32 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chrt: when more than one argument, interpret first
 argument as priority
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250626112743.9862-1-bensberg@telfort.nl>
 <9a721a20-0836-44db-b0cc-7d48f853318c@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <9a721a20-0836-44db-b0cc-7d48f853318c@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0se5lFeK40eBoetKiO5dem2U"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0se5lFeK40eBoetKiO5dem2U
Content-Type: multipart/mixed; boundary="------------sBnOyeQ9w70v05NDnbg4qPBq";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <568493ee-0541-46e5-bd3c-b916af454808@telfort.nl>
Subject: Re: [PATCH] chrt: when more than one argument, interpret first
 argument as priority
References: <20250626112743.9862-1-bensberg@telfort.nl>
 <9a721a20-0836-44db-b0cc-7d48f853318c@linux.ibm.com>
In-Reply-To: <9a721a20-0836-44db-b0cc-7d48f853318c@linux.ibm.com>

--------------sBnOyeQ9w70v05NDnbg4qPBq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNy0wNi0yMDI1IG9tIDEwOjM4IHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IE9uIDI2LzA2LzI1IDE2OjU3LCBCZW5ubyBTY2h1bGVuYmVyZyB3cm90ZToNCj4+IFRo
ZSBmaXJzdCBhcmd1bWVudCBpcyBhIHByaW9yaXR5IG5vdCBvbmx5IGZvciBgY2hydCAtLXBp
ZCA8cHJpbz4gPHBpZD5gDQo+PiBidXQgYWxzbyBmb3IgYGNocnQgPHByaW8+IDxjb21tYW5k
PiBbPGFyZ3VtZW50Pi4uLl1gLg0KPiANCj4gR29vZCBjYXRjaC4gU0NIRURfUlIgaXMgaW5k
ZWVkIHRha2VuIGJ5IGRlZmF1bHQgd2hlbiBubyBwb2xpY3kgaXMgZ2l2ZW4uDQo+IA0KPiBX
ZSBjb3VsZCBhZGRyZXNzIHRoaXMgYnkgaW5pdGlhbGl6aW5nIGBuZWVkX3ByaW9gIHRvIGB0
cnVlYCBieSBkZWZhdWx0LA0KPiBhbmQgdGhlbiBzZXR0aW5nIGl0IHRvIGBmYWxzZWAgaW4g
dGhlIGNvcnJlc3BvbmRpbmcgc3dpdGNoIGNhc2VzIGZvcg0KPiBwb2xpY2llcyB0aGF0IGRv
bid0IHJlcXVpcmUgYSBwcmlvcml0eS4NCg0KV2VsbCwgdGhhdCBjaGFuZ2UgaXMgcmVkdW5k
YW50IHdpdGggbXkgcHJvcG9zZWQgY2hhbmdlLg0KDQpBbHNvLCBzZXR0aW5nICduZWVkX3By
aW8nIHRvIHRydWUgYnkgZGVmYXVsdCBnaXZlcyBhIHNvbWV3aGF0IHdyb25nDQppbXByZXNz
aW9uLCBiZWNhdXNlIG5vIHByaW9yaXR5IGlzIG5lZWRlZCB3aGVuIG9ubHkgb3B0aW9uIC0t
cGlkIGlzDQpnaXZlbi4NCg0KV2hhdCB5b3VyIHByb3Bvc2VkIGNoYW5nZSBhY2NvbXBsaXNo
ZXMgaXMgdGhhdCB0aGUgZXJyb3IgbWVzc2FnZQ0KZm9yIHRoZSBtaXN0YWtlbiBgLi9jaHJ0
IHNvbWVjb21tYW5kYCBjaGFuZ2VzIGZyb206DQoNCiAgIGNocnQ6IHVuc3VwcG9ydGVkIHBy
aW9yaXR5IHZhbHVlIGZvciB0aGUgcG9saWN5OiAwOiBzZWUgLS1tYXggZm9yIHZhbGlkIHJh
bmdlDQoNCnRvOg0KDQogICBjaHJ0OiBiYWQgdXNhZ2UNCiAgIFRyeSAnY2hydCAtLWhlbHAn
IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KDQpJIHRoaW5rIGJvdGggZXJyb3IgbWVzc2FnZXMg
YXJlIGVxdWFsbHkgcG9vciAtLSB0aGUgZmlyc3QgaXMgcHV6emxpbmcsDQp0aGUgc2Vjb25k
IHRvbyB1bnNwZWNpZmljLiAgSXQgd291bGQgYmUgYmV0dGVyIHRvIGNvbWJpbmUgeW91ciBj
aGFuZ2UNCndpdGggbW9yZSBzcGVjaWZpYyBmZWVkYmFjaywgZGVwZW5kaW5nIG9uIHdoZXRo
ZXIgLS1waWQgd2FzIGdpdmVuLiAgSSdsbA0Kc2VuZCBhIGJldHRlciBwYXRjaCBuZXh0IHdl
ZWsuDQoNCg0KQmVubm8NCg0K

--------------sBnOyeQ9w70v05NDnbg4qPBq--

--------------0se5lFeK40eBoetKiO5dem2U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhegVAFAwAAAAAACgkQUUu+Lrjhlh+q
3Q//YXuBWVC32gffoK24cpc6EsoqVRUL9jOMjom/pE7etPHIQH5ICHnEVou2/dBjVyk/YV8jOoXr
f20MuPBBGMdxNWSBzyGLoKhipoo4oqsNqamoCwSs6D9gysd1XL5xvp1YLhdnlzhDup7Xym/vNGHY
DyWIRPTJIsAYU1aCFY17In8Go9OU4j5PB2dqw6QtKkTYbwTw9QNNMzXNvtqybTJMA0Nw3xGUhXj0
0Bl6kvZABcHJRV+YVh2PR8+UYPbHGJ5nE+HxR+OQ+EQv5O5u/eB3neMc/4WbI+Q6ZwmQFGAuso2y
7iPN0N5SKtKe/lmCbzmSl54f48B5enABT0a7I2rOdUjM70Ay+MsTIH8QdbW+lV+LP00ViH3FQ9fZ
81TYxmWpZfw0/zNqP3QJzbl5Bs1wxGR5MXL7Ra6s2nttpuev/XRny08PfooJXI1NzJPohjnZr+BT
gO9sNEMxYU1mExiXbzanVUOATpHDe1pT9F/301s1bc8bIUaF0ZyYmvxIRpqmRR4T9Zj7pqDhfDz2
ZUNk5wdsM546qhSpmzF5yCJBdRToY8kDXql5T1Wa+iy+QQin9JkaDKzumdl2jBayJayDJ7weFUP1
SPo+LKjo5+SKg/nrg1JtElTHbvxcDejeAmTqwVoPMaOijG1THucxFFn/aGHtsNVUV7a/Ude6TWuU
1xw=
=WzIB
-----END PGP SIGNATURE-----

--------------0se5lFeK40eBoetKiO5dem2U--
