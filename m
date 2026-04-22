Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A403A1A704B
	for <util-linux@vger.kernel.org>; Wed, 22 Apr 2026 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838742; cv=none; b=KnU65p94U3buCFCydzNgoVDJ72DgaraBEbnGRkbPNXDULUIB6GQjpIUnHbaUg8GHTXuqbBsXKSO3KIkRdodMUlIUE1rcks+OwrnEf45XmdMOwNf8VrziykSnYa/0sOwa/uPjNSvJ7eE4Qd/cE2e+W9yCgCMu7uPllES/IuWRE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838742; c=relaxed/simple;
	bh=6gCkVcXHrlxu4VufzEviKgWJhSJ7M+Xc8wa3LeJleA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b00ET3j1vjAb7uDP9qimeJDDDYXfnwGmlyDyoWX4OtxJNNJSGQe4cwzubEl3t9+KWuQriaeqVKUW+XKGCCI77t2bXOccfCjhLSCENYWOIY+Giqe1+Sfkt7WxDteRsadnY6KwvV3TEyu4QO+EeAgN1VauucbQZ2nwMIHzqQjSyN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=qbTCUsgm; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="qbTCUsgm"
X-KPN-MessageId: fc85c9fb-3e12-11f1-969c-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id fc85c9fb-3e12-11f1-969c-005056abbe64;
	Wed, 22 Apr 2026 08:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=6gCkVcXHrlxu4VufzEviKgWJhSJ7M+Xc8wa3LeJleA0=;
	b=qbTCUsgmg0USTOEKCny69AeKE0SfEYuhaRQ9A5vih9Jl4ClewDhIR7QT6sqSXqGb2Jiva9eEEAPKa
	 kiaRy0jOVJuc6zkEdB64cwi+Q+kv+AHuBVdjQ9zmtOaU0Nt3To5d7k5rIr6QOXTuqJpgu8475CS7Ar
	 /Alswfx/+ySKflBM=
X-KPN-MID: 33|mQgpMTm6hdwzAhfBg7UxGr8PcwX5ABJ4zxobatwSgnSuRSWI2CP71CyfgfYoAmi
 hCXlXY3EKxxGpuJp67kAfZ5DAkIg/WT99knZOvumRJmQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nZgkR8icVXbLofF8jNS7JLFyzrbn0CTpUGpPY4OJieDm3/vkzjaqV2sPIb6YCUo
 W3iTdjELCHOgihggfFviAxA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fc668e65-3e12-11f1-8011-005056ab7447;
	Wed, 22 Apr 2026 08:17:49 +0200 (CEST)
Message-ID: <bd1c4673-ab3a-4934-a7d1-8113a48c9811@telfort.nl>
Date: Wed, 22 Apr 2026 08:17:46 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] copyfilerange(man): fix swapped offsets in command
 example
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
 util-linux@vger.kernel.org
References: <20260420180528.943663-1-stepnem@smrk.net>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <20260420180528.943663-1-stepnem@smrk.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hVAsZsefuYwoEntm4l9Bh3O0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hVAsZsefuYwoEntm4l9Bh3O0
Content-Type: multipart/mixed; boundary="------------Aq0tAmSo8YlWxrIVl8Y7uQ9g";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@smrk.net>,
 util-linux@vger.kernel.org
Message-ID: <bd1c4673-ab3a-4934-a7d1-8113a48c9811@telfort.nl>
Subject: Re: [PATCH] copyfilerange(man): fix swapped offsets in command
 example
References: <20260420180528.943663-1-stepnem@smrk.net>
In-Reply-To: <20260420180528.943663-1-stepnem@smrk.net>

--------------Aq0tAmSo8YlWxrIVl8Y7uQ9g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyMC0wNC0yMDI2IG9tIDIwOjA1IHNjaHJlZWYgxaB0xJtww6FuIE7Em21lYzoNCj4g
ICBbLi4uXQ0KDQpUaGUgY29udmVudGlvbiBmb3IgdGhlIHN1YmplY3QgbGluZSB3aGVuIG1h
biBwYWdlcyBhcmUgYWZmZWN0ZWQgaXM6DQoNCiAgIHByb2dyYW06IChtYW4pIGRlc2NyaXB0
aW9uIG9mIGNoYW5nZQ0KDQpTbyBpbiB0aGlzIGNhc2U6DQoNCiAgIGNvcHlmaWxlcmFuZ2U6
IChtYW4pIGZpeCBzd2FwcGVkIG9mZnNldHMgaW4gY29tbWFuZCBleGFtcGxlDQoNCg0KT3Ro
ZXJ3aXNlIGl0IGxvb2tzIGFzIGlmIGNvcHlmaWxlcmFuZ2UgaXMgYSBmdW5jdGlvbiB0aGF0
IGlzIGNhbGxlZA0Kd2l0aCBtYW4gYXMgYXJndW1lbnQuDQoNCg0KQmVubm8NCg0K

--------------Aq0tAmSo8YlWxrIVl8Y7uQ9g--

--------------hVAsZsefuYwoEntm4l9Bh3O0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmnoaAsFAwAAAAAACgkQUUu+Lrjhlh8m
rBAAzBXpcP5ahEQFSKw6+DuBZeIWD+wXv3FgLa6fdRHPUdFh6PI/rfvp1GDLp3z3yT357uneLLO3
Kjs+wLZexrm1MRpTgVRXEI8HNcGUAw0wAahO1DK49ZVx4c/fZIZJY9Wb1Iwu0HoJCH1lxk4A7gw6
JMGQYsMera7OkH4i6gw7nZeCmIHyJiULdafZhPBgc9Q+VU7faE/HhjzpfuuIg0DKsptnH2+XM/Ir
wJjZdoCJIYaIAhL93iFL8PkRP2ACUhZ8eglbmdcevHtP8YVa+yw9vupn0YxV1/F+vpaA2qFnX8Ju
4J1hTZ+Xxe+xsFrug2nRVcX+aCd5D0Cf6v9jKgY4rD/RLZIkaQmk5+JJTVSPPje9LEiWkBCNdi/A
QuMN0YBgfGfex+Tq5Xcw8gDGVNjuEE1sO8cB9sbPl4JP595PLdUCZ4Km91Qw/tDRMYsCYv20cPl2
ZC0Uk1bG9RiFYywJwHR6mtHigkmzCOwpYDQRN0/GLqkZzifB3U+MN7vwii/zBNkBVnlNxQI/lHBr
YlvPwkeOF7RXLXPEKnG9Vym8oPRuzhPk/uk5gdKSTOOsYmmAeqLmRNZPIyOiXsZYftO1yCGlElVR
Dhm134W6Xc+7rb6fWTdner9Rh4j0vF7s9UH6iyHeM4gUMokCkNMhnIiw8evuFEu/8y+EN1NoD6ra
OtQ=
=/zKu
-----END PGP SIGNATURE-----

--------------hVAsZsefuYwoEntm4l9Bh3O0--
