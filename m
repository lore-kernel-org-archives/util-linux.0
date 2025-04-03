Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652224397B
	for <util-linux@vger.kernel.org>; Thu,  3 Apr 2025 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674125; cv=none; b=TqSlcmSHc8F6kiBP1AQwIL2ZhHCwSOSnEfv+SdeHYSmM8VY+RKcXkfxLSY3oj8HjHy9DdeYo2cTZlwOmoDwp/LvyG2MYrit2hXMeMgKlkOMgc0PIg/ftBjsEf50IAWNVqsoQm2xkbGk++VCXomolEI1ZFOaI+8NAc0gD+Dae29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674125; c=relaxed/simple;
	bh=pzm1FmRttrG1BxU2Qaop2w5I11HfGisR48/6/SytJZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5rxbZavoXFkEEGNmYwqrbPdZoiGWndtcTVvCNjqx3EUh/pniZfcbuXTnwm6y8x0XO5LlHa8rRCf1gB4Os+elenXBi90Cr8M/C/VW3I/iyTNm4wQPvjCFaW3Caf0OI4DnC9QSXUXCGuDNm4hLaw930ghFIN03jdAVIupkGlz9mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=jPyRWXoE; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="jPyRWXoE"
X-KPN-MessageId: d3d9fe36-1071-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d3d9fe36-1071-11f0-bc28-005056ab378f;
	Thu, 03 Apr 2025 11:55:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=pzm1FmRttrG1BxU2Qaop2w5I11HfGisR48/6/SytJZM=;
	b=jPyRWXoEzwYCERoTEtqpxhkuHJpluQObBlO4Cji1KWag6IezwKZmP0lPnju3pRxCvGd8Apjc8ZZMD
	 OsBHc8FYQFneUBaCGuju/L0cZDjCJv8aC9cxpK4kYJvUEZ9c0Na1cGbL21XeImHeNTQDWTC9Nq324Y
	 ZHi+5/t5wPKJ/Zp0=
X-KPN-MID: 33|0tH6JftfL5+dvzSGLj4Ts4EbsR+Cyo86X2xFsjbGzNJ31E+cR9eB5R0bhDiooFj
 4JZ2nvMXeW+hh286Y3nk/KAFtnIQkTDmy6nbMUzGmlt8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|TES+xU4o3TGPxLR8RllIBX/d625dYjiroJL5GwU3usBNUIKCAcKOC96/aXSXHwp
 PqA3QEQxG9QyOvrSvGkmuCg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id bc8dfb81-1071-11f0-9b55-005056ab1411;
	Thu, 03 Apr 2025 11:55:13 +0200 (CEST)
Message-ID: <2c111844-b6fa-42cc-8333-eec4d7bb4a49@telfort.nl>
Date: Thu, 3 Apr 2025 11:55:12 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] coresched: reduce excessive whitespace and
 verbosity in usage text
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Thijs Raymakers <thijs@raymakers.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-9-bensberg@telfort.nl>
 <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------NzQy7eYtY2EudWKkrHbQBNJj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------NzQy7eYtY2EudWKkrHbQBNJj
Content-Type: multipart/mixed; boundary="------------HAUcVo8t9iI0zUhF6R4cOZ07";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Phil Auld <pauld@redhat.com>,
 Thijs Raymakers <thijs@raymakers.nl>
Message-ID: <2c111844-b6fa-42cc-8333-eec4d7bb4a49@telfort.nl>
Subject: Re: [PATCH 09/10] coresched: reduce excessive whitespace and
 verbosity in usage text
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-9-bensberg@telfort.nl>
 <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>
In-Reply-To: <cztqfu3prb4v2urpxrujq5wqqdclnxwsny4h5ejbml7d7kll2n@yj3dgreqhtrl>

