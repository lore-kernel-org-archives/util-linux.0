Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED019CCFC
	for <util-linux@vger.kernel.org>; Sat, 11 Oct 2025 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760186859; cv=none; b=L1fvBVenYClvOxjYBp2I3zFj6zPf5NswFOGZtEFgtV1Lzg0ifOgL6AxSbu0ttIIBORP1cXUUFrFXDhv7WPoT3VH++pDM31YCmdFcW5WRQa34pfad+RpXgAoMZ9Z0/OqTGnMOLSFejb6S0DJU/ev/y/x0lrXmn/jOIiviwwgIMzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760186859; c=relaxed/simple;
	bh=7RdeXbg3OJr2bigXCQoJG9XuYNIU5ZtVqY6ebLkMYSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I/XjjCo1HwaB4o2jLqq2/J0ICl+Fh48zgo117HtfBiqhu3EyTc2BQS0UySFG6QtvvXHwqgcGlHRxtHmiegXDuZyzQU4SQjwFI2GIgDD9tYXUoToEtaujn+Syxy23FmY97TA8eXa9Nh7QTCMSoxzSyUvh9AMCZhbUEP4LZZtZr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Col//W5G; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Col//W5G"
X-KPN-MessageId: 8f972692-a6a0-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8f972692-a6a0-11f0-a27d-005056abbe64;
	Sat, 11 Oct 2025 14:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=7RdeXbg3OJr2bigXCQoJG9XuYNIU5ZtVqY6ebLkMYSA=;
	b=Col//W5GhHLkfqIsgi20aM3dJ1N9zuJgl7KVV2I4qNSHfUBW/AoIekyGifzzjjbMkbzL7rvlC7/2W
	 spZLq4gWPaW5SXIDtShpe9iptIAb4PeBekanFwizHO8foqbQijApXGJTj8yNJiSj/j/H190o6vHKXv
	 C5lC59cKhfqbgC5A=
X-KPN-MID: 33|hF0L3apwBsZs41Y7dTf7zi6GYo1kEXgkgSiZVWvzeBe+OfV51BWZp02KRGm5qvM
 e/GE+woeo8zURj9bkj4w2hC4TDnMsHCQtUTFtwKJ3uLQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fU1+PS5SEn6f1i7apBBaTqewfvWewLUCVpUUnKDPEm5NuPX1cpliocj98qhVuVW
 PF+FSDtALlB7uiQqniIszsw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 6e805121-a6a0-11f0-8003-005056ab7447;
	Sat, 11 Oct 2025 14:47:22 +0200 (CEST)
Message-ID: <eedcefa2-6759-430c-b8c1-41ab0dfa4a40@telfort.nl>
Date: Sat, 11 Oct 2025 14:47:22 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DKIM] Re: `losetup --remove` is confusing, and misuse silently
 fails
To: Nuno Silva <nunojsilva@ist.utl.pt>, util-linux@vger.kernel.org
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <10cdaqe$vrk$1@ciao.gmane.io>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <10cdaqe$vrk$1@ciao.gmane.io>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------T0lnIItqqnzuSq35Gemv827u"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------T0lnIItqqnzuSq35Gemv827u
Content-Type: multipart/mixed; boundary="------------OPjT9E4YG0QHmCoDg01qO8Nn";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Nuno Silva <nunojsilva@ist.utl.pt>, util-linux@vger.kernel.org
Message-ID: <eedcefa2-6759-430c-b8c1-41ab0dfa4a40@telfort.nl>
Subject: Re: [DKIM] Re: `losetup --remove` is confusing, and misuse silently
 fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <10cdaqe$vrk$1@ciao.gmane.io>
In-Reply-To: <10cdaqe$vrk$1@ciao.gmane.io>

