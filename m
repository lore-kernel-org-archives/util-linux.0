Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB3A366049
	for <util-linux@vger.kernel.org>; Tue, 24 Mar 2026 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367455; cv=none; b=ljJ6ImPoZjU+bUa6Jy3ahrzMA0cuJt8yaWsz48Z/MrLX0oSOCyjGXyngGb7i5adgzhlCn1cKLF0H9p2/baSC0pqr444YrCxrWHFMj5k0RMdCh8LwdDu7xDShlpuJOy6LWz2afzNs3HCB46f5A+aWl7m8D8M8Msd0I3p+xpwdifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367455; c=relaxed/simple;
	bh=jwglVHg3I06KCO3ls1ygCOTbVi3rmkUUMFxNmU0Y2Oc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=riI9vyZ3I7A1awZ1DXZBOIEt6PQI7Duta+5txBb+hMbkPRidlgyr51RjVY3YHzUY+4AiSVHk++fYa1KZsRhIo/FQBPiA+hJO3uJDUDfC5llkZ/e53x5KkdfFG0M/sTccJCCblt/xz4DskJ8HEOyaasP5PQjOIrG9GYJOj+3HRCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=w5HOwTga; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="w5HOwTga"
X-KPN-MessageId: 12fa7731-2799-11f1-b183-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 12fa7731-2799-11f1-b183-005056abad63;
	Tue, 24 Mar 2026 16:49:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:subject:from:to:mime-version:date:message-id;
	bh=jwglVHg3I06KCO3ls1ygCOTbVi3rmkUUMFxNmU0Y2Oc=;
	b=w5HOwTgarr1AyzEa9oO7ShWCaJlZqiGHrqwyHL3wkuRxT0+mLJVLR/rl/dEgBxMwKetHtK4VtuakP
	 AGNAQI/zaCphBbDnxdju7iSnj4LLm2+WseO8fyskSaJMNqDZHKjPnB4nGb0dH8wmXanXGbMKjRfcAF
	 WFOfM2yn3xQ+bGXo=
X-KPN-MID: 33|25vh0Rd3nL07k+y6SBPar/K2UWQ3NnDvmhjT82qNroLAOSbeGul0wjIY1jt9vo9
 Vb2I5Wql6EHXJ6WWW7bgdEf2bAjgHEXwSRko1fe4BlvQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JYPrtF98d2tmkd8r7VXX7H90FdTqpky/4np+mujoMT6cQgVkTw1SfFqPHOeDlwj
 D2fZLUfDv2nlo3FhA1uFFtg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 12d3bc52-2799-11f1-8011-005056ab7447;
	Tue, 24 Mar 2026 16:49:42 +0100 (CET)
Message-ID: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
Date: Tue, 24 Mar 2026 16:49:42 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
To: Util-Linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: the bad effect of tables on msgids
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Oa1nhX90YV8m5VVwvkkbLbUp"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Oa1nhX90YV8m5VVwvkkbLbUp
Content-Type: multipart/mixed; boundary="------------sdrN5RKt5uAGj6qUDNrUcrJT";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Message-ID: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
Subject: the bad effect of tables on msgids

