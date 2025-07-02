Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CB523184F
	for <util-linux@vger.kernel.org>; Wed,  2 Jul 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463599; cv=none; b=sdMPJvwnVWwYCSRwfLl194XbweGc6y5KpP/6rnYD/FIwUQKIYmGj3p6kvt4JXHmgFRNBdGi+n65bHoGU3Lgqyorixt3jRSOesGJXP42aJYVImNn+EHED1mHdgKZiUZqIGnekvXDmyoviCkUuY6i6qzF2a3bvRESiSsf1y3cY1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463599; c=relaxed/simple;
	bh=FUqJla4V0ijbyEyPeRoq6Iv+ng9ZylybeagyvAMYYRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pM4PbjRIVCWuAzPXFI02D5YfH7cEHbJyzCCA1DgvHlKbYjaOwTzZZpD/c5bDGCfWWSgz5gKYQHwbS3aVnAjj22x4Ewd9Rs0/0JonvncI8xjGtBrufArXb0S2Wx9Nze8ybkPHZsFDh2pCy22xgNhUA2qqabksDAXyXvVFLod9UKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=IcWNhlXc; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="IcWNhlXc"
X-KPN-MessageId: 3af98eae-574a-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3af98eae-574a-11f0-b9a4-005056abbe64;
	Wed, 02 Jul 2025 15:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=FUqJla4V0ijbyEyPeRoq6Iv+ng9ZylybeagyvAMYYRU=;
	b=IcWNhlXcuIpKZeuENAmn5EFnfGsAkXBrNPBJnsU1ew1OYoGxXq2fHI6L4sFRSl3d/oGUhNhdc6vTZ
	 X7lAKwACkp1+Ci+OXzjVYEDi7/H+QJo/RDicDfxBtxS+2wqt6o4tNrqsUN0g6paQ9qlkelpg2RCH2n
	 DtiQBZ29M5AOJN2s=
X-KPN-MID: 33|f6NlrtH7Jw3J4l6z+wMDaF6KDYFQ3CFYvx+PYi+jv3W2mGQBM0A6mkCxo8Rm9iH
 hEqmzDwIRGlLO+8nd3/m9WsCxBZ/xRg1APMUc3psqZ5E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XmHcwJ8KMhc3GHd+mTY0Q3kvVWLkd4rguKJ1n2vvLhhUx6RMXeclUMNMRVzk9VM
 I8axiZhKt++vI5p2FckkiNw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 08e740e6-574a-11f0-9c8f-005056ab7447;
	Wed, 02 Jul 2025 15:39:53 +0200 (CEST)
Message-ID: <bc67a8ab-2a8b-4339-88e7-02fe71779491@telfort.nl>
Date: Wed, 2 Jul 2025 15:39:53 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
To: Karel Zak <kzak@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
 <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
 <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TTpBYTIGX6zW39ECGBmXhm0r"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TTpBYTIGX6zW39ECGBmXhm0r
Content-Type: multipart/mixed; boundary="------------wicfU5LVML9jV1c21lJdr3Ky";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Message-ID: <bc67a8ab-2a8b-4339-88e7-02fe71779491@telfort.nl>
Subject: Re: [PATCH 3/4] chrt: simplify the other check for too few arguments
References: <20250630084052.11041-1-bensberg@telfort.nl>
 <20250630084052.11041-3-bensberg@telfort.nl>
 <4e545c8f-8e74-462f-8416-3c1cbde81b2e@linux.ibm.com>
 <a80cdbf2-0c4d-40dc-8ae6-9ccbd900bc1b@telfort.nl>
 <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>
In-Reply-To: <4xnz2hducqdq7o2nvysrm5pvll7k52sprsycok6ouf5epqua6d@5yicext46xu5>

