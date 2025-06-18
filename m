Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC061FF603
	for <util-linux@vger.kernel.org>; Wed, 18 Jun 2025 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234783; cv=none; b=XM05l3rp26lphElABmuPJ6frN+fSOTTfCa/OTGSw87EtRzH0/Yjwpr5xp4U7wLhaOCuBgnAvslPo/lnt8vIjUDW8PFyPXoRr6l5q1jpSHf+5Jeic3kcBnH5aDR3+RRSokCa2jXOjgrtIvbZLaYPsMEXmshCfLvIYhEXJNBEgDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234783; c=relaxed/simple;
	bh=qTA3HdlH+9RXW2BYcmOkQBwbBP6nWbWCbGd4SDrVYJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y2CqQ1+8gZCFWoh1Gvj1HXd+RtmsDw0270+h9EPo7wbDxv1wa7c8oSJ57JKYFk662iPk+N0i9NUONhNUlQm57MH4F1YWnunA8R1VZr5laJvdGQXF0/HCfcw5RyE/CFNJFvhYNGM3ru0Nqk1J8yOQOyEt2dwlsdqzQ2rvN1IGXEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=JxEsMrNE; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="JxEsMrNE"
X-KPN-MessageId: ecd79d75-4c1c-11f0-bc2d-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ecd79d75-4c1c-11f0-bc2d-005056ab378f;
	Wed, 18 Jun 2025 10:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=qTA3HdlH+9RXW2BYcmOkQBwbBP6nWbWCbGd4SDrVYJo=;
	b=JxEsMrNEbtQLmMGQSISmpHip6fc2utKHge3fOZpwEKUBs347VDnS87VcAh1IpYY2SgldNryyv1XWa
	 159GOl94dX7cB3rl1gU/14RI78DU8MfoMhj8tZ0B2T4Jh3/IsuPiWbWkXeL92G2RhXthyHfLBVvQJE
	 bJv8ooUBde3REZvs=
X-KPN-MID: 33|+NC3b9mgKccENAdJ23b2+puEziE3HgR0rJ1vKtUSUpnW6M5hDrcgtM7/Fuq+fMs
 YYrdNmN5411A6YP+ykwnef5ZeF2RdauCT9lQBA/tlabk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8iS0I4hcQD0DHJp1tsNs0GDm3dWVr+BsWR714Q7aYY2IMljmR11NV5yzAXNpanb
 hAgaqH88DcUz9JgkpisNXjQ==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id d0cc4ca7-4c1c-11f0-9c5f-005056ab7447;
	Wed, 18 Jun 2025 10:18:29 +0200 (CEST)
Message-ID: <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
Date: Wed, 18 Jun 2025 10:18:29 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20250617182403.47095-1-vineethr@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------otePyqo0vD5jo7xvgLfCEZL0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------otePyqo0vD5jo7xvgLfCEZL0
Content-Type: multipart/mixed; boundary="------------0aKf0IXdGQ4Vphrpa92ccjwf";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Message-ID: <232025d8-cdb4-48a7-a7c9-7dc211f76173@telfort.nl>
Subject: Re: [PATCH v2] chrt: Make priority optional for policies that don't
 use it
References: <20250617182403.47095-1-vineethr@linux.ibm.com>
In-Reply-To: <20250617182403.47095-1-vineethr@linux.ibm.com>

