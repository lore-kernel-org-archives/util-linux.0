Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603F42153D8
	for <util-linux@vger.kernel.org>; Mon,  6 Oct 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744677; cv=none; b=qlGb1JH0ncFJutdVy8iVxEjmI39zo1/+COw6df4GB/IU3GAt9pxREindJKhsNTUDVt78e2LoYP487JVIj9KERwA0wFFEv36EthdZWxiW5uIX9nDwhUyeNkNerjvTYCoTOKTVde6aUFzLEhpn4i9q8iWgYRI8ifj8hICFvN5N6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744677; c=relaxed/simple;
	bh=oqjfHmxfZXVJbsa7ds0YKw+CbpURCqEtfi9QXHdlXuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV6iNxVcms9mq8e94e2jFgcnWrLsP5p/lz1ylEYllXk9MTZfULFH2+hc2pcJ6QqKNyTB5GmBpyS1FOn68MmelUI2A32zmpUQWWoAb6NBw46X7JzoFH/A1dtp1LqZiqgObLxE3haARJiBCnpdMXd90zvAw/HePcqvAHxHWFWDcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=IK5yodC7; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="IK5yodC7"
X-KPN-MessageId: eead21f8-a29a-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id eead21f8-a29a-11f0-bd6b-005056aba152;
	Mon, 06 Oct 2025 11:57:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=oqjfHmxfZXVJbsa7ds0YKw+CbpURCqEtfi9QXHdlXuE=;
	b=IK5yodC7cWkFGCq4xzqc2tjeiUL5rmsV0bl6+OmVROmJpfdhIZ3JivGaCfSpd9/1DO1Kj/iNQBQQ/
	 4kKwhaoeLxZ6i7tpTABc4o87zbsOOuQ5RyTE2bk5o2FnydFzEyFgY2on1/461Z9UFsxwIQO4of5StL
	 oeSdPI2jxUVIKwXo=
X-KPN-MID: 33|0b1Ef/H4XuM4ePVX/tMy8AjunRprNLNeelvAmarGIWXJFxO9KIhfFFoPTPY1dEe
 QM8kl6mw0lNpA8cIy6dVzQfdg9LzV4iuBBJaxyY8wcPk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|eQ8HgV48X1vS6xFW45mDRs+WT63lMMZ0wwjawhTDK+ajzAO2I6xr5bzYghEltLF
 jKgQuTvUCgOks1+OqqG1nQw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id eb93bfd6-a29a-11f0-a6c9-005056abf0db;
	Mon, 06 Oct 2025 11:57:51 +0200 (CEST)
Message-ID: <fed873ef-7480-4f91-a5ea-a10fe5e61654@telfort.nl>
Date: Mon, 6 Oct 2025 11:57:50 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] swapon: rename the new --annotation option to
 --annotate
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
References: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LPhizWxPgRu0d0B2mQ4NlNUe"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LPhizWxPgRu0d0B2mQ4NlNUe
Content-Type: multipart/mixed; boundary="------------fwkHgRYKlGzzsU0IGX0KRHdj";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Message-ID: <fed873ef-7480-4f91-a5ea-a10fe5e61654@telfort.nl>
Subject: Re: [PATCH 2/2] swapon: rename the new --annotation option to
 --annotate
References: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
In-Reply-To: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>

--------------fwkHgRYKlGzzsU0IGX0KRHdj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwNi0xMC0yMDI1IG9tIDA0OjAyIHNjaHJlZWYgQ2hyaXN0aWFuIEFsYnJlY2h0IEdv
ZXNjaGVsIE5kam9tb3VvOg0KPiBGWUksIEkgYWRkZWQgeW91ciBwYXRjaGVzIHRvIG15IHB1
bGwgcmVxdWVzdCogb24gR2l0aHViIGFuZCBmb3IgY29tcGxldGVuZXNzDQo+IEkgcmVuYW1l
ZCBtYW4tY29tbW9uL2Fubm90YXRpb24uYWRvYyB0byBhbm5vdGF0ZS5hZG9jIGFuZCBhZGFw
dGVkIHRoZSBuYW1lDQo+IG9mIHNvbWUgdmFyaWFibGVzIGZvciBjbGFyaXR5Lg0KDQpUaGFu
a3MuDQoNCg0KQmVubm8NCg==

--------------fwkHgRYKlGzzsU0IGX0KRHdj--

--------------LPhizWxPgRu0d0B2mQ4NlNUe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjjkp4FAwAAAAAACgkQUUu+Lrjhlh9F
jhAAz16f8MDeXPcfNmaC5wpFGZTjHrUUW9ei8Er818BiS4AMpkIcO6m3U8pD0OakOFxDdoVNGcpM
HP5OqS+YYfKkU9D38edz9oWAcJbbeEAYzCcjBYEAspvcZaZiuhvN8gN/fW4DTacbkl+JLh4aP10n
byX1nCXKbUxHlCYliK8eHxcjSa4Zmeej1g21mDXpkOxku3ZejbMIM+ga6o2X3zZ+umNW92D2aaLI
5Do1JAb8bb2rPm2e9gtuCb6gQzjMiaOGu0ESfnzBolrumBY1lY74+fOcNeZXJgno0/aw1L27B00y
78VVCpZx4848RiUCrIByzCjrmfYEWVUlSCmvboZdIztCE4joqjHFMZ2K11H8yYzUfckFHpleSi+0
/OrK1xdO3pAwWWLrT9iZxrd23p0nZlYf02FH8EhvBZtanmKv0m8wMO4gGqWQrEAq+gNL7mSbASbD
frmh2ddl74hwa/xWgmV3iTVFqUw+kEk8Mx84wtTXp4mwV33hio78mOqVMCbo2MOHgRZRQCUXX2dl
8WyKUWx7iIby6vlO31CZ7W/EnQewu4KJ6Ql9JGxtoNBDq0l8aaR1WV19G0HCCPeUVAcx4iqPg/1B
4Y+d6atHKtaNS2Zwi6Zo+QS1BO31mT9iC7qLk1MOEsNeHPGogLKk7SPTzQg4/Wfe24UEeAtuyhPm
d48=
=UHum
-----END PGP SIGNATURE-----

--------------LPhizWxPgRu0d0B2mQ4NlNUe--
