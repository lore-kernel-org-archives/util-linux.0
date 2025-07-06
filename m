Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E69235972
	for <util-linux@vger.kernel.org>; Sun,  6 Jul 2025 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751793017; cv=none; b=DgLQlCm0kP/lacGCxgQgMMDHfcGTxPWt9WlARTh5czseZAg61d192q5JvnqVFwYXvvZRXiGYtKp+qO0k+0zsiOt1U6s7iwNI8n8n1NHAPYbrZnifY+BtWuEC6OHqY5Rgnfmf94JVLnw3Yad9F+eU7LF8axpN5hSXSJ2biUke5qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751793017; c=relaxed/simple;
	bh=SuA7WjzWlz2wJaYsVft5rK2I+wuHa/Gt6b8KiU4joxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fN5MdWTh1MWe3IFgCg+RixMm7mMjxIJ6qgUUhxNFIy48vBR9CtkcVPrxzp7G6AapSFhrD9lpfg8qL5F9xHbMSRhyxg+oT3cd1/y4GLREmGBrr0BJh8HpH/6q8ehPbmQVACaVl9B3n8AlAGGGaZpLZ2c4gjqxTuhlaxtevjuYiBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FLSn2yI5; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FLSn2yI5"
X-KPN-MessageId: 2ba3d453-5a49-11f0-bc2f-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2ba3d453-5a49-11f0-bc2f-005056ab378f;
	Sun, 06 Jul 2025 11:11:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=SuA7WjzWlz2wJaYsVft5rK2I+wuHa/Gt6b8KiU4joxo=;
	b=FLSn2yI5izEoxlrwbNiDdSVqw8MlkYUonPSkcDUNhcypGfV7AmVrxZLRRwExD1iY/Qezy5zOrytoI
	 nRoQqhlabglbOpU3fXLsfvkoQ5VNMYcHFNHB1lvkskUVeLq17KZybvTA/4h/XdoFF4PQrkXCRXZeL0
	 8WaB/JXSvramMbCI=
X-KPN-MID: 33|vWl5uD64PmBn+XP/q2kw8yYu/fUtcILT0g8rVV86iVfYnCs1vNCUtnU70j5D7al
 /s52PnwV+Z+4u9MwIloO4WonekwCMWiT5vaHNmJv8xB8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HCUpMsPAfQRumtvT8LBt9BsiCwQ0FuwiUjsfaItc7bYn0rO52Zfgyvsc/i6lXJd
 hfXEGO2FQIANSq+6HjXOs4A==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0127cc96-5a49-11f0-85b2-005056ab7584;
	Sun, 06 Jul 2025 11:10:04 +0200 (CEST)
Message-ID: <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
Date: Sun, 6 Jul 2025 11:10:04 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 V2] chrt: simplify the other check for too few
 arguments
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------v2Lhy7PBxLaFcfoPsDyd9tpn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------v2Lhy7PBxLaFcfoPsDyd9tpn
Content-Type: multipart/mixed; boundary="------------I0RHkjuKilEcVQmMbfPNhbIw";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Message-ID: <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
Subject: Re: [PATCH 3/4 V2] chrt: simplify the other check for too few
 arguments
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
In-Reply-To: <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>

