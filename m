Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2677C13D
	for <util-linux@vger.kernel.org>; Sun, 22 Jun 2025 15:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607510; cv=none; b=iJYO8BC6ZZVHMWsooF3qKTxm35t6OCV6+OBn+w94JeKNCZ3PGEzhgmdSiC4rS/nC49yxJ+ogS2sa/LfF/kSefpMeFkYtCt7TdToqbbITM1OzKZsya6cyFzvyg7JqsUWg21b2JLY6kpoIwXIr5llLe6g1sUa5PFubg044dZzLIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607510; c=relaxed/simple;
	bh=5j9MnKUcD39jXTAMNBUEtblQoFqQcgPleZsH+09M50s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=j3U3sIkFewDHLp2A/0HGInbgoZFrewWbiGupdtkhX0ZUHKfQaknHArct4vXjrpetv6M9vZBhTPOSSb2xK2Qj2GbAK+ujjPuvM7VhOvwlbP7YVRGjtM3eI4F4gCZ2RJnGR7Boyg7bDfaG8geTzCYZ6w1Sp2mmeIeAc+cXLzHHlao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=IbH6Ocqt; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="IbH6Ocqt"
X-KPN-MessageId: f84606df-4f80-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f84606df-4f80-11f0-b9a4-005056abbe64;
	Sun, 22 Jun 2025 17:52:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=5j9MnKUcD39jXTAMNBUEtblQoFqQcgPleZsH+09M50s=;
	b=IbH6Ocqtrz882mT+g/7uxiyDujFEQ4l0kZiJjJEmeRQaIjAhYZDW8dKAGqKFrbVJeGhJrjPN2P6NF
	 Ls8fSQPM1sWoMdgmytrWfDv+dxBwoMk7Cj4kjemKKvcJUAeDxwGaZkLCXLPNU6TobaUdgIFqvf/bpY
	 BvA3d/uEbRhLR6fQ=
X-KPN-MID: 33|BOdPT3Z/1SXNQbjTPpVQuNc55RgqvxXbxu4PQsqht4woH+vTcZ5xMzHGKy5YNJi
 +2v8J3MCr3COZtan0IjLHEJt7wte1qHaQbfPltBvjwxw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TxmrSB4OdkMslu9XcfR9tQXsyHldkxS+Z+sC4BldPw50Dk2mlw2+IYwYPUdGLRP
 B7Ycv8+MPb4zDYYge0qvZag==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id c9483dbf-4f80-11f0-9c18-005056ab1411;
	Sun, 22 Jun 2025 17:51:40 +0200 (CEST)
Message-ID: <00bb2e9d-cf47-489c-a881-81ab2edc2fe3@telfort.nl>
Date: Sun, 22 Jun 2025 17:51:39 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rename: change "expression" to "original"
To: util-linux@vger.kernel.org
References: <20250621232642.17613-2-contact@hacktivis.me>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
In-Reply-To: <20250621232642.17613-2-contact@hacktivis.me>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------a7zyLzWidJ8RtZOqneI1DMya"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------a7zyLzWidJ8RtZOqneI1DMya
Content-Type: multipart/mixed; boundary="------------v3gWABH8b0jO7Twu0B74wIle";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Message-ID: <00bb2e9d-cf47-489c-a881-81ab2edc2fe3@telfort.nl>
Subject: Re: [PATCH] rename: change "expression" to "original"
References: <20250621232642.17613-2-contact@hacktivis.me>
In-Reply-To: <20250621232642.17613-2-contact@hacktivis.me>

