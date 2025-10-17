Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99421B185
	for <util-linux@vger.kernel.org>; Fri, 17 Oct 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691329; cv=none; b=kcV5X7oYdEWZKw5VA+pAt6RLrQnmLDyExnBYxpeWYHeRhHnfPaNMDcVYQFL0bNVuK7D3aZUaOn2EhRhodsqXY05hY99S5YN8WL5F8GwWxTCdKB685t1mHCkK4C7pAEafs8wAtQe4NtD18GIOrADz8wOfnGy6od0vMOAD8pW+egk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691329; c=relaxed/simple;
	bh=CPViOMFmmVe55SHBtXPbS4I2T2CUOWRjcC88HQLYu2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgbefZjb7to9aqoYxR5QuWsrzBJ1OXF2Z+NigXHxm6i5Ep3QOlooCkVFKa71Av3XTnI8uxB0T+e21A6X8reTL92a+z6IuvD76oVhfXALoTk92iLIh47sg7BhhrL3+/jkoqzSqH9o98XUK5zI9SUB3IKThpvdXvhDxIvisXYCgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=AbyXB3X3; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="AbyXB3X3"
X-KPN-MessageId: 0947fc2f-ab37-11f0-84a0-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0947fc2f-ab37-11f0-84a0-005056abad63;
	Fri, 17 Oct 2025 10:55:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=CPViOMFmmVe55SHBtXPbS4I2T2CUOWRjcC88HQLYu2k=;
	b=AbyXB3X3BISYtjYe9Ioft+qBgy0fujRoI7+r0bK18ghDCDIW04Ie4EW2JOFIhbIyqGVDkg4H0kvRw
	 x8iSgEw4a9GxozKjwRCfwSNt5Dq935N56POsJzphA2JwMA2QIkG00H/9aWxAPbO3FuR3S1rN3fs1qQ
	 Hy0UcFrntr1BFMl8=
X-KPN-MID: 33|NMFACMV5Msat8IEknm18JreTMAuTHI/4wgblrUmR0OzcwijVAVAldLm/y7viSeb
 m1HFPzWRDl6uRUXeoifms0SOht0v0hyeicL/at9Ird68=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|m6jTsVwq9b0gVwnNEI5+bBhZ39zui7HwVU/K27wSzE4jOoNV0G3KP42NJQOqKL5
 S6gCn5SCZywY19rgOmzBqUg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 01600e8d-ab37-11f0-8003-005056ab7447;
	Fri, 17 Oct 2025 10:55:18 +0200 (CEST)
Message-ID: <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
Date: Fri, 17 Oct 2025 10:55:17 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 wguanghao <wuguanghao3@huawei.com>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------iK1mt0s6bXNtNpozGH4hKwHZ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------iK1mt0s6bXNtNpozGH4hKwHZ
Content-Type: multipart/mixed; boundary="------------YK8RkGtF01vKxxZaprOEerBc";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 wguanghao <wuguanghao3@huawei.com>
Message-ID: <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
In-Reply-To: <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>

--------------YK8RkGtF01vKxxZaprOEerBc
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxNi0xMC0yMDI1IG9tIDEyOjI4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vdXRpbC1saW51eC91dGlsLWxpbnV4L3B1bGwvMzgwMw0KDQpNaXN1c2lu
ZyB0aGUgdG9vbCBub3cgZ2l2ZXMgYSBzdXJwcmlzaW5nIGEgcmVzdWx0Og0KDQogICAjIC4v
bG9zZXR1cCAtLXJlbW92ZSAtLWRldGFjaA0KICAgbG9zZXR1cDogL2Rldi8tLWRldGFjaDog
cmVtb3ZlIGZhaWxlZDogU3VjY2Vzcw0KDQogICAjIC4vbG9zZXR1cCAtLXJlbW92ZSAtLWRl
dGFjaCBsb29wMA0KICAgbG9zZXR1cDogL2Rldi8tLWRldGFjaDogcmVtb3ZlIGZhaWxlZDog
U3VjY2Vzcw0KICAgbG9zZXR1cDogL2Rldi9sb29wMDogcmVtb3ZlIGZhaWxlZDogRGV2aWNl
IG9yIHJlc291cmNlIGJ1c3kNCg0KSWRlYWxseSwgYGxvc2V0dXBgIHdvdWxkIGZpcnN0IGlu
dGVycHJldCBhbGwgb3B0aW9ucywgYW5kIGNvbXBsYWluDQp0aGF0IC0tcmVtb3ZlIGFuZCAt
LWRldGFjaCBjYW5ub3QgYmUgY29tYmluZWQuICAoVGhlIGNvZGUgZm9yIHRoYXQNCnNlZW1z
IHRvIGJlIHRoZXJlLCBidXQgaXQgZG9lc24ndCBhcHBlYXIgdG8gaGF2ZSBhbnkgZWZmZWN0
LikNCg0KQnV0IGF0IGxlYXN0IGl0IHNob3VsZG4ndCBwcmludCAiU3VjY2VzcyIgd2hlbiBz
b21ldGhpbmcgZmFpbGVkLg0KDQoNCkJlbm5vDQoNCg==

--------------YK8RkGtF01vKxxZaprOEerBc--

--------------iK1mt0s6bXNtNpozGH4hKwHZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjyBHYFAwAAAAAACgkQUUu+Lrjhlh/+
hBAArv7jSwYyVd8luU4HkZsdnVbDrlJ+5H1ZqMGGihz/k8XdSq6avQUDBrlZvVBssAsc1xxKOjoX
lnr9CpIdXW5HQkcmiKIrgu9lCCExAiFHk0lCdPt/UbA+N5sgXkdKMUlDBAlDCeXPMypaJeru3Xn8
3ok/SnViQW8gl7qiU9ahm/oeVThL7KxPNOB9ZINC091doAh7jMEoq2bLxpagjYVae14odJH4DD2H
N9MOtqWC6jNzCHMJOrMZtXY6mHS6Zn7DN6QRinkRpZQu06e2Cgk/bglaOxZZ/I+Ax2sRjlcUZFCj
bzFOw+EtMsgQncne5zlpt/IjsykNuZ2uL6KygcZuh8h/6OHEjreKhC1Dl+PplGFf4lZdOumWLI+X
41aXiho80F/LiOSM4nWI1XDkcOQiIngYoGyScKXUP+gcYGgpI1GxlQBC+zVldQWMQGw3KU4RbBr/
tTy80lC2qUF+pWLoZZI4RDqatw1L74UTum8JbDAOwMa0JykEPxeEx08U6lVCw1cJkWf3ebg3mqfm
kXSN2VaQ7Z6F+8UVGW3rJh2+U7A5+EHqOnipFUrIbL96TY1Vtp4gbg2dqB/AcOtoUWz298gYXL3t
LBPfQkq/qbcZdWK3ds07j6kx0Q6yjKFMSikRvmDFSi0Cy5NP4dSr4C2mqmWznyho79q/sL8Wpqg0
bFA=
=zKqG
-----END PGP SIGNATURE-----

--------------iK1mt0s6bXNtNpozGH4hKwHZ--
