Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F279231A30
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2025 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571198; cv=none; b=nCq3YFQMza+PDuOKXdyo5eNenTYHJO0NzkD7vWStQ9UJ3ZJqj9qvmqHvU8rQcqLeqeX0u7k2+mnzBS1tk+fGqf/R3JJEbtmItAxrmZjRLMbXvcK9r/9SkacKNH2bgDDAHwYsryou6M4kafknDGHRETZ1ctdDXXu1XSVVy/3hhfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571198; c=relaxed/simple;
	bh=C/Jn79MPAuLjqHB6BMqx7y1H6hVWRywMwLeYg/+bEuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vze41rJcsa16RDLgq1JTF+PyeEGKzY9CpxHxrDclzNXCLuE00wRw6Hpd18otiXzV+YXcIvqMNtBXjr09+4sSJaP+pOdqUOfWUPqoJpa3u0H6d61RoDfpc36yRKEJ73/pItaJxA9XiceNXaVscPEpRSRUWOiDrF2o6+hhG+Cd4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ItzqRhjH; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ItzqRhjH"
X-KPN-MessageId: 10cfd44d-615d-11f0-bc32-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 10cfd44d-615d-11f0-bc32-005056ab378f;
	Tue, 15 Jul 2025 11:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=C/Jn79MPAuLjqHB6BMqx7y1H6hVWRywMwLeYg/+bEuw=;
	b=ItzqRhjH6BFJwZmIl3tLEYlLksPlpQgofkM6Q6eRgxbrfai0S4T5H0FQIWxiyDPjh+WJg6TDvcXKj
	 MGi1GRBL5b4Zel1WgZrYdO/2wfzdxKAjxuPHh21h9vCeRPYSPP60CeidyW5VY+nDE2OoTmZlrt70gU
	 L0QwYJ2zxu2hzAQM=
X-KPN-MID: 33|6Zu48gyBEoK4RYHT6zd7yConxaEcy2xSIWRcyP6l8sMbdL0Ov/SOm6tVZ4BV+ob
 sGBEwhArFr1fDn5uNxhxZduaD6nIw66H+eIwdA7K3dGA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VSookExIxgkSSHUY3CW3jcaf8YdzMfx1t2A/qKidNDN9HJaV99kMenIsSJBZsQu
 aGkvnGIes2HJhfbh9TimiZw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d9b67b4a-615c-11f0-95bb-005056abf0db;
	Tue, 15 Jul 2025 11:19:46 +0200 (CEST)
Message-ID: <378538ce-013c-411e-93e7-ef37f2bc94ab@telfort.nl>
Date: Tue, 15 Jul 2025 11:19:46 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chrt from git segfaults
To: Karel Zak <kzak@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
 <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1jS0kEpBq2J6L7amSMhbx4dV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1jS0kEpBq2J6L7amSMhbx4dV
Content-Type: multipart/mixed; boundary="------------7N5PGssHeF02nyszt9Qa2y1T";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <378538ce-013c-411e-93e7-ef37f2bc94ab@telfort.nl>
Subject: Re: chrt from git segfaults
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
 <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
 <3239b9c9-844e-40c0-9735-604842af6953@linux.ibm.com>
 <25e238da-af73-42fa-ad18-8d9e77d33bab@telfort.nl>
 <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>
In-Reply-To: <fgeg2ezfxn6ofip7huhofg6a6mmx2yqn37p2j32rfxn33mpgyu@c2ldx4q6zvzu>

--------------7N5PGssHeF02nyszt9Qa2y1T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxNC0wNy0yMDI1IG9tIDEzOjMyIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBJIGhhdmUg
bWVyZ2VkIEJlbm5vJ3MgVjIgc2V0IG9mIHBhdGNoZXMsIHNvIG5vdGhpbmcgZWxzZSBpcyBp
biB0aGUNCj4gcXVldWUgZm9yIG5vdy4NCg0KSSdtIG5vdCBzZWVpbmcgdGhvc2UgaW4gZ2l0
IHlldC4gIERpZCB5b3UgZm9yZ2V0IHRvIHB1c2ggdG8ga2VybmVsLm9yZz8NCg0KDQpCZW5u
bw0KDQo=

--------------7N5PGssHeF02nyszt9Qa2y1T--

--------------1jS0kEpBq2J6L7amSMhbx4dV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmh2HTIFAwAAAAAACgkQUUu+Lrjhlh8c
BRAA2bdWJtUhO2qGs1lC4U7Ffufk3+4SsCzc/SRZSUwC/fmi4WY72uCTdwWmvNYIccpy/lCwiYtS
IAg8hia4gBRyiYy6fAOouvC3CFRBx5b76kTX966DxP8AD5vOwG7noWtZT/Iv08cpKTVa1C1d0saw
sdXJ24Y1FrLoawIUOP36KkBB6y5I5ygSqnTM15hamgy81ISJrVzNO5J5P9KP8ifcPASKk1jvBukj
tlg5E2Lv5A4XD06vrIUCPziTAb62H8zsZR+pPVgdVqks7pjeap+yRRrcTPbjTbokJrc9NatYCTo/
OtFioqFw0+x35vY3QvayGfQXL2KEdlIYIVtMKSGayV38jA6Wko8INljYM56j64gbHJmrk/a/xM4m
yaV61FqtJgZuFenhq+GGQ2RyS6DjceNRqxN0OUZgwV/cilo88xKJSU4dkuq4pXDruPP+KhPLjKyU
yAV5BhkabiPgAXPb1THiYZQZtIH7VIDiTJ7i0WWt++c4Aq9lYFF66nV4jvds+J1MFU9GWJu3i/P2
mO2JNlVIF+mWb3ufeyhWlRme8dzGvmz5OgjnhrSXcjNJxyEtroj8ibNVPHkkZhZ65Bbic65W3J+S
beeAFb/FqJVblgE8F0GmTzKKvMV3tVC+hRmM1euGgdbwCIM+EgqQhLUQMrbPEsYPq8RT+z4cgLzC
B1Q=
=fXah
-----END PGP SIGNATURE-----

--------------1jS0kEpBq2J6L7amSMhbx4dV--
