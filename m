Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1DE3D3304
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070880; cv=none; b=baGoSCDCnrofMQSYY8fz6HTjIZp2ilYp/1MMJlpF5C0g9w64a+n7bHPaskkqcBxnHQvmUZsI8VaP5SyEx1lHOWFgGP3khQAhqxsJIRgdupcXapT/gwdX/p6xLaVVaR/DfweV2Glke0NLu+S6jXuoXkhPxN3CPb+C9nqY/FOKxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070880; c=relaxed/simple;
	bh=+nqPDrioqAHf/jW2oBsTALjK1vt96nYndRyX9TGQTQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMqzf/JOmOxEjhJxyR+4NCPWr77Chup7c48ssxJ61ncfVKMeLsuYIwZLX1SMHKYv1ipIoSRDabhlh3wgujSwsQyggCbTmE4GWNWHEtC76EDhKJS2QvoQaAv431Ao9Sq3ldv2sC8lixxJXS2HxP7GR1FLw+soXCtHeuycVx37x5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=inEqwSy/; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="inEqwSy/"
X-KPN-MessageId: 6566be06-1bce-11f1-92a5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6566be06-1bce-11f1-92a5-005056aba152;
	Mon, 09 Mar 2026 16:41:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=+nqPDrioqAHf/jW2oBsTALjK1vt96nYndRyX9TGQTQw=;
	b=inEqwSy/zXe3FsVBprZH0zSBk+fOimdPH5FYEhVCHP1RyzNqYV2MwGOyY9Ln89bG84GyobKPP1CxZ
	 cjpGWxSYFchYygb6yGnPdeeixNMT1YwbTmZFWDl45uhs9tCJZC/w1NLhslr6/u/eirCcx12oENOwUv
	 FWZP2HmJFK7CQl3A=
X-KPN-MID: 33|D1fb5fl4ElwhjTysstkTVHpTqg7+RIoMR54jSEdpIBsJoKQOSrkkJoeUoU5F++k
 cNtGQV8rqMLXXev+8JE6TJm3xaUuQ2HMgAeV2HPNmtiI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|y/jyl2E0gt1QY+fT77bDI2vn50BeBuZmsh6FUZoCZIkgLPoTTYdeMPq/FkrOreo
 B8bRilTX13IqmchdYKsZMsg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 65450675-1bce-11f1-bdab-005056ab1411;
	Mon, 09 Mar 2026 16:41:10 +0100 (CET)
Message-ID: <88f53bc1-a59a-46b3-9687-06eac7a957c7@telfort.nl>
Date: Mon, 9 Mar 2026 16:41:09 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oD9MDWt4mAO030yVZFa58PZ9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oD9MDWt4mAO030yVZFa58PZ9
Content-Type: multipart/mixed; boundary="------------0rLGt1Dp21f1iK5pBwVmAit8";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Message-ID: <88f53bc1-a59a-46b3-9687-06eac7a957c7@telfort.nl>
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
In-Reply-To: <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>

