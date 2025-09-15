Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBF264A83
	for <util-linux@vger.kernel.org>; Mon, 15 Sep 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929873; cv=none; b=GpZvFFGcuKQxB3Mzfqmt2BNACFjTWA3cPELVtqbPblbH0/01WdaDiimMxCDSIfqmD5WPIT2GUdspjdyvbZU3FhrlhCvwaVHTHbVlUiZyJFPcIcy1ejVXMDLrxWDOHPH8psITRsAy+DV8DrTc4UWUBValnj5ZrGjiriHUhWSjMvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929873; c=relaxed/simple;
	bh=txiDZJDR5wIJj3dW1iFWaD9OtemjB3RiV2T3MJh2K38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOtwCgGeHHWxYz28MQ1vok9H3bXcG6knrTGGDaIBgISqyAR1/ZazYyVZVJ7RqBAl+owTEXYeE5xadmv/kmhFTNnbzgZqqxtvthURYg9HJFGkjU5kQYPGD9YyCJ2AHVTKZi10WBWO1W5Z65M1C7o9L1n2rqACfux7RhpPfUOui5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=r3RiVhDh; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="r3RiVhDh"
X-KPN-MessageId: 1180e9a4-921a-11f0-a4bf-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1180e9a4-921a-11f0-a4bf-005056abad63;
	Mon, 15 Sep 2025 11:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=txiDZJDR5wIJj3dW1iFWaD9OtemjB3RiV2T3MJh2K38=;
	b=r3RiVhDhG9PXDaRNqZrL3RmEukK35aDjr/wx6dH0zDyJjgT+ayFtdzNeqvkPHW7YJ/wWMwyJOWlvr
	 Fjyd5lHRJ/o+j5fqxIwAp1TCrNh16uM8fZNg63BOQLFpoxa4C2i3HhHHS8ldrTbHJ0n2FFpfXL/mLP
	 9mMkCy4Mg4NS104k=
X-KPN-MID: 33|whRkBaZ7vxW7jAJXd88krQM2oIQfV73lqgp5MGJ6o/almaYTOav/XUqWvjPGDKI
 ZfQHaFAnmDFI1DQmvJvTOcaE3pIxsd0egdDiDr7Mkt6k=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|IQO2vWiRg4+C1I7VVP5/UYYRW/uKi+H1FSDRYFz8kqYfBjQ+wrQ2r+Mc1NgYN36
 8En9eNgOmYmr6wJdYev6URw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7cd2d172-9219-11f0-abc8-005056abf0db;
	Mon, 15 Sep 2025 11:51:01 +0200 (CEST)
Message-ID: <13928bd5-c3e3-4b6d-a5a0-3daf6b9e4429@telfort.nl>
Date: Mon, 15 Sep 2025 11:51:01 +0200
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
 <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
 <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ioUltRfsbRWX6wttuBmhVvLZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ioUltRfsbRWX6wttuBmhVvLZ
Content-Type: multipart/mixed; boundary="------------4OuEf4hX0KV2PalEnc5Svs3p";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <13928bd5-c3e3-4b6d-a5a0-3daf6b9e4429@telfort.nl>
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
References: <20250911134807.12903-1-bensberg@telfort.nl>
 <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
 <rs4jch6hxbont2e56cnshc37hzefhprhlljy2v56xhhtjkfdbm@kgf6bctiicox>
 <14fbf910-bc2b-4bd4-89ce-dac8a4d8c970@telfort.nl>
 <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>
In-Reply-To: <cspldmiiosndipcki3zybaik2edrf2lstkpxxj27rum5xrlfdc@6a4t452pkz7l>

