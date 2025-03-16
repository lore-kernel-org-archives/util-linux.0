Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FF2E3368
	for <util-linux@vger.kernel.org>; Sun, 16 Mar 2025 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742140015; cv=none; b=fqncz2awJBt3QYUUCYszCfOUMqxMbOw5wSh/noPCL6SUGbubvqC6XCrfMer5oeFfrLfSjfn5DMg18F1egKRDNwMvjPm0kxxq9eZz/XRoW/CSr4XUmVSr/l6XPkVkFjNXEa+SikUWv6soq7zaOhnw5YIG91+JhrrCRg+cWqxXZ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742140015; c=relaxed/simple;
	bh=+c7J8eBpkZZ/BeI12XMn1TM7uNNXEiHF14hdlomu2pA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=sLnFqJaskUxXgvxYqKPs4Rut4qmMejNN4DGLKgDJwkyVnnfLSrYuJ2Hhzy1h0qaeZpkBZiNNbeGRgL3rhuvI7H8ERDkesf7wHZYwPVV3j1daB16Z7DknwQVlQIqX3jkf+bdwKrl+pIGVLFBfLu+VAWMAfSgEVTRhDhkSUd9+LZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=lzh63S4j; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="lzh63S4j"
X-KPN-MessageId: c1d9d020-027d-11f0-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c1d9d020-027d-11f0-b99f-005056abbe64;
	Sun, 16 Mar 2025 16:45:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=+c7J8eBpkZZ/BeI12XMn1TM7uNNXEiHF14hdlomu2pA=;
	b=lzh63S4jWgJD1EVbnRtrUWvnPSCnfYKh7LzBmxLk/DOWm1Y0y+pds4/PoHBfd4oc2oFu5w3fSacdE
	 SbeIWUJIW4B55rkhklYczhVEiJBhOpNlsHE6fTH4LhcfQwKhKwMp0XV2bbCluW2Atdt1FRDZfxspwA
	 MZIWw3eohipt3xpY=
X-KPN-MID: 33|sZ0CadKTzuw8WD1eOLnGJxNLCmnZyA6CTE9y/YCvQ5SQYMzrrUgf2atUoU1ksSN
 B6FMpmzB3JdnCzvrSB/Oii1a7umn33noiHqcMMe3qRoc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|qduSzXCeBw7AG5X3H+p6Irot0LcXoxAAMaVbj4ZZ/mZXfGtdv4bjJB2ogt7/60W
 c5cW4FJF1bO5LCHG3hEpgyA==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b840f947-027d-11f0-9b2a-005056ab1411;
	Sun, 16 Mar 2025 16:45:43 +0100 (CET)
Message-ID: <b354fc17-f706-4a56-a271-592cd44a7b5d@telfort.nl>
Date: Sun, 16 Mar 2025 16:45:42 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: bug in `more -c` when using . to repeat <enter>
Content-Language: en-US, nl-NL, es-ES
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
To: util-linux@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Q2f4tfRtE0UQGpxr08cc0nto"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Q2f4tfRtE0UQGpxr08cc0nto
Content-Type: multipart/mixed; boundary="------------RNG7N2z0wtCC2hXR7WOWnqL5";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <b354fc17-f706-4a56-a271-592cd44a7b5d@telfort.nl>
Subject: bug in `more -c` when using . to repeat <enter>

