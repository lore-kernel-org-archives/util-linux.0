Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1B2D6E7A
	for <util-linux@vger.kernel.org>; Thu,  9 Oct 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760003103; cv=none; b=auAbQ0syzf3BEPUCk/gqv16jsRmRraz3URHVob5LxPm+PimuxksKkNjvfJ3OStB/45dHUpJYsTikJmoQSXmCfY8Xe3m+s3tfoSboua+MAtLjVfytp5LjXrberVquICXUYcy0dY46mCuD+OvaPd5zAEr5HdB3zCnJmxAiBCvln2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760003103; c=relaxed/simple;
	bh=60Ins8lHIiZE3+s4z1JREwBHGIw1PmsRCu3RPDOb8Qc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=IzOGr/ePtd1NqYVikCQ6BhJg0AZLk361AsjGB821M3VRBtUk2HZO9CHDDtYGmkW/lzZW0ghKCGFnIiAH60QplJWwnDPz8naIQTyC2uemwTzQNOhJJuPg6GzAFeG6wvaBaE06VYZ5ADcNKBG86mQ0SRA+HbxAQ2Ej0rVfdVMolsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FfKC6dar; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FfKC6dar"
X-KPN-MessageId: a01d2df5-a4f4-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a01d2df5-a4f4-11f0-bd6b-005056aba152;
	Thu, 09 Oct 2025 11:45:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=60Ins8lHIiZE3+s4z1JREwBHGIw1PmsRCu3RPDOb8Qc=;
	b=FfKC6daro5FnAwXQruKBq93/dD4mqyIZtbC6fCkU7pRfBFGaERF99qe1RmocEe+qscNxnJyzUU2cQ
	 oS3Deaz2d1csXz02wXXlRSTBKVeaXM6D8EYlttxz9l9mP0z4T2jaOoeR8FO9Ezkk3YxeGV0g/HpSFY
	 /T2qQTH0ZzWYLnUA=
X-KPN-MID: 33|2B5FgtfaIyGNtL85UrzYlR9B71p4J47+V+TLTHUqZ5O9j/RLvZqdvu/S5Uvz6fR
 zrEcSnQXo7XhsVTuygsO1TQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vEMytptAyDUYEuyUMb7AjTgpV85sOPlIQm9Ox9zGHERKnBfd94tnnL9dpK6sObt
 nOT5IyMUxAhviP3hGmn7LVw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 9b20f272-a4f4-11f0-a6c9-005056abf0db;
	Thu, 09 Oct 2025 11:44:53 +0200 (CEST)
Message-ID: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>
Date: Thu, 9 Oct 2025 11:44:52 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: poor feedback when misusing `losetup`
To: Util-Linux <util-linux@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4No7Gz39Gu67V3G50Nzzcm44"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------4No7Gz39Gu67V3G50Nzzcm44
Content-Type: multipart/mixed; boundary="------------kF2sJajhik5Vj2DQMAjeSj0k";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>
Message-ID: <9ab7cfb1-511c-4bb5-b630-d8ea51836bfc@telfort.nl>
Subject: poor feedback when misusing `losetup`

