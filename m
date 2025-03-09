Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76412B71
	for <util-linux@vger.kernel.org>; Sun,  9 Mar 2025 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741520384; cv=none; b=Nx7lWP5x5aMFcMKjPEj4JsZk+qNUNkLVXY63gyx6Dy64wghqpNcnoaWG34Vjoq9MHNpXvFQ7f4ihIPU3CjnF+raplRikhXMogADb6s821NvFaQJcmdFYqAI9Lp7IcObIbwfXmeRx88JifS5sbfz2nw/fzG/hMf/WRjRvcwEOSDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741520384; c=relaxed/simple;
	bh=FrMicy7IdSdqskZdKPoyPP2v5ye7X7jxwXQ1ed89t7s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UbWyDUIJ98r4gRqKCeQVdObDlc2rQKdORFxIzKb7Q68Uzf8TnM7BN35OZdkAlCFaKH7sAcJ1g6FBGn4KMNyFBmJQnFbd0+TWFIaEvU9Avdk2cEfucFQGMwZnt6KIOw8FhKIPAljYq1BKYiFmBy+MrBzyJ9v6n6Q4cvlHfmZTCdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gsVbT/KZ; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gsVbT/KZ"
X-KPN-MessageId: 352c4601-fcdb-11ef-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 352c4601-fcdb-11ef-b99f-005056abbe64;
	Sun, 09 Mar 2025 12:39:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=FrMicy7IdSdqskZdKPoyPP2v5ye7X7jxwXQ1ed89t7s=;
	b=gsVbT/KZX9AaoAVsDpHydJ3PLoiKTvCAG2ct5Z/NoHEukkMm3QJhEHTsjN4UON9vpu+KpOdwWzyUT
	 aTEuF42LUzpG4KU6zQcM2yag0yqmQjFqh5nvUDqDtPpqA6Ohc2fRixROx4WNoV4Hrsn/x8MO7shv2A
	 6cftgetcqYgl60hc=
X-KPN-MID: 33|K58WcSYsWjmih8ecBnKutKjciABNe1NEMditOn8zJ06fGUvgoEvwS6ByPkt41LB
 J3x3lrejdkFhBXARxJ9U2tsOe5xe5AMt1Nt3g/gD66Xg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|S0bPNOa1ga4YBmLHiqbQHfFqHrm8+YuFUWKgRdupw3qgZ5KI2wvIGVlqrVpqIgk
 wKtlAqasINUJRaTin8fr3Tg==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2b2d3b20-fcdb-11ef-9bcf-005056ab7447;
	Sun, 09 Mar 2025 12:39:32 +0100 (CET)
Message-ID: <31895e4b-64ad-4072-a6bf-c0ac5bea4812@telfort.nl>
Date: Sun, 9 Mar 2025 12:39:32 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: [RFC PATCH 2/2] irqtop: add filter support
To: Joe Jin <joe.jin@oracle.com>
Cc: util-linux@vger.kernel.org
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <20250307025201.92541-3-joe.jin@oracle.com>
Content-Language: en-US, nl-NL, es-ES
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20250307025201.92541-3-joe.jin@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5sKq2E04uLzyQ04vpARAUCtq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------5sKq2E04uLzyQ04vpARAUCtq
Content-Type: multipart/mixed; boundary="------------J2aSzLmF3sanEsDoTw0ZYo1i";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Joe Jin <joe.jin@oracle.com>
Cc: util-linux@vger.kernel.org
Message-ID: <31895e4b-64ad-4072-a6bf-c0ac5bea4812@telfort.nl>
Subject: Re: [RFC PATCH 2/2] irqtop: add filter support
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <20250307025201.92541-3-joe.jin@oracle.com>
In-Reply-To: <20250307025201.92541-3-joe.jin@oracle.com>

