Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46850481C4
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500564; cv=none; b=C3toyEh7aQEvssHGQRowgJ9NqzlgEjjCf38gb5GcbChSEjmBGX42R12BVS2pDzTlAIseWGE/4qIrtU+T+CWC2vglIlbKH4GA90YoKWujUiBcJD1dKU9F+yrhUC3il+07yGl7yInue4QV4TtLrJULREDkmDFEK6hwgzOZzRLAdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500564; c=relaxed/simple;
	bh=PWZe+7Itlxx1vVPx2AgQKzXZSYCx1p0MAPe4xFqT4DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=S5K6nBO5LfNRMruKfOdFb44aC0e1U7NQ7g6s6Xzi7Xdgjsk2ek1+qeW4LAHqZSo3QbYa1vFFWLeFOOjsIteWrq6Tnwv5Q47Pg5z08fYRI5X5yOch12fP6F6xaXHOmjX1Hoy6KwK68x0jd2rW3/r207gAq+CYJRLH3KlRC1VWNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ly/pg13q; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ly/pg13q"
X-KPN-MessageId: 6a001705-210e-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6a001705-210e-11f0-b9a0-005056abbe64;
	Thu, 24 Apr 2025 15:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=PWZe+7Itlxx1vVPx2AgQKzXZSYCx1p0MAPe4xFqT4DI=;
	b=ly/pg13qHYo4ph98EsFEp+cIjfPzyAYv6CMPpkw2bs2yDZmNwQj+YcJN424UCiSWqGn05/5COzjBO
	 iYDIPfoT4UGpteKkDX+e2ClpfWOE9qF3JLF1Gw4s3TiIA7svS3S7xbWV54J+s5sSFyL4RUgKXX3Tt2
	 8Ei0kyH22GurbAIE=
X-KPN-MID: 33|nvVds6ENaL6dhik7s4UTs9UqjeD7ljin7CwgoA7lMwD4SKNXvKm8FF5a/CHWCb6
 k76tGzWlpI62wXc+36a7XEra1VCljdJ80Hn9pT5jGr4A=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|uiWf9xZswfPsffm0fYcA502fuy+T7+5DCcU+i7FFpOYQB758KHpEmJ1YCTNoFPy
 DmeiQMUbduY6YPLzflvwl6Q==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 42bea1ce-210e-11f0-9c06-005056ab7447;
	Thu, 24 Apr 2025 15:15:58 +0200 (CEST)
Message-ID: <9681cda7-c636-4399-8229-caada39ccd1f@telfort.nl>
Date: Thu, 24 Apr 2025 15:15:57 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] pipesz: report default size in --help, instead of
 referring the user
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-6-bensberg@telfort.nl>
 <MN0P221MB1530A6F07A44AF169879CBA7C2852@MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
Cc: Nathan Sharp <nwsharp@live.com>
In-Reply-To: <MN0P221MB1530A6F07A44AF169879CBA7C2852@MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------i0zNaUBMywL40I0CywYD0ffK"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------i0zNaUBMywL40I0CywYD0ffK
Content-Type: multipart/mixed; boundary="------------bmhv2ZNuLcn9klLasXUIQJvb";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Cc: Nathan Sharp <nwsharp@live.com>
Message-ID: <9681cda7-c636-4399-8229-caada39ccd1f@telfort.nl>
Subject: Re: [PATCH 6/7] pipesz: report default size in --help, instead of
 referring the user
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-6-bensberg@telfort.nl>
 <MN0P221MB1530A6F07A44AF169879CBA7C2852@MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM>
In-Reply-To: <MN0P221MB1530A6F07A44AF169879CBA7C2852@MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM>