--------------kF2sJajhik5Vj2DQMAjeSj0k
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpJJ3ZlIGF0dGFjaGVkIGFuIGltYWdlIG9mIHNvbWUgZmlsZSBzeXN0ZW0gdG8gYSBsb29w
IGRldmljZSB3aXRoOg0KDQogICAjIGxvc2V0dXAgbG9vcDIgc29tZS5pbWcNCg0KVGhlbiBJ
IHdhbnRlZCB0byBsaXN0IGluZm9ybWF0aW9uIGFib3V0IHRoaXMgbG9vcCBkZXZpY2U6DQoN
CiAgICMgbG9zZXR1cCBsb29wMg0KICAgbG9zZXR1cDogbG9vcDI6IGZhaWxlZCB0byB1c2Ug
ZGV2aWNlOiBObyBzdWNoIGRldmljZQ0KDQpJdCByZXN1bHRzIHRoYXQgd2hlbiBzZXR0aW5n
IHVwIGEgbG9vcCBkZXZpY2UsIG9uZSBjYW4gdXNlIHRoZSBzaG9ydA0KbmFtZSwgYnV0IHdo
ZW4gZG9pbmcgYW55dGhpbmcgZWxzZSwgb25lIG5lZWRzIHRvIGdpdmUgdGhlIGZ1bGwgcGF0
aDoNCg0KICAgIyBsb3NldHVwIC9kZXYvbG9vcDINCiAgIC9kZXYvbG9vcDI6IFs2NjMwNl06
NTc5MjA0OSAoL2hvbWUvYmVuL3NvbWUuaW1nKQ0KDQpXb3VsZG4ndCBpdCBiZSBuaWNlciBp
ZiBvbmUgY2FuIGFsd2F5cyB1c2UgdGhlIHNob3J0IG5hbWUgLS0gd2hlbg0KdGhlIHJlbGV2
YW50IGxvb3AgZGV2aWNlIGlzIGxvY2F0ZWQgaW4gL2Rldi8/ICBCZWNhdXNlIHRoZSBtYW4g
cGFnZQ0KYWx3YXlzIHNheXMgJ2xvb3BkZXYnOyBpdCBkb2Vzbid0IGRpc3Rpbmd1aXNoIGJl
dHdlZW4gc2V0dGluZyB1cCBhDQpkZXZpY2UgYW5kIGRvaW5nIGFueXRoaW5nIGVsc2Ugd2l0
aCBpdC4NCg0KDQpUaGVuIEkgZGV0YWNoIHRoZSBkZXZpY2UsIGZvcmdldCB0aGF0IEkgaGF2
ZSBkZXRhY2hlZCBpdCwgYW5kIGRldGFjaA0KaXQgYWdhaW4gbGF0ZXI6DQoNCiAgICMgbG9z
ZXR1cCAtZCAvZGV2L2xvb3AyDQogICAjIGxvc2V0dXAgLWQgL2Rldi9sb29wMg0KICAgbG9z
ZXR1cDogL2Rldi9sb29wMjogZGV0YWNoIGZhaWxlZDogTm8gc3VjaCBkZXZpY2Ugb3IgYWRk
cmVzcw0KDQoiTm8gc3VjaCBkZXZpY2UiPyAgU28gSSByZXF1ZXN0IGluZm9ybWF0aW9uIGFi
b3V0IHRoZSBkZXZpY2U6DQoNCiAgICMgbG9zZXR1cCAvZGV2L2xvb3AyDQogICBsb3NldHVw
OiAvZGV2L2xvb3AyOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQoNCkJ1dCBpdCBleGlz
dHMgYWxyaWdodDoNCg0KICAgIyBscyAtbCAvZGV2L2xvb3AyDQogICBicnctcnctLS0tIDEg
cm9vdCBkaXNrIDcsIDIgb2t0ICA5IDExOjI5IC9kZXYvbG9vcDINCg0KV291bGRuJ3QgaXQg
YmUgYmV0dGVyIGlmIGBsb3NldHVwYCByZXBvcnRlZCAiTm90aGluZyBpcyBhdHRhY2hlZCIN
CndoZW4gdHJ5aW5nIHRvIGRldGFjaCBvciBnZXQgaW5mbyBmcm9tIGFuIHVuYXNzb2NpYXRl
ZCBsb29wIGRldmljZT8NCg0KDQpCZW5ubw0KDQo=

--------------kF2sJajhik5Vj2DQMAjeSj0k--

--------------4No7Gz39Gu67V3G50Nzzcm44
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjnhBQFAwAAAAAACgkQUUu+Lrjhlh+l
iQ//U/I/ktTASzEgvYGt2S107R8EpjrWsQ5+8Es+zn8q8Hj/T6Za8UaOWdhUsJAe1jOc2njnndot
O5Hd1e0vcXTZimxZoJlejQyriHX47YpBlU7q97ejLVYLCrOq/HQ8W1jiSlBi6Arq28vr4FMTFQcQ
Q2dQx7vrHzD2U1+WGs0VzIRr82/xZqTH4byzQQDnla2VhgPieuP6q+lxN/rXzGcjTZkm6UBCy4tA
ZOPTMi0Uq3f5SKWVzAYyAHjZ9JPq7XtiTbYIM/yVa+9sYmt4pgxMxkaayW8S/hOZND2DOuryblJ5
Eg9jxbgyd2DS4O5SV8b2mIZdvMYV+rNWHtrW2M1hDreSO3+JP+1huiRhKiWW+U1J9uzehCF+pD/r
KCUDGICTllYyuaocIM2pCnRppNZ5gkjOUfZe33bTrtCEcXii5B9wy7hTv+2zBqec8/QquO5ZKCOu
RFCg7uZgSpkYlhI+PWkgBOYi9Fx+ExUoYwVK/QqpHKgQ9yYe3cfZsEo3xCdYUKs1LpHd22pn7yXT
lmGtHNER3VupGdld0kp0Ej/IGVhQ+jjR/5i3p4FsmY/EMJVYpzsVk1H15Yw9pvMGQKUzLTSBXKlj
+d8HuQS8qOFhMxxaTyViryqgZIFvVVf24SvitMzkBiFGyQSwVHLSCJuoRKiKh80lalYaCDnDwv/m
2Eg=
=/2om
-----END PGP SIGNATURE-----

--------------4No7Gz39Gu67V3G50Nzzcm44--
