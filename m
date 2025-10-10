Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304D22620F5
	for <util-linux@vger.kernel.org>; Fri, 10 Oct 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085323; cv=none; b=GzUEojMG0064jGNwVYuZ2Kz0mrnj9TWuz7zUcEsNHX+3e9tD6A/kU7v3QAs+QKl+EKWD0wrIWJNWoMAlk+B5Js0m3ZRai12kHLE+V6+br8gFlhLQJwsZuG23ytu9AvxRokqdw9cjwDAOu3dygJ/RqgsWHZAGafaLv3aupnPkt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085323; c=relaxed/simple;
	bh=azThfCDIkl27HDK7FwgtWvMoQrX0BMz+RN+lOCnCkpI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mBH7zMysfokOLsC6LTfzLXSG7p3U6Uql4i99fCS0YHCXK987wNd7DhPsDqid7FecuS+4qWz8c2+MQYs58I6KZJlDgxk4Ox9/tQnLFp/Nwahzm9o5E5eB9YoK5z+YAFSqZ/pHt9Y14DufOX6uP/9NcIQnvw7B9ifFemFzjPzy3Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=WDg5gRMK; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="WDg5gRMK"
X-KPN-MessageId: ed56fa69-a5b3-11f0-84a0-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ed56fa69-a5b3-11f0-84a0-005056abad63;
	Fri, 10 Oct 2025 10:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:from:subject:mime-version:date:message-id;
	bh=azThfCDIkl27HDK7FwgtWvMoQrX0BMz+RN+lOCnCkpI=;
	b=WDg5gRMKvOcEtpr7artko2B1FZwdXaIjsW3RekyV8r4My9zgzfhCje3Rdel+Lm1+usYOsihLZH4/T
	 LPzOGvtLZJ8yQr6FxVRtcTe//5jAi7IZMsPywZj/2URQpXhiQoIZQPxHNKNrP5z6JZbAh1OLX3azUK
	 Q4zgCj9KTWSe6FZU=
X-KPN-MID: 33|LwyOYmK8gPB1ZLapAp5cmnaH9qYY4JhUAyTqKLC+f8GCDLSapoOb+gkIIvXpCot
 E8Qg9Cp/G7VbkEUGYu9pxxabeS6bAvfzNgtRX5u6rOjA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|urYfICMLDz4Prn+Ngtjsc893DI1z0qSpoPXIbaTDexbOrMD4Xz2geh+l5+r0fqb
 aNS/n/prPRp/6da4COwKGew==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e4ca7ee4-a5b3-11f0-a6c9-005056abf0db;
	Fri, 10 Oct 2025 10:34:10 +0200 (CEST)
Message-ID: <b5af6e19-a9e6-42cb-9c99-31d501697833@telfort.nl>
Date: Fri, 10 Oct 2025 10:34:10 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: poor feedback when misusing `losetup`
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>
References: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
In-Reply-To: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dnlSewqcIViDRI0ZxhRIE9pz"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dnlSewqcIViDRI0ZxhRIE9pz
Content-Type: multipart/mixed; boundary="------------Y1Y1i2vCGHfQHYmJGU30xhkR";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>
Message-ID: <b5af6e19-a9e6-42cb-9c99-31d501697833@telfort.nl>
Subject: Re: poor feedback when misusing `losetup`
References: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>
In-Reply-To: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>

