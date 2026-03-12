Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5E3F075F
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331092; cv=none; b=jGIppS5VuOYY78ZYn+bzBIO6Ylbeg3xuIXtIth9LuTzx6G2Bq5bSTTchG94juK6X8a0egrIcMZfCd3+nwa+lvLBbfGpr4+U+tsFj/fTcJLRjUSZ4TRnVwYU7VsRuYu6OgzOCR1NuhT+Y18E4qaHpw6A8esl7VGTtd6N3tX8BUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331092; c=relaxed/simple;
	bh=+Hf3yCBMMoKBUOwi5mTYLOVsP0Nl1c+YUb0DX01L9w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZ7QF7AJVvoWSUz0R0teuAkfbDLrrY5JQi4/Gg4EK4FCnPVNqFsNew42OwFx8f2mxpMgFJWZEeB3Vj4w30/6+O+JSHF9qbcMaa7On7nLYtw+LXDCTl8qb6LAR8oWpIn+eNABVP0bZKQU1RtqJ2OU/+ydu9qXGfUqhdjmMaiet0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=b0TOLBUZ; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="b0TOLBUZ"
X-KPN-MessageId: 442499bc-1e2c-11f1-8a99-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 442499bc-1e2c-11f1-8a99-005056ab378f;
	Thu, 12 Mar 2026 16:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=+Hf3yCBMMoKBUOwi5mTYLOVsP0Nl1c+YUb0DX01L9w8=;
	b=b0TOLBUZqTU0eyTVjcoMIdnRyqH8pJFw/S+xHZPEJYztmut3fmtTLULVx31vsgZiw1SXPr8Ecf6PZ
	 TE0BKjY5Z5ed7KpPUT6KfRLRC3BzSjx1lGQI4Fycg+NPu2PUJPpNdalQJ/KGyqoiYEmG2hRJl/Kd7s
	 XRLgLhA4Mch04Eh8=
X-KPN-MID: 33|jnm2yIXEi9aXmOdsu9nJtnyVS49x2O0cU6ipEvmtMMRb4iVrwF2Q8n44JmPv+Q8
 f7FySLjxw5oqD1hzym4QayXn6Trrgqizx0YGjhSvRREo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SbFTzORVhrdMzYg3csPb2Sy8EZ1ikQZJrnkIJkQaPAOuDTaF3/xhPNxlG8d/258
 ZudXHh4CPKp3RgJbsWNcw+w==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 440b1d51-1e2c-11f1-a6cb-005056abf0db;
	Thu, 12 Mar 2026 16:58:09 +0100 (CET)
Message-ID: <fdf20c71-fad8-4115-8fc6-8fc4c4125a5e@telfort.nl>
Date: Thu, 12 Mar 2026 16:58:09 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
 <abFtIOGI3eO0Sskk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <abFtIOGI3eO0Sskk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xftrNkM0OwTc0PqWnEVqqfNB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xftrNkM0OwTc0PqWnEVqqfNB
Content-Type: multipart/mixed; boundary="------------D4CFvGjFduymhiZDavArCqJv";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <fdf20c71-fad8-4115-8fc6-8fc4c4125a5e@telfort.nl>
Subject: Re: [PATCH 2/2] lsmem: (man) correct the markup of column names, and
 improve some grammar
References: <20260307114308.7517-1-bensberg@telfort.nl>
 <20260307114308.7517-2-bensberg@telfort.nl>
 <aa6-0Gx7Q8ZzWozj@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <d6fywjkl5vvef3uyshxi477fe6vtnzygb7sjsy5mecs7c546gd@cy73pfohzucq>
 <abFtIOGI3eO0Sskk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
In-Reply-To: <abFtIOGI3eO0Sskk@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>

--------------D4CFvGjFduymhiZDavArCqJv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMS0wMy0yMDI2IG9tIDE0OjI0IHNjaHJlZWYgU3VtYW50aCBLb3Jpa2thcjoNCj4g
T24gV2VkLCBNYXIgMTEsIDIwMjYgYXQgMDE6Mjc6MDNQTSArMDEwMCwgS2FyZWwgWmFrIHdy
b3RlOg0KPj4gSG93ZXZlciwgaW4gdGhpcyBjYXNlLCBJJ20gbm90IHN1cmUgaWYgdGhlIGRl
c2NyaXB0aW9uIGFkZHMgYW55dGhpbmcsDQo+PiBhcyBpdCByZXBlYXRzIHdoYXQgaXMgb2J2
aW91cyBmcm9tIFNUQVRFLCBDT05GSUdVUkVELCBNRU1NQVAtT04tTUVNT1JZDQo+PiBjb2x1
bW5zLg0KPiANCj4gVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEluIHRoYXQgY2FzZSwgd2Ug
Y2FuIGRyb3AgdGhlDQo+IHRhYmxlIGFuZCBrZWVwIHRoZSBzZW50ZW5jZSB3aGljaCB3YXMg
cHJvcG9zZWQgZWFybGllci4NCg0KU28uLi4geW91J3JlIHNheWluZyB0aGUgb3JpZ2luYWwg
Mi8yIGxzbWVtIHBhdGNoIGlzIGZpbmUgYXMgaXQgaXM/DQoNCg0KQmVubm8NCg0K

--------------D4CFvGjFduymhiZDavArCqJv--

--------------xftrNkM0OwTc0PqWnEVqqfNB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmy4pEFAwAAAAAACgkQUUu+Lrjhlh+S
ZxAAx2jqpaL0SW+SnGWDFsRe6VWMYsSpkpI+KTOx4+l8uF3PCC4MMOLgxBiID85eVysFYKdu5POi
bIR9SEI6RW+0G/Lzw2r3X5Bi7HcXEpjvHvCiLZKEi4vwiCIVMALHNUhAKDpP8j1yP4LsiJ8HG9ZS
k32D8uf+/K2J7fivPHPK9G2+9pH5K27ZtdYBmUTrWB8U8ljR7mSBWy8d/FhfsogaFLnqJyb6KxIM
0Gn0SVUamp2f8r6ULuIjC55jhJHijqWtix7gDelnXb4r7Osx5JSVMJ0assxB3m33epcQa5yGCPHh
awSFEPCZqfPzNt0pYZLDzGBNxFdcgxz721WNPLcruGHh9RCenqL9B66gNDZrq+xKLqqI2ULJ6KQW
Nlm5lJl5carLm4X+Ho3/cUG7nqDZ6ylDkovAdXBiZYZQxhioiTQarSfjKljv4DE7hpLEErEsfOt4
w6GPrTTCUVS+eUTKEz/7FpvMNiBDo4gWSJbfgwSREkcUW5zByIY6+83fMihsS9eX8gC6/uIBm8v0
zppe3cNQhqtSdrniFUQu4AWz7K1ewuo0KO/ZgebaLSyGR1EqR51GM5c6nAbwAMzFBnGfnr2T2M6J
VmXy8FZQlfD5UaZkzkSY6nAFb3jq0SQefp0j1snS5VTxLsz1olg4cVJfLVyrj9WCsgOEOrpLHrSc
73E=
=B3OY
-----END PGP SIGNATURE-----

--------------xftrNkM0OwTc0PqWnEVqqfNB--