--------------RNG7N2z0wtCC2hXR7WOWnqL5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpUbyByZXByb2R1Y2UsIHJ1biBgLi9tb3JlIC1jIFJFQURNRWAuICBUeXBlIDxlbnRlcj4g
YSBmZXcgdGltZXMsDQphbmQgc2VlIHRoYXQgZm9yIGVhY2ggPGVudGVyPiB0aGUgc2NyZWVu
IHNjcm9sbHMgb25lIGxpbmUgdG8gc2hvdw0KYW5vdGhlciBsaW5lIG9mIHRoZSBSRUFETUUu
ICAoRXhjZXB0IHdoZW4gdGhlcmUgaXMgYSBibGFuayBsaW5lOg0KdGhlbiBpdCBzY3JvbGxz
IHR3byBsaW5lcyBhbmQgc2hvd3MgdHdvIGJsYW5rIGxpbmVzIC0tIHRoYXQgaXMNCnByb2Jh
Ymx5IGEgc2VwYXJhdGUgYnVnLikNCg0KTm93IHR5cGUgLiBpbnN0ZWFkLCB3aGljaCBzaG91
bGQgcmVwZWF0IHRoZSBsYXN0IGNvbW1hbmQsIGluIHRoaXMNCmNhc2UgPGVudGVyPi4gIFNl
ZSBob3cgdGhlIHNjcmVlbiBpcyBjbGVhcmVkIGFuZCBqdXN0IG9uZSBsaW5lIG9mDQp0aGUg
UkVBRE1FIGlzIHNob3duLiAgS2VlcCB0eXBpbmcgLiBhbmQgc2VlIHRoYXQgZWFjaCB0aW1l
IGp1c3QNCm9uZSBsaW5lIGlzIGRpc3BsYXllZC4gIFR5cGluZyAuIGhlcmUgYmVoYXZlcyBh
cyBpZiB0aGUgdXNlciBoYWQNCnR5cGVkIDEgPGVudGVyPiwgbm90IGp1c3QgPGVudGVyPi4N
Cg0KQnVnIHdhcyBmb3VuZCB3aGlsZSB1c2luZyBgLi9wYWdlIFJFQURNRWAgYWZ0ZXIgYGxu
IC1zIG1vcmUgcGFnZWAuDQpCdXQgYC4vcGFnZWAgZG9lcyBub3QgZG8gdGhlIGRvdWJsaW5n
IG9mIGJsYW5rIGxpbmVzLg0KDQpWZXJzaW9uczogMi4zNy4yIGFuZCAyLjQxLXJjMi4NCg0K
DQpCZW5ubw0K

--------------RNG7N2z0wtCC2hXR7WOWnqL5--

--------------Q2f4tfRtE0UQGpxr08cc0nto
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfW8icFAwAAAAAACgkQUUu+Lrjhlh+6
GhAAzx3+AOTK47WKUnN3n0OkOTOyW9xa7a+Ljn/WC5PzHgXZ4MwHkR7t/imKF0LF5lGWMd8g7AFV
HLxyv6B9939Zi2VNaPSMW+C7WAgfBwzwpj2hS81jh5mnU4OVctnVZuGEsUthg9cIyvqkk7PMhhXk
GbWTE8NsTg6UMGKqAAN828CsmPkODXpHoofoQNUv/ltyJIOVQtnIG3z6GpZnIlehP+0+tFf8NYP0
zE4X8BaDln3eE3k3vkAOqdK1MvLo/KVaYbM2tLUg/ob2NN2+5S4w93EEIsEdSrCUmczwKf57K9JK
JU/OUv/PDFLL57u0ZK0qDyGQnYYRKZLr05X6kpIRTwuBVHE3aBv6jRoSkBpbbxldwvTGd1KL28wP
CfQBAnp8g8mqznItb5KaGfKFjM1Uupv4dwR4IMRKhLmYp7Yx/oEeY7xGo5wqpbQrJufsafB4Rrzl
0AjLtgohWZng4L1yH6rChTkDxCNp3sn49j7pyUTGAIntrK/05dm4FAzTI4PbvVpMnavTfQqmLqP+
yxR5l8IQLmJUyLPiodPEQr7SFN62aXm+NZChrKPxvVspMperCnrwxPpLHusCC/5ey50eUBXGhbYy
kl9ZWNDTxgjOh4rsgvHl8WDD6EMjowzYsqsRJPz/M8e8e13bpYaqlB3JAsdww10vGQW5G4XRNJcM
Hf4=
=oLK0
-----END PGP SIGNATURE-----

--------------Q2f4tfRtE0UQGpxr08cc0nto--
