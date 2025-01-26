Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3307155C87
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737888819; cv=none; b=HSLhwtndtcud/zY3sI6aYSvDphAig3WvCy912C0kG5xflXW2UHhI/Fe+ODPQ+9IUaWZ9VgmmWOzUY3uZpnG3HU2kFFyFMH40Eu+Nrzblks1qMcNWBKN1seHbDOGy5ergV7yT+1UH5948C2wTPGYRN0OWeoynHJcRb6lVPjJvdjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737888819; c=relaxed/simple;
	bh=2vIAhQssPdSqBPDUTdXl1VIEEYY8E7XDPpK4WUyFjw0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=oVavE70fK0wPk+lqhdo3VMnesdY/U5KuNgQxV2UeNue1PAmHOyN63oGdBe4OYRZBH2Utj4vQvmZMkfKfASrecMCGnZTOiiJnp82kZVlMJwkfXG3wTa7MlVsWqQYf/dMdRveC4wLIA2i6y0hZmC0+/p1SqSvoyVaTNgCkopzcdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MSLdDj8D; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MSLdDj8D"
X-KPN-MessageId: d0605623-dbd3-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d0605623-dbd3-11ef-8d8a-005056aba152;
	Sun, 26 Jan 2025 11:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:subject:from:to:mime-version:date:message-id;
	bh=2vIAhQssPdSqBPDUTdXl1VIEEYY8E7XDPpK4WUyFjw0=;
	b=MSLdDj8DzMqYIaBJ6213kal0U46OcmZ0k1kMPKPRrt0jwtXG3Y4Qykf0nT7sqUGVK9Wv4hDGoTm6v
	 8yvEtrE/crFvMrkZkj6yJL8GFIDb4mJqNwOF+TLYVKHgLPmswqOzq5eVc834t0j00SmUHsmEKqVVKd
	 R4IsZOVMBGA9qt+o=
X-KPN-MID: 33|Ja8/xQU5sfXzIPRpimtib+/nneex5mnllniSZwy5bkjQcX/kksbVzYjcbgX3EOC
 POISFQyZnELbTV50fIg9+Dqfgh1yfB8ecImWnhnMCOv0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|nsBBTFsFlg0OqPD1VLzR8CJjUcdmIGmqUoIPGfuesjM0tCH5BXBNDUu+llur8QD
 jwZwoP7S8dblhhWWSedPDRw==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id a1889563-dbd3-11ef-a312-005056abf0db;
	Sun, 26 Jan 2025 11:52:26 +0100 (CET)
Message-ID: <3a525c3b-ddb1-48c9-887a-f34705415fec@telfort.nl>
Date: Sun, 26 Jan 2025 11:52:25 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
To: util-linux@vger.kernel.org
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: lscpu uses unfitting "MHz" in frequency scaling item
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------mf0ggxkVheETq1htIzzzLk00"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------mf0ggxkVheETq1htIzzzLk00
Content-Type: multipart/mixed; boundary="------------zsm8A0HpClvJ2XUrJz36Yul0";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <3a525c3b-ddb1-48c9-887a-f34705415fec@telfort.nl>
Subject: lscpu uses unfitting "MHz" in frequency scaling item