--------------v3gWABH8b0jO7Twu0B74wIle
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyMi0wNi0yMDI1IG9tIDAxOjI2IHNjaHJlZWYgSGFlbHdlbm4gKGxhbm9kYW4pIE1v
bm5pZXI6DQo+ICAgPT0gU1lOT1BTSVMNCj4gICANCj4gLSpyZW5hbWUqIFtvcHRpb25zXSBf
ZXhwcmVzc2lvbiByZXBsYWNlbWVudCBmaWxlXy4uLg0KPiArKnJlbmFtZSogW29wdGlvbnNd
IF9vcmlnaW5hbCByZXBsYWNlbWVudCBmaWxlXy4uLg0KPiAgIA0KPiAgID09IERFU0NSSVBU
SU9ODQo+ICAgDQo+IC0qcmVuYW1lKiB3aWxsIHJlbmFtZSB0aGUgc3BlY2lmaWVkIGZpbGVz
IGJ5IHJlcGxhY2luZyB0aGUgZmlyc3Qgb2NjdXJyZW5jZSBvZiBfZXhwcmVzc2lvbl8gaW4g
dGhlaXIgbmFtZSBieSBfcmVwbGFjZW1lbnRfLg0KPiArKnJlbmFtZSogd2lsbCByZW5hbWUg
dGhlIHNwZWNpZmllZCBmaWxlcyBieSByZXBsYWNpbmcgdGhlIGZpcnN0IG9jY3VycmVuY2Ug
b2YgdGhlIF9vcmlnaW5hbF8gc3Vic3RyaW5nIGluIHRoZWlyIG5hbWUgYnkgX3JlcGxhY2Vt
ZW50Xy4NCg0KSW5zdGVhZCBvZiB1c2luZyB0aGUgd29yZCAib3JpZ2luYWwiICh3aGVyZSBJ
IHdvdWxkIGZpcnN0IHRoaW5rOiBvcmlnaW5hbA0Kd2hhdD8pLCB3aHkgbm90IHVzZSAic3Vi
c3RyaW5nIj8gIEl0IGRlc2NyaWJlcyB3aGF0IHRoZSB0aGluZyBhY3R1YWxseSBpcywNCmFu
ZCBmaXRzIGJldHRlciBpbiB0aGUgcmVzdCBvZiB0aGUgZXhpc3Rpbmcgd29yZGluZy4NCg0K
DQpCZW5ubw0KDQo=

--------------v3gWABH8b0jO7Twu0B74wIle--

--------------a7zyLzWidJ8RtZOqneI1DMya
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhYJosFAwAAAAAACgkQUUu+Lrjhlh/N
xQ/8DZShLutziYlUw/NDk/mJ/PmdkXBrDaBKttqF5Rqusk7dqMCIlYsDCVCaG0B/a5TOZe5UqFoh
reHb5xZoUh9iioqAa+ML15+IIAricgkLgCrPZCBE4gowpdW7zOleDyYSNtZ6YYOUX82DUDBHQMJg
RFBi6rjR+8tDjZXK3MP2KVH6h0zTcJWvpqDG0uUyUL70Y2+mDuK04Kn2HlxuCfh1QRD5UPWVaoVz
LbJAJ8vcBqJnncDxOn/ffYsLmdQe1xC903wx832Z4PnEPf/vtiCce8qf24GaNCjg7NydDe5cmuMC
jSdTya8cOdbpmKAFQoqPexbvcj3O+3fNrCAHmXoyHak6dZ7Ba3uFWlJFN/x01RHWXjkLZgo9ZVoo
ZCkma3opIGg0Es1k1Fx24vDOY9Bvq4XZ86wfb+ZWNh/df+G8w3u0YqKuVZfTT8c2IqMV606+1UaE
qZq3XZ4a61fEazMtYmGjc3CsOhg64NOER0ADx9EV3ND4Ir6Itogs9KbMIkfboFmifQgT/iNzunBQ
X359m+4ly9l2jtLsKU4yCkwF0P8O9AJKVvzUSjxMhl6AhfhKkxeASNJeiggEFNDUmEnbIDi1S0Ij
GS/cEsA0GLIH+3dddER26Nplx1PjW/BNtySClgYBq9l6IVq9V3faGz0H8z0RngJPUkRKvePYxL0T
IqY=
=/ajW
-----END PGP SIGNATURE-----

--------------a7zyLzWidJ8RtZOqneI1DMya--
