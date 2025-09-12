Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3330E0D8
	for <util-linux@vger.kernel.org>; Fri, 12 Sep 2025 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688490; cv=none; b=edzHKw6PBsGziV5tAkOhSyfZxm9RfYMaL/m+EogSA/4y/n7PmQdejVxZ4zAWEeDSGshundwmh9IHmTri1VIBJf0yqNOYHk6dmFfqPPVGEFNA7LwmPf7akMPW3i5RO4IothFWeIGaJD+zRjzw966Z9pFwdzdzyV+LsTQetygQFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688490; c=relaxed/simple;
	bh=aurBonlltxUg0GVq40WMLjdzXnwX/sBeQpnnUH2vTkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajcuVHmfDB/q5Feg+LPzxDmQvIiDgf7EuMmi1WlzVdstLBbGC+Zck8oq8yTmg+ybJYs72d0k/09t5j/gNT6ve9cYeqZC+bZP3qAHMLt+jxMLkdWmFHfYmHqLpSG9+B4Tsa5tdhe7Kopuw7Vq5b/v3MQ0uN/J1ZvoQRZMnGHSq3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=WsKVmoTh; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="WsKVmoTh"
X-KPN-MessageId: dcda7657-8fe7-11f0-b7a7-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dcda7657-8fe7-11f0-b7a7-005056abbe64;
	Fri, 12 Sep 2025 16:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=aurBonlltxUg0GVq40WMLjdzXnwX/sBeQpnnUH2vTkg=;
	b=WsKVmoThtVrQwfB29OoBiZHJi/C4evCm600Y9zotF/SE/oH5AvzgK3IMeA8c/USk5aGddFOZw1Swr
	 iMDA9ANDwOxy6ZwC2cpQNscGjyodmOJ0rIDXga1El0ahjlvuGUP5GpwzrIdP0iTqHiH0CSQWHGMfzq
	 hHsZYCX3GqDWOkP8=
X-KPN-MID: 33|ZriwyE9Lhcb6wus2XLjpcGY0LpNu2Db+/F/BYZh+nO1oD2OVy/BtN/huvQamMHD
 QaWX+u4799Aw/kZHFVV1ATi+Uo8JD8OinmEsLYvjqt+s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|WRJwHB9k1nW/iUSJnTycaGbM2gfIQsSJLsm7ZArGFPaIH50Pd1XMg6+sW2RdKVe
 NJXtFHE/8tt9irZEAbZVUWA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 78df3113-8fe7-11f0-abc8-005056abf0db;
	Fri, 12 Sep 2025 16:47:57 +0200 (CEST)
Message-ID: <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
Date: Fri, 12 Sep 2025 16:47:57 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
 <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------V5vP2gO9Q5KcWv9rbTR3PP57"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------V5vP2gO9Q5KcWv9rbTR3PP57
Content-Type: multipart/mixed; boundary="------------rqo7ude8jPdi4z0J4JHm7TD7";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
 <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
In-Reply-To: <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>

