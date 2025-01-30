Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB31E7C2B
	for <util-linux@vger.kernel.org>; Thu, 30 Jan 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246224; cv=none; b=qI15TtCtwoz1/es7YuNCKFxzBbGO1YNaehbrPuFYcoWAl4iTqmmQ8X3KpxSBAW/VxtxvO9MzLIHjd7S1CzikwWP/kHlV32XETCdb9NUO0bK/7WFFmIMBaDFcN70x8HhnSyGdP6a1wjAuW7obyUKkIxQ8nmGRG5HpAWjCeHCKRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246224; c=relaxed/simple;
	bh=xPOEKbJSMMVdQ2eICQZWZdLlpHqhWVUPrcQFf+W1wYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4aBhr0aLy9Yzg0s7QKGtHuah2ZOpWOfUiT064sRJ5pdRpHsHSNzR97QXRk1mc2qlRzXM1rDo8c1+2KfV43hEiBXDWLSIGBK4H+eMRADRpMlbKa24RPbd3lDdsZ4rDZbXeEHSKRYqX2GaynY9DSr0QI+m5i1HKg2PUn69t0gsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=hIpuB31M; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="hIpuB31M"
X-KPN-MessageId: 1bf05237-df14-11ef-8d8a-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1bf05237-df14-11ef-8d8a-005056aba152;
	Thu, 30 Jan 2025 15:11:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=xPOEKbJSMMVdQ2eICQZWZdLlpHqhWVUPrcQFf+W1wYE=;
	b=hIpuB31M+qfMTylvVIJmD763JSOU9dXpF/CGsDNFU2C/xsSb86jsAgbTjdDpMWI1Hf/c0JQo85qbE
	 VjiFG89yIbJjIa8GOyyTRYNkO6Japg7OUbN/JH9oQWDBb0Y/DvwH4mu3CDLyWKhJrgHsimiJW8u4U6
	 XpnJDlce9ht3t3W0=
X-KPN-MID: 33|glMOhhwrdT1hjUvnj9iUKY9QWi/6geR37eLFqG0has5GXdSzPooUmahduY2ZS8A
 HOcNaOMEPe8Jka+48RMQSlwZ9Psddp5yrYm/orvOvJmI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|P4yniOr4M6jaZDQtXh7w+HGuvvx30ZuCAhpy5GgR5QksMOzf1vOzozEO4etOsDg
 cClTZh+lhG4ij0AY3Jv6Z9A==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ebd65df6-df13-11ef-99e9-005056ab1411;
	Thu, 30 Jan 2025 15:10:12 +0100 (CET)
Message-ID: <87e41451-ea76-4a7f-8fd6-37b164a4656f@telfort.nl>
Date: Thu, 30 Jan 2025 15:10:12 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] logger: do not show arguments of --socket-errors as
 optional in --help
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250127110825.7219-1-bensberg@telfort.nl>
 <vp3yphm7y73xe4t3clnykrsz3wxvq3mkvmpjybdonz7ypoj3qo@id5gpz6wq4rp>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <vp3yphm7y73xe4t3clnykrsz3wxvq3mkvmpjybdonz7ypoj3qo@id5gpz6wq4rp>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------S4SW0yXprff09a0028KxZYCX"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------S4SW0yXprff09a0028KxZYCX
Content-Type: multipart/mixed; boundary="------------wQNoH0qz45xjfCDPUiQN1eMp";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <87e41451-ea76-4a7f-8fd6-37b164a4656f@telfort.nl>
Subject: Re: [PATCH] logger: do not show arguments of --socket-errors as
 optional in --help
References: <20250127110825.7219-1-bensberg@telfort.nl>
 <vp3yphm7y73xe4t3clnykrsz3wxvq3mkvmpjybdonz7ypoj3qo@id5gpz6wq4rp>
In-Reply-To: <vp3yphm7y73xe4t3clnykrsz3wxvq3mkvmpjybdonz7ypoj3qo@id5gpz6wq4rp>

