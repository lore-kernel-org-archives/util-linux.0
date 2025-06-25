Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF03269817
	for <util-linux@vger.kernel.org>; Wed, 25 Jun 2025 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862585; cv=none; b=W4rSkkuz4h4UcfMs6q/BmOCo07fP8BHWeLvNmaMvnyu/gRz43oechb94X0vD6Rzgh+E9VQ1g3MBDXWkFI+epW0nWfLKn+pomvaA0MxqPdaCcJ0EPxzbM1xpyWb+WPVL9v/0/DyMNpbtBTm2J1HdwWzNH/mpljktwOYslEveCRa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862585; c=relaxed/simple;
	bh=W9BGd9oWrBulZhX+d6xX+K4lAnvHh2WuaqEqdztVeps=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=IeO4QBr7nFhqwOULylZmpnaW/moZc4JLTlECWFCcVLyZz0Z4GTFHNKbLcdY++5Z+RWOyNjujga3djnLcqDOWVw3UwdrbOfI5uBjB/u6an6akmY5O49lmtDhE7oI0hJraUPFeSNxcMlDEVWbUUzT0Sd+1HvJErIr+oenHzVBi+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QRKj44YF; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QRKj44YF"
X-KPN-MessageId: dcc62337-51d2-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dcc62337-51d2-11f0-b9a4-005056abbe64;
	Wed, 25 Jun 2025 16:44:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:subject:from:to:mime-version:date:message-id;
	bh=W9BGd9oWrBulZhX+d6xX+K4lAnvHh2WuaqEqdztVeps=;
	b=QRKj44YFLGyIvAqEMhJLPpcx8K+oYxWgo7zroCl02BxU9Aq2xFEa6a0SQxwJQ6uD3p4vzCOEM5Tei
	 sWhK3bBp9EAaLysaAI0NJlZHPsfvDXLWdGLIxJYKyY9PktfQ4eKHmC0xFu0w6MWyOUzPAJYOaUAD3V
	 aUs2ECNc84faoquA=
X-KPN-MID: 33|0j2TBV300cVAwlLuu5tBmJgwaijdKdIqrYKohrIQ6edA8cXa1PEzv9LLoZW4E+f
 ndxIHNPSX+nXCQ1mrb462+sF1r/P6L1bPm41m3iC2RPk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|83IB0yr8ilke2QKFamK0IBvhA/0ywV5ErgGzzVXlYmP8y0TfRkpIh/669SRPNUo
 AzBdOZO5z2QHgTUQvAiDXAA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ad7cd651-51d2-11f0-9c7b-005056ab7447;
	Wed, 25 Jun 2025 16:42:54 +0200 (CEST)
Message-ID: <2d636f3a-c6cd-464a-9a48-66b8a2f26b9d@telfort.nl>
Date: Wed, 25 Jun 2025 16:42:54 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: behavior of `chrt` changed when specifying a command
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hQeVv76tPU70JP9NvmSVhA0t"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hQeVv76tPU70JP9NvmSVhA0t
Content-Type: multipart/mixed; boundary="------------IpCeffr1g80jBowEy9xSQJCa";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Message-ID: <2d636f3a-c6cd-464a-9a48-66b8a2f26b9d@telfort.nl>
Subject: behavior of `chrt` changed when specifying a command

--------------IpCeffr1g80jBowEy9xSQJCa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpCZWZvcmUgdGhlIHJlY2VudCBjaGFuZ2VzIHRvIGNocnQuYyAoY29tbWl0IGU3YTJkNjI0
MzQgYW5kIGVhcmxpZXIpLA0Kb25lIGNvdWxkIGxldCBgY2hydGAgcnVuIGEgY29tbWFuZCB3
aGlsZSBzcGVjaWZ5aW5nIG9ubHkgYSBwcmlvcml0eSwNCmxlYXZpbmcgYGNocnRgIHRvIHBp
Y2sgU0NIRURfUlIgYXMgdGhlIGRlZmF1bHQgcG9saWN5Og0KDQogICBjaHJ0IDEyIGdyZXAg
Ym9vIFJFQURNRQ0KDQpUaGlzIHdvdWxkIHByaW50IG9uZSBsaW5lIGZyb20gdGhlIFJFQURN
RS4NCg0KQnV0IHJ1bm5pbmcgdGhhdCBjb21tYW5kIGluIGN1cnJlbnQgZ2l0IGdpdmVzOg0K
DQogICBjaHJ0OiB1bnN1cHBvcnRlZCBwcmlvcml0eSB2YWx1ZSBmb3IgdGhlIHBvbGljeTog
MDogc2VlIC0tbWF4IGZvciB2YWxpZCByYW5nZQ0KDQpPbmUgaGFzIHRvIHNwZWNpZnkgdGhl
IHBvbGljeSBleHBsaWNpdGx5IGZvciB0aGUgY29tbWFuZCB0byB3b3JrOg0KDQogICBjaHJ0
IC1yIDEyIGdyZXAgYm9vIFJFQURNRQ0KDQpJZiB0aGF0IGlzIGludGVudGlvbmFsLCB0aGVu
IHRoZSBzeW5vcHNpcyBuZWVkcyB0byBiZSBhZGp1c3RlZCB0byBzaG93IHRoZSBuZWVkDQpm
b3IgYSBwb2xpY3kgb3B0aW9uIHdoZW4gd2FudGluZyB0byBydW4gYSBjb21tYW5kIHdpdGgg
YGNocnRgLg0KDQoNCkJlbm5vDQo=

--------------IpCeffr1g80jBowEy9xSQJCa--

--------------hQeVv76tPU70JP9NvmSVhA0t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhcCu4FAwAAAAAACgkQUUu+Lrjhlh/r
0g//cul+pe8zl+HM6iyL2AinhNB1EBW5pSBv3S4+emrOFdON/NadgqbXo0urnXL894/YlUZmozDU
y6YwMeQKu0WlUXHKKUxk9JbOPGQLozxc4ZwX0mSLoHDAkVgeizvJRyqt3jUeZVyKkgtypN2mHkuR
Vd9kYL+PK6ZYqk5r+N0ZJC5F3MYucHPS2O5cl4xdpQZFtH6nywfS/t1l3AmlR6SOhgHR2Uy95CfO
/Vn9Btpb329QTwnFXaXHDmXiIQCCSG+KyvzEu9Np7CuvHJfLd5VD66+xJQREXVViXom19k+QeBRx
DQKosHr8kwl7kgwfd3XDKJgjQqOgIABpJQmqPQhI7OT4xk8HIe7qXQBDadZl2cGS9wx57JqHMyZU
C1INtvyZDIrSO5Qy7lz3LhAgm/3iPFkkrMOE7NKHjFZZ49BcqsX+bpMBV07yjQlMJ4Jmc6uLrMdF
8QG0j1KrRtNWiYwJv+oYOHMnu0uNGO7qjiw28u2pfdN9VEJF5BW9W2AyZ336mpSmfBCR0VqfzHMe
sgqNsarxxQRrO/U9A2yoqsOUJBhClQl5/yEjKaZNaok0REYKzJyBIq141YXrq6FgMKuOnD5FolMJ
ezWax3AdCAREKcmimU2oILIuzeCHGpwBtoS558J2lr8UzcbNm/t3TrK42XUb5pCZficdxWzt6sKX
q3o=
=MGge
-----END PGP SIGNATURE-----

--------------hQeVv76tPU70JP9NvmSVhA0t--
