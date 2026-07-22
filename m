Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBF360EF0
	for <util-linux@vger.kernel.org>; Wed, 22 Jul 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731311; cv=none; b=tYldHSx9OfALL8gAMJv7ob2fzdk1vuBkJzBEpdZyCCtDK4vh45w6uVAR+Tt9iDMna+swxCh3qqKyn8cmKBOdUdCwN98JQ307bP3zyWH/2mF4zb2H2V4RxIqQfSaBIcZbU/zp8GkFwdEByNLfMd/0RjLB8D2UroQPFkecUM5hZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731311; c=relaxed/simple;
	bh=6qu8zI0StWWzeicuix5Z8VMGDqVVcXVMzQ/FXPv8HTs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=VR6psuSS82mLwA6ED1aDk1i7xVkIyvzPR6Racfq3oNUpqKYp1U1YheDj5GvcfQbh7GJoZ2Q3gyElW8aGvsmnUrycNCxjnqAQSwf7InKjInm3ALdXtAeN8v8pb4Ty+zsLEjmL9d7nrL5p1rn7WnmLc6VTepEy6S5VbvYUAddJAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nsTIuya2; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nsTIuya2"
X-KPN-MessageId: 7271d541-85db-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7271d541-85db-11f1-861c-005056aba152;
	Wed, 22 Jul 2026 16:41:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:subject:from:to:mime-version:date:message-id;
	bh=6qu8zI0StWWzeicuix5Z8VMGDqVVcXVMzQ/FXPv8HTs=;
	b=nsTIuya2LQYmFVl00aUY+hVj0ysjtYfvq9Ttug0fP/nfrmNGUccGHu+gq1tT6K664djYQHeVc38Cj
	 K57oa8j5vbf4Wpa6s6BFjzap+/uIz+iZTsQmX7BE17WUv2dGjIA1X//CWX2dTdlHDSsSJOoVuMMNeT
	 7+b1SVP6CgXVdonE=
X-KPN-MID: 33|uFX6uE+SkP3ccEaDWEexr7sTaepFMuPkIsylAdKmbifHkb8I2eLPHMyi//Cs9qX
 pKDmWiJMxYwO9OrpL2jeKk+bDhF2B8J4ZzRqLpFmEymk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/afzrWD4X/t1jFHnQ+PZnT3okP6zRChJa3PKBB0iTVkGSeg80FebPxiW+MZ02Lo
 m5/+DPFPI8Y/bukCCWG4eFA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 724d66a7-85db-11f1-a8b5-005056ab7447;
	Wed, 22 Jul 2026 16:41:38 +0200 (CEST)
Message-ID: <80a2f0de-b88c-4630-bb3d-bab24863fb18@telfort.nl>
Date: Wed, 22 Jul 2026 16:41:38 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
To: Util-Linux <util-linux@vger.kernel.org>
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: the offending %s in an sfdisk message translation
Cc: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AI9ElGvr5jfd8QDgCYu80nhX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AI9ElGvr5jfd8QDgCYu80nhX
Content-Type: multipart/mixed; boundary="------------880v2LvafSpwBbv2b03suQwU";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>
Cc: Christian Goeschel Ndjomouo <cgoesc2@wgu.edu>
Message-ID: <80a2f0de-b88c-4630-bb3d-bab24863fb18@telfort.nl>
Subject: the offending %s in an sfdisk message translation

--------------880v2LvafSpwBbv2b03suQwU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIaSwNCg0KU2tpbW1pbmcgdGhyb3VnaCB0aGUgbGF0ZXN0IGNvbW1pdHMsIEkgbm90aWNl
ZCBlYmI3NDM4YTQ4LCB3aGljaA0KcmVmZXJlbmNlcyBodHRwczovL2dpdGh1Yi5jb20vdXRp
bC1saW51eC91dGlsLWxpbnV4L2lzc3Vlcy80NDc0Lg0KDQpXaGVuZXZlciB0aGVyZSBhcmUg
aXNzdWVzIHdpdGggbXVsdGlwbGUgUE8gZmlsZXMsIHBsZWFzZSBjb250YWN0DQp0aGUgVFAg
Y29vcmRpbmF0b3IgKG1lLCB2aWEgY29vcmRpbmF0b3IgYXQgdHJhbnNsYXRpb25wcm9qZWN0
Lm9yZykuDQoNCkkndmUgbWFudWFsbHkgZWRpdGVkIHRoZSBhZmZlY3RlZCB2aS5wbyBhbmQg
ZGVsZXRlZCB0aGUgbWlzdGFrZW4NCiIlcyAtLSIuDQoNCg0KQmVubm8NCg0K

--------------880v2LvafSpwBbv2b03suQwU--

--------------AI9ElGvr5jfd8QDgCYu80nhX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmpg1qIFAwAAAAAACgkQUUu+Lrjhlh/u
ig//XHJshgxq2urOLGEv8cpzcBNhQOTfZjtci1IxAOgsyL2uVLLRbhwzL6/74u/2PNt5FeksvV//
UOvondBSRaZVqhF3Ck9mxztujqwbeR5+Epws5j9MmL6iKV1hEdobbnyn+JrqpayZh4FabhRuseTW
7H8R6nFLGiYxYeH0cOwmpv50sZ/MJNZM8HpTF8zMf1EkCma+usvB9TPu85grQvrON6Z9wfc7YOK9
aqkYOjGCEG6FR4rR9l+YTlc0O9Ns4yC7QprQIy5RmBry0wgdU9E6ft8wMoFHsYF8i+Es0mdtcYwk
QPJos2jb8v0asv+LIUcbBa++er+plkvS66VyxzYqwmaOB1gQWDTOqldTljtwLownBdb6uxMgz03h
xJlEwjO2p40XEfpYZA3utOa1+39bM9U6SBO5+M3q+vr1UHEU/ii2FBfJl2HQjWEVDzkAPmp1MJL+
u/NPHH/kb8z/1X/DpgUSZnqkw+prdmq0WJyys7XaGn+hDkF2JvRK1zG0sg61C605LCe/vmP+iUGf
fs1n27DXsCRTuBvyR1/9RghFxHm1qMGPZSk8BeMKy5QLMsqvl3/GYiGDFaiKNRzqRRhEZq6OBBal
9fiENpgXXop0lzBhthR6gtoDEqpf4KD4J9PpRyC18X1Nr3VIh4Hxjshm7LMnU3GroLKURALWLrT3
jMI=
=8RFP
-----END PGP SIGNATURE-----

--------------AI9ElGvr5jfd8QDgCYu80nhX--
