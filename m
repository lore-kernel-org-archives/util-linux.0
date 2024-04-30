Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF477172BD9
	for <util-linux@vger.kernel.org>; Tue, 30 Apr 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486101; cv=none; b=mmUD4qpU0VhXj7LaoB0V3AScjkpKohtUIfhppo1kKvLibtQdINsGoxNBPffoollb48WxqQEgumE+fCF+1JQA8fJvMJxvhyH2UtwSIj49sV0FEFATF6eZadBsP1cAUnihqxM67FelphSkuK/ltvhVCmu9ByoK6nFJKsBnTlXDU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486101; c=relaxed/simple;
	bh=jSSIrEj3gsYZxVBmWxv5VLoxpNqr+a94WCSCYF8aT/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQ1RCFBtAgCmrFbYqnepPoY1O8icIdZGBba63VRjKiaAiXxpG3COjQlPXxzG+4Nr4v/jYzHMkUp9ttGMBmZgZ1502v1R684xisWNzlGEtwPYTwu99Rj73x1hkbRLFM0gFYNwWmxR5IJnSk7aJupYcHC71coz5HTn6e98KJOPhUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=n06ls2Wq; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="n06ls2Wq"
X-KPN-MessageId: 14ecb2da-06fb-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 14ecb2da-06fb-11ef-836c-005056aba152;
	Tue, 30 Apr 2024 16:08:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=jSSIrEj3gsYZxVBmWxv5VLoxpNqr+a94WCSCYF8aT/Q=;
	b=n06ls2WqpCBxqMXHrz/Ei3xEEacYJX1XCdyk4jBcxz9hZcRWXMSNuwelGr3y4KEW97YtNS3NtSGWT
	 kh0fxy3ymtOdcXaT6TtLhjm4CFVNIzQHwFDk2M7YuS7UItga35r4SaY0FLmKLZt+BbJg7IQzgFCxE9
	 SDjZ+wg7BTakxlSs=
X-KPN-MID: 33|oIhKOhznGw27QYnAWmFdorXq1vRWu3VykyphidSNRKTQ2Mew3/sc2TuWyhPNGu5
 Y85Y5DZPFzRCK2VGZHRlzrhgUcEufjGEd/1+8j0UOU4w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oXCqFG1at3iY7ya80NdXuJuZVzHIzfvMziOG6I0NUqN+EkF5rj2g26odJMUkhsQ
 cX/+AH3lqAjk+qR/Ze9l8qw==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 1658c043-06fb-11ef-a212-005056ab1411;
	Tue, 30 Apr 2024 16:08:15 +0200 (CEST)
Message-ID: <9397da62-de57-429c-9f3d-9be26ec1cd76@telfort.nl>
Date: Tue, 30 Apr 2024 16:07:28 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
 <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
 <20240429193802.cflzk47hgjrlsq5f@ws.net.home>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20240429193802.cflzk47hgjrlsq5f@ws.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vGJTPB0MuWgmkhP8E89WSOUE"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------vGJTPB0MuWgmkhP8E89WSOUE
Content-Type: multipart/mixed; boundary="------------DQKnLWfCo5p00xNQiCwQTrfT";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Message-ID: <9397da62-de57-429c-9f3d-9be26ec1cd76@telfort.nl>
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
 <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
 <20240429193802.cflzk47hgjrlsq5f@ws.net.home>
In-Reply-To: <20240429193802.cflzk47hgjrlsq5f@ws.net.home>

