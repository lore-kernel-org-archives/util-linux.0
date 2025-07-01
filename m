Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4711487E9
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376894; cv=none; b=sPrZlUneUe0/C0YP9UXxOtmH7Lh6L38aQYu9zzhYYAGCSfiPee6FT1JGStzFak56ws62fbCWsCfeY5hxJELp6feYVevHVfWdBsUdYYXxmoNI9ByfUCVt396Qo505vr1kdiM0/VZhAVPp1DEA3QUMslTia1h5uXV6nmEwWL5hyXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376894; c=relaxed/simple;
	bh=C4O8YGcIV7fqQGSWwbor5FVA8NTCSzWKrUMrhvoC374=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WJE4vUdTtEztw3fjtIv/IaE6/ntGaQd2bg+2c+wM6WAoi3bMOYzNRLtA4rtJSvMpsIwezRWlUA0+PA7Np8u5DFZHpo/sF7h+9Nt+hNXryHwaeveEG3/FNMPzMPEbUVSShLjHkqXIIQS3aGhaAfeqed3tNAeDLsQIxVly4y0cTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MFLa02tl; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MFLa02tl"
X-KPN-MessageId: 3d54be2b-5680-11f0-a833-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3d54be2b-5680-11f0-a833-005056abad63;
	Tue, 01 Jul 2025 15:35:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=C4O8YGcIV7fqQGSWwbor5FVA8NTCSzWKrUMrhvoC374=;
	b=MFLa02tl88rSUl9HBI7qsgIHDS5/ZttFVylXJ9BeRNXuEXBh8tg7DiU8eoTaKFXVQwWxbUGAYy8gd
	 TnakaaKBwVBYdGAO3k8Xmo91TUYNIpLBcy5bJnzsFS08KdI9xgQgkr+4rralepuq1k3oRfHEVu1eWk
	 NzFgenODoVUYoKE8=
X-KPN-MID: 33|Uj16hdcPIB8URFxW9HG0mN6lq0nyfcbdKHQvgt3PBJwPpg6QfoVnmB9JReszorV
 g8FW05ho5Mszvhh4zG4Xykr7jNqH9r8OXdGWcmVn2SvM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LYnuGr7X+IXgrTYOc5vewpU30qto0rhMz06CqgucNAEVesGEMYZrKl1c6iu9YYQ
 QwRgnb81d6++iNlc4NAN9EA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 25001d47-5680-11f0-9c3d-005056ab1411;
	Tue, 01 Jul 2025 15:34:42 +0200 (CEST)
Message-ID: <3f71b403-9c43-4d99-9d15-6d6708832a00@telfort.nl>
Date: Tue, 1 Jul 2025 15:34:40 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] chrt: do not try to interpret the --pid option itself
 as a PID
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-2-bensberg@telfort.nl>
 <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4ejXsFRwdK0wn0L0a1475PeA"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4ejXsFRwdK0wn0L0a1475PeA
Content-Type: multipart/mixed; boundary="------------IHQ4w4NZ1L1aam0Td3v9lN0v";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <3f71b403-9c43-4d99-9d15-6d6708832a00@telfort.nl>
Subject: Re: [PATCH 2/4] chrt: do not try to interpret the --pid option itself
 as a PID
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-2-bensberg@telfort.nl>
 <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>
In-Reply-To: <79eaa2c0-65be-4370-b44f-2e8a1730b671@linux.ibm.com>

