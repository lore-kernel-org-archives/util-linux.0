Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD5218821
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 10:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577417; cv=none; b=Cw+A6cRK1TN1C5iVpjKFCuRD65ZZnHHY0pEk0jn6HeMZTiZYbYATE8iwFoqrPeXIAAPwH5oPTHEM2eXHUgda61Omdb+eLLug2d8urTQ/qnOuy/0tnPE1xLniHiNnVIQ2tMdJUCqxA2mhAsqw6pxyVpxXFkQe+F0URkPbtPI8fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577417; c=relaxed/simple;
	bh=0GWPxlspr51X4ukzJSeFI9NGfA2A+Tm1N6uUhiS1W6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXUHp4bUPKh7UL2vlrE57b2JXTiCmpm2UFMIcnflvrJr1RlO0SpZ00smISzZi+PFoHQBrk6mfnrITgscaz7idV2Oi6ZNpRnoORDrmRGRdAJ8q0nw6Vo8sKIGozZRjLPueAw1xEUTvrhDyd9mnSVotfxGZW+vdybS6wWWggMrSO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nzs8vN6x; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nzs8vN6x"
X-KPN-MessageId: 4cada296-21c1-11f0-a82e-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4cada296-21c1-11f0-a82e-005056abad63;
	Fri, 25 Apr 2025 12:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=0GWPxlspr51X4ukzJSeFI9NGfA2A+Tm1N6uUhiS1W6Y=;
	b=nzs8vN6xzAwrer/5Q5VlS+3ZvI9JBE/q76rvPjfhdlFlJIki+Cyai/TKrSdmG8rA/PF8NBcxNCOBL
	 r16sJ3COsx0fXMhOV+CatiVtA1wJoZ6MllHjhlQLdBJNFI3oB9yR6BZ0UO1FC62pavXjbAV+rg4zYd
	 1Su997ElkRv1+0NM=
X-KPN-MID: 33|CVK2GTtDuIVqY7GBv+VPo/sXEvkzMZrb5ayas0wYq67ndBOwbbyxVTnNe092gWi
 D8OJf9E29IUIqS7ztS53J/9hKiDpnlYqoXxyg49xsCu8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zUlXp8iAkJZPl+JwHjuD9MJvDxKf+nJmRVAHCc7nv967ya5ubYsi1KtJTGYQvcL
 y1ZJL1rOMmqguRDk90iARjg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 33afba12-21c1-11f0-9c06-005056ab7447;
	Fri, 25 Apr 2025 12:36:53 +0200 (CEST)
Message-ID: <9de5bcde-1315-42f9-a7bb-09fbfea6198c@telfort.nl>
Date: Fri, 25 Apr 2025 12:36:52 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
To: Karel Zak <kzak@redhat.com>, Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-3-bensberg@telfort.nl>
 <20250424.185505.855258258029883426.yamato@redhat.com>
 <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ekY1jkS0dSBQ4V6eJeM3OeQB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ekY1jkS0dSBQ4V6eJeM3OeQB
Content-Type: multipart/mixed; boundary="------------chFEWkW10N6Ny40TPQy1dvSM";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>, Masatake YAMATO <yamato@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <9de5bcde-1315-42f9-a7bb-09fbfea6198c@telfort.nl>
Subject: Re: [PATCH 3/7] lsfd: improve grammar, and use angular brackets
 around placeholder word
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-3-bensberg@telfort.nl>
 <20250424.185505.855258258029883426.yamato@redhat.com>
 <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>
In-Reply-To: <3vy4ysebkufi3zpcv2s66nnzghsf7nu4fthkmzotj6ctxawnd5@ottmham4b2lu>

--------------chFEWkW10N6Ny40TPQy1dvSM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNC0wNC0yMDI1IG9tIDEyOjA1IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBJdCB3b3Vs
ZCBiZSBiZXR0ZXIgdG8gbm90IGFubm91bmNlIHRoYXQgc3BhY2UgaXMgcG9zc2libGUgdG8g
dXNlIGFzDQo+IHNlcGFyYXRvciwgYW5kIHVzZSBjb21tYSBpbiB0aGUgaGVscCBhbmQgbWFu
IHBhZ2UNCg0KQWdyZWVkLiAgUmV2aXNlZCBwYXRjaCBoYXMgYmVlbiBzZW50Lg0KDQo+ICAg
IGZwdXRzKF8oIiAtcCwgLS1waWQgPGxpc3Q+ICAgICAgICAgICByZXN0cmljdCB0byBzcGVj
aWZpZWQgcHJvY2Vzc2VzIChjb21tYW5kIHNlcGFyYXRlZCBwaWRzKVxubiIpLCBvdXQpOw0K
DQpUaGlzIGlzIHRvbyBsb25nIChtb3JlIHRoYW4gODAgY2hhcmFjdGVycyB3aWRlKSBhbmQg
Z2l2ZXMgdW5uZWVkZWQgZGV0YWlscw0KLS0gZnJvbSBvdGhlciBvcHRpb25zIHBlb3BsZSB3
aWxsIGFscmVhZHkga25vdyB3aGF0IDxsaXN0PiBtZWFucy4NCg0KDQpCZW5ubw0KDQo=

--------------chFEWkW10N6Ny40TPQy1dvSM--

--------------ekY1jkS0dSBQ4V6eJeM3OeQB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmgLZcQFAwAAAAAACgkQUUu+Lrjhlh/p
3Q//dd9rlz6A5XC5sIiq6I1z4irM/qYwsV3LYNeMDvgiSCv7lRLa+ZKj5ZDWGSfS+MYvqSPrwHii
1uHS6gLFiYPkRyshQR1IvRSuP1zJl97hZzBgQipaxzva9PXQiojlV7t/DHFoaPWvpvW5/JHgah2c
H2yAOh+zAU8TiA3yWkUlNib4kiGse7Dac/HOZ/ybv/uOk9NVXQOlQSBvMaLGpFEmUyGtkPLGfng+
TNcf+L9+T0pm9/q8ECPBnmJJ6Ozu5Uy/uogXfbc/2TagXZzS2bnXjoiV9KsMi17fhYzPgfpye7l/
jNW/o47O8dqN6S0sIq94awwhu6QOGHfHZzTaEj3UvBJdoNiBoUzh4SLLKABKpiCHfae0ba8zd8WN
QAZEPwZ7VYVykHEYXqgBuk/BwTOnxowHdpasNtGW57TztMsPiJ5UFgFx07LV7oKeO2o4ecHlrOp7
99y/bypU60aRSMyFOy9Wvnlio8s02lfieGj8RO6N2/mi7UUnCfsYlffC1800JU2VMkPhI81aSWLh
OergFiAht9Xaa3P42IjZh8Xk2SF9cQq3rXt03k5rgLS+Oztqxh+3Q/o1wrLUbyFL8hW9FrIaGdm/
okOOt0tA+nabRsgt28Q9I6FoZA+PQdK0iuFmB6K4Q0nwvTr4fm+dQENnLLMvYZ3RZFf0FgmjsWDo
P3I=
=pUNz
-----END PGP SIGNATURE-----

--------------ekY1jkS0dSBQ4V6eJeM3OeQB--