--------------J2aSzLmF3sanEsDoTw0ZYo1i
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwNy0wMy0yMDI1IG9tIDAzOjUyIHNjaHJlZWYgSm9lIEppbjoNCj4gLS0tIGEvc3lz
LXV0aWxzL2lycXRvcC4xLmFkb2MNCj4gKysrIGIvc3lzLXV0aWxzL2lycXRvcC4xLmFkb2MN
Cj4gQEAgLTEyLDcgKzEyLDcgQEAgaXJxdG9wIC0gdXRpbGl0eSB0byBkaXNwbGF5IGtlcm5l
bCBpbnRlcnJ1cHQgaW5mb3JtYXRpb24NCj4gICANCj4gICA9PSBTWU5PUFNJUw0KPiAgIA0K
PiAtKmlycXRvcCogW29wdGlvbnNdDQo+ICsqaXJxdG9wKiBbb3B0aW9uc10uLi4gW0lSUV0g
W1BBVFRFUk5dIC4uLg0KDQpPaCAtLSBJIGZhaWxlZCB0byBub3RpY2UgdGhhdCB0aGlzIGNo
YW5nZSBpcyBmb3IgdGhlIG1hbiBwYWdlLA0Kbm90IGZvciB0aGUgdXNhZ2UgaGVscCB0ZXh0
Lg0KDQpJbiBhIG1hbiBwYWdlLCB0aGUgY29udmVudGlvbiBpcyB0byBwdXQgcGxhY2Vob2xk
ZXIgd29yZHMgaW4NCmxvd2VyY2FzZSBpdGFsaWNzLiAgVGhhdCBpczogbWFyayB0aGVtIHdp
dGggdW5kZXJzY29yZXM6DQoNCiAgICppcnF0b3AqIFtvcHRpb25zXSBbX2lycV9dIFtfcGF0
dGVybl9dIC4uLg0KDQpJZiwgaG93ZXZlciwgaXQgaXMgcG9zc2libGUgdG8gc3BlY2lmeSBt
dWx0aXBsZSBpcnEgbnVtYmVycyBhbmQNCmlycSBuYW1lcywgYW5kIG9uZSBjYW4gbWl4IHRo
ZW0sIHRoZW4gSSB3b3VsZCB3cml0ZToNCg0KICAgKmlycXRvcCogW29wdGlvbnNdIFtfaXJx
X3xfcGF0dGVybl9dLi4uDQoNCg0KPiArRGlzcGxheXMgaW50ZXJydXB0IGNvdW50ZXIgaW5m
b3JtYXRpb24gb25seSBmb3IgdGhlIHNwZWNpZmllZCBfSVJRXyBvciBmb3IgaXJxbmFtZXMg
bWF0Y2hpbmcgX1BBVFRFUk5fIHdoZW4gZ2l2ZW4uDQoNCkhlcmUsIGxvd2VyY2FzZSB0aGUg
dW5kZXJzY29yZWQgd29yZHMsIGFuZCAiaXJxIG5hbWVzIiBpcyBiZXR0ZXINCmFzIHR3byBz
ZXBhcmF0ZSB3b3Jkcy4NCg0KDQpCZW5ubw0K

--------------J2aSzLmF3sanEsDoTw0ZYo1i--

--------------5sKq2E04uLzyQ04vpARAUCtq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfNffQFAwAAAAAACgkQUUu+Lrjhlh+M
KA//QKvL95/uyyzNokRopHCcqid6s+YCNWPv4HGoXKYursDOGtmPMmLqNyEq4ZiRAFlAzCbLtgck
PhF5GjV9EySfU100Iu6znEp6sHYg7runqIkwGMCcT/U2vf94Y+Jqji1Agqfi84uGQZO+DzfJycKT
8FTBZUvzS+0wWsE8E1uz2d8u/eeLgy600CCjKTXY2w7AtNfL3VWmox+uuNm+ik3YmUOAiIesYxvJ
PdJNmxl+64YtGgoFa90f4KKjSQrnQ7KB2GRO/KafULbPbGpUuxD2chu0iLfqqcItZXCj9E4YzPx1
HH/zmXPjmE/f7P+pzRFOk0DmVhSQluIgv65GzBB+CyPW4xfoXI3WlAo2+5aJDd19BJpaA3eMXPYP
93xywzeUZM6J/vsPHqG9smkmWxifPm1mBEvjEBLBNJiInD7wFmFupUKT5KqvfrX3qn0yFEeIPh1Q
TiUmK785DKw2qWbGqENH4gK/+WGA3r1hpiUV35EVDVDeK7jGBpF282iHM620trTKzObhTH+tPhA8
ysNxTZn4Ci9KgRwUjqKRao141UBZSr3VkE3qLNJYY3N1QAKXdYqPBxabzoT7Vz+Rq5gctzd7oa2I
D+416K+EhYWHXJ+D/Xt6aMIxjnoukvcJMUQlhPTIpfnjYHoQf1jEYzRtcv0TQdmxD3R/c0SpzQO1
r7k=
=rsTr
-----END PGP SIGNATURE-----

--------------5sKq2E04uLzyQ04vpARAUCtq--