--------------I0RHkjuKilEcVQmMbfPNhbIw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwNi0wNy0yMDI1IG9tIDA3OjU4IHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IEJ1dCBwcmlvcml0eSBzaG91bGQgYWxzbyBiZSBvcHRpb25hbCB3aGVuIC0tcGlkIGlz
IG5vdCB1c2VkLCBmb3INCj4gcG9saWNpZXMgdGhhdCBkb27igJl0IHJlcXVpcmUgaXQuDQoN
Ck9oLi4uICBUaGVuIHRoZSBzeW5vcHNlcyBuZWVkIGFkanVzdGluZywgYmVjYXVzZSBjdXJy
ZW50bHkgdGhleQ0KaW5kaWNhdGUgdGhlIHByaW9yaXR5IHZhbHVlIGFzIG1hbmRhdG9yeSB3
aGVuIGEgY29tbWFuZCBpcyBnaXZlbjoNCg0KICAgY2hydCBbb3B0aW9uc10gcHJpb3JpdHkg
Y29tbWFuZCBbYXJndW1lbnQuLi5dDQoNCg0KPiBXaXRoIHlvdXIgcGF0Y2gsIHRoaXMgZmFp
bHM6DQo+IGNocnQgLS1vdGhlciBscw0KPiBjaHJ0OiB0b28gZmV3IGFyZ3VtZW50cw0KPiBU
cnkgJ2NocnQgLS1oZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbi4NCj4gDQo+IHdoaWxlIHRo
aXMgd29ya3M6DQo+IGNocnQgLS1vdGhlciAwIGxzDQo+IA0KPiBUaGUgZmlyc3QgY2FzZSBz
aG91bGQgd29yayB0b28sIHRvIG1hdGNoIHRoZSBiZWhhdmlvciBpbnRyb2R1Y2VkIGluDQo+
IGNvbW1pdCBlN2EyZDYyNDM0YzIgKCJjaHJ0OiBNYWtlIHByaW9yaXR5IG9wdGlvbmFsIGZv
ciBwb2xpY2llcyB0aGF0IGRvbid0IHVzZSBpdCIpLg0KDQpXaXRoIGN1cnJlbnQgZ2l0IChv
ciBhZnRlciBjaGVja2luZyBvdXQgdGhhdCBjb21taXQpLCBhbmQgdGhlbiBydW5uaW5nDQpg
Li9jaHJ0IC0tb3RoZXIgbHNgLCBpdCBzYXlzIGhlcmU6DQoNCiAgIFNlZ21lbnRhdGllZm91
dCAoZ2VoZXVnZW5kdW1wIGdlbWFha3QpDQoNClJ1bm5pbmcgdmFsZ3JpbmQgb24gaXQgZ2l2
ZXM6DQoNCiAgID09MzgzNzA9PSBJbnZhbGlkIHJlYWQgb2Ygc2l6ZSAxDQogICA9PTM4Mzcw
PT0gICAgYnkgMHgxMEM2RUI6IG1haW4gKGNocnQuYzo1NzQpDQoNClBvaW50aW5nIHRvOiBp
ZiAoc3RyY21wKGFyZ3ZbMF0sICItLSIpID09IDApDQoNCg0KQmVubm8NCg0K

--------------I0RHkjuKilEcVQmMbfPNhbIw--

--------------v2Lhy7PBxLaFcfoPsDyd9tpn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhqPWwFAwAAAAAACgkQUUu+Lrjhlh/a
MxAA2W6xbCPkF0WXoqbGP8IHDE8gd1J7Aed+7JStqamXDjgBmBw0LAPrqTpozvWRAR0BW9iDj0L1
j01rNQxt7mjWwYhNDU9vNR1kcpgWMkWdZ6pNmvl7tAAtTfr4+/gX9aDcNUWdadbDKbsKEcjeQ++1
ZuYFN63UaykmHdvXDXpTOmS8VZsie4JsDo/j9Ybwztumw8szo3jxd+o7UxJCG3BanQBb9zyo13J3
K7Pu5h8t9OuQP+NGnHoyo1WUYdbEzKguKILJUYuAvz/1uI571/BCBJhOACGPfQcikEqzogZgp11b
wQaoYdlAtVMd85bpe32+BO2R142tOGByh8yHE8EEYbnl9G3E116vd9D79TmFxAruaAM7HGBSSky0
JUF7OZUjUluxAcj3paWU+pfIcykl//IJjEf0n9APRp6qFzMQCGUOsnYGdEJ0pZF+oQoZnORNnqY5
eyBZI/Smy/lajZawkiMlE1Bh0dTW6RhBysHoPe13UErmlCy1Ju/0F0GQVRdKv9KeSTE1I017PDIq
K3FrE6EVdZtGVNIgC5Ad7Enfk6sroMePhlfNFOJv6fIGxYYKt53qg9FpW4gaOKVy3XNF3eidO5So
fG26NLWhDBH0juALeCfpNuJdeZGzTCzSkgGPgjWS5fDuEuUZlMCSsapA2P0AaWKuBKsvXllwoml2
GOM=
=KNgF
-----END PGP SIGNATURE-----

--------------v2Lhy7PBxLaFcfoPsDyd9tpn--
