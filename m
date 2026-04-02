Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2829D266
	for <util-linux@vger.kernel.org>; Thu,  2 Apr 2026 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137126; cv=none; b=S36/IVXSLuZvi9vD3J+Qt77CQc53ojX11/M/RWcPhLIcXTv+MxQht7/JDkrowL+XOHd/QVWuZtxV5JSkgss2pRwObVOlBBWv14PSmk14qpY5oRSJIvJetsg1faIiM6gbKL80bOx7kEJqTsykInRomduJuASqMmRLdbtJraRiSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137126; c=relaxed/simple;
	bh=trOkVH3kpji4IYrWwsY60CpFHxGCv2ChI5sRZInNSs8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=BC+RrwQgfXzjyPqZ7iHt5VM0yswjeKDEpt+0YgF1yzQlR4PhzBgByZ0VNulHJ6pFDySwl9pS4QhI4C8hSLqR2Va96HmT8HwUhuNgY7pkQjPUfk4eQ5/R1dBwPT/uJztsqfAB5gt8d5hOBaWZSK5JKshH6roDSdRW8KhEEaq9IvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ttxwyr5G; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ttxwyr5G"
X-KPN-MessageId: 4273b053-2e99-11f1-92a9-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4273b053-2e99-11f1-92a9-005056aba152;
	Thu, 02 Apr 2026 15:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:from:subject:mime-version:date:message-id;
	bh=trOkVH3kpji4IYrWwsY60CpFHxGCv2ChI5sRZInNSs8=;
	b=ttxwyr5G7DlPKgMoqa8ZPeUvHYsYHNj3KSD9KyYcyTGnDbf+giv0SKjCBdzxP4x7mNfaOwd6SES8F
	 k+wLMCef40sGqWJmfzNS24XTuFM1VADseX60tHcqaWnVrfxEYLaAMn7Lhh0Xv8WMHQOvTopVUoRPIu
	 NzMnAfLf28MHbLo8=
X-KPN-MID: 33|uPO9E6o94e+ffWZC35sI7dkiBx4DBVZolkAHZDk9fChi/7yDyIlqD+bSRSmoOm/
 G9kwkkw/g5hWTnVHCWrIydQ==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|8YgLStlUWhPH1XQGin8qjTk5MFy7ikWAQlimcyup2p048zRXD1t/TJ4nW7+xg1F
 o5BV+UlJWFauquosn6sByYA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4250af2a-2e99-11f1-8011-005056ab7447;
	Thu, 02 Apr 2026 15:38:40 +0200 (CEST)
Message-ID: <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
Date: Thu, 2 Apr 2026 15:38:39 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: the bad effect of tables on msgids
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
References: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
In-Reply-To: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3IwOhXHIfZvvtcLhTd70Xo3d"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3IwOhXHIfZvvtcLhTd70Xo3d
Content-Type: multipart/mixed; boundary="------------qwYrKQiRSGrnvKu8qE1VZLqz";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Message-ID: <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
Subject: Re: the bad effect of tables on msgids
References: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
In-Reply-To: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>

--------------qwYrKQiRSGrnvKu8qE1VZLqz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNC0wMy0yMDI2IG9tIDE2OjQ5IHNjaHJlZWYgQmVubm8gU2NodWxlbmJlcmc6DQo+
IFsuLi5dICBjaGFuZ2luZyBzaW1wbGUgbGlzdHMgdG8gdGFibGVzIDEpIG1vcmUgdGhhbiB0
cmlwbGVzIHRoZSBzcGFjZSB0aGF0DQo+IHRoZSBpbmZvcm1hdGlvbiB0YWtlcyB1cCBvbiB0
aGUgbWFucGFnZSwgbWFraW5nIGl0IGxlc3MgZWFzaWx5IGRpZ2VzdGlibGUsDQo+IEFORCAy
KSBtYWtlcyBpdCBoYXJkZXIgdG8gdHJhbnNsYXRlLiAgSSBkb24ndCBzZWUgYW55IGFkdmFu
dGFnZXMgdG8gdXNpbmcNCj4gdGFibGVzLiAgSWYgdGhlcmUgYXJlIGFueSwgcGxlYXNlIGVu
bGlnaHRlbiBtZS4NCg0KUGluZz8NCg0KDQo+IElmIHRoZXJlIGFyZSBubyBhZHZhbnRhZ2Vz
IHRvIHVzaW5nIHRhYmxlcyBpbnN0ZWFkIG9mIGxpc3RzLCBwbGVhc2UgcmV2ZXJ0IA0KPiB0
byB1c2luZyBsaXN0cyBmb3Igc2ltcGxlICJ0YWJ1bGFyIiBsaXN0aW5ncyBvZiBpbmZvcm1h
dGlvbi4NCg0KDQpCZW5ubw0K

--------------qwYrKQiRSGrnvKu8qE1VZLqz--

--------------3IwOhXHIfZvvtcLhTd70Xo3d
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmnOcWAFAwAAAAAACgkQUUu+Lrjhlh8u
eQ//S40YmsVO2mv7LXbeJeDqzDmaT3bBt1/jdc8GJoocou4f1XpJ5C1d7ZlGSJCHJtALp+FqX5Pu
MK4NtuEwkFVlxzqBWg3kFSZdcx0NwxfSI3T84iLTirkH92aLnx7AWK9Dgf3sTOC8UQU8oCw0KfKC
dB4oZ1cGorAU2Bg0WQnW+lfEvCHoYTJCwvq1SdqYsJD1FY2TkhARNNm2u0JkZBF8SRLICN6i2ePX
lr4OIBV0BSPJw9NFAC7HjnCVeyzM+cexZeXhoOwhTOqEE9h/eL7jAlSbDiZ8YzHQm3BWpDSmDpto
guQhP15AzUSNHandIRk/TxqO+abUdQDH8HNq9B+LyivjNfhpFt8F3fZc8CSV7dYcJuPRlBjvWf5X
+QdnzXbpoq3Jqv6brWqodql9CE64hMddCVW3EKU30u07UalBYqDm8LlsKU+xEP80fKfQPltWStrN
McQ0LhrKnkbp6HiIMKpKH5bEHTKvjnk0hxaXW73alverfscRTq6bNY7Go/2KyxrjT0UzJVoPLud8
x22m17MDSG/UlMEta7M47vLqlKkuSsm2dHncQDFKd8Um3clmTnuYKbw621kUp1pEorZnA/wL+0A5
DdPpSiDIPFUQ0qmplsUQS3DiUreEXeLXC0dXRb/bwAf4F4MnU7Bkhx1LOVR7amch2uTuvTW4B6lC
IyY=
=gKsB
-----END PGP SIGNATURE-----

--------------3IwOhXHIfZvvtcLhTd70Xo3d--
