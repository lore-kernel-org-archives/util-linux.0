Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14202556E
	for <util-linux@vger.kernel.org>; Thu, 19 Jun 2025 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342576; cv=none; b=tKZtHdNkhT7GN/Cnt5yuP+6V8EmJbY/gYBzsEH0Igh4MEBUj1vTZchjnY4T+5EEvWuV7U4o+KjoMEw7YCyxCMUFY9z0NB8fJt/m+ThX5Rbo4lU2Hqq5ABs8w4x58lHhGCPM6XW++ITouEmZPL2OG8rISsRQWcuTH0rm+NKTSFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342576; c=relaxed/simple;
	bh=bMY55js/44jkOXm/HHGxiVuFlHX8bIZgNujd6WMBum0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSxX15fs6QMv1m71TjAlCR2Zqt70WH8UfDy+S6k1NMDSLNQQMWJ82d3OR0JGIgzoMIFNEf/ya+12S2y01P15YPQGTOGmiLHMDQnpHgxNDAnh45DyB3dlfeU5x08sZKtH5n5/mvqI1AS2yd/9kjz4OZc3JW051yL6/xQuCCLmIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=X9BhCxtG; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="X9BhCxtG"
X-KPN-MessageId: f11d930b-4d17-11f0-86d0-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f11d930b-4d17-11f0-86d0-005056aba152;
	Thu, 19 Jun 2025 16:16:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=bMY55js/44jkOXm/HHGxiVuFlHX8bIZgNujd6WMBum0=;
	b=X9BhCxtG9FWZUXA66EpX9odNsaUlsaJPIB11WPXW5iAGX7Prg0MshC8l4fqLUnWOWEtHBEkRmjNMw
	 s3W+Av19q0zbFG/qlKXs8B80PReOa31rVMKHtusIx1BNUdYFVZPsOpQdgIeBbcIDLrgGZ2aJAhTZeD
	 lVHGhuSH1hlcKKY0=
X-KPN-MID: 33|v4dAkBgd+K0J9yq1qt6gfIXkH/sM94lZg8elDP2o6ZOsmcx7ff1os5hdCyjXLw6
 9shjjaLpbqRtQb3K6s4smzbVkSp3bPY+cFNtzpygQjos=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|C87LaSbfxd+kDmYQ6aS1UfUpddNmfEhi4SvKg0MQ7gMt2eesThpwabHOGsbr+sw
 UpxaGgBRYB7zUy4LZ404emQ==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ca8bcf88-4d17-11f0-85aa-005056ab7584;
	Thu, 19 Jun 2025 16:15:02 +0200 (CEST)
Message-ID: <41499ee7-7d8f-4143-b560-1b02f2d1f00c@telfort.nl>
Date: Thu, 19 Jun 2025 16:15:00 +0200
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
 <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
 <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------00s6TdBMk00eFdzHZ4iCN0tA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------00s6TdBMk00eFdzHZ4iCN0tA
Content-Type: multipart/mixed; boundary="------------4oHRFc75qB6VwzRyHr3Gn3vT";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <41499ee7-7d8f-4143-b560-1b02f2d1f00c@telfort.nl>
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
 <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
 <7nyugk5zfclbpqc2kpcotycgssj6jticujokevyo6ulw7japtl@pnqb6svtmxao>
 <bbd6aabd-707d-4fee-b80c-36749cf7c531@linux.ibm.com>
 <8197c011-67ff-4c84-b46a-304faa6678d6@telfort.nl>
 <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>
In-Reply-To: <d3cfa396-a89f-4ff0-8424-318ed0b3c2be@linux.ibm.com>