--------------HAUcVo8t9iI0zUhF6R4cOZ07
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMy0wNC0yMDI1IG9tIDEwOjExIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IE1hciAzMSwgMjAyNSBhdCAxMTo0NDo0MkFNICswMjAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+IC0JZnB1dHNsbihfKCJNYW5hZ2UgY29yZSBzY2hlZHVsaW5nIGNvb2tpZXMg
Zm9yIHRhc2tzLiIpLCBzdGRvdXQpOw0KPj4gKwlmcHV0c2xuKF8oIk1hbmFnZSBjb3JlLXNj
aGVkdWxpbmcgY29va2llcyBmb3IgdGFza3MuIiksIHN0ZG91dCk7DQoNCj4+IC0JZnB1dHNs
bihfKCIgZ2V0ICAgICAgICAgICAgICAgICAgICAgIHJldHJpZXZlIHRoZSBjb3JlIHNjaGVk
dWxpbmcgY29va2llIG9mIGEgUElEIiksDQo+PiArCWZwdXRzbG4oXygiIGdldCAgICAgIHJl
dHJpZXZlIHRoZSBjb3JlLXNjaGVkdWxpbmcgY29va2llIG9mIGEgUElEIiksIHN0ZG91dCk7
DQoNCg0KPiBUaGVyZSBpcyBhIGNvbW1lbnQgZnJvbSBUaGlqcyB0aGF0IGtlcm5lbCBkb2Nz
IGRvZXMgbm90IHVzZSBoeXBoZW4sIGl0DQo+IG1lYW5zICJjb3JlIHNjaGVkdWxpbmciIHJh
dGhlciB0aGFuICJjb3JlLXNjaGVkdWxpbmciLiBNYXliZSBpdCB3b3VsZA0KPiBiZSBiZXR0
ZXIgdG8gZm9sbG93IGtlcm5lbC4NCg0KV2hlbiBzcGVha2luZyBvZiB0aGUgc2NoZWR1bGlu
ZyBpdHNlbGYsIGl0IGlzIGluZGVlZCAiY29yZSBzY2hlZHVsaW5nIiwNCmJ1dCB3aGVuIHVz
aW5nIHRoaXMgY29tcG91bmQgd29yZCBhcyBhbiBhZGplY3RpdmUsIHRoZW4gaXQgaXMgbXVj
aA0KY2xlYXJlciB0byBoeXBoZW5hdGUgaXQsIHRvIGF2b2lkIHRoZSBpbXByZXNzaW9uIHRo
YXQgaXQgaXMgdGFsa2luZw0KYWJvdXQgYSBfY29yZV8sIGRlZXAsIGNlbnRyYWwgc2NoZWR1
bGluZyBjb29raWUuDQoNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvYWRtaW4tZ3VpZGUvaHctdnVsbi9jb3JlLXNjaGVkdWxpbmcuaHRtbA0KDQpJbiB0aGF0
IGZpcnN0IHBhcmFncmFwaCwgSSB3b3VsZCB3cml0ZSAiQ29yZS1zY2hlZHVsaW5nIHN1cHBv
cnQuLi4iLg0KDQpodHRwczovL3d3dy5ncmFtbWFybHkuY29tL2Jsb2cvcHVuY3R1YXRpb24t
Y2FwaXRhbGl6YXRpb24vaHlwaGVuLXdpdGgtY29tcG91bmQtbW9kaWZpZXJzLw0KDQoNCkJl
bm5vDQoNCg==

--------------HAUcVo8t9iI0zUhF6R4cOZ07--

--------------NzQy7eYtY2EudWKkrHbQBNJj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfuWwAFAwAAAAAACgkQUUu+Lrjhlh9E
wBAA75YnmfVyHEm6vn/yyLm2AJMsP2jQCL800IRy9AF0xkE5xlc/qHt3b/uME7n80ZyqWicN1ol5
ykm5yWfcc2bg0xmK4XEMgs+bSffPhwltacXCd1AJmI73vGSyphoc2s2lp7DqolTQcP845QQG25ri
bz40BbqPDEn//2vYtjZrGX0lgfI2EFCwLSMPlrM46iGawUUg0yu899Hs+OmUZetm3XWc7Be49JPt
ljN4IHglCgx/I7eN1tMIiQmaxNT9UFMA78ZtgE9gJRHQ5x4A2UEUh7Bf9LNiBBVjsd7ARyZqNdtP
ISpvteuN1fpqt3afUJ97WC46BNme1cq6CDMTLQV9WrMSbOP2Iz6V2PQA3yWqKWzAtR2fOKsbfopA
XSkbWRzqHo8YxSHNDNklJ1uTQZubOc1VL1j2FigW+GPhS0NRgyhnZia7RDkZE5kygl8soCJkM816
ePfi3/DE9dMJPgxr9/hE7/IM8bCERWxfnaABha0wom4rhNjeq6eU2nCRy7axvA6B8gH02CtZZ/4I
BBuD7MJQrIKuswm6CVpQQAXmtG/lkxOp9ulKoSuMGT6/DJoJCSoBIcnBZSizn/UlBRn3ch2Z5uAp
mnNTXjHOt1t1SZD0gYHfzGcb5J+gD2tPtFbm7GgjJpcbhIISDLNHx5sa8n9WQXaKxVtL3VYoWruQ
Cno=
=7dkG
-----END PGP SIGNATURE-----

--------------NzQy7eYtY2EudWKkrHbQBNJj--