--------------4OuEf4hX0KV2PalEnc5Svs3p
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxNS0wOS0yMDI1IG9tIDExOjIyIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBXaGVuIHRy
YW5zbGF0b3JzIGFyZSB3b3JraW5nIG9uIHN0cmluZ3MsIGl0J3MgYmVzdCB0byBrZWVwIHRo
ZW0gZnJvemVuDQoNClRyYW5zbGF0b3JzIGFyZSBjdXJyZW50bHkgbm90IHdvcmtpbmcgb24g
dGhlIHN0cmluZ3MgZm9yIDIuNDEuMiwNCmJlY2F1c2UgSSBoYXZlbid0IGFubm91bmNlZCB0
aGUgUE9UIGZpbGUgeWV0LiAgU28gaXQgaXMgZmluZSB0bw0Kc3RpbGwgbWFrZSBjaGFuZ2Vz
IGFsc28gdG8gdGhlIGJyYW5jaC4NCg0KPiBhbmQgZG8gc3RyaW5nIGZpeGVzIGluIHRoZSBu
ZXh0IHJlbGVhc2UgKG9yIG5leHQgLXJjKS4gU28gSSBoYXZlDQo+IGFwcGxpZWQgdGhlIHBh
dGNoIHRvIHRoZSBtYXN0ZXIgYnJhbmNoIG9ubHkgZm9yIG5vdy4gT0s/DQoNCk5vdCBPSy4g
IEFzIHNhaWQ6IEkgZG9uJ3Qgd2FudCB0byBvZmZlciBhIGZhdWx0eSBzdHJpbmcuICBQbGVh
c2UNCmFwcGx5IHRoZSBwYXRjaCBhbHNvIHRvIHRoZSAyLjQxIHN0YWJsZSBicmFuY2gsIHNv
IHRoYXQgSSBjYW4NCmFubm91bmNlIGEgIGJldHRlciBQT1QgZmlsZSAoSSB3aWxsIGVkaXQg
aXQgaW4gcGxhY2UgLS0gbm8gbmVlZA0KZm9yIGFub3RoZXIgcmMgcmVsZWFzZSkuDQoNCj4g
Rm9yIGEgbWFqb3IgcmVsZWFzZSAoZS5nLiwgdjIuNDIpLCBpdCB3b3VsZCBiZSBiZXN0IHRv
IGRvIHN0cmluZw0KPiB0cmFuc2xhdGlvbnMgdHdpY2UgYmVmb3JlIHRoZSBmaW5hbCByZWxl
YXNlIHRvIGFsbG93IHRpbWUgdG8gZml4DQo+IHN0cmluZ3MgYW5kIGZpbmFsaXplIHRoZSB0
cmFuc2xhdGlvbnMuIE1heWJlIGZvciB0aGUgZmluYWwgcmVsZWFzZQ0KPiBpdCB3b3VsZCBi
ZSBiZXN0IHRvIGhhdmUNCj4gDQo+IC1yYzEgLi4uIHN0YWJpbGl6YXRpb24gb25seSwgbm8g
dHJhbnNsYXRpb25zDQo+IC1yYzIgLi4uIHRyYW5zbGF0aW9ucywgc3RyaW5nIGZpeGVzIGZy
b20gdHJhbnNsYXRvcnMNCj4gLXJjMyAuLi4gZmluYWwgdHJhbnNsYXRpb25zDQoNClRoYXQg
c291bmRzIGZpbmUuDQoNCj4gQnV0IEknbSBub3Qgc3VyZSB0cmFuc2xhdG9ycyBhcmUgcmVh
ZHkgZm9yIHN1Y2ggcmVwZXRpdGl2ZSB3b3JrDQo+IChhbHRob3VnaCB0aGUgc2Vjb25kIHVw
ZGF0ZSB3aWxsIHByb2JhYmx5IGJlIHF1aXRlIHNtYWxsKS4NCg0KSWRlYWxseSBJIHNob3Vs
ZCBjYXRjaCB0aGUgZmF1bHR5IHN0cmluZ3MgYmVmb3JlIHlvdSBtYWtlIHRoZSByYzIuDQoN
Cg0KQmVubm8NCg0K

--------------4OuEf4hX0KV2PalEnc5Svs3p--

--------------ioUltRfsbRWX6wttuBmhVvLZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjH4YUFAwAAAAAACgkQUUu+Lrjhlh/A
wBAAtEBuxbtfSFhJMJCAYu7artzdnIHWiQu2eKO38kqthR9NEYnXJlxf8L1TECDtXKk2F2mNsFA1
2ToEF1ScDGbQJ7T9AQ2K64QeJY7QZbWedSHJRdINV7i2/qiqFN3qcC+hUzYJixESIO6JK9Ha9v0y
xfT1zdueWtZFruxkJ6RkaBlRthKm9db88xvIHouG/W67jyhbzPXm9520hzSywCESi0n53apVxOzt
rOBx+VY1+xOGD8UTdKfLaJnibez9FlTz8raTBrk2swMYlylOyXIOU9zKI2dK/0ce+3tl1k+lGYLp
sCH3okFxEqDsTO0myN+LUAZH6NllFjcXREwvVmVqmP/HLgcAZnmv720bEEv4QPD44FsBCM1q0nhm
l1/xB1aqQprYnKzuv4lmGp5cxRBlKjyHl0QPhHs10A3MaYau6QByKC5nvzyc85SllVr20LTszri+
ukCOB7sDWWiGoGdHw4g1uLVsXZsUne2YuUk/Zx3c6nrZ6G9V5wfm26HKss/7pUFJ/ZDuoLY2MUM7
KPM3etdqNNIbVmxxNaV1KpshUdRP2F1DvgW+b439Tji8rpLZCbZpNmt3HWHUp0q4F8x2Q08vNlpy
Iyu+Zxc+ynOR/IO1zuTQ6wpYuwVVY5cJHAa3k9gkjMHvNAFcefoe+Qf7k5ivku9R3sqjsQBYAMpQ
BrY=
=NKCd
-----END PGP SIGNATURE-----

--------------ioUltRfsbRWX6wttuBmhVvLZ--
