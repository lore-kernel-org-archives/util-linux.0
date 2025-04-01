Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5D1EDA20
	for <util-linux@vger.kernel.org>; Tue,  1 Apr 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499546; cv=none; b=nfxyOty0M/4hF1/tbhgn6L8tb/dQ3v9Gpy723MsvoTuoGdyLURJolimV02LnYODLHv0BPL3WpqET2gzuUDpeaXBxq8nuAVvsVW5aZVjEqs7e52QjycacpLIERImhziiHE2ZcDrj0bBZ0ZndvYtpSANRRnwBY08DlDHJYgAptXKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499546; c=relaxed/simple;
	bh=ML9QOc1IQY1+Im7j1byLYAoeqHtJATsc2f7Qwl41p+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSmeKGmjGzboi9c/dxlaEzt6CqiCod+CzTgu4d4Vix1lbr1jM+zKjrFtdG9BriKPWQKlCxA0va9xUtW6Rp6d8D24MynZTQy0vfQyd9r3xgN9x2INTtut3BPf1XamM3rBx887eI6+BN3NKotnJxT9mSXBVyndWwlpKKPlZdVQeCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=tvrWyHPU; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="tvrWyHPU"
X-KPN-MessageId: 5684dbcf-0edb-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5684dbcf-0edb-11f0-a82d-005056abad63;
	Tue, 01 Apr 2025 11:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=ML9QOc1IQY1+Im7j1byLYAoeqHtJATsc2f7Qwl41p+s=;
	b=tvrWyHPUZI0Eox90NVWOPoS3CDyWUA/NG5pW7RNlxCXPS6CIok3U3kO2AN8ywHWaF25n/oC+JMAly
	 a5vtOc9Off1eiTQhDyh/2USnE7imdPh+xXAp3a1CZw0/tGXD5ELky+/EPgJlRae6bgeJwfsdAL6owz
	 vbGt9kGI9Jl55eyU=
X-KPN-MID: 33|M0OLP1R/k50EihK4z9fLVzKhNb+k8z0s+k398CJtJfZY1cJPM3J4rVYEQPjF6rL
 WSsbpeBQI18JUib5yN5EBdS5gT+2aluG6WXvyKCqxZ88=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jWtLKOK74Me2onX/Ejeppqy2SuuyzgOuJEQnZ/MuiV0X3f4+JQ/GP1kcMrrJqgb
 oLHvsDf6qN5gLNrwZv06idA==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 476e4916-0edb-11f0-9598-005056abf0db;
	Tue, 01 Apr 2025 11:25:40 +0200 (CEST)
Message-ID: <a281e4be-2cd9-4d22-be86-502395556005@telfort.nl>
Date: Tue, 1 Apr 2025 11:25:40 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] coresched: rename option '--dest-type' to just
 '--type'
To: Karel Zak <kzak@redhat.com>, Phil Auld <pauld@redhat.com>
Cc: util-linux@vger.kernel.org, Thijs Raymakers <thijs@raymakers.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-10-bensberg@telfort.nl>
 <20250331110902.GB120637@pauld.westford.csb>
 <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JNQ7mVg6yrZ8AVHsjnD0efNB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------JNQ7mVg6yrZ8AVHsjnD0efNB
Content-Type: multipart/mixed; boundary="------------QR3HHb9ecZl6Nnf5Qr0I3GJa";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>, Phil Auld <pauld@redhat.com>
Cc: util-linux@vger.kernel.org, Thijs Raymakers <thijs@raymakers.nl>
Message-ID: <a281e4be-2cd9-4d22-be86-502395556005@telfort.nl>
Subject: Re: [PATCH 10/10] coresched: rename option '--dest-type' to just
 '--type'
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-10-bensberg@telfort.nl>
 <20250331110902.GB120637@pauld.westford.csb>
 <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>
In-Reply-To: <tvh2bppxcinonxmyjrrgghgsylnaz6mkcrqr5ifxfqxvw54jym@iirtylnnzx4h>

--------------QR3HHb9ecZl6Nnf5Qr0I3GJa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMS0wNC0yMDI1IG9tIDEwOjM1IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IE1hciAzMSwgMjAyNSBhdCAwNzowOTowMkFNIC0wNDAwLCBQaGlsIEF1bGQgd3JvdGU6DQo+
PiBidXQgdGhpcyBjb3VsZCBicmVhayB1c2Vycy4gVGhlcmUNCj4+IG1heSBub3QgYmUgdGhh
dCBtYW55IHlldCBhbnl3YXksIG9mIGNvdXJzZS4NCj4gDQo+IEl0J3MgYWxyZWFkeSByZWxl
YXNlZCwgc28gaXQgaXMgdHJ1bHkgYSBiYWNrd2FyZC1pbmNvbXBhdGlibGUgY2hhbmdlLg0K
DQpVc2VycyBvZiBhIGJyYW5kLW5ldyB0b29sIHJlYWxseSBzaG91bGQgZXhwZWN0IHNvbWUg
aXRlcmF0aW9ucyBpbiB0aGUNCm5leHQgdmVyc2lvbnMgdG8gaW1wcm92ZSB0aGUgZmVlbCBv
ZiBpdC4gIFNvIEkgZG9uJ3Qgc2VlIGEgcHJvYmxlbSBpbg0KY29ycmVjdGluZyBhIHBvb3Ig
Y2hvaWNlIGZvciBhIGxvbmctb3B0aW9uIG5hbWUuDQoNCg0KQmVubm8NCg0K

--------------QR3HHb9ecZl6Nnf5Qr0I3GJa--

--------------JNQ7mVg6yrZ8AVHsjnD0efNB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfrsRQFAwAAAAAACgkQUUu+Lrjhlh8z
CxAA0HlbmDsktZTDVEY20sm+00w+QOY73AXbDJKJHrICiTwtvlCBFGBniG/nvBcV34AysmW+o6eh
9V65G3el4gbdq860g7E9qsTJDsy8yOA+3K5dIG+I4vdXD0yGPgXlw+gTcOIlI96v1aUf24I7UOYi
3NnWr0coQM7Adm15y+Cm3A2M4V0YNJzARiwiOBEm9OjK0RtRNYuSHln8DWyiCiQko4CapoX9FBwv
mUppKuF6fe6GMsjN1A2ZhXz6gFHEG071iTBKixffzasfby6EIlIzd+I1uNJxe7/LWl26fvZfE8ng
kJAYYJSeJtIisGZThCVadHcY+RrpiIVnAB7gyYQJBySOFvqP21Je0mPA4NY7BSfXq7YSR+8KokCC
dEy1KO3kR4TH0Kbj0JpELp5IHxUFF4J4S0nGUroWF3stZ2Xx2ZyiodvS8w4wKCBjDOXJNyWy+jT5
+8fHd/q1nx8ymS76iLQGsF4ZVWDFVl+eVj+RNJXeyJ5YvaPHD3HKfeRpfIkjelJyxRvxHiurU+bL
i/tc/0igRnIICaOKfWHQGW9Yo03XbVMvDK9aETPttPmdKI7Se/yMMQRHPQ8xN2NgmSxT2L0klSis
NbvesCSGXtd/eO8Cp1d+txxqQe3Kxuh8wZKZSk/D85Ah5HDeJ6bf3dxInQUErgsxAt8hzWgJWIUp
DQg=
=6uGg
-----END PGP SIGNATURE-----

--------------JNQ7mVg6yrZ8AVHsjnD0efNB--