--------------4oHRFc75qB6VwzRyHr3Gn3vT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxOC0wNi0yMDI1IG9tIDE4OjQxIHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IFNvLCBteSB0aG91Z2h0IGlzIGp1c3QgdG8gbWFrZSBwcmlvcml0eSBhcmd1bWVudCBv
cHRpb25hbCBmb3INCj4gcG9saWNpZXMgdGhhdCBkb24ndCB1c2UgaXQgYW5kIGtlZXAgdGhl
IGV4aXN0aW5nIGJlaGF2aW9yIGFzIGlzLg0KDQpUaGF0J3Mgbm90IHBvc3NpYmxlLiAgQ3Vy
cmVudGx5LCBkb2luZyBzb21ldGhpbmcgbGlrZQ0KDQogICAuL2NocnQgLS1pZGxlIC0tcGlk
ICQkDQoNCmp1c3QgcmVwb3J0cyB0aGUgY3VycmVudCBwb2xpY3kgYW5kIHByaW9yaXR5LCBh
bmQgZG9lcw0Kbm90IGNoYW5nZSB0aGUgcG9saWN5IChiZWNhdXNlIHRoZSBwcmlvcml0eSBp
cyBtaXNzaW5nKS4NCkFmdGVyIHlvdXIgcGF0Y2gsIGRvaW5nIHRoZSBzYW1lIGNvbW1hbmQg
cmVwb3J0cyBub3RoaW5nDQpidXQgX2RvZXNfIGNoYW5nZSB0aGUgcG9saWN5LiAgWW91IGNv
dWxkIHN0aWxsIG1ha2UgaXQNCnJlcG9ydCB0aGUgY3VycmVudCBzZXR0aW5ncywgYnV0IHRo
YXQgd291bGQgZ2l2ZSB0aGUNCndyb25nIGlkZWEsIGJlY2F1c2UgaXQgd291bGQgYmUgdGhl
IF9vbGRfIHNldHRpbmdzLg0KDQpTbywgYXMgS2FyZWwgc2FpZCwgc2lsZW50bHkgaWdub3Jp
bmcgdGhlIHBvbGljeSBvcHRpb24NCndoZW4gbm8gcHJpb3JpdHkgd2FzIGdpdmVuIHdhcyB1
Z2x5LiAgVG9vIHVnbHkgdG8ga2VlcA0KaXQgdGhhdCB3YXkuICBBcyBLYXJlbCBpbXBsaWVk
OiBicmVhayBjb21wYXRpYmlsaXR5IGFuZA0KZG8gdGhlIHNlbnNpYmxlIHRoaW5nOiB3aGVu
ZXZlciBhIHBvbGljeSBvcHRpb24gaXMgZ2l2ZW4sDQphY3QgdXBvbiBpdCAtLSBhbmQgd2hl
biBhIG5lZWRlZCBwcmlvcml0eSBpcyBtaXNzaW5nLA0KZXJyb3Igb3V0Lg0KDQoNCkJlbm5v
DQoNCg==

--------------4oHRFc75qB6VwzRyHr3Gn3vT--

--------------00s6TdBMk00eFdzHZ4iCN0tA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhUG2UFAwAAAAAACgkQUUu+Lrjhlh/Q
7g//a0rOZjQRLcJ+hueG4qT/HIyA2nmZ3oSM4n9ejpi6UGQiPYwynvim1iWg11OfKCLkLmqn93Hu
N9VjrWb0ZFuemD4dQG+dfOCA+e2IMPLs8l8qSt9JuORaJuZ1AsIYYczFMjGh4rIZjFukzsNP+d8M
mFD06ZmpSPy2jCBE9KHBkcRg6Gcun9tCeKy5cjveX2mcbvTVTeI0YDwiGFM4rYbOcfo2XtKfRqoW
ZSJIeYTaUkfxX0J3XGSbLItNOHfbbApoIOqnqg9S3Z2o+j28diKd5B8FoWQbHdWDvPvGQVpRuy2o
++jelvP2FkLIEgjaxPxs6FOX0thLImsabQ8/io1d9ezL9Ly0LOZeqqZCpXLU/S5g4K93b6YpWldx
InzkIzUfQ156dp9RU1HAIXklrNzsZCGecsSNsxTldcKOu50dRUsnkSzXh0llvJ6y+X4C4mNNDJ+4
F/ZZphVakGQSdxmM9Qqntx9uXmDKHuHrCGl3SdYn+pI0wydpNTH7mCFDRyhvzCz/nmBDwxMdrLsP
bUQ+rbbRFKJfcs2+Zjk82rBhQ1wFlXM8mZCQw2Vp7ZR3Had7fZ+VVxhohp9P6i/RMxyzih6SrW0X
WopMBV9eHnbUdFo/xDfWVlTrrtzTymFykTK9xWxL6j0h+fCstrjVR7nylpqBlDNHjaNgjANpc63A
Oh8=
=8jFJ
-----END PGP SIGNATURE-----

--------------00s6TdBMk00eFdzHZ4iCN0tA--
