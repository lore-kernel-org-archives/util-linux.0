Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA947E0E9
	for <util-linux@vger.kernel.org>; Mon, 29 Apr 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402774; cv=none; b=m7AZpvGMGHZEdPkZgaV3W6yqCpC0lPAjsFB5aCIKYp2EBLQwlhowyuOukrBF64XVgLlLGbDrRhbF0MX5fwbriYOndhmXwKdMoZA7Ue4teVOVmn4AKFMepkgwSswcFEuV7CL+l1PyFrCx4fpVp5s5Hml1e6tQljhxKsodKVScS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402774; c=relaxed/simple;
	bh=XD3RvrHpopBOxbH9NAfxHZLsZBbxAp3PO/EWQAsPDS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uobewvnBJMHBqGDtwfwRN5PCvFHDlZ0T0NQimryv2YiaRRKvmATH5My0jK8MJiSmtj9+Hv/NgAN7G4izcIQ8b/ExjZtnLFbGJ94M91YobY//cycZdOWDYa9C9Cb6/4AmAKiJq6Gq7HSY3BFF4t8pv9qpq5uoRQNty3crX830y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=O1W8Y6yL; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="O1W8Y6yL"
X-KPN-MessageId: 07ea820b-0639-11ef-b9a0-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 07ea820b-0639-11ef-b9a0-005056ab378f;
	Mon, 29 Apr 2024 16:59:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=XD3RvrHpopBOxbH9NAfxHZLsZBbxAp3PO/EWQAsPDS4=;
	b=O1W8Y6yL9fjtgoWoDQpBZgVJvYR9eeAhZChhr0pkGMufSn7Kt746vc7h2MTGNHM32/GNd+U3D8AS+
	 vIhRdlxHTDc3LzN0p0yag6g4ul8gelWP4EueYRCKaA46zM4IJZb7GI0KUBjPt7zqvoITph6O95JqkD
	 +cS5Ker7HrWcvvm4=
X-KPN-MID: 33|w51EduWdF1oT20gMFuAt+50Mh7HI1joubnWRepEC9d+YQdT2p0JPr5TXqeV7sfG
 NLmecMevQsjw8XBIfzGDpPRm9bm+LSkc3jCsbvpHJcGc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fPnD1xqxG/aoOvYL9IyZfs5LaEAmE+a0MWhbMjD6oxKPE6krzMPyJize7/Q3auH
 r3tzUySvOer9GUF4h1kNbeg==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 0fd89eb3-0639-11ef-8d64-005056ab7447;
	Mon, 29 Apr 2024 16:59:22 +0200 (CEST)
Message-ID: <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
Date: Mon, 29 Apr 2024 16:58:35 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cCInL6aRTsX1mITZlUgpt5XV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cCInL6aRTsX1mITZlUgpt5XV
Content-Type: multipart/mixed; boundary="------------89tFfE7w7HPTpSj5nz6exs71";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Petr Pisar <petr.pisar@atlas.cz>
Message-ID: <4582ffa0-e5fb-42ca-9b4f-a6a0bc67bed2@telfort.nl>
Subject: Re: [PATCH 1/2] textual: fix some typos and inconsistencies in usage
 and error messages
References: <20240429123542.zbiieh6dpux6xoza@ws.net.home>
In-Reply-To: <20240429123542.zbiieh6dpux6xoza@ws.net.home>

--------------89tFfE7w7HPTpSj5nz6exs71
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOS0wNC0yMDI0IG9tIDE0OjM1IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiAgIEFwcGxp
ZWQgKHRvIG1hc3RlciBhbmQgc3RhYmxlL3YyLjQwKSwgdGhhbmtzIQ0KDQpIbW0uLi4gIEkg
ZG9uJ3QgdGhpbmsgaXQncyBhIGdvb2QgaWRlYSB0byBhcHBseSBpdCB0byB0aGUgc3RhYmxl
L3YyLjQwDQpicmFuY2gsIGFzIGl0IGludmFsaWRhdGVzIGFueSB0cmFuc2xhdGlvbnMgdGhh
dCB3ZXJlIG1hZGUgZm9yIHRoZXNlDQpzdHJpbmdzLiAgSXQgd291bGQgYmUgb2theSBpZiB5
b3UgZmlyc3Qgb2ZmZXIgYSBuZXcgUE9UIGZpbGUgdG8gdGhlDQpUUCBiZWZvcmUgbWFraW5n
IHRoZSBuZXh0IHN0YWJsZSBkb3QgcmVsZWFzZS4NCg0KDQpCZW5ubw0KDQo=

--------------89tFfE7w7HPTpSj5nz6exs71--

--------------cCInL6aRTsX1mITZlUgpt5XV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmYvtZwFAwAAAAAACgkQUUu+Lrjhlh80
ChAAzw8zHpAu7vYR2y/2b+6nI8XROdZPOfo1iUze0HI8mbO3+3zDNXU46oa0vvU/9gsZviwXGARv
/AyrpwzARt7OBvqM8agGTArLZKpM7xG/JFj2D0NUC+J+fk2rbqz93zvDfGPXKXR9fjVTiD3Xvm9m
B+cZxe2gSUBkc4SB6XpmGBa+4IVTD+NP36juidThdhF8ZH8ebA3fXzc4b/GNGvCsjMCRtve1Tunm
bJVcu+tEMOfQOEfHd7bHLcfCYhpbXIRvQ9DZsnYaXbWmsinetFcG8c2SJLs+bAcrPJrlvlPQqXQU
vqbW3AbGbj6h6oU0h5a2o40Rpe0GhceATf5dOjtJ5jhe8HuSrDC6licDsQLfOdESqyFnP8XUVi2h
Uw9KZEXRR8VpHEfrIqVVGrMjwVHP5DXEsfzrYN2ebby0Q+ojZqb1nIZnV9vBXSVqhI1qbQ5i3Wg7
Ni/KMy/VwCCI6h79kBcgSl12zuQTJbi9qhttSMSsAfRliGTrOfjWF0LshVHKfSTgiu1ZnuSc/pGK
1PJo+YEvkk7gCYcqs8kVLmxj80EQtVSUvEoYDn7OVZNZEzniT4gBEwypyIfz6qy+sHiLmNmL76iP
j3nE/06VelOwT/D6ATCtiR776Z/99N8AH4rd03NSnbc+WZVDz7VJWR6yyGDhMa4eCTKYUweH/KV3
+Iw=
=fElD
-----END PGP SIGNATURE-----

--------------cCInL6aRTsX1mITZlUgpt5XV--