--------------0rLGt1Dp21f1iK5pBwVmAit8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwOS0wMy0yMDI2IG9tIDEzOjM2IHNjaHJlZWYgU3VtYW50aCBLb3Jpa2thcjoNCj4g
VGhlIHRhYmxlIGlzIHVzZWZ1bCBiZWNhdXNlIGNvbmZpZ3VyYXRpb24gYW5kIGRlY29uZmln
dXJhdGlvbiBzdXBwb3J0IG9uDQo+IHMzOTAgaXMgc3RpbGwgcmVsYXRpdmVseSBuZXcsIGFu
ZCBpdCBkb2N1bWVudHMgdGhlIHBvc3NpYmxlIHN0YXRlDQo+IGNvbWJpbmF0aW9ucy4gVGhp
cyBoZWxwcyB1c2VycyBpbnRlcnByZXQgd2hhdCB0aGV5IHNlZSBpbiBsc21lbSBvdXRwdXQu
DQoNCkkgZG9uJ3QgdGhpbmsgc28uICBUaGUgaW5mb3JtYXRpb24gdGhhdCB0aGUgdGFibGUg
Y29udGFpbnMgaXMgZXhwcmVzc2VkDQplYXNpbHkgaW4gdGhlIHNpbmdsZSBzZW50ZW5jZSB0
aGF0IEkgcmVwbGFjZWQgaXQgd2l0aC4NCg0KPiAqIFRoZSBpbnRlbnRpb24gaXMgdG8gc2hv
dyBwb3NzaWJsZSBtZW1vcnkgYmxvY2sgc3RhdGVzLg0KDQpBbGwgc3RhdGUgY29tYmluYXRp
b25zIGFyZSBwb3NzaWJsZSwgZXhjZXB0IHRoYXQgYmxvY2tzIGNhbm5vdCBiZSBvbmxpbmUN
CndoZW4gdGhleSBhcmUgZGVjb25maWd1cmVkICh3aGVuIHRoZSBzeXN0ZW0gc3VwcG9ydHMg
ZGVjb25maWd1cmF0aW9uKS4NClRoYXQgaXMgd2hhdCBteSByZXBsYWNlbWVudCBzZW50ZW5j
ZSBzYXlzLg0KDQo+ICogVGhlIHRhYmxlIGlsbHVzdHJhdGVzIHdoZXRoZXIgYSBtZW1vcnkg
YmxvY2sgaXMgY29uZmlndXJlZCB3aXRoDQo+ICAgIG1lbW1hcOKAkW9u4oCRbWVtb3J5IGlz
IGVuYWJsZWQgKHllcy9ubykuDQoNClRoaXMgbWFrZXMgbm8gc2Vuc2UgdG8gbWUuDQoNCj4g
KiBVc2VycyBtYXkgY29uZmlndXJlIGEgbWVtb3J5IGJsb2NrIHdpdGggbWVtbWFw4oCRb27i
gJFtZW1vcnkNCj4gICAgZW5hYmxlZC9kaXNhYmxlZCBhbmQgYnJpbmcgaXQgb25saW5lIGlu
IGEgc2VwYXJhdGUgc3RlcC4NCg0KSWYgdGhhdCBuZWVkcyBleHBsYWluaW5nIGV4cGxpY2l0
bHksIHRoZW4gcHJvcG9zZSBhbiBhZGRpdGlvbmFsIHNlbnRlbmNlLg0KTm8gbmVlZCBmb3Ig
YSB0YWJsZS4NCg0KPiAqIFVzZXJzIG1heSBicmluZyBtZW1vcnkgb25saW5lIGluIGEgc2lu
Z2xlIHN0ZXAsIGluIHdoaWNoIGNhc2UgdGhlIHRvb2wNCj4gICAgcGVyZm9ybXMgYm90aCBj
b25maWd1cmF0aW9uIChpZiBzdXBwb3J0ZWQgYnkgdGhlIGFyY2hpdGVjdHVyZSkgYW5kIHRo
ZQ0KPiAgICBvbmxpbmUgYWN0aW9uLg0KDQpUaGUgdGFibGUgZG9lcyBub3QgbWFrZSB0aGlz
IGNsZWFyIGF0IGFsbC4gIFRoZSBgbHNtZW1gIGNvbW1hbmQgZG9lcyBub3QNCmJyaW5nIG1l
bW9yeSBvbmxpbmUgb3Igb2ZmbGluZSwgc28gaXRzIG1hbiBwYWdlIGlzIHRoZSB3cm9uZyBw
bGFjZSBmb3INCnRyeWluZyB0byBleHBsYWluIHRoYXQuDQoNCj4gKiBVc2VycyBtYXkgb25s
eSBjb25maWd1cmUgbWVtb3J5IGFuZCBsYXRlciBkZWNvbmZpZ3VyZSBpdCBhZ2Fpbi4NCg0K
VGhlIHRhYmxlIGRvZXMgbm90IGhlbHAgdG8gZXhwbGFpbiB0aGlzIGF0IGFsbC4NCg0KPiBI
b3cgYWJvdXQgdGhlIGZvbGxvd2luZz8NCj4gRXhhbXBsZSBTVEFURSwgQ09ORklHVVJFRCwg
TUVNTUFQLU9OLU1FTU9SWSBzdGF0ZXM6DQo+IFNUQVRFICAgfCBDT05GSUdVUkVEIHwgTUVN
TUFQLU9OLU1FTU9SWSB8IERlc2NyaXB0aW9uDQo+IG9ubGluZSAgfCB5ZXMgICAgICAgIHwg
eWVzICAgICAgICAgICAgICB8IE1lbW9yeSBibG9jayBpcyBjb25maWd1cmVkIHdpdGggbWVt
bWFwLW9uLW1lbW9yeSBlbmFibGVkIGFuZCBvbmxpbmUuDQo+IG9ubGluZSAgfCB5ZXMgICAg
ICAgIHwgbm8gICAgICAgICAgICAgICB8IE1lbW9yeSBibG9jayBpcyBjb25maWd1cmVkIHdp
dGggbWVtbWFwLW9uLW1lbW9yeSBkaXNhYmxlZCBhbmQgb25saW5lLg0KPiBvZmZsaW5lIHwg
eWVzICAgICAgICB8IHllcyAgICAgICAgICAgICAgfCBNZW1vcnkgYmxvY2sgaXMgY29uZmln
dXJlZCBidXQgY3VycmVudGx5IG9mZmxpbmUuDQo+IG9mZmxpbmUgfCBubyAgICAgICAgIHwg
eWVzICAgICAgICAgICAgICB8IE1lbW9yeSBibG9jayBpcyBkZWNvbmZpZ3VyZWQgYW5kIHdh
cyBwcmV2aW91c2x5IGNvbmZpZ3VyZWQgd2l0aCBtZW1tYXAtb24tbWVtb3J5Lg0KPiBvZmZs
aW5lIHwgbm8gICAgICAgICB8IG5vICAgICAgICAgICAgICAgfCBNZW1vcnkgYmxvY2sgaXMg
ZGVjb25maWd1cmVkIGFuZCB3YXMgbm90IHByZXZpb3VzbHkgY29uZmlndXJlZCB3aXRoIG1l
bW1hcC1vbi1tZW1vcnkuDQoNCkFib3ZlIHRhYmxlIGdpdmVzIHRoZSBpbXByZXNzaW9uIHRo
YXQgdGhlIGZvbGxvd2luZyBsaW5lIGlzIG5vdCBwb3NzaWJsZToNCg0Kb2ZmbGluZSB8IHll
cyAgICAgICAgfCBubyAgICAgICAgICAgICAgfCBNZW1vcnkgYmxvY2sgaXMgY29uZmlndXJl
ZCBidXQgDQpjdXJyZW50bHkgb2ZmbGluZS4NCg0KQnV0IGl0IGlzIHBvc3NpYmxlLCByaWdo
dD8NCg0KQWdhaW4sIEkgdGhpbmsgYW55IHRhYmxlIGlzIGp1c3QgYSBjbHVtc3kgd2F5IG9m
IHN0YXRpbmcgd2hhdCBjYW4gYmUgc2FpZA0KaW4gb25lIG9yIHR3byBzZW50ZW5jZXMuICBB
bHNvLCBhIHRhYmxlIGdpdmVzIHRoZSBpbXByZXNzaW9uIHRoYXQgaXQgaXMNCmltcG9ydGFu
dCBpbmZvcm1hdGlvbiwgYW5kIHRodXMgZHJhd3MgYXR0ZW50aW9uLCBtYWtpbmcgdGhlIHVz
ZXIgd2FzdGUNCnRpbWUgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2hhdCBpcyBzbyBpbXBvcnRh
bnQgYWJvdXQgaXQuDQoNCg0KQmVubm8NCg0K