--------------0aKf0IXdGQ4Vphrpa92ccjwf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxNy0wNi0yMDI1IG9tIDIwOjI0IHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IEN1cnJlbnRseSwgY2hydCByZXF1aXJlcyBhIHByaW9yaXR5IGFyZ3VtZW50IGV2ZW4g
Zm9yIHNjaGVkdWxpbmcNCj4gcG9saWNpZXMgbGlrZSBTQ0hFRF9PVEhFUiBhbmQgU0NIRURf
QkFUQ0gsIHdoaWNoIGlnbm9yZSBpdC4NCj4gDQo+IFRoaXMgY2hhbmdlIHJlbGF4ZXMgdGhh
dCByZXF1aXJlbWVudC4gTm93LCBwcmlvcml0eSBpcyBvbmx5IGV4cGVjdGVkDQo+IGZvciBT
Q0hFRF9GSUZPIGFuZCBTQ0hFRF9SUi4gRm9yIG90aGVyIHBvbGljaWVzLCBhIGRlZmF1bHQg
dmFsdWUgb2YgMA0KPiBpcyBzZXQgaW50ZXJuYWxseSBhbmQgbm8gYXJndW1lbnQgaXMgcmVx
dWlyZWQgb24gdGhlIGNvbW1hbmQgbGluZS4NCg0KRG9lc24ndCB0aGlzIGFsdGVyIHRoZSAi
c2hvdy10aGUtY3VycmVudC1wb2xpY3ktYW5kLXByaW9yaXR5IiBiZWhhdmlvcg0Kd2hlbiBu
byBwcmlvcml0eSBpcyBnaXZlbj8gIEN1cnJlbnRseSBgLi9jaHJ0IC0taGVscGAgc2F5cyAo
dHJpbW1lZCk6DQoNCiAgIFNldCBwb2xpY3k6DQogICAgY2hydCBbb3B0aW9uc10gLS1waWQg
PHByaW9yaXR5PiA8cGlkPg0KDQogICBHZXQgcG9saWN5Og0KICAgIGNocnQgW29wdGlvbnNd
IC1wIDxwaWQ+DQoNCg0KV2l0aG91dCB0aGUgcHJvcG9zZWQgY2hhbmdlLCBydW5uaW5nIGBj
aHJ0IC0tb3RoZXIgLS1waWQgJCRgIHNheXM6DQoNCiAgIHBpZCAxNDI3J3MgY3VycmVudCBz
Y2hlZHVsaW5nIHBvbGljeTogU0NIRURfT1RIRVINCiAgIHBpZCAxNDI3J3MgY3VycmVudCBz
Y2hlZHVsaW5nIHByaW9yaXR5OiAwDQoNCkFmdGVyIHRoZSBjaGFuZ2UsIHRoYXQgc2FtZSBj
b21tYW5kIG91dHB1dHMgbm90aGluZy4gIE1heWJlIHRoYXQgaXMNCmZpbmUsIGJ1dCBpdCB3
b3VsZCByZXF1aXJlIHNvbWUgYWRqdXN0bWVudCBvZiB0aGUgZG9jcy4NCg0KDQpCZW5ubw0K
DQo=

--------------0aKf0IXdGQ4Vphrpa92ccjwf--

--------------otePyqo0vD5jo7xvgLfCEZL0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhSdlUFAwAAAAAACgkQUUu+Lrjhlh9c
Gg/7BXKDK3J/fZDeicAkxWA9IMqOg8/ygG37Mo1Vi7rUiNGpmKKsfKQF4rnu3yP9oE3z270zeHD/
6IV5aDXpvX4qcO1rz6sL4KvL0GnGmcnTJSIHMqGxHvEZ5+TSogeJTqP+876F32jYhKTZ5iJn+8YF
gls9+J4ZwuZBVPkML1vRwWkHB548AmJdmQw1cP7Jxbahs0NY/HLGUKgHjisoWmFuJPKyL2LgQAGt
PxEZFnCC+4PJ/k+K3EvlSaN9Qm0eA09KhOIm9ujdYchz3RnNRE3GbcOxuo/xkBeKK0pLuGen8/Ck
x6iH25tK5UJv7WWVcCF5obpOCyQIHbS8u7olmlSECsZ22qAyUYUc2HKv2BYiEQnHGIhcUffHtp8l
Dxtvn1A9ZhfKRk4BXR0WNcEMNv/+j7gU8hrfHJnl6qXizZhM4o2aH5UEhZMHkblfecC6J6Ov4SuF
nk31xkZjtDnUxNj+HKCG7ST4fCpvlaXn6ol0JmxHNqzTw9CxLwqd/sPV3Q2TOoGBp5f9nA1N+6yD
tRTv4Gc7g/2KypvN8cKiXCWnTf5D79ZTHHwfKcF8ocCgJOAcVHi8nSbaZNblOoukKBer7iwP4nzA
cV+Er3+ePWJvlcw7Zft4obYaYaureA8M33vEQJO86dCoGnHbiGi5at32T+tpX5eashtGNN2IBUSO
yjM=
=BtJ6
-----END PGP SIGNATURE-----

--------------otePyqo0vD5jo7xvgLfCEZL0--