--------------rqo7ude8jPdi4z0J4JHm7TD7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMi0wOS0yMDI1IG9tIDE1OjE4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBUaHUs
IFNlcCAxMSwgMjAyNSBhdCAwMzo1MTo0OFBNICswMjAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+DQo+PiBPcCAxMS0wOS0yMDI1IG9tIDE1OjQ4IHNjaHJlZWYgQmVubm8gU2No
dWxlbmJlcmc6DQo+Pj4gLQlmcHV0cyhfKCIgLWsgICAgICAgICAgICAgICAgICAgICBhbGlh
cyB0byAnLS1rZXJuZWwgbW91bnRpbmZvJ1xuIiksIG91dCk7DQo+Pj4gLQlmcHV0cyhfKCIg
LS1rZXJuZWxbPTxtZXRob2Q+XSAgICBzZWFyY2ggaW4ga2VybmVsIG1vdW50IHRhYmxlIChk
ZWZhdWx0KVxuIg0KPj4+ICsJZnB1dHMoXygiIC1rICAgICAgICAgICAgICAgICAgICAgYW4g
YWxpYXMgZm9yICctLWtlcm5lbD1tb3VudGluZm8nXG4iKSwgb3V0KTsNCj4+PiArCWZwdXRz
KF8oIiAtLWtlcm5lbFs9PG1ldGhvZD5dICAgIHNlYXJjaCBpbiBrZXJuZWwgbW91bnQgdGFi
bGUgKGRlZmF1bHQgYmVoYXZpb3IpO1xuIg0KPj4NCj4+IEthcmVsLCBkbyB5b3Ugd2FudCB0
byByb2xsIGFuIHJjMiwgb3Igc2hhbGwgSSBqdXN0IG1ha2UgdGhlc2UgY2hhbmdlcyBpbg0K
Pj4gcmMxIFBPVCBmaWxlIGZvciB0aGUgVFA/DQo+IA0KPiBJIHRoaW5rIFJDMSBpcyBzdWZm
aWNpZW50IGZvciB0cmFuc2xhdGlvbnMgZm9yIHN0YWJsZSByZWxlYXNlczsgd2UNCj4gZG9u
4oCZdCBuZWVkIGFzIGxvbmcgYSBzdGFiaWxpemF0aW9uIHBlcmlvZCBhcyBmb3IgbWFqb3Ig
cmVsZWFzZXMuDQo+IFRoYXTigJlzIHdoeSBJIGFza2VkIGZvciBhbiB1cGRhdGUgb24gVFAu
DQo+IA0KPiBPciBkbyB5b3UgdGhpbmsgaW5jbHVkaW5nIHN0YWJsZSByZWxlYXNlIHVwZGF0
ZXMgb24gVFAgaXMgb3ZlcmtpbGw/DQoNCk5vIC0tIG9mZmVyaW5nIHN0YWJsZSBkb3QgcmVs
ZWFzZXMgZm9yIHRyYW5zbGF0aW9uIGlzIGZpbmUsDQphcyBsb25nIGFzIHRoZSBzdHJpbmcg
Y2hhbmdlcyBhcmUgdGhlIHNhbWUgYXMgbWFkZSBpbiBtYXN0ZXIuDQoNCldoYXQgSSdtIGFz
a2luZyBpczogd2lsbCB5b3UgYXBwbHkgdGhlIHBhdGNoIChib3RoIHRvIG1hc3Rlcg0KYW5k
IHRvIHRoZSBzdGFibGUgYnJhbmNoKT8gIElmIHllcywgdGhlbiBJJ2xsIGVkaXQgdGhlIHJj
MSBQT1QNCmZpbGUgdG8gY29ycmVzcG9uZCB3aXRoIHRob3NlIGNoYW5nZXMuICAoSSBkb24n
dCB3YW50IHRvIG9mZmVyDQphIGZhdWx0eSBzdHJpbmcgYW5kIHRoZW4gc2VlIGl0IGNvcnJl
Y3RlZCBpbiB0aGUgbmV4dCBQT1QuKQ0KDQoNCkJlbm5vDQoNCg==

--------------rqo7ude8jPdi4z0J4JHm7TD7--

--------------V5vP2gO9Q5KcWv9rbTR3PP57
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjEMp0FAwAAAAAACgkQUUu+Lrjhlh9k
qQ//UW7w7XzwlhG4tfQgfcmNSf5HHAhdgyckRa+zuYr9xj4gWaHaGbO3w5bGseqcl0xjZlf998Pk
mhhD1YMGLBfS9V+wEp1ySfJkoNHAuWGc0gvzu3ai/TnqpDY7+8exTtAbm+vsBSMLb+N+VpqxuSbH
SWKZ4UM7ybW6aPCYIrA0Q09uKYLUEUoJx7X4dmsewjMIPzTM+EJPwBRd6erUxhpu8BQcCqk+Jiql
HCRi7foMtEuMVu1N56TJ2oAzB6In4VV5GIFbVal8lfRh82rMke1sshZOtKh3/mW1mvlcc7Qi3zvb
u2zQqSahl6CeA4DkTNkgvWV0luSzFZvuRyblLsjhf3Jg+ydc1/Mre5bQdMGrOZwmXkcNNt6ulHcE
sR7yYvnYrtemDNFth6EppZ/69OcGBbLW1LuzU9FabAvXAmO6ASjuinfilXI62qHSSaky/uGwQnQl
A+sA9iXImMUnbFE3trYaBCD44dJijUeXbFADhIK9OL9+xr2oLogzC1+TTqUD2iipCIjyjUZrNX/p
sbuzgPbjFuu9uTIj8y4n9SBoD5CyxQcoxaEnaae/aZEX9J6h9mDBEJwvswo5DNC6u31m7YsotChU
5eEtPS0ezI7w12mrlPK4qma4Rj85kzXrjAL1gk16tVGNb8obKynJzN/zYR3ZngPZjU44CVyOVJpR
a9A=
=l0x1
-----END PGP SIGNATURE-----

--------------V5vP2gO9Q5KcWv9rbTR3PP57--
