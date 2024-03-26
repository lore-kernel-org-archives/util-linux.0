Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DB13C696
	for <util-linux@vger.kernel.org>; Tue, 26 Mar 2024 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711468193; cv=none; b=uK/BKDf/047jMmI//X52kle0nvuANciMwXloUPXfdmxTxjqec9rInZc3ajlSKix5N3/E9G/5UTEDo3TrM6Td0MaRUQaX7vL2IQXGPKsj9ea24OBe7zHqKFK7bgjetcyl1a7UNvdCTN7Sdq3BwJCjSOoPeanPFAfQzqJqxU5dVFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711468193; c=relaxed/simple;
	bh=OrO4byAdW8UI7cBytr8d0/loHeh9p0segbnUXBrhtpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=SEf9iDzoPJ5imKDRbcyW7VbMSA1u2UzyCYaDv5U4ZmozssJOBw6dXqEnoHtTEf1tJMFOPYZNxxsR4jT1b4nitmV/17wUp4PEEepUbiCnKeqGAfyon6orgEorhU6MkoNFm4dvqP8V2wWIUDxutZSixCe2rOkBA6ln0Tk+k1aTdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=IsBuAzIg; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="IsBuAzIg"
X-KPN-MessageId: 4dc18397-eb88-11ee-89f5-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4dc18397-eb88-11ee-89f5-005056abbe64;
	Tue, 26 Mar 2024 16:48:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=OrO4byAdW8UI7cBytr8d0/loHeh9p0segbnUXBrhtpc=;
	b=IsBuAzIgB9rV+qaYw5MCkGgJUjUN3R2qt68RKLBDkcWgXhgOQtYkHjDyEtl1J6C31R3L7oRI6+iEl
	 eFUh928FWb9Zx8kU39rQyAk+dROtydvtKl47zRp6kYMAgv29USzzzH9RLPZnOeyqOjKF+iGmxvLRCz
	 xn3Nq4LfS+7EJu84=
Received: from [192.168.2.2] (82-168-50-91.fixed.kpn.net [82.168.50.91])
	by smtp.kpnmail.nl (Halon) with ESMTPS
	id 50992c37-eb88-11ee-a20e-005056ab1411;
	Tue, 26 Mar 2024 16:48:39 +0100 (CET)
Message-ID: <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>
Date: Tue, 26 Mar 2024 16:48:09 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Mistakes in messages of util-linux-2.40-rc2
Content-Language: en-US, nl-NL, es-ES
To: util-linux@vger.kernel.org
References: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
Cc: Petr Pisar <petr.pisar@atlas.cz>
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AO1TM0ENSMxRz90MFVO05srP"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AO1TM0ENSMxRz90MFVO05srP
Content-Type: multipart/mixed; boundary="------------AC1nugqMXulvRb3fFbhf6GY9";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Petr Pisar <petr.pisar@atlas.cz>
Message-ID: <257b46c7-dbe9-414e-a707-fc543d1e7849@telfort.nl>
Subject: Re: Mistakes in messages of util-linux-2.40-rc2
References: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>
In-Reply-To: <ZgKxUSbGN-R8Rn-w@album.bayer.uni.cx>