--------------sdrN5RKt5uAGj6qUDNrUcrJT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIaSwNCg0KQ29tcGFyaW5nIHRoZSBQT1QgZmlsZSBmb3IgdGhlIG1hbnVhbCBvZiB0aGUg
dXBjb21pbmcgdjIuNDIgd2l0aCB0aGUgcHJldmlvdXMNCm9uZSBhdCB0aGUgVFAsIEkgbm90
aWNlIChhbW9uZyBvdGhlciB0aGluZ3MpIHRoZSByZXBsYWNlbWVudCBvZiB0aGlzIG1zZ2lk
Og0KDQogICBtc2dpZCAiIg0KICAgIiAgIGY6ID0gdGhlIHBhdGhuYW1lIGN1cnJlbnRseSBi
ZWluZyByZXNvbHZlZFxuIg0KICAgIiAgICBkID0gZGlyZWN0b3J5XG4iDQogICAiICAgIGwg
PSBzeW1ib2xpYyBsaW5rIChib3RoIHRoZSBsaW5rIGFuZCBpdHMgY29udGVudHMgYXJlIG91
dHB1dClcbiINCiAgICIgICAgcyA9IHNvY2tldFxuIg0KICAgIiAgICBiID0gYmxvY2sgZGV2
aWNlXG4iDQogICAiICAgIGMgPSBjaGFyYWN0ZXIgZGV2aWNlXG4iDQogICAiICAgIHAgPSBG
SUZPIChuYW1lZCBwaXBlKVxuIg0KICAgIiAgICAtID0gcmVndWxhciBmaWxlXG4iDQogICAi
ICAgID8gPSBhbiBlcnJvciBvZiBzb21lIGtpbmRcbiINCg0Kd2l0aCB0aGUgZmFyIGxvbmdl
ciBvbmUgYmVsb3cuICBJdCBzZWVtcyB0byBtZSB0aGF0IHRoZSBhYm92ZSBvbmUgaXMgZWFz
aWVyDQp0byB0cmFuc2xhdGUgKGJlY2F1c2UgY2xlYXJlciwgbW9yZSBjb21wcmVoZW5zaWJs
ZSwgd2l0aCBhIHNpbXBsZXIgc3RydWN0dXJlKQ0KdGhhbiB0aGUgb25lIGJlbG93LiAgU28u
Li4gY2hhbmdpbmcgc2ltcGxlIGxpc3RzIHRvIHRhYmxlcyAxKSBtb3JlIHRoYW4gdHJpcGxl
cw0KdGhlIHNwYWNlIHRoYXQgdGhlIGluZm9ybWF0aW9uIHRha2VzIHVwIG9uIHRoZSBtYW5w
YWdlLCBtYWtpbmcgaXQgbGVzcyBlYXNpbHkNCmRpZ2VzdGlibGUsIEFORCAyKSBtYWtlcyBp
dCBoYXJkZXIgdG8gdHJhbnNsYXRlLiAgSSBkb24ndCBzZWUgYW55IGFkdmFudGFnZXMgdG8N
CnVzaW5nIHRhYmxlcy4gIElmIHRoZXJlIGFyZSBhbnksIHBsZWFzZSBlbmxpZ2h0ZW4gbWUu
DQoNCiAgIG1zZ2lkICIiDQogICAifGY6XG4iDQogICAifHRoZSBwYXRobmFtZSBjdXJyZW50
bHkgYmVpbmcgcmVzb2x2ZWRcbiINCiAgICJcbiINCiAgICJ8ZFxuIg0KICAgInxkaXJlY3Rv
cnlcbiINCiAgICJcbiINCiAgICJ8bFxuIg0KICAgInxzeW1ib2xpYyBsaW5rIChib3RoIHRo
ZSBsaW5rIGFuZCBpdHMgY29udGVudHMgYXJlIG91dHB1dClcbiINCiAgICJcbiINCiAgICJ8
c1xuIg0KICAgInxzb2NrZXRcbiINCiAgICJcbiINCiAgICJ8YlxuIg0KICAgInxibG9jayBk
ZXZpY2VcbiINCiAgICJcbiINCiAgICJ8Y1xuIg0KICAgInxjaGFyYWN0ZXIgZGV2aWNlXG4i
DQogICAiXG4iDQogICAifHBcbiINCiAgICJ8RklGTyAobmFtZWQgcGlwZSlcbiINCiAgICJc
biINCiAgICJ8LVxuIg0KICAgInxyZWd1bGFyIGZpbGVcbiINCiAgICJcbiINCiAgICJ8P1xu
Ig0KICAgInxhbiBlcnJvciBvZiBzb21lIGtpbmRcbiINCg0KKFRoZSBhYm92ZSBjaGFuZ2Ug
d2FzIHRoZSBlZmZlY3Qgb2YgY29tbWl0IGE4NjE2ZDFhNzYgZnJvbSB0aHJlZSB3ZWVrcyBh
Z28NCmJ5IE1hcmlvLikNCg0KSWYgdGhlcmUgYXJlIG5vIGFkdmFudGFnZXMgdG8gdXNpbmcg
dGFibGVzIGluc3RlYWQgb2YgbGlzdHMsIHBsZWFzZSByZXZlcnQNCnRvIHVzaW5nIGxpc3Rz
IGZvciBzaW1wbGUgInRhYnVsYXIiIGxpc3RpbmdzIG9mIGluZm9ybWF0aW9uLg0KDQoNCkJl
bm5vDQoNCg==

--------------sdrN5RKt5uAGj6qUDNrUcrJT--

--------------Oa1nhX90YV8m5VVwvkkbLbUp
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmnCspYFAwAAAAAACgkQUUu+Lrjhlh8L
ZA/+OxLLeDt5UjirRC5eekh1kuUWLRDdl0rimxjKL1+SdEuyQrntqxrTnY8hGW/2PZKGhn/BetFx
y9nwo71WzGkFLr6vzjWPZPKG8KSq2AzU2B65iV3XgzYVO2dpKj37NU62Wbup+IM7I+XBO7dT+ZCD
cQkYdNMHC8/N20mIzKQyhkmxygnxuY4tLUJtTjxTrmfZ3Rktl9uSrYusVsoDa/KQZyMQq18vwBrC
/0fKaP7wEz5F0Qv8OfdbdSpg9US3aXpiP1QP4AGSS8527HaOjdGct27LZhfMFE3GikLyq1dH6dGo
O2Nrcf+S4YekZAbVtS8Xy/j89VNFQ/523giW6LUSGkcoR43nmqsf3rmLFq8pef+lwU9tTQQKSyzH
ao6cMwf584eUfnfGS0A8tepH58W/xcfaWX/YzXVWNcZJKtP6X+S3LGmvrbeMDnhqBvatKYQv23cK
HF5pF2vAsVpq9H9tdSX3pH/gAeFUl7lavRm2SNsRQaMYbUtZTUOBlCU3vPUzrqZqbPiGUs9lQxUu
RG0qiLzlQPtySXfY4B72hypfDvKVELoAiaH3xJPrT6rlyszIXM8/5xx6du6mOKXDh+XmC10nRyS9
aD8JO4R9EccO1x8ScINYOk3nuZyl8vwyoEGax99uvRk9v+yCjmNvgWo5y9y+yu8TPm67Pq12JOPo
jFk=
=hbc/
-----END PGP SIGNATURE-----

--------------Oa1nhX90YV8m5VVwvkkbLbUp--