--------------wQNoH0qz45xjfCDPUiQN1eMp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOS0wMS0yMDI1IG9tIDEzOjMyIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBPbiBNb24s
IEphbiAyNywgMjAyNSBhdCAxMjowODoyNVBNIEdNVCwgQmVubm8gU2NodWxlbmJlcmcgd3Jv
dGU6DQo+PiAtCWZwdXRzKF8oIiAgICAgLS1zb2NrZXQtZXJyb3JzWz08b258b2ZmfGF1dG8+
XVxuIg0KPj4gKwlmcHV0cyhfKCIgICAgIC0tc29ja2V0LWVycm9ycyBvbnxvZmZ8YXV0b1xu
Ig0KPj4gICAJCSIgICAgICAgICAgICAgICAgICAgICAgICAgIHByaW50IGNvbm5lY3Rpb24g
ZXJyb3JzIHdoZW4gdXNpbmcgVW5peCBzb2NrZXRzXG4iKSwgb3V0KTsNCj4gDQo+IEkgZG9u
J3QgaGF2ZSBhIHN0cm9uZyBvcGluaW9uIGFib3V0IGl0LCBidXQgaW4gb3RoZXIgcGxhY2Vz
IHdlIHNlZQ0KPiBzb21ldGhpbmcgbGlrZToNCj4gDQo+ICAgICAtLXNvY2tldC1lcnJvcnMg
PG1vZGU+ICAgcHJpbnQgY29ubmVjdGlvbiBlcnJvcnMgd2hlbiB1c2luZyBVbml4IHNvY2tl
dHMgKG9uLCBvZmYgb3IgYXV0bykNCg0KV2hlbiB0aGVyZSBhcmUganVzdCBhIGZldyBwb3Nz
aWJsZSBhcmd1bWVudCB2YWx1ZXMsIEkgcHJlZmVyIHRvIGxpc3QNCnRoZW0gZGlyZWN0bHkg
YWZ0ZXIgdGhlIG9wdGlvbiAtLSBpdCBzYXZlcyBoYXZpbmcgdG8gaW50ZXJwcmV0IHdvcmRz
DQpsaWtlICJtb2RlIiwgYW5kIHRoZW4gbG9va2luZyBmb3IgdGhlIHBvc3NpYmxlIHZhbHVl
cyBmdXJ0aGVyIGRvd24uDQpJdCBhbHNvIG1ha2VzIGl0IGEgbGl0dGxlIGxlc3MgbGlrZWx5
IHRoYXQgdHJhbnNsYXRvcnMgbWlzdGFrZW5seQ0KdHJhbnNsYXRlIHRoZXNlIHZhbHVlcy4N
Cg0KDQpCZW5ubw0KDQo=

--------------wQNoH0qz45xjfCDPUiQN1eMp--

--------------S4SW0yXprff09a0028KxZYCX
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmebiEQFAwAAAAAACgkQUUu+Lrjhlh89
yRAAyLBl86j9pSBi0kU6lt9p3RCNnYQoEYPkWMP80M1R85L2jRM3kfyWXqLZTCg+AlzvZJCn8fFP
Hy+dQbFlW13w/jxogoW4jQq+1B3r+RNoJnltIoxjzSiN70zNcPYMrB30hlB0pDdy01Y5nzLFtjuA
jg1SjyiOCIJYN7q3Guz0cZp9kKpyDPnjhXo3lmxzmj9ounrNV6joHSwytVzKrF7AwByGYOgSRhyg
gcMDZaKQCgp6DrSDZ/wBOeYxKI7PoS4zR6XfcQiS0RK4vP6D8tdEvI4gLVY0+7aq7pxBfbS67Nc7
zu6Sy5s4y5CGOBJH7LABZ5JlaLPl/WuRZ6rveXHUr6h/ZZtj9bkOGbhBbl10/MM5xIflMYZ1X8qC
qHAWnJY3M/v5V69b9I42Q/efNjJzvGclo6bLVluXJd/M/2hbvlySSpnqBSbKkboC2uUN6H2oYIMj
5B+0ezviIK01iJaPTvqVMICSkiW37w3ghPqTKbr1om2MEaQohxpGdpDaM4YGUSgFdv5zSI2Fi6id
0NvGGYMZhq64rDu3umZyKCWIrnKeliV2BzumQa1vnNLdezgMo0PNgWpLEkLfOrMZCkvqwHcEqnXs
4k7bfiQbSs2wR9JU86rEepLihKoQdvnttGHREAc8F9yKp97kbGYXfgr/clHwZ4SDZKgswEa9oZtW
KNU=
=0AeJ
-----END PGP SIGNATURE-----

--------------S4SW0yXprff09a0028KxZYCX--