--------------zsm8A0HpClvJ2XUrJz36Yul0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIaSwNCg0KU2luY2UgY29tbWl0IDliOWU0ZjVkMDZiZTU1ZjRiOWUxYTUyYjQ0ODA1NTkz
M2RmOTJjNmINCmZyb20gZm91ciB5ZWFycyBhZ28sIGxzY3B1IGxpc3RzIGFsc28gYW4gaXRl
bSBsaWtlIHRoaXM6DQoNCiAgIENQVShzKSBzY2FsaW5nIE1IejogNjElDQoNClRoZSBwcmlu
dGVkIHZhbHVlIGlzIGEgcGVyY2VudGFnZSwgbm90IGEgZnJlcXVlbmN5LCBzbyB0aGUNCiJN
SHoiIHNob3VsZCBub3QgYmUgdGhlcmUsIEkgdGhpbmsgLS0gdGhlIHBlcmNlbnRhZ2Ugd291
bGQNCmJlIHRoZSBzYW1lIG5vIG1hdHRlciB3aGV0aGVyIHRoZSBmcmVxdWVuY2llcyAoaW4g
b3RoZXIgaXRlbXMpDQphcmUgc2hvd24gaW4ga0h6IG9yIE1IeiBvciBHSHouICBTbyBJIHBy
b3Bvc2UgdG8gY2hhbmdlIHRoZQ0KbWVzc2FnZSB0bzoNCg0KICAgQ1BVKHMpIGZyZXF1ZW5j
eSBzY2FsaW5nOiA2MSUNCg0KT3IgYWJicmV2aWF0ZWQ6DQoNCiAgIENQVShzKSBmcmVxLiBz
Y2FsaW5nOiA2MSUNCg0KDQpbSW4gRHV0Y2ggSSdtIHRyYW5zbGF0aW5nIGl0IGFzIGlmIGl0
IHNhaWQ6DQoNCiAgICAgQ1BVKHMpIGZyZXF1ZW5jeSBsZXZlbDogNjElDQoNCmFzIHRoZSB3
b3JkICJzY2FsaW5nIiBoZXJlIGlzIHVudHJhbnNsYXRhYmxlLl0NCg0KDQpJIHdvdWxkIHBy
b3ZpZGUgYSBwYXRjaCwgYnV0IHRoZSBtZXNzYWdlIG9jY3VycyBpbiBhIGRvemVuDQpvciBt
b3JlIHRlc3RzLiAgQW5kIHByb2JhYmx5IHRoZSBjb2x1bW4gbmFtZSBuZWVkcyB0byBiZQ0K
Y2hhbmdlZCB0b28sIGZyb20gU0NBTE1IWiUgdG8gRlJFUVNDQUwlIG9yIFNDQUxJTkclPw0K
DQoNCkJlbm5vDQo=

--------------zsm8A0HpClvJ2XUrJz36Yul0--

--------------mf0ggxkVheETq1htIzzzLk00
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmeWE+kFAwAAAAAACgkQUUu+Lrjhlh+H
+RAAnkG+kXVpFH927LbLMl/KJ6RWA7e0MZUfLtT5nDg5JBdhk+cGLoI81UVPwQIiy20hI3jzdxq+
901DLEb/zG65BV+pzTqMisLqr1+sSU3CXjN60+jpQZoec2x82WX02YGbdGZMMWAjCy1QOsu6Q/Ol
oJGFXL6/tlN2shP5JXNibdfsn9/eYcUQx07587HYU717LMn8XAt/QeQ6pTh8qFFOU5sKdFXO3JTh
AM1K+e+8vtk+oSjf1q9VjEIE5NSaWsnEkRsLX4bgamu/xQI68/7uzmx137lcVwaUXBrJ/wE4ZIvR
xTWikW2nu2Q2ElCpGgHU9T4L7GGKeooLCd0ra44dbs7WwczQ/iQqrD+QTNRnRPKqPTaAqDPEL4OW
5FjqOYnY/yyv5Hh6q4QCUvXZ16NmmC7F9KzxnIQ4HE8yub2dh6p6WCNMyJ0ubsiy9P6eqFXzDmPQ
KPHEfeGiGW6u9AvhLqTL3+1QB5QrKc76nbllJXQ4GbkUwWvdveQ8FCHTaOFTaaK/17rT9tq87NKY
lZ97S6ROfKlxGY1P42epWsjj7xvdni0eShu+U/i5u0BCaax5hLIlUrE9sgaSA/lAmyV+8XxXRsOb
TOHt+POqHZUfMPR6GTND3qzRd7SzesYjiW17rrkA/sYqXWJviLVSb75b+V4d73lzpbNdNGMCsn6r
lmE=
=aRbI
-----END PGP SIGNATURE-----

--------------mf0ggxkVheETq1htIzzzLk00--