--------------Y1Y1i2vCGHfQHYmJGU30xhkR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwOS0xMC0yMDI1IG9tIDExOjQ0IHNjaHJlZWYgQmVubm8gU2NodWxlbmJlcmc6DQo+
ICDCoCAjIGxvc2V0dXAgbG9vcDINCj4gIMKgIGxvc2V0dXA6IGxvb3AyOiBmYWlsZWQgdG8g
dXNlIGRldmljZTogTm8gc3VjaCBkZXZpY2UNCj4gDQo+IEl0IHJlc3VsdHMgdGhhdCB3aGVu
IHNldHRpbmcgdXAgYSBsb29wIGRldmljZSwgb25lIGNhbiB1c2UgdGhlIHNob3J0DQo+IG5h
bWUsIGJ1dCB3aGVuIGRvaW5nIGFueXRoaW5nIGVsc2UsIG9uZSBuZWVkcyB0byBnaXZlIHRo
ZSBmdWxsIHBhdGgNCg0KU29ycnksIEkgd2FzIHVzaW5nIHRoZSBzeXN0ZW0taW5zdGFsbGVk
IGBsb3NldHVwYCAtLSB0aGUgYC4vbG9zZXR1cGANCmZyb20gZ2l0IGFjY2VwdHMgdGhlIHBs
YWluIG5hbWUganVzdCBmaW5lLg0KDQoNCj4gIMKgICMgbG9zZXR1cCAtZCAvZGV2L2xvb3Ay
DQo+ICDCoCAjIGxvc2V0dXAgLWQgL2Rldi9sb29wMg0KPiAgwqAgbG9zZXR1cDogL2Rldi9s
b29wMjogZGV0YWNoIGZhaWxlZDogTm8gc3VjaCBkZXZpY2Ugb3IgYWRkcmVzcw0KPiANCj4g
Ik5vIHN1Y2ggZGV2aWNlIj/CoCBTbyBJIHJlcXVlc3QgaW5mb3JtYXRpb24gYWJvdXQgdGhl
IGRldmljZToNCj4gDQo+ICDCoCAjIGxvc2V0dXAgL2Rldi9sb29wMg0KPiAgwqAgbG9zZXR1
cDogL2Rldi9sb29wMjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KDQpUaGVzZSBpbmFj
Y3VyYXRlIG1lc3NhZ2VzIGFyZSBzdGlsbCB0aGUgY2FzZS4gIEFyZSB0aGV5IHNlZW0gZXZl
bg0KbW9yZSBpbmFjY3VyYXRlIHdoZW4gdGhlIHVzZXIgcHJvdmlkZXMganVzdCB0aGUgcGxh
aW4gbmFtZSAobG9vcDIpDQphbmQgdGhlIGVycm9yIG1lc3NhZ2UgbWVudGlvbnMgdGhlIGZ1
bGwgbmFtZSAoL2Rldi9sb29wMikuDQoNCg0KQmVubm8NCg0K

--------------Y1Y1i2vCGHfQHYmJGU30xhkR--

--------------dnlSewqcIViDRI0ZxhRIE9pz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjoxQIFAwAAAAAACgkQUUu+Lrjhlh8k
vg/+LHzx7nB4DUohDfFY99B0dJxIPRWQC0VEzlg9t09i60LwF4cjZ6DlXn3wKm4rCLzh1eKCfkEL
BcPscqoMnjVzjmy+9GuzfsuhEx6TAvrojAgxscMDgjukEDP2sGGNNmatairXW88eSqPvpk81An7A
IkWVaIOd/dqLh7Jfd0+2yC5d2SH0j5vVnO7Uy7osEAtbhqbw5+1BNelei6qY4KGqGFlvZwEHU4AG
nlrBoVbCNSvtjLpKQfe8QNRrFvfJ/W0EKdCtB1Afx8vFKlC7yBoGXO8pl1siBYhKiZUKnEB4cCrD
aNk7vNPMgLJV6ygVYvLYC6nJmMdFLyRUiLKCyz11Z4SHx0+aeGArVHUZQWldRNPaVLJ7oA3KULdm
+djNwSlSuKomBekJPS8FB1qYdoDzSNSzaH/zaNQqAEfjyqwDg89j7NUw+JXMkjvnowHOESiUyUX8
YSmLfW5+ReorTaZR0QDd2di7xLvFmUi/LpV3eXn08aYBldwd/E0u61uQsdUitzjbd8vCZZ4CGdWT
GFGYLvRfnxHBz8lP35NCPqbv4pwBfjAZiXEX9vFqQ6QUNPRypS355xVR7GaHoMrZb33+oGE7H0sa
X2L3uThU1dPM35oF5uIA4hcXNZqTRNTPTcUrn+nLVwnNwLzwnyZ4VZzPLd7Q/s9b3TJg6jpBiM2u
d0s=
=SqWY
-----END PGP SIGNATURE-----

--------------dnlSewqcIViDRI0ZxhRIE9pz--