--------------wicfU5LVML9jV1c21lJdr3Ky
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMi0wNy0yMDI1IG9tIDExOjAxIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBUdWUs
IEp1bCAwMSwgMjAyNSBhdCAwMzozOTo1N1BNICswMjAwLCBCZW5ubyBTY2h1bGVuYmVyZyB3
cm90ZToNCj4+IFRoZSByZWFzb24gSSBkb24ndCB3YW50IHRvIHNlZSAiVHJ5ICdjaHJ0IC0t
aGVscCcgZm9yIG1vcmUgaW5mb3JtYXRpb24uIg0KPj4gd2hlbiBJIG1ha2UgYSBtaXN0YWtl
IGlzIHRoYXQgaXQgbWVhbnMgdGhhdCBJIGhhdmUgdG8gcmVhZCB0d28gbGluZXM6DQo+IA0K
PiBXZSBzaG91bGQgYmUgY29uc2lzdGVudC4gVGhlIGBlcnJ0cnloZWxwKClgIGZ1bmN0aW9u
IGlzIHVzdWFsbHkgdXNlZCBhcyB0aGUNCj4gZGVmYXVsdCBlcnJvciBmb3IgYW4gdW5rbm93
biBvcHRpb24gb3Igd2hlbiB0aGUgdXNlciBpcyAibG9zdCIgb24gdGhlIGNvbW1hbmQNCj4g
bGluZSwgZm9yIGV4YW1wbGUsIGlmIG5vdCBhbGwgcmVxdWlyZWQgYXJndW1lbnRzIGFyZSB1
c2VkLg0KPiANCj4gICAgd2FybngoXygidG9vIGZldyBhcmd1bWVudHMiKSk7DQo+ICAgIGVy
cnRyeWhlbHAoRVhJVF9GQUlMVVJFKTsNCj4gDQo+IChvciAiYmFkIHVzYWdlIikgaXMgY29u
c2lzdGVudCB3aXRoIHRoZSByZXN0IG9mIHV0aWwtbGludXguDQoNCkFmdGVyIGdyZXBwaW5n
IGZvciAtQjEgZXJydHJ5aGVscCwgSSBub3cgc2VlIHRoYXQgdGhpcyBpcyB0aGUgc3R5bGUN
CmluIHRoZSB1dGlsLWxpbnV4IHRvb2xzLiAgSSdtIHNvcnJ5IHRvIHJlYWxpemUgdGhhdC4g
IDovDQoNCj4+IHRoZQ0KPj4gc2Vjb25kIGxpbmUgZG9lc24ndCBhZGQgYW55IGluZm9ybWF0
aW9uIC0tIGl0IGp1c3Qgc3RhdGVzIHRoZSBvYnZpb3VzLg0KPiANCj4gSXQgZG9lcyBub3Qg
aGF2ZSB0byBiZSBvYnZpb3VzIHRvIGFsbCB1c2VycywgLT8gLWgsIC1ILCAtLWhlbHAsIHNv
bWV0aW1lcw0KPiBub3RoaW5nLCBldGMuDQoNCkFzIGZhciBhcyBJIGNhbiB0ZWxsLCBhbGwg
dGhlIHV0aWwtbGludXggdG9vbHMgdW5kZXJzdGFuZCAtLWhlbHAuDQpTbywgZm9yIHV0aWwt
bGludXggdG9vbHMsIGl0IGlzIHJhdGhlciByZWR1bmRhbnQgdG8gdGVsbCB0aGUgdXNlcg0K
dGhpcy4NCg0KKFRoZXJlIGFyZSBqdXN0IHRocmVlIHRvb2xzIHRoYXQgZG9uJ3QgdW5kZXJz
dGFuZCB0aGUgc2hvcnQgZm9ybQ0KLWggZm9yIGhlbHA6IGFnZXR0dHksIGNvbCwgYW5kIHNl
dHR0ZXRtLiAgZnNjayBkb2VzIG5vdCBvZmZpY2lhbGx5DQpzdXBwb3J0IC1oLCBidXQgcHJp
bnRzIGEgaGVscCB0ZXh0IGFueXdheSwgZnJvbSBlMmZzcHJvZ3MuKQ0KDQoNCkJlbm5vDQoN
Cg==

--------------wicfU5LVML9jV1c21lJdr3Ky--

--------------TTpBYTIGX6zW39ECGBmXhm0r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhlNqkFAwAAAAAACgkQUUu+Lrjhlh8T
fRAAqxFt+Too5FRHMhRz40dl/HVuR6e4WA7H1MT1dIxF8whpe71387nd//DLiWUO4QBlOtR8ePWR
7brsUtAXhIKvpePg2b+9CmAItU3vGhteQ6tNOTPlysN0ZHpUMuryFmyWZEtjLyK/q5wQ5l69JnU+
jvaxMSEttQ9N2H6+niSH4fztXDds9n+5bwhYY0y2ALgyEIK5gqkMht2nyrW6lgs57K38fooLiWhJ
nPhQyYrWUFIM2r6psMjX7ZmQfS9MRce4pdrxIL6+BhOxs9UlpDDMalWfjIAjIm86UsbvMQhhrAHE
RP4qmovQ01MmqNhQIes2a/K8jykv/0O02hZ/lbux9gbr1HSp2U68ASfLq5EMXqOy98QRU7fOdauc
sQwgGT2Dek0KNiVUCiVikowsl2wiSq8GKKMJlX5Z77uNrcwU9Ditv0SyG9FHH4daerMc8x0/btJn
ni4Qn/V5n05Vz0ISRADJIWtizL1z8QcWBnR0tX5KaHSsdw4zu3+ZvU41yAyOlVY9Xdp5BFu8YIzm
AqEfwqRPnWnFblH3l5KYbgQTe6zBcUqmR0lMCTSxcNW7PlDQ04sWclbZH2KXl7cA6WxjZjGjE5MH
nRV2hUBz8A5QOy7/5z3WCm2BxS36UNu91pVzegUqvAJRTG96gEFTjXY2QMWhXnT4oD7/eKWGaITP
ERY=
=I0Y2
-----END PGP SIGNATURE-----

--------------TTpBYTIGX6zW39ECGBmXhm0r--