--------------AC1nugqMXulvRb3fFbhf6GY9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNi0wMy0yMDI0IG9tIDEyOjI4IHNjaHJlZWYgUGV0ciBQaXNhcjoNCj4gd2hpbGUg
dHJhbnNsYXRpbmcgdXRpbC1saW51eC0yLjQwLXJjMiBJIG5vdGljZSBhIGZldyBtZXNzYWdl
cyB3aGljaCBhcmUsIGluIG15DQo+IG9waW5pb24sIGluY29ycmVjdDogWyAuLi5dDQoNCkEg
cGF0Y2ggZm9yIG1vc3Qgb2YgdGhlc2UgaXNzdWVzIGlzIGNvbWluZyB1cC4NCg0KS2FyZWws
IHdvdWxkIHRoZXJlIGJlIHRpbWUgZm9yIGFuIHJjMz8gIEl0IHdvdWxkbid0IG5lZWQgdG8g
ZGVsYXkNCnRoaW5ncyBtdWNoOiBnaXZpbmcgdHJhbnNsYXRvcnMgdGhyZWUgb3IgZm91ciBk
YXlzIHRvIHVwZGF0ZSB0aGVpcg0KdHJhbnNsYXRpb25zIGZvciB0aGVzZSBzbWFsbCBjaGFu
Z2VzIHNob3VsZCBiZSBlbm91Z2guDQoNCg0KPj4gIzogbWlzYy11dGlscy9sc2Jsay5jOjIz
Ng0KPj4gbXNnaWQgIndyaXRlIHNhbWUgbWF4IGJ5dGVzLCB1c2UgPG51bWJlcj4gaWYgLS1i
eXRlcyBpcyBnaXZlbiINCj4gDQo+IFRoZXJlIGFyZSBtdWx0aXBsZSBtZXNzYWdlcyBlbmRp
bmcgd2l0aCAidXNlIDxudW1iZXI+IGlmIC0tYnl0ZXMgaXMgZ2l2ZW4iLg0KPiANCj4gSSBm
b3VuZCB0aGUgIiwgdXNlIiBjbGF1c2UgY2x1bXN5LiBFc3BlY2lhbGx5IHRoZSByZWZlcmVu
Y2UgdG8gIjxudW1iZXI+Ii4NCj4gSSBrbm93IGl0IHJlZmVycyB0byBhbiBhcmd1bWVudCBv
ZiB0aGUgLS1ieXRlcyBvcHRpb24sIGJ1dCBpdCBjYW4gYmUgZGlmZmljdWx0DQo+IGZvciB1
c2VycyB0byByZWFsaXplIGl0LiBbLi4uXQ0KDQpJZiBJIHJlYWQgdGhpbmdzIGNvcnJlY3Rs
eSwgdGhlIC0tYnl0ZXMgb3B0aW9uIHRha2VzIG5vIGFyZ3VtZW50Lg0KU28gdG8gbWUgdGhl
IG1zZ2lkIG1ha2VzIHplcm8gc2Vuc2UuICA6Lw0KDQo+IEkgcHJvcG9zZSByZXBocmFzaW5n
IGl0IGFzICJ3cml0ZS1zYW1lIG1heCBieXRlcywgcmVzcGVjdCAtLWJ5dGVzIGZvcm1hdCIu
DQo+IE9yICJ3cml0ZSBzYW1lIG1heCBieXRlcywgcmVzcGVjdHMgLS1ieXRlcyBmb3JtYXQi
Lg0KDQpXaGF0IGRvZXMgInNhbWUiIHJlZmVyIHRvPyAgInJlc3BlY3RzIHRoZSAtLWJ5dGVz
IG9wdGlvbiIgd291bGQgYmUgYQ0KZ29vZCB3b3JkaW5nLg0KDQooQXMgSSBkb24ndCB1bmRl
cnN0YW5kIHdoYXQgdGhlc2UgZGVzY3JpcHRpb25zIGFyZSBzYXlpbmcsIEkgaGF2ZSBub3QN
CnRvdWNoZWQgdGhlbSBpbiBteSBwYXRjaC4pDQoNCg0KPj4gIzogc3lzLXV0aWxzL2NoY3B1
LmM6MjA4DQo+PiAjLCBjLWZvcm1hdA0KPj4gbXNnaWQgIkNQVSAldSBjb25maWd1cmUgZmFp
bGVkIg0KPiANCj4gImNvbmZpZ3VyZSIgc2hvdWxkIGJlICJjb25maWd1cmF0aW9uIi4NCg0K
SG0uICBJIHRoaW5rIHRoYXQgdGhpcyAiY29uZmlndXJlIiAoYW5kICJkZWNvbmZpZ3VyZSIg
ZnVydGhlciBkb3duKQ0KcmVmZXJzIHRvIHRoZSAtLWNvbmZpZ3VyZSAoYW5kIC0tZGVjb25m
aWd1cmUpICJjb21tYW5kIi4gIFNvIG15IHBhdGNoDQpkb2Vzbid0IGNoYW5nZSB0aG9zZS4N
Cg0KDQpCZW5ubw0KDQo=

--------------AC1nugqMXulvRb3fFbhf6GY9--

--------------AO1TM0ENSMxRz90MFVO05srP
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmYC7jkFAwAAAAAACgkQUUu+Lrjhlh/H
HRAAruCkUhrSaqc1V+/Sai4QmrTYkLWgB1mBHBYf+Tqa0DJkAXJycG6pDa24iQVjT4PAJnsX+0ZM
5LwchNoF1HL15HRCj889BRmXVr+FV86qpPv+KItuwJKBSR//i5dQ9VnwDGTb/WpcA7C4/b+RrToi
vXPHE/wRYiWKXN/NYKhYVga7ohJ/Nc/G2t09+r2NQ0SViDMJ62jy6cjU/M6gc+lfwXoxXwRAQjCG
y3HSPjs5mto/Owd+L8a2G+KMwRvXfeVFZyqL2vi3F7ZGNDs3RYSbFH5HbWe2M+V3jQpA4Xa+SgLu
RS8P/10VfPvXY3zW6bm3tANTM/dwWBqhxt4lY5NvhKV8GqwRdDxltouRG8WVc7oqctY6QDCe7L4E
Zl8FFuffs0isOFAbSqARUYRP6w52qoXnzjeb8eq969Kys/nesTAUkvj95CdfqK84kqIW89NDnHkR
8OltLM0qlQWV8enUyh4HDlcPq99+bWx6exM7iLnzVal0Q/0IQS23AzbkLuq2pCQiIuPqnqyzNcjX
CsJZWI/UA9LsYmPe+8h+9uyjTjGJH2yaIrlzutqu+0U+fJAO1RrV6uRr1rkT2eA3YyoMdRHSxHJc
4y3lTbtrZSYfbFgPetFVLGbFelVFVTaH6FiXEyb0tB1mlkOAIbDlENAhpMbgQTqidoPoFyHrwhE/
mGw=
=Vdjc
-----END PGP SIGNATURE-----

--------------AO1TM0ENSMxRz90MFVO05srP--
