Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E188322544
	for <util-linux@vger.kernel.org>; Thu, 11 Sep 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598720; cv=none; b=dhk93kR9rRdRepr5I/CgDDjqzp0qiVEL4pzf3TURFXNNDwCKTYvkw4h/I/Ib30f/HZbd1wVL9Rij/4XuPhIgPnHIz+jUFDyawQJ+fc/jp8Lci4CRD5wdLMRRqppv25u3ZY3IhadiE4osZ9rFemVYdermVgNsW/qqUM17IcDLkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598720; c=relaxed/simple;
	bh=Kicw380qj4aXFUBisHOYJ+u9VNl0E5XdPt1MT1wZSS8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=Pgpo35JpgGOILdvYMtYcvsI1f5vTkZmt1mAtTRGed8khTmqAcGGF/T7AQ9QVV3ZG8DL7N9bd6o+D38Bx+WqYCWLvc2/+ZWoz1ssiNU4i1UmGmO0QI9lsu0cNm5iHjd3+EBxHamH1Mdbd32TYgKDta19KKm6IHJ0KfEXN0uE8qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=DqeaeLJX; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="DqeaeLJX"
X-KPN-MessageId: a2d04cba-8f16-11f0-80ec-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a2d04cba-8f16-11f0-80ec-005056aba152;
	Thu, 11 Sep 2025 15:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:from:subject:mime-version:date:message-id;
	bh=Kicw380qj4aXFUBisHOYJ+u9VNl0E5XdPt1MT1wZSS8=;
	b=DqeaeLJXyeIx8Zb2NeVg70sgPoLKFDxBM2/heRxkWjFOI2ZWNDwI54srGVkHhi3RgPtsNAAK2zt6Z
	 uj0YvOxEIPViEdNUfEtV35nMxctKjmmreH0kc8P7P2xUDfLEgybRlBqENTdl6ujlTmL7oRNnu2qbcq
	 II7CtyEJZ4GSe61Q=
X-KPN-MID: 33|DruPg656CiKocj9EJbCNy00T5kkAoDaSxAIBeIBpVyoju1HlqrV35xj3U519z4T
 kmypVMEIunqzmBsl7wAAK8beHfeOawqJb3Yaq8vAP0kY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HTb4wlzFZQ7/TE1f+yXPkzgC4Cn0eTJHo78kHcMrQ+eLmHRn4ic80ayG4CPRlpZ
 JuEsO5Niodjv/gRzZiZe4mA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 7723e538-8f16-11f0-8079-005056ab7447;
	Thu, 11 Sep 2025 15:51:50 +0200 (CEST)
Message-ID: <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
Date: Thu, 11 Sep 2025 15:51:48 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
References: <20250911134807.12903-1-bensberg@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
Cc: Karel Zak <kzak@redhat.com>
In-Reply-To: <20250911134807.12903-1-bensberg@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yIMXW10Rco9lIcbRxi4XLriK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yIMXW10Rco9lIcbRxi4XLriK
Content-Type: multipart/mixed; boundary="------------BOhvs46exsR0iTGcQn055PLH";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Message-ID: <47103376-a043-4f78-8213-ba06f52f5116@telfort.nl>
Subject: Re: [PATCH] findmnt: (usage) add a needed equals sign before an
 optional argument
References: <20250911134807.12903-1-bensberg@telfort.nl>
In-Reply-To: <20250911134807.12903-1-bensberg@telfort.nl>

--------------BOhvs46exsR0iTGcQn055PLH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMS0wOS0yMDI1IG9tIDE1OjQ4IHNjaHJlZWYgQmVubm8gU2NodWxlbmJlcmc6DQo+
IC0JZnB1dHMoXygiIC1rICAgICAgICAgICAgICAgICAgICAgYWxpYXMgdG8gJy0ta2VybmVs
IG1vdW50aW5mbydcbiIpLCBvdXQpOw0KPiAtCWZwdXRzKF8oIiAtLWtlcm5lbFs9PG1ldGhv
ZD5dICAgIHNlYXJjaCBpbiBrZXJuZWwgbW91bnQgdGFibGUgKGRlZmF1bHQpXG4iDQo+ICsJ
ZnB1dHMoXygiIC1rICAgICAgICAgICAgICAgICAgICAgYW4gYWxpYXMgZm9yICctLWtlcm5l
bD1tb3VudGluZm8nXG4iKSwgb3V0KTsNCj4gKwlmcHV0cyhfKCIgLS1rZXJuZWxbPTxtZXRo
b2Q+XSAgICBzZWFyY2ggaW4ga2VybmVsIG1vdW50IHRhYmxlIChkZWZhdWx0IGJlaGF2aW9y
KTtcbiINCg0KS2FyZWwsIGRvIHlvdSB3YW50IHRvIHJvbGwgYW4gcmMyLCBvciBzaGFsbCBJ
IGp1c3QgbWFrZSB0aGVzZSBjaGFuZ2VzIGluDQpyYzEgUE9UIGZpbGUgZm9yIHRoZSBUUD8N
Cg0KDQpCZW5ubw0KDQo=

--------------BOhvs46exsR0iTGcQn055PLH--

--------------yIMXW10Rco9lIcbRxi4XLriK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjC0/QFAwAAAAAACgkQUUu+Lrjhlh8k
Nw/+O2BwVuwfZYvw7TLxGE/TAi7d6sUAlGCeHB31AI8MqaSrMk9ec/Jd4ovIu/I6E+59q/l3+4Cu
FWB8r30BD9niGqYXCHh23x4m8sHqNe7f+Y8YH7K6uAByMdZXDvDLazx7Q4zZiTJoP7XWAZOdN9Ro
jiRXDAmTHSgS50CHLtE5BGgaVIzvVfabwjvFIk2G6THPjO6KE1Mf1kJlg0DAZv6huBIe/sJOwk7A
+OHwP/y52Pp+QRUCiZ6rFYT56Ma2h7HH7IuZFn/zhmC/d/SO1bouYcVoe0tRnJffI3/GTaRXxZJ+
IUeIkUTOQ2J0MPiwOAfGh46aVRp2no9njCblYJAJL1cgoKHezclPi9vmOkjWBwzfSiK75TddpCPS
Ly0eSbZqtIU5dZdAnLo3qG6UW2BaDiflyc/rBCOK7TlYUjrYZQd+VKWdX5VwibM3tDZU2qyr82AM
TL3dbAAdrVhNcNcHL3JPGRhsXzjDaI+pP9ztftcXrDvUY38uxLVDohdUpb2NRUR7yi+cG8wVoubb
bq9p5oe9kssokJCToMflPWI+U+oJdqXGM8Ljz1/s1TbFeNiuHawB0+Qym7YaB33HczWwkwRIbegZ
TWTSSPuoVWghsYn574IGIswhEcwXhjFZCxcdUaKpZH4RBGwTgXFhH0D1rWNJe0pM+5C+CjywNfTz
lf0=
=n/dQ
-----END PGP SIGNATURE-----

--------------yIMXW10Rco9lIcbRxi4XLriK--
