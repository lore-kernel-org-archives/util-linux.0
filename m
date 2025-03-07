Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1F2153EC
	for <util-linux@vger.kernel.org>; Fri,  7 Mar 2025 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741347952; cv=none; b=LRxuGQxRCtn5r9ssMAtkkyT4xLs7ohTGgrF5H0p3WNvjOO7xZbYyY5U3OVsDFUPQj2EOCfkT1XFXctHC0YwqOhrmSGnVpr52VZMIF9EStMA9RsHB2UrbQbWkVoznte7uIMGZzJCAy6370iQL4D1ZvigYubi/qwFiRETQwft3VbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741347952; c=relaxed/simple;
	bh=A021R+MJgm3xEh+sfiwBWEn5n9iDzLQeojep5/L8AHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0d1wtH53nXUnkV4EfLmaRP7TaBjbAemOUJw+sfA9hYz2jnI88t97LuDPVwiXFSCeMXBqyyuzdZMM5LD13TV2W0wxCb6B7zopOlzmUbEs73TXRwhwbQkDydBgNCKrQtX+1mM3lu5BfLQ6B4zdsu3utD/KIjkVlFG+SiB820cOTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=UXd9/GDM; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="UXd9/GDM"
X-KPN-MessageId: bd3f015f-fb49-11ef-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bd3f015f-fb49-11ef-b99f-005056abbe64;
	Fri, 07 Mar 2025 12:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=A021R+MJgm3xEh+sfiwBWEn5n9iDzLQeojep5/L8AHo=;
	b=UXd9/GDMCyfIreaiBgX9QcyjmjRE0uUqSGe70sGQdzorcIzxssAF2SbFAF5xWcRpsrRuOLMVlfLit
	 WsB5jHwGD7loVSnVsuA/KQYaRuZbOyQLzqOu9j321S6x2qdqPYo2Vvnj3x4ilf4Nj+tVcmVgT83gnb
	 H5l2QXTDPcFSueGA=
X-KPN-MID: 33|7XoIw9iexxRyj0TR8lXa3lAc2ah+Vdjw5YcqhAKTg1R0UedDDsYcG6qDewV4iUx
 7v5Y7MBWrluD9ifQShXTUgNc4TOXc+yTdwPgoR+1QjjE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6qkalkZccUQcYDDoqrS1nNRahF3PSRrEoPgQTEAxauNNZFB5s/Kgc8/XJ4ym5wi
 GHnP3it5m3NcADv0hTeVrDw==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b1d50e6c-fb49-11ef-9b17-005056ab1411;
	Fri, 07 Mar 2025 12:45:40 +0100 (CET)
Message-ID: <c64a9a6a-8f8e-44d5-9ceb-f9dab99a3ad7@telfort.nl>
Date: Fri, 7 Mar 2025 12:45:40 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] irqtop: add filter support
To: Joe Jin <joe.jin@oracle.com>
Cc: util-linux@vger.kernel.org
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <20250307025201.92541-3-joe.jin@oracle.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20250307025201.92541-3-joe.jin@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f1gRNLIkXShqB0aTGeq0F1t1"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f1gRNLIkXShqB0aTGeq0F1t1
Content-Type: multipart/mixed; boundary="------------F6DcDiw0scfjfrzJFc2I5oBU";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Joe Jin <joe.jin@oracle.com>
Cc: util-linux@vger.kernel.org
Message-ID: <c64a9a6a-8f8e-44d5-9ceb-f9dab99a3ad7@telfort.nl>
Subject: Re: [RFC PATCH 2/2] irqtop: add filter support
References: <20250307025201.92541-1-joe.jin@oracle.com>
 <20250307025201.92541-3-joe.jin@oracle.com>
In-Reply-To: <20250307025201.92541-3-joe.jin@oracle.com>

--------------F6DcDiw0scfjfrzJFc2I5oBU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwNy0wMy0yMDI1IG9tIDAzOjUyIHNjaHJlZWYgSm9lIEppbjoNCg0KPiAtKmlycXRv
cCogW29wdGlvbnNdDQo+ICsqaXJxdG9wKiBbb3B0aW9uc10uLi4gW0lSUV0gW1BBVFRFUk5d
IC4uLg0KDQpUaGVyZSBzaG91bGQgYmUgbm8gZG90cyBhZnRlciAiW29wdGlvbnNdIiwgYXMg
dGhlICJvcHRpb25zIg0Kd29yZCBhbHJlYWR5IGltcGxpZXMgdGhhdCBpdCBjYW4gYmUgbXVs
dGlwbGUgb25lcy4NCg0KKFRydWUsIGl0J3Mgbm90IGZ1bGx5IHByZWNpc2UgLS0gYmV0dGVy
IHdvdWxkIGhhdmUgYmVlbjoNCiJbb3B0aW9uLi4uXSIuICBCdXQgZG9uJ3QgdXNlIHRoYXQu
ICBQbGVhc2UgdXNlIHdoYXQgYWxsDQp0aGUgb3RoZXIgc3lub3BzZXMgdXNlOiAiW29wdGlv
bnNdIiwgc2FucyBkb3RzLikNCg0KQWxzbywgdGhlIGNvbnZlbnRpb24gbm93YWRheXMgaXMg
dG8gcHV0IHBsYWNlaG9sZGVyIHdvcmRzDQppbiBsb3dlciBjYXNlIGFuZCBiZXR3ZWVuIGFu
Z3VsYXIgYnJhY2tldHM6DQoiWzxpcnE+XSBbPHBhdHRlcm4+XS4uLiINCg0KDQpCZW5ubw0K
DQo=

--------------F6DcDiw0scfjfrzJFc2I5oBU--

--------------f1gRNLIkXShqB0aTGeq0F1t1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfK3GQFAwAAAAAACgkQUUu+Lrjhlh+0
IA/9GJEOUH+cBrIwUSf9Tb7VHN83JQShDf9Ep8c/z+53L6/wzsDhqBxM8jxhudEuV2BrZx+MC+Ym
8CeCUPrPNJ8jjiHRkKSHQDiQToiVXANqn7GPPiIWHYeywhZm7jYnv/1HUZ38tEHrKL9RVYsW9gJC
AqWMRj1e2WrN/bJtfeIajlNYwvo38nu2xyeolmTkM0eoxFRCS0LSjWHPVBIQHxKp3c4n79e5M5/V
41UyiDzJlIEIdvRMRi2jZFpxMWIOh53A2JiovCb+O50zF1lnows+brEPrRd2nsAfXHAod25KF0XD
wK++UOvHw1WCY+7yvYi88pqd0uW1PuH6SDHdrQpmtxgG5ko6/3UNNGveaEiJc2ZAWaBlhttTj1E6
9A569lsL7149lhN0GJiHaud0Vgh3/hw7cuSh6JOFMN4tT0q9tic6sXF5y209P8SI8rfTKgk/MD14
dGe4OKkeT2rIRmCn5/qqMv8P8XEiIKnXI7PvWvA2KgBQ2jUbE+dH48GCkIEg0UFco9ldu8m4ebAj
hOS3k11D+Qdz+FJ47UOzRZLvB6iqT3YhiQlqy60yP4zJy0vxxWGGU08t3raIKUNDMcRbg+E8taB9
SZ/Yje+TWJk/S8AJ4lcbAAeNxO3j/2vBCedFFQ8Phy024bYGxwItJJ2dx9PGRKV/O/dYhz+ZLy52
ovo=
=geoq
-----END PGP SIGNATURE-----

--------------f1gRNLIkXShqB0aTGeq0F1t1--
