Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1B308F0C
	for <util-linux@vger.kernel.org>; Fri,  7 Nov 2025 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514574; cv=none; b=M31ruCNFvDJExaDgjaTmHmIQvF9hq80VPlpq8vXmonoPCoGD2u2tGXlRRKT+AbM4Y/gtGlL9nb2rTbg5M3218V9PJ3g1zrDNvsYgJh8NxzZUG4xnvpUpQ7OrK+87Bk9B/LQ0KQUjECtIjOgXbPhm2DCnwPvDD9mOAoLfhEUB7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514574; c=relaxed/simple;
	bh=GWBjy26DNffTE8ZRWhYE2EhNgUfOSIxdHWTvLZlLCeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDP6/MFTJ7wGWKp9Hp8gwDdCg3vd8gtMqbwZyiYqqAu9DJTcjhhT/WX5GyH5dcnIxseL1yru8ryUUdu+8BWY38ASZfz9MdWB1QHNiBz2lfaWY4wgPp39/TOlmw6JgdtOM8/pdVR0zxKvmPScZPm1odU2xXeJ5pKvkHRaPoTzhSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qMe7QFuY; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qMe7QFuY"
X-KPN-MessageId: 2ea70938-bbcc-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2ea70938-bbcc-11f0-bd6b-005056aba152;
	Fri, 07 Nov 2025 12:23:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=GWBjy26DNffTE8ZRWhYE2EhNgUfOSIxdHWTvLZlLCeQ=;
	b=qMe7QFuYgag19S+YpYthqUaVI0uoQvH1Hc7I2UHvupFmX8OIT9cPkzLmyyHggcEVLhp17QjvoLr05
	 wTZtk1QE1J6AV/560+/tLMOQd4Hm1FUGmUNhVmTeYkqkmH2YNc9E+LvWJJCOewV5X1Yxo7z70kcRaE
	 2shqsJlZhRIBF6kI=
X-KPN-MID: 33|46nt/Jbuv6RVLsYtpOc5rtrg6O6LU/XoLmxmziyfJ4UhIIwFfaxlzUb7KYWEcTS
 sAgcITM8LVFliPjnSTcz642ZM/dgQc1lYidcdPBGpVw4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NPB5Df/gTfumpBOft31rVTQjH/XHImiwijBM2B+DJlr4derG2tmjWBeo8rELj58
 OXVEONug/4gkcruYvX68KkA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id eea21154-bbcb-11f0-a6c9-005056abf0db;
	Fri, 07 Nov 2025 12:21:40 +0100 (CET)
Message-ID: <a6aad56b-ed97-45e0-a681-951c0f5d0fa4@telfort.nl>
Date: Fri, 7 Nov 2025 12:21:40 +0100
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
 <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
 <pdmvdt2cdvr57pwsyz3g7eehtyni2e5zfnz76mhf5rcsjwcfmm@kf7ergmarrsi>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <pdmvdt2cdvr57pwsyz3g7eehtyni2e5zfnz76mhf5rcsjwcfmm@kf7ergmarrsi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------HrShTxtwojW70zzEGGDYwioi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------HrShTxtwojW70zzEGGDYwioi
Content-Type: multipart/mixed; boundary="------------MkVQXOTiCAqAHov4inCCilFO";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Message-ID: <a6aad56b-ed97-45e0-a681-951c0f5d0fa4@telfort.nl>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
 <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
 <dexp4ooy65b2la7ujbpnp5itphzzriwg57uz2cvkt4grn3b7bv@7nzd6wye2vjt>
 <7b928196-6485-4514-a336-5c403652a0c3@telfort.nl>
 <pdmvdt2cdvr57pwsyz3g7eehtyni2e5zfnz76mhf5rcsjwcfmm@kf7ergmarrsi>
In-Reply-To: <pdmvdt2cdvr57pwsyz3g7eehtyni2e5zfnz76mhf5rcsjwcfmm@kf7ergmarrsi>