--------------OPjT9E4YG0QHmCoDg01qO8Nn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMS0xMC0yMDI1IG9tIDEyOjE2IHNjaHJlZWYgTnVubyBTaWx2YToNCj4gRm9yIGFs
bCBjb21tYW5kcyBhZnRlciB0aGlzIG9uZSBpbiB5b3VyIG1lc3NhZ2UsIHdoZXJlIHRoZXJl
IHdhcyBubw0KPiBvdXRwdXQsIHdoYXQgd2FzIHRoZSBleGl0IHN0YXR1cz8NCg0KVGhlIGFu
c3dlciBpcyBiZWxvdy4NCg0KPj4gICAgIyAuL2xvc2V0dXAgLWQgLVIgbG9vcDQNCj4+ICAg
IGxvc2V0dXA6IC9kZXYvLVI6IGRldGFjaCBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkNCj4+DQo+PiBIdWg/ICBXaHkgZG9lcyBpdCB0cnkgdG8gaW50ZXJwcmV0IGFuIG9w
dGlvbiBhcyBhIGxvb3AgZGV2aWNlIG5hbWU/DQo+IA0KPiBUaGUgb25saW5lIG1hbnVhbCBo
ZXJlIHNheXMgdGhhdCAtZCB0YWtlcyBvbmUgYXJndW1lbnQsIHNvIG15DQo+IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCB0aGF0IGlzIGV4cGVjdGVkPw0KDQpBZ3JlZWQuICAoSXQncyBqdXN0
IHRoYXQgSSBleHBlY3RlZCB0aGUgdG9vbCB0byBiZSBjbGV2ZXJlci4pDQoNCj4+ICAgICMg
Li9sb3NldHVwIC1kIGxvb3A0IC1SIGxvb3A0DQoNCiAgICMgZWNobyAkPw0KICAgMQ0KDQpT
byBpdCBkaWRuJ3QgYWN0dWFsbHkgd29yay4gIEl0IG9ubHkgd29ya3MgKGFuZCBoYXMgZXhp
dCBzdGF0dXMgMCkNCndoZW4gaGF2aW5nIGEgZG9uZSBhIHBsYWluIGAuL2xvc2V0dXAgLWQg
bG9vcDRgIGJlZm9yZWhhbmQuDQoNClNlZWluZyB0aGF0IGZvdXIgb3B0aW9ucyAoLWQsIC1E
LCAtYywgLVIpIGFyZSBtb3JlIGxpa2UgY29tbWFuZHMsDQptYXliZSB0aG9zZSBzaG91bGQg
YmUgbWFkZSBtdXR1YWxseSBleGNsdXNpdmU/ICBNZWFuaW5nIHRoYXQNCmxvc2V0dXBgIHNo
b3VsZCBiYXJmIHdoZW4gbW9yZSB0aGFuIG9uZSBvZiB0aGVtIGlzIGdpdmVuPw0KDQoNCkJl
bm5vDQoNCg==

--------------OPjT9E4YG0QHmCoDg01qO8Nn--

--------------T0lnIItqqnzuSq35Gemv827u
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjqUdoFAwAAAAAACgkQUUu+Lrjhlh8T
1RAAqOVUlNLltSNch+a1Jy0SIt4cgAe2LUD+jncnGgWXNgLkm8iM5RDFDnLb7JOpqg977dvL1Qgq
CM+1viSTnh8E0W7k+8r/cZCdVftSQ6jxQTlvsQP381brTRA2bGeHl3FR1m+oQS3FdtGcvSZjgZBi
NXxa1fucjz9ZGGv/IMzeWHOseX+5to3Fxa+mSlVJNEHgpz24imLUDZRChY3El9FBn3T2CSJV4Vop
Gxl6WTF0BNmRSOiTzmyFvD+nYV+9hPwE2PBXtcmL3pEdiMYFIuth9LMHVmjB8sBEbc5UgWSILs4I
sg+PvFTGk+H/JLkp/Wf0XHlM4hVYopa/nIl1r5sy5AlUOyKQa6fFK0zSBSMCvV2ME+9UIWE+oQvh
CGV/psLj6gcPyZpjb0VKvoMac69OhmDl5f0+Cm4GGlQNA2X9DtDYJ2qnuEoKjhFuoNZbWIXPDhds
HNxWXzHnpheCiUHIi1jkOluL7n0jcmCazXmGA4cPb1NQU9wZNsGBoNJwmf7B78Rul9/ibxX2pqSZ
+/Ju+Lg9eM4dUUiP6YRQY2Bsaz5ZhpWv6CvGKeQo8CenoNuAqWMsICPO6BConi2/ZALf5/kk5gFS
40NWGECktmplVGHLZ8SNrFQFrPtFT8Wzx+E/GX04WIlgKZkFk9rdrsSW9sxQlRA0pCy2RoMUlpSU
wJE=
=aQ6V
-----END PGP SIGNATURE-----

--------------T0lnIItqqnzuSq35Gemv827u--
