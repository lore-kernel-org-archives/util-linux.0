Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621D926C39F
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773330760; cv=none; b=RDM39M+Jnu8Sb2UoF7Zb60mgE4SFvTagLjgkM8bAgSEooLKiISyhXXrTEkIospYErUoH0WI4ul09m/wSlfZsvhsLQRacNJieIUPcKgO62HOluwIJ5s/VptxkzgQTeVqbQMw7COQzgI86HNEyhIRbKAvX76c3L/+hJAExiWeVVF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773330760; c=relaxed/simple;
	bh=+UmxZIDk9ebKGG/6jpVRsVNzYmm9E/5f1ppfozaryoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z66JzXugJmt6A6/ggFwQwVApyLAOjAJ3cSQ8F3GCWSfVt/a12DIn+XyBII574SGufwfFzHt4nTFfKJ8VfWsQcm6FqJXZZ7l4qQ3dsiOvyY6EktqQpBVDYGKOLgB3IwqNXTDgawsPKH0WqPntSkJ1u1Aixe4cd1vsOHpc/jbntQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cxQPYfto; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cxQPYfto"
X-KPN-MessageId: 7d8ecea8-1e2b-11f1-8a99-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7d8ecea8-1e2b-11f1-8a99-005056ab378f;
	Thu, 12 Mar 2026 16:52:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=+UmxZIDk9ebKGG/6jpVRsVNzYmm9E/5f1ppfozaryoM=;
	b=cxQPYftorftFSZdOlDQukU057Hvi8F4OAWYgzRBL7tFlBYhExHEVKtrQvVl8lg4LMdqcudxSW/HES
	 fA651558bD19oVGG3KERx/7+4f+EPYntnJXJXatW4BPmg159pxUxwp1e8WaG8zKkYN/3nQ5sLMpADP
	 7Lr0t+iHdC5yPbQ4=
X-KPN-MID: 33|vKv6r7WThfNy0ZrBhjUWUvpMXMuhYFfi8vc+QSUeYeATNKtGfqzkYLkkf4YpgYA
 O5L8uZ1XK/TrbKr3stwF0fq0HwLT9aI/q0JKVcvy6tso=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pv/UTU7mbr8NcrJc7Unq/gZ+om82YtJwGu2Bb62N6Qsux5JjEtBlbgs2U4LtuJ1
 od1e7vfrLWI+wyyqVX/7BSw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7d70189c-1e2b-11f1-bdac-005056ab1411;
	Thu, 12 Mar 2026 16:52:36 +0100 (CET)
Message-ID: <3c8222c3-9e75-4c94-9fc9-64e0c45e8596@telfort.nl>
Date: Thu, 12 Mar 2026 16:52:30 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] copyfilerange: (usage) correct the markup and improve
 the wording
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Dick Marinus <dick@mrns.nl>
References: <20260309160903.15490-1-bensberg@telfort.nl>
 <jg4hhpuwvwuxwkfaobly25qd3rjdlfizcm3jims42zse7m4zue@dqtq3ifmdggn>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <jg4hhpuwvwuxwkfaobly25qd3rjdlfizcm3jims42zse7m4zue@dqtq3ifmdggn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GsgotW9lV8VjZF4Vses25nyn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------GsgotW9lV8VjZF4Vses25nyn
Content-Type: multipart/mixed; boundary="------------rYG6Z8j59QnWRXmPmng9GoeY";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Dick Marinus <dick@mrns.nl>
Message-ID: <3c8222c3-9e75-4c94-9fc9-64e0c45e8596@telfort.nl>
Subject: Re: [PATCH 1/2] copyfilerange: (usage) correct the markup and improve
 the wording
References: <20260309160903.15490-1-bensberg@telfort.nl>
 <jg4hhpuwvwuxwkfaobly25qd3rjdlfizcm3jims42zse7m4zue@dqtq3ifmdggn>
In-Reply-To: <jg4hhpuwvwuxwkfaobly25qd3rjdlfizcm3jims42zse7m4zue@dqtq3ifmdggn>

