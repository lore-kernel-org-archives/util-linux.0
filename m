Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C321504F
	for <util-linux@vger.kernel.org>; Wed,  9 Apr 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191375; cv=none; b=W/FteWBkOAZzsfhLF8KYIKYYVEx8ZDEwoGrmfqSyFA0CDuTqdcNsMCAqXYJkAUcus4AeDL/M36LvdAWIoHw8KToBA2YC6J0M1Zz6eEfT8ByLiY+1EEfnZpiqc+pAW3cJmmCAu08GSPaVslJ1XJW2DeDOzpGPNiReLGI8aQ6UnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191375; c=relaxed/simple;
	bh=oVQQrKOoeadiGfaX8BxL3ZrchTykC8UJI9hWWeP0uNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CxXfhaWtbrhfJPG+GGSEJXEyBfQDUlJU695ij7kzQEnHfVdgwvFQsZGihFY429XYn8zVw0zOZD47Gux1hW9N/glCFi8f9GOkbT4+ylapgQL33/dgDW33oPsNDz1XhFpXGitM9CSdvjevPpjmO8i7rRp+kaDCddW93UZETzGwqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=aPxkeAH/; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="aPxkeAH/"
X-KPN-MessageId: 1b661f84-1526-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1b661f84-1526-11f0-a82d-005056abad63;
	Wed, 09 Apr 2025 11:36:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=oVQQrKOoeadiGfaX8BxL3ZrchTykC8UJI9hWWeP0uNc=;
	b=aPxkeAH/3LWpyZGHYHV6UdeXZNhZeZg17OXIXGxDTomAz1G4WrqQoTXkjCoT7z/3axxD4A2iJwhnH
	 5pybOngczDMB9KwHvVEXYCXaEHtp/oO4foJR0Oc3l7rvtAnLt9GDyCgVshUhGbY1qKCHFq/0JcLZRh
	 WJX5mXuHzw2MMqLg=
X-KPN-MID: 33|QvcUTfmyERXzkyB/MfWHvkWjIfQaoOqbZJLkt9byx013e+9KHfPhWyg4VyeUsA2
 9+Qff/VPhCn7NZtr7fGuqCz+zNtKZobjpXDGpfn8qwI8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Ve4zroJwCbs0zwXAt7pfpIsx+JnM8QYSHoTgmS5mVaHseL42YW4BjHd2K3OJpRf
 Vln9czShUSqbYmRkuygR+1A==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0d66c397-1526-11f0-9b69-005056ab1411;
	Wed, 09 Apr 2025 11:36:02 +0200 (CEST)
Message-ID: <1514a603-24d9-423b-b348-07d2f94d7961@telfort.nl>
Date: Wed, 9 Apr 2025 11:36:02 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that mistakenly
 mentions `arch`
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250407151503.23394-1-bensberg@telfort.nl>
 <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------OvcBndutaBTX2acm6nHegiJx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------OvcBndutaBTX2acm6nHegiJx
Content-Type: multipart/mixed; boundary="------------BOr1eOeCr5CG7sa6dj6DqTqg";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1514a603-24d9-423b-b348-07d2f94d7961@telfort.nl>
Subject: Re: [PATCH 1/8] setarch: (man) remove a synopsis line that mistakenly
 mentions `arch`
References: <20250407151503.23394-1-bensberg@telfort.nl>
 <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>
In-Reply-To: <mbag4aqfzuvn5q44cpbtem6ei7ai6jr2lz2pyzxrytsom4i3vq@7ak5vpzjgy7o>

--------------BOr1eOeCr5CG7sa6dj6DqTqg
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T3AgMDgtMDQtMjAyNSBvbSAxMjozMyBzY2hyZWVmIEthcmVsIFphazoNCj4gT24gTW9uLCBB
cHIgMDcsIDIwMjUgYXQgMDU6MTQ6MzJQTSArMDIwMCwgQmVubm8gU2NodWxlbmJlcmcgd3Jv
dGU6DQo+PiAtKmFyY2gqIFtvcHRpb25zXSBbX3Byb2dyYW1fIFtfYXJndW1lbnRfLi4uXV0N
Cj4gDQo+IFRoaXMgaXMgbm90IGEgYnVnLiBXZSB1c2Ugc3ltbGlua3MgZm9yIHNldGFyY2gg
dG8gc3VwcG9ydCBzcGVjaWZpYw0KPiBhcmNoaXRlY3R1cmVzLg0KDQpBaCwgb2theS4gIFRo
ZW4gdGhlIG1hcmt1cCBpcyB3cm9uZzogaXQgc2hvdWxkIGJlIF9hcmNoXywgbm90ICphcmNo
KiwNCmFzIGl0IGlzIGEgcGxhY2Vob2xkZXIgd29yZCwgbm90IGEgbGl0ZXJhbCBjb21tYW5k
Lg0KDQpSZXZpc2VkIHBhdGNoIGlzIGNvbWluZyB1cC4NCg0KDQpCZW5ubw0KDQo=

--------------BOr1eOeCr5CG7sa6dj6DqTqg--

--------------OvcBndutaBTX2acm6nHegiJx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmf2P4IFAwAAAAAACgkQUUu+Lrjhlh/9
2BAA3nM1lNJpx9K1PxiU3ioaBEXfhycdS14KtRi2x/ZRfghxpfDTPokkNSoB72Up7F1lcacIq80E
OT5cBPKAodU8o3oljA7DpcmvSj47HvUAK0/+a7CIX0DSNCzPoVMWSum+dWImwdSWtz/u8Vq8B97c
gbQxBU1x96F2N/G7hFB4zoWpr+0+LUVynvGsbaQUG+e32lQImQfW3N4Gbo3v49y8BvyMb3FEjU3O
qk+9PFS5AdstckUdvCJdfLdSUUlhD6UQR/kO6TEFUJFD1AK/jVWMpO62z67IZCWGTPgbLcl9xCPo
z/Q/GXu2ckQc3c6CSQzyi0cqCFfd4R5xnVQM6SgVsch9OVIi/vgajbZHQ8FVzPD7I13IaPGL4H3O
DcHrFjqBhDlAnThdkyYiuPqG5qcTBBdO9X6VZXjg0W//W1/Li67ZumfjldDAs06nhE2SWdB4aRat
8ugEnsdfSdoI3rdxPbK+y2y7aKKOCkC+auue4U3+f15ARt7KKiRRlOvXLcwicLeESpWr6BygETsv
+pSDA0Q2u+UXhZFcZzyVXsunBKNpZV3f72d7d2D5taSIsPG0cFuRmu151V1JvvXtrPhofp2ZUu/s
ubbcJif0PhWWPIKcILtm5srjbrZkGdpxdCKRjd0sfPSVxP/WOr1m4GeWidcxmwkeN3kwyJf9ZiXm
LzU=
=Y69f
-----END PGP SIGNATURE-----

--------------OvcBndutaBTX2acm6nHegiJx--
