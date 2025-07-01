Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1B3C47B
	for <util-linux@vger.kernel.org>; Tue,  1 Jul 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377210; cv=none; b=tFO4r0IbWOu7QJvsOBWvBrxmhOSDT6tr+bK1cDX2gb4RLjwZqPC2YWyM7qfnUUTv6wGNjTb1xsvndy695HVzhsSNP7tyR+APi2KOTXLmmtEedstkK1qpNeCIhzU5s1S9aKFVZvhMhcLsk5Ii/tcamKYvHjHx2AQnVMKPSkm0N88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377210; c=relaxed/simple;
	bh=zvnTxdhD5D6FP+F4aEwguJZApAWvZWxOzmnC9pNe8no=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j2NCreTxmMGJxn7wH7h5SGwytYC60Xq3Tzl+53yqeEJCqOcah867Pr8jaVqwPksYk6OYkclPTxVs2ZgPluw/RwOXV09cwbbW5RYyPy3tDCuueTdNZeHsruZDH9ya8AwPKVgg9p/NKbAbaswsxE3r/zGNUshBCDOdUMhHuvUtKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=FjOGvBRc; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="FjOGvBRc"
X-KPN-MessageId: 12afb95d-5681-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 12afb95d-5681-11f0-b9a4-005056abbe64;
	Tue, 01 Jul 2025 15:41:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=zvnTxdhD5D6FP+F4aEwguJZApAWvZWxOzmnC9pNe8no=;
	b=FjOGvBRcky4TU3urpZ4tzOXkGYIa1iSkyi0ZEbfRqLQapMCKSZrmcB5H2kQDS7/kLMPZ0gXe3ADD2
	 adVk5GnAPcG+3futMNN6Ikx73qWhZnvQSmIcrJrUBAjCDMYCElMsj8E5huVNliMeQZ/5OcreJQfr9B
	 e+CqR0Ezana2OlOM=
X-KPN-MID: 33|JiB0PoKwKYmuC2iGKVvTrQ7YzMSEfizgLP8P1E/yPjSQ4aC26clBAEJE7hiaboz
 vhHc1NQwX2Z9JPfGE8/BPBdfWmKsERuk2gM+KaJ1rHzk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|99lCuGulwF9EECahZL9AP7SRBM4xTYPYkroaKEg6z7WQQCrHCsZiA4L4FSb3cN9
 USt1p6D2APGIEOAd/NmllDA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e16a34c6-5680-11f0-95b7-005056abf0db;
	Tue, 01 Jul 2025 15:39:58 +0200 (CEST)
Message-ID: <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
Date: Tue, 1 Jul 2025 15:39:57 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------04r4mbv4c11Ofd6L1m06RdSO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------04r4mbv4c11Ofd6L1m06RdSO
Content-Type: multipart/mixed; boundary="------------rAlx57T3tgBcf4uqw0s95RLp";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
In-Reply-To: <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>

--------------rAlx57T3tgBcf4uqw0s95RLp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMS0wNy0yMDI1IG9tIDA3OjE2IHNjaHJlZWYgTWFkYWRpIFZpbmVldGggUmVkZHk6
DQo+IE5pdDogSSB0aGluayB3ZSBjb3VsZCBzdGlsbCBoYXZlICJUcnkgJ2NocnQgLS1oZWxw
JyBmb3IgbW9yZSBpbmZvcm1hdGlvbi4iDQo+IGFsb25nIHdpdGggeW91ciAidG9vIGZldyBh
cmd1bWVudHMiIHNvIHRoYXQgdXNlciBrbm93cyBleGFjdGx5IGhvdw0KPiBtYW55IGFyZ3Vt
ZW50cyBhcmUgbmVlZGVkLg0KDQpUaGUgcmVhc29uIEkgZG9uJ3Qgd2FudCB0byBzZWUgIlRy
eSAnY2hydCAtLWhlbHAnIGZvciBtb3JlIGluZm9ybWF0aW9uLiINCndoZW4gSSBtYWtlIGEg
bWlzdGFrZSBpcyB0aGF0IGl0IG1lYW5zIHRoYXQgSSBoYXZlIHRvIHJlYWQgdHdvIGxpbmVz
Og0KdGhlIGVycm9yIG1lc3NhZ2UgcGx1cyB0aGUgIlRyeS4uLiIuICBJdCB0YWtlcyBtZSBt
b3JlIHRpbWUsIF9hbmRfIHRoZQ0Kc2Vjb25kIGxpbmUgZG9lc24ndCBhZGQgYW55IGluZm9y
bWF0aW9uIC0tIGl0IGp1c3Qgc3RhdGVzIHRoZSBvYnZpb3VzLg0KSXQgcmVtaW5kcyBtZSBv
ZiBDbGlwcHk6IHNvIGVhZ2VyIHRvIGhlbHAgdGhhdCBpdCBiZWNvbWVzIG9ibm94aW91cy4N
Cg0KDQpCZW5ubw0KDQo=

--------------rAlx57T3tgBcf4uqw0s95RLp--

--------------04r4mbv4c11Ofd6L1m06RdSO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhj5S0FAwAAAAAACgkQUUu+Lrjhlh/W
eBAAjnlf1Bl9jvanELCcnNPv9X/0tRlkxRxY7avTqDhAVQzyl1qezf5ZgGtoTvnIoMe8HojMOOpl
kVkmBHw8OMeHg6LtsOZuhwYy2RIOVnV2WzW8VIUhIUTVMC1wG8v9gRVseyeFEWym+a6Lo7q6t0NG
/RiC/xrqSqPrRsFJYfMAADuURoF54TKwWHkDCjsTDuTjS/qrhUM1RPB7QWoHUeVldaYlzvssDFgJ
yQXJ85AZIfZm6EP0+OjWGJ1RigXa7FQccgC6RH4AFSSSUlpWOaQuJPb7o3TkJtem7frw5s/UMhEd
Az0KwMVzk4wE28MYhyP5yqsGfFp15lNpETWo08MtI839gkuig22Ir6NkbzJzq1CXXULKsuHEy7S1
PShcKPghfY1r0T2dGGH3jwuWokZvKaHUBIayx8dlpYjfrJtWKmNppXseJh1sXvSz1aOKVgRMCxiQ
1Y/GDpYwWNf09XWCVUrL3o0y9EB2mk/0e/3xOGtRzZz1CaD0MMoCqkzIfcW7mFUUbikG8Et/KZV1
mO4QAp7wVjZlArw+Ha0MiQnyI5IaOLEwoLbEGX7bJLjqf/896kVMahJ5hNeb+YOGiTeJwCfVT8T0
FgISE19SeSDXgf9lnxTMqtgCtkvN6YDeJmBueMgp/MUfRJygM7fLAEzXvK+r9g1Ksf2YDcfONTQR
gWs=
=o/vy
-----END PGP SIGNATURE-----

--------------04r4mbv4c11Ofd6L1m06RdSO--