--------------DQKnLWfCo5p00xNQiCwQTrfT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOS0wNC0yMDI0IG9tIDIxOjM4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IEFwciAyOSwgMjAyNCBhdCAwNDo1ODozNVBNICswMjAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+IEhtbS4uLiAgSSBkb24ndCB0aGluayBpdCdzIGEgZ29vZCBpZGVhIHRvIGFw
cGx5IGl0IHRvIHRoZSBzdGFibGUvdjIuNDANCj4+IGJyYW5jaCwgYXMgaXQgaW52YWxpZGF0
ZXMgYW55IHRyYW5zbGF0aW9ucyB0aGF0IHdlcmUgbWFkZSBmb3IgdGhlc2UNCj4+IHN0cmlu
Z3MuICBJdCB3b3VsZCBiZSBva2F5IGlmIHlvdSBmaXJzdCBvZmZlciBhIG5ldyBQT1QgZmls
ZSB0byB0aGUNCj4+IFRQIGJlZm9yZSBtYWtpbmcgdGhlIG5leHQgc3RhYmxlIGRvdCByZWxl
YXNlLg0KPiANCj4gR29vZCBwb2ludC4gSSBiZWxpZXZlIHdlIGNhbiBiZWdpbiBpbXBsZW1l
bnRpbmcgcmMxIGZvciBzdGFibGUNCj4gcmVsZWFzZXMsIHdpdGggYSBzaG9ydCBwZXJpb2Qg
b2YgdGltZSBmb3IgdHJhbnNsYXRvcnMgdG8gbWFrZSBhbnkNCj4gbmVjZXNzYXJ5IGNoYW5n
ZXMuIEZvciBpbnN0YW5jZSwgd2UgY291bGQgcmVsZWFzZSByYzEgb24gV2VkbmVzZGF5IGFu
ZA0KPiB0aGUgZmluYWwgdmVyc2lvbiBvbiBNb25kYXkuDQoNClRoYXQgd291bGQgYmUgZ3Jl
YXQuICBGaXZlIGRheXMgaXMgZWFzaWx5IGVub3VnaCBmb3IgYSBmZXcgYWRqdXN0bWVudHMu
DQoNCj4gU2luY2UgdGhlIHN0YWJsZS8gYnJhbmNoIGlzIG5vdyBiZWluZyBtb3JlIGFjdGl2
ZWx5IG1haW50YWluZWQsIGl0DQo+IHdvdWxkIGJlIGJlbmVmaWNpYWwgdG8gaW52b2x2ZSBU
UCBpbiB0aGUgcHJvY2VzcyB0b28uDQo+IA0KPiBEb2VzIGl0IG1ha2Ugc2Vuc2U/DQoNCkl0
IGRvZXMuICBUaGFua3MuDQoNCkxvb2tpbmcgZm9yd2FyZCB0byB0aGUgVVJMIG9mIHRoZSBz
dGFibGUgcmMxIHRhcmJhbGwNCg0KDQpCZW5ubw0KDQo=

--------------DQKnLWfCo5p00xNQiCwQTrfT--

--------------vGJTPB0MuWgmkhP8E89WSOUE
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmYw+yAFAwAAAAAACgkQUUu+Lrjhlh92
lRAA75AF8jKgUuhWnBCtGEVDNCzML+FOOBYr4Mjz+tCLFi6dn3EOgCamFsUUjkrX1R1mGFYqIlsB
ewuC+eE/SGVsd1zI+H6psQE5zAcJZCnAv+UeS4duFSd1qfB39Owf0M/eg93aERdI3C5gOoTvpErU
aRjPRoW/HDuJ/3S6AAaPkDmEk7AKlhikvzkjhU8rIhm7NYFJ5JFfOmtIEk6Yz6uqkKNpGMtmepNo
ilIE4DkMFD7hde2FNMg1c8MRl3swycX2PjG3cZRoNQusCorXG4bL4lav3EO2po23CGAgUxSwpeza
nC3afvVpX263yK8ACzeFGnfNKCINFDQC0vnDM1XA2CsYk/Qfvl9t+wRWnHkHSMHNeK+6j581xRqk
7548LIqJ2a4sW5LjHd3H/pHgEFk+WGdC8zBtF7pU0XvMohU/86yNKMc1JyVybeQ78mx9gDI62hdp
u/loSDFrf7ascyzCRZgRkDFrOgv5y+lSCa4ulEwuyAH6fpUYF3pVxWHF7t9EpRnF7sW2q1k06i49
OXMkVPbykJclolA8XKUfdonNrEAxkgvaWhBQHWdGllNi1mvrg7rgdKL/UA6fpDlURxrNTNFNMZqh
y48ji0rKUqc7rbA+49Bznbbiu0Xl8lUODyfn5qdIiUt+bLWFNpGzjxi607KH3k5hTInBsDOl+IAq
2l0=
=4G+y
-----END PGP SIGNATURE-----

--------------vGJTPB0MuWgmkhP8E89WSOUE--