--------------MkVQXOTiCAqAHov4inCCilFO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwNy0xMS0yMDI1IG9tIDExOjE2IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IE5vdiAwMywgMjAyNSBhdCAwMzo0Mjo1MFBNICswMTAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+IEZvciB0cmFuc2xhdGFiaWxpdHksIHRoZSBhYm92ZSBzaG91bGQgYmUgbGlr
ZToNCj4+DQo+PiAJZnByaW50ZihzdGRlcnIsIF8oIiVzOiBvcHRpb25zICVzIGFuZCAlcyBj
YW5ub3QgYmUgY29tYmluZWQiKSwgLi4uKTsNCj4gDQo+IFllcywgSSBrbm93LiBUaGUgcHJv
YmxlbSBpcyB0aGF0IHdlIG5lZWQgYW4gZXh0cmEgYnVmZmVyIGluIHRoZSBjYXNlDQo+IG9m
IHRoZSBzaG9ydC1vbmx5IG9wdGlvbi4gSSBoYXZlIHVwZGF0ZWQgdGhlIHB1bGwgcmVxdWVz
dCB0byBtYWtlIGl0DQo+IG1vcmUgZWxlZ2FudC4gTm93IGl0IHVzZXM6DQo+IA0KPiAgICAg
IGVycngoT1BUVVRJTFNfRVhJVF9DT0RFLA0KPiAgICAgICAgICBfKCJvcHRpb25zICVzJXMg
YW5kICVzJXMgY2Fubm90IGJlIGNvbWJpbmVkIiksDQo+ICAgICAgICAgIC4uLi4NCg0KDQpU
aGF0IHdpbCB3b3JrLiAgVGhhbmtzIQ0KDQoNCkluIHRoZSBjb21taXQgbWVzc2FnZSBpdCBz
YXlzIGZvciBORVc6DQoNCiAgICAgJCBsb3NldHVwIC0tcmVtb3ZlIC0tZGV0YWNoIGxvb3Aw
DQogICAgIGxvc2V0dXA6IG9wdGlvbnMgLS1kZXRhY2ggYW5kIC0tcmVtb3ZlIGNhbm5vdCBi
ZSBjb21iaW5lZC4NCg0KQnV0IHRoZSBhY3R1YWwgZXJyb3IgbWVzc2FnZSBpczoNCg0KICAg
ICBsb3NldHVwOiBvcHRpb25zIC0tcmVtb3ZlIGFuZCAtLWRldGFjaCBjYW5ub3QgYmUgY29t
YmluZWQNCg0KKHRoZSBvcHRpb25zIGluIHRoZSBvcmRlciBhcyBvbiB0aGUgY29tbWFuZCBs
aW5lIGFuZCB3aXRob3V0IGEgcGVyaW9kKS4NCg0KDQpCZW5ubw0KDQo=

--------------MkVQXOTiCAqAHov4inCCilFO--

--------------HrShTxtwojW70zzEGGDYwioi
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmkN1kQFAwAAAAAACgkQUUu+Lrjhlh8l
jw/+NkLj13WWqj/UYQqindrGclxNfQjAOX5pkrDwoDNJYmfJ92iWh7vgji9BmL+OBD3MrXwAGG9x
ZnYUpGOoSHVdLcoc2gQj6HiJbg/70xFO7yOBuS8e2C3Aaq9uWL3Ew/lFD69raXpD2dGOCJzJwThD
FF4Eb2LCOaUX08ja9K9LpIwiYj4ZImeazt9K1un3PWDquCuQ7NMQRrRuX3L+QvSYOY7YIsS7EG7V
vtodepYRGT63jxVelByO9/L61KeASgw6dagx1KbNOKxTAuvxfNEHS2+E4EyvDqF5lQsBM6XYT5yU
OBMdEbN8YDgiX74wnr25Zeu+jwa/Lh3e73Grl1D36nbV2bbc4nDmHfSWhfL9V/TBPkVHADgbSAMH
9KbyfoVUzIVp6DAQSETXQ4oD2JyOnt4/aSGUokpahRn0UK7vzt5998hUR5ExDhH8RytptwngoThV
+zwGnlScFD0lZIYsylqofA45meL4BsnnU840+uoxANb0kSx1ywJF00s1YWo0FbNG8YGAMGpLyUvv
YamjAS5Qk+T8n+MW5H1MAhTPFzOvpLdIPmI2vRm5IeR0naA3KeXgftm6+ukJlyhDEh7pVLtGo47m
HvcLy1Wz5emNSneLXrRlejhfSPpKa+BiFiI28JIqs+cwjbutBqwmGZtPmuMiF1F4L3tvRcKIywSw
K4w=
=CmWt
-----END PGP SIGNATURE-----

--------------HrShTxtwojW70zzEGGDYwioi--