--------------0rLGt1Dp21f1iK5pBwVmAit8--

--------------oD9MDWt4mAO030yVZFa58PZ9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmu6hYFAwAAAAAACgkQUUu+Lrjhlh/T
vRAAiBZoiPoEZnVdiiwiwMOgGe6qtgDKjnL9YqOPlI14CiSw4Qq8C5WDqX7PUjVotQf7W/fwlYfr
X9ntpRoKYx3R4LCs2bFN/V4g+kowejccRU7n7eh4sRW+74PwFbasXcnOODpLf8hvF30qJ7On64S5
ETDtYabM0kgVVypUQDOOosHJxwEcDEx58lmcwtRVt6URHaXYwwRSYT8+dbILp52WPC9eVyyM3SYs
YPz89PXFyBllpu+XYq96tDlw3h4urAOaLGQnYSmSzEr8MoyPpBiceg9mkeWIYgxwKeCx/CkcDOPT
y9NhLi1GqvjhGBIhKxsiBBqcF9SVXLmbw76XWveKgGU1X8PKOTxQwWbxcQV5+YfqRDWkm4Uj7kKf
dPomlWnWSAkqT5ckwK33txU/a3ZHbG/LrdftrwvJOf9GT73NxB9/tPQdqOKWejOevYEa47Oz+ZMn
e/H4oBwBca0NlPcm1jVBnR8m1Mfy0zjchuL341TjAr/My783YJJYWCtzxf78mkWyir84f0sEi48K
vfbP2FHmrY4qww4Ooxu2etgFfBSuhZGzQPO7UQzLw+aknk3dfgNgo2muhdJOznkEZqWQGkZ3fGar
pkvoQE/Cz9JYQ9HR4lBQjNdDBwnLsV0z2gXR1J7yuKMdUkWpGhIA8S8wsqlyoKCU8mpkvkwxzIVt
Ex0=
=GFjR
-----END PGP SIGNATURE-----

--------------oD9MDWt4mAO030yVZFa58PZ9--