--------------rYG6Z8j59QnWRXmPmng9GoeY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMS0wMy0yMDI2IG9tIDEzOjE0IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IE1hciAwOSwgMjAyNiBhdCAwNTowOTowMlBNICswMTAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+ICsJZnB1dHNsbihfKCJFYWNoIDxyYW5nZT4gaXMgb2YgdGhlIGZvcm0gPHNv
dXJjZV9vZmZzZXQ+OjxkZXN0aW5hdGlvbl9vZmZzZXQ+OjxsZW5ndGg+LFxuIg0KPj4gKwkg
ICAgICAgICAgIndpdGggYWxsIHZhbHVlcyBpbiBieXRlcy4gSWYgPGxlbmd0aD4gaXMgMCwg
YXMgbXVjaCBkYXRhIGFzIGF2YWlsYWJsZSB3aWxsXG4iDQo+PiArCSAgICAgICAgICAiYmUg
Y29waWVkLiBXaGVuIGFuIG9mZnNldCBpcyBvbWl0dGVkLCB0aGUgbGFzdCBmaWxlIHBvc2l0
aW9uIGlzIHVzZWQuIiksIG91dCk7DQo+IA0KPiBIbW0uLi4gZm9yIHRoaXMgcHVycG9zZSwg
d2UgYWxyZWFkeSBoYXZlIHRoZSBVU0FHRV9BUkdVTUVOVFMgc2VjdGlvbg0KPiAodXN1YWxs
eSBhZnRlciB0aGUgT1BUSU9OUyBzZWN0aW9uKS4NCj4gDQo+IFdoYXQgYWJvdXQ6DQo+IA0K
PiAgICAgIGZwdXRzKFVTQUdFX0FSR1VNRU5UUywgb3V0KTsNCj4gICAgICBmcHV0c2xuKF8o
IiA8cmFuZ2U+IGlzIG9mIHRoZSBmb3JtIDxzb3VyY2Vfb2Zmc2V0Pjo8ZGVzdGluYXRpb25f
b2Zmc2V0Pjo8bGVuZ3RoPixcbiINCj4gICAgICAgICAgICAgICAgIiB3aXRoIGFsbCB2YWx1
ZXMgaW4gYnl0ZXMuIElmIDxsZW5ndGg+IGlzIDAsIGFzIG11Y2ggZGF0YSBhcyBhdmFpbGFi
bGUgd2lsbFxuIg0KPiAgICAgICAgICAgICAgICAiIGJlIGNvcGllZC4gV2hlbiBhbiBvZmZz
ZXQgaXMgb21pdHRlZCwgdGhlIGxhc3QgZmlsZSBwb3NpdGlvbiBpcyB1c2VkLiIpLCBvdXQp
Ow0KDQpZZXMsIHRoYXQgYWN0dWFsbHkgbG9va3MgYmV0dGVyLiAgVjIgaXMgY29taW5nIHVw
Lg0KDQoNCkJlbm5vDQoNCg==

--------------rYG6Z8j59QnWRXmPmng9GoeY--

--------------GsgotW9lV8VjZF4Vses25nyn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmy4T8FAwAAAAAACgkQUUu+Lrjhlh/f
3Q//UDY9WKmXbtuXiDNatZanauw8UfwNO+i/0j6otlEHbkUE3vJPAVAe7RUWQpVu+u7dRtSdqeCy
zSSqiUTnk6IlU5pUjMq4XOY9hXsddP2dna15LWeKS/eS3D+dCLbd4fxQP52c0CnK9m9HAh12Oy+a
8zTXOgfS1xVqxS71U5ssgHe3EPAHRm+y+iRTYqCrqjdy59O58vEInLO5FwXhHPl8WpcACtFbKfne
JzHdpjHrQDttAhkOO+HAkIk9LTIU10UeBCYCPUYzoqOAiwm1P5sKwBv8MHrYqHdDBZfdqLbJGigj
Ma1WnIA4ZYbkwxN3D2wELGFC583jmLsCh930+iPEc9ejDPyDBaPmU1+PEIPBN6PD3VTjjZQJj4AW
DMdDwbcoviaU72u3cQyrK3LMT7LoPeJGCRNk5UTQ6NdLxhimB3W8kZMH81FMtqFvaNvBiwfMuP9o
uPxoQtD4TVk3KRRVpX44xZ8Xf68tcTpdOhdwf1xnoLbj0OeW2GcirpKBKHm/m4ardAKtnCRPWAda
bFxQHhr/AzAOmPxuWcjw0RoodNkz74r1Yb+byOfYD67Mu/mlQLPboUpsBqnVieCFSyAxUH26XfES
hj9LqUUtYMNkeXpoM2/PBBst2ji225nxtgL1rgYpsjLalkW0xhx4YC/oQnrm5TYQnV9+uB5S/E7n
LcQ=
=MMUJ
-----END PGP SIGNATURE-----

--------------GsgotW9lV8VjZF4Vses25nyn--