--------------bmhv2ZNuLcn9klLasXUIQJvb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNC0wNC0yMDI1IG9tIDEzOjI0IHNjaHJlZWYgTmF0aGFuIFNoYXJwOg0KPiAgwqDC
oMKgIElmIGl0IGlzIHRvIGJlIGRvbmUgYXQgYWxsLCBpdCBNVVNUIGJlIGRvbmUgaW5zaWRl
IHRoZSB1c2FnZSgpIGZ1bmN0aW9uOyANCj4gc28gdGhhdCBpdCBpcyB1bmxpa2VseSB0aGF0
IGZ1dHVyZSBjaGFuZ2VzIHdpbGwgaW50cm9kdWNlIGEgcmVhZCBvZiBhbiANCj4gdW5pbml0
aWFsaXplZCBnbG9iYWwgdmFyaWFibGUuDQoNCldoaWNoIHZhcmlhYmxlIHdvdWxkIGJlIHVu
aW5pdGlhbGl6ZWQ/ICBHbG9iYWwgdmFyaWFibGUgJ29wdF9zaXplJyBnZXRzDQppbml0aWFs
aXplZCB0byAtMSBpbiB0aGUgYmVnaW5uaW5nLiAgQnV0IG9rYXksIG1vdmluZyB0aGUgdHdv
IGxpbmVzDQpiZWZvcmUgdGhlIGNhbGwgb2YgdXNhZ2UoKSB0byB0aGUgc3RhcnQgb2YgdXNh
Z2UoKSBpdHNlbGYgaXMgZmluZS4NCg0KPiAgwqDCoMKgIEhvd2V2ZXIsIEkgZG8gbm90IHRo
aW5rIHRoaXMgaXMgYSBnb29kIGlkZWEgaW4gaXNvbGF0aW9uLCBhcyBpdCBkZXByaXZlcyAN
Cj4gdGhlIHVzZXIgb2YgdGhlIGtub3dsZWRnZSBvZiB3aGVyZSB0aGUgZGVmYXVsdCBzaXpl
IGNvbWVzIGZyb20sDQoNCk5vdCBhdCBhbGw6IHdoZXJlIHRoZSB2YWx1ZSBjb21lcyBmcm9t
IGlzIG1lbnRpb25lZCBpbiB0aGUgbWFuIHBhZ2UuDQpUaGUgdXNhZ2UgdGV4dCBpcyBub3Qg
bWVhbnQgdG8gaW5jbHVkZSBfYWxsXyBkZXRhaWxzIGFib3V0IHRoZSBwcm9ncmFtDQotLSB0
aGF0IGlzIHdoYXQgdGhlIG1hbiBwYWdlIGlzIGZvci4gIEFuZCwgdW5saWtlIHRoZSBtYW4g
cGFnZSwgdGhlDQp1c2FnZSB0ZXh0IF9jYW5fIGluY2x1ZGUgdGhlIGFjdHVhbCB2YWx1ZSBv
ZiB0aGUgdGhpbmcuICBBbmQgaWYgaXQgY2FuLA0KaXQgc2hvdWxkLCBpbiBteSBvcGluaW9u
LCBhcyB0aGUgdmFsdWUgaXRzZWxmIGlzIG11Y2ggbW9yZSB1c2VmdWwgdGhhbg0Kc2F5aW5n
ICJnbyBsb29rIHRoZXJlIi4NCg0KPiBhbmQgYWRkaXRpb25hbGx5IGNvdWxkIGNhdXNlIHRo
ZSBoZWxwIG1lc3NhZ2UgdG8gcHJpbnQgYSB3YXJuaW5nIQ0KDQpUaGF0IGlzIGFjdHVhbGx5
IGJldHRlciB0aGFuIHJlZmVycmluZyB0byBhIGZpbGUgdGhhdCBoYXBwZW5zIHRvIGJlDQp1
bnJlYWRhYmxlL3VucGFyc2FibGUsIGJlY2F1c2UgdGhlbiB0aGUgaGVscCB0ZXh0IHdvdWxk
IGJlIGx5aW5nLg0KDQoNCkJlbm5vDQoNCg==

--------------bmhv2ZNuLcn9klLasXUIQJvb--

--------------i0zNaUBMywL40I0CywYD0ffK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmgKOY4FAwAAAAAACgkQUUu+Lrjhlh9w
gQ//Wh6jczA4PaVEdhn1tqgPEfg8Ah4ElVyHMtyQKwWZKnRjpAfFtAMeSkI+vwQUdhN0fb4WyCJg
L9yaXEwx88E+YnZN4JClvfuchqXjqjfADr7y/r/SdO+fpIDDDLxRLN8AueCTG1I79z7MPkA6Iaz+
lwDQ5vQfwlV3ZSihN53pfjjLBOA20VM904p4ipWijjGH6K9zBcZouJ7lJfmIoqx3a8p0nnKhqHwi
Gy4JgRp3IMAG6W6RM3M3bSu8B4dm6SvQrvuGEw2JtNSQf+Kr6o2qq4VYf2C5EdvbNCto3tPeypNn
jdfyU9Ns+x/41FfrERZe2AfU4qhRGTrgZHA3QgHVudPgo6tU6YMWLCZTYebZd8T0Kmyx+QkpxJpd
cJ7pXVp9YPuCbbCQubqifMswrZUc7/0OH+qcW6ToMawYYQyidpDQ+l2bzZ5bWlt75djxkYRFo+PD
pIfkjC7eq+38XnBcmRlXWzLbGVkgKtDOmJtjF3asptLShlAYrffcsGr6mLUZ9DnOl2XM6Sx4M0JQ
vd0zGJ3EnwjQNue+9bBAET13zksk9kukV2nC8jby/wyWNxJ0cWDIJR0nFg890nUCcMK0uHp3NdQ5
axyjwSs0I0TBzf1kxGerOW78xC+1pwwnJNJ+QZ8aJ9I2aIpg7er17PUrMUDnXC165rP5tfhYLars
Cj0=
=ZoeT
-----END PGP SIGNATURE-----

--------------i0zNaUBMywL40I0CywYD0ffK--