--------------IHQ4w4NZ1L1aam0Td3v9lN0v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIZWxsbyBWaW5lZXRoLA0KDQpPcCAwMS0wNy0yMDI1IG9tIDA3OjA1IHNjaHJlZWYgTWFk
YWRpIFZpbmVldGggUmVkZHk6DQo+IE9uIDMwLzA2LzI1IDE0OjEwLCBCZW5ubyBTY2h1bGVu
YmVyZyB3cm90ZToNCj4+IFdoZW4gbm90IHNwZWNpZnlpbmcgYSBQSUQgd2l0aCAtLXBpZCwg
YGNocnRgIHdvdWxkIHJlcG9ydDoNCj4+DQo+PiAgICBjaHJ0OiBpbnZhbGlkIFBJRCBhcmd1
bWVudDogJy0tcGlkJw0KPj4NCj4+IFRoYXQgd2FzIHNpbGx5LiAgQWZ0ZXIgdGhpcyBjaGFu
Z2UsIGBjaHJ0IC0tcGlkYCB3aWxsIHJlcG9ydDoNCj4+DQo+PiAgICBjaHJ0OiB0b28gZmV3
IGFyZ3VtZW50cw0KPiANCj4gSU1PLCB0aGUgY3VycmVudCBtZXNzYWdlIGlzIGFscmVhZHkg
aGVscGZ1bCwgYW5kIEknbSBub3Qgc3VyZQ0KPiB0aGUgcHJvcG9zZWQgb25lIGlzIG11Y2gg
Y2xlYXJlci4NCj4gDQo+IE1heWJlIHNvbWV0aGluZyBsaWtlIC0tcGlkIHJlcXVpcmVzIGFu
IGFyZ3VtZW50IHdvdWxkIGJlIGNsZWFyZXI/DQoNClRoZXJlJ3Mgbm8gbmVlZCBmb3IgdGhh
dCwgYmVjYXVzZSB3aGVuIHRoZSB1c2VyIHNwZWNpZmllZCAtcCBvciAtLXBpZA0Kd2l0aG91
dCBhbnkgZnVydGhlciBhcmd1bWVudCwgdGhlbiBzYXlpbmcgInRvbyBmZXcgYXJndW1lbnRz
IiB3aWxsIGJlDQplbm91Z2guICBObyBuZWVkIHRvIHNwZWxsIGl0IG91dC4gIFRoZSBhZHZh
bnRhZ2Ugb2YgdGhpcyBzaG9ydCBtZXNzYWdlDQppcyB0aGF0IGl0IGFsbG93cyBmb2xkaW5n
IHRoZSBtZXNzYWdlcyBmb3IgInRvbyBmZXcgYXJndW1lbnRzIiBpbnRvIGENCnNpbmdsZSBv
bmUgaW4gdGhlIG92ZXJuZXh0IGNvbW1pdC4gIEZ1cnRoZXJtb3JlLCB0aGUgbWVzc2FnZSBp
cyBhbHJlYWR5DQp1c2VkIGluIGEgZmV3IG90aGVyIHV0aWwtbGludXggdG9vbHMsIHNvIGl0
IHdvbid0IGJ1cmRlbiB0cmFuc2xhdG9ycy4NCg0KPiBBbHNvLCBJIG5vdGljZWQgdGhhdCBj
dXJyZW50bHkgbW9yZSB0aGFuIG9uZSBwaWQgY2FuJ3QgYmUgcGFzc2VkDQo+IGlmIHNvbWVv
bmUgd2FudHMgdG8gdXBkYXRlIHRoZSBjdXN0b20gc2xpY2UgZm9yIG11bHRpcGxlIHBpZHMg
YXQNCj4gb25jZS4gSSBjYW4gbG9vayBpbnRvIGFkZGluZyBzdXBwb3J0IGZvciB0aGF0IGlm
IGl0J3MgaGVscGZ1bC4NCg0KSSBkb24ndCB0aGluayB0aGF0IGlzIGEgZ29vZCBpZGVhOiB0
aGUgY3VycmVudCBpbnRlcmZhY2UgaXMgYWxyZWFkeQ0KY29uZnVzaW5nIGluIHRoYXQgX2dl
dHNfIGluZm8gd2hlbiBhIHNpbmdsZSBhcmd1bWVudCBmb2xsb3dzIC0tcGlkLA0KYW5kIHRo
YXQgaXQgX3NldHNfIHNvbWV0aGluZyB3aGVuIHRoZXJlIGEgdHdvIGFyZ3VtZW50cy4gIEFs
bG93aW5nDQp0byBzZXQgc29tZXRoaW5nIGZvciBtdWx0aXBsZSBQSURzIGF0IG9uY2Ugd2hp
bGUgaXQncyBub3QgcG9zc2libGUNCnRvIHF1ZXJ5IG11bHRpcGxlIFBJRHMgYXQgb25jZS4u
LiBpcyBtb3JlIGNvbmZ1c2luZy4NCg0KDQpCZW5ubw0KDQo=

--------------IHQ4w4NZ1L1aam0Td3v9lN0v--

--------------4ejXsFRwdK0wn0L0a1475PeA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhj4/EFAwAAAAAACgkQUUu+Lrjhlh8D
SxAA3HbAtvJ+1nONYWtOI0ee3y6+fiavxadFnh7pn0WiAGVOBHHdcSTo3LHKhWCYiF+bi8uyhRrV
LzCmckPs8ULNR2CR4O1ohVkLFBgru6nGHXoLPaoCz98iePisTvaE6tUB6UeM8/jv2eXEWZM9Yd1Q
Xe4Qh5yNuruMEK47UGypMEGoXCKK9Z/e6G+nxtXWAGt2X8xv5vgqU+aCS7ft6DsAZqLAvk3zOKgl
vl47ktavb0IcvfWc4HgSy5Ug5un4FTlkLpnB0DHmFTEibpb+CojPxUKIRN6ShClaYoJZ7VRvcSuv
x1dQTkr14iHQAuSw4Xo5LQmXBqdkBfy9jcEX1hZ909UBWceKZuz/5EBrhqlh1L8AQ3ktt0Ibwd9F
ojuc6j6gwVhd1KfSg3zbIbSis6aMLVwZc68gBuU4ifD9t7/YRpshxjGqPF3g4DpyPbru/7s5QEZy
W/tPkqbOo+K1tcpLbpdCWWp1idk51hPwuNQw0LSLKyI97fHJh8yDZHRy2pTKAT6TMlJ9HTeRHzDX
6IMqs56tLmMyM7LZpesXOo3Mpu4ZtNl0ldNgwAw8UHN2BZN5Y8l6hkqS2Wz4ooMCN3dbF5Qvc0LS
rMSxCl8YGpoQ5dXzPLl2mmKzEFKGgDxtgzom3uccuo9VtbXCmkTdaw4iVEssSEXSD0wyHZulynQC
TKI=
=pIOA
-----END PGP SIGNATURE-----

--------------4ejXsFRwdK0wn0L0a1475PeA--
