Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA72E542C
	for <util-linux@vger.kernel.org>; Sun,  1 Mar 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772364360; cv=none; b=VWRYd9OcSXdoeajcEikMRBIpFrVhH3oNk0Eo2kuk/cqQdYsU4TtA0U7BonCnNly5A5LWJAkfaA9DZ+YouIXHLwRJakjIlkDyligZi0pESMlyS5xGIkSxA+sURuBBB/HsLmD6isUQlLfLE93adOfsZwBLM6KsBNFKLiS8ezG+mfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772364360; c=relaxed/simple;
	bh=1Uyecel0WN0A48T5L8dGNogi0lzneTmDq0Is1v9LZlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf9UM0YXwN4u2ndw12jVq7XttFI+5cejNyEIwm3/4h0/CJht2c6Ub7kopTTUt1ceQyDPXkDtQ6XKtx+gtCgw+FesVZbDnTf9ePjMPThD9eVViDWg3/ZvfWOVoKuFsJo1XN8tfYUMyIdyKqp/znuT/QratqqiqCvlMjSSagTtQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=m15ish3r; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="m15ish3r"
X-KPN-MessageId: 662ae5f7-1561-11f1-92a2-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 662ae5f7-1561-11f1-92a2-005056aba152;
	Sun, 01 Mar 2026 12:25:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=1Uyecel0WN0A48T5L8dGNogi0lzneTmDq0Is1v9LZlc=;
	b=m15ish3rLW9HO61wNNJvjPPpFYmpvCOwNy/f9+nFzY0vVhEPhM44h9C6rzTtXyqjm1kAhG5v2jNWZ
	 HKWxA31eL9dQjed7w2pEbAdNftWHwsxodacPeOySd8CqLr5dSA1exzei/u+xvii8Ozpowk3gAgQUZc
	 S4St8dNwRB+VufKU=
X-KPN-MID: 33|VIExWTriRvku47ZaEa+OA0y/49OkP6MBgJrYuLcRUFGw3iSO1bfIHVLniNz560e
 VBiBVz0ro3sDsEqfGJmg1GnKlJaF4L466ogW0V5LPAHk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|yTbSeH2oTY/QUBTiv2jLg13zgT1E252Kn2wfTdwcw6VR1u0XRb7VjvP8eh2Yieu
 mBQaEW1+9AEMW9kBCYUjPdg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 65f2d067-1561-11f1-b8e2-005056ab7584;
	Sun, 01 Mar 2026 12:25:49 +0100 (CET)
Message-ID: <1922449f-ac4f-4362-92ed-0176243e11ac@telfort.nl>
Date: Sun, 1 Mar 2026 12:25:48 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] findfs: (man) improve the markup, the layout, and the
 wording
To: util-linux@vger.kernel.org
Cc: Nuno Silva <nunojsilva@ist.utl.pt>
References: <20260228115245.9553-1-bensberg@telfort.nl>
 <10nup2p$o2$1@ciao.gmane.io>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <10nup2p$o2$1@ciao.gmane.io>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UDjXqX6XGD6ACiAJLSGMU3k9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UDjXqX6XGD6ACiAJLSGMU3k9
Content-Type: multipart/mixed; boundary="------------gqGz0fOcvXfTPhIYrwkwfMvv";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: Nuno Silva <nunojsilva@ist.utl.pt>
Message-ID: <1922449f-ac4f-4362-92ed-0176243e11ac@telfort.nl>
Subject: Re: [PATCH] findfs: (man) improve the markup, the layout, and the
 wording
References: <20260228115245.9553-1-bensberg@telfort.nl>
 <10nup2p$o2$1@ciao.gmane.io>
In-Reply-To: <10nup2p$o2$1@ciao.gmane.io>

--------------gqGz0fOcvXfTPhIYrwkwfMvv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyOC0wMi0yMDI2IG9tIDE0OjAzIHNjaHJlZWYgTnVubyBTaWx2YToNCj4gT24gMjAy
Ni0wMi0yOCwgQmVubm8gU2NodWxlbmJlcmcgd3JvdGU6DQo+PiBEcm9wIHRoZSBhbmdsZSBi
cmFja2V0cyBhcm91bmQgcGxhY2Vob2xkZXJzIC0tIHRob3NlIGFyZSB1c2VkDQo+PiBpbiAt
LWhlbHAgb3V0cHV0LCBidXQgaW4gbWFuIHBhZ2VzIGl0IGlzIGp1c3QgaXRhbGljcy4NCj4g
DQo+IE15IGFwb2xvZ2llcyBpZiBJJ20gbWlzc2luZyBzb21lIGNvbnZlbnRpb24gZnJvbSB1
dGlsLWxpbnV4IGl0c2VsZiwNCg0KSGF2ZSBhIGxvb2sgYXQgc29tZSBvdGhlciB1dGlsLWxp
bnV4IG1hbiBwYWdlcy4gIFRoZXkgYWxsIHVzZSBqdXN0DQppdGFsaWNzIGZvciBwbGFjZWhv
bGRlcnMgKG5vcm1hbGx5IGRpc3BsYXllZCBhcyB1bmRlcmxpbmUpLg0KDQo+IGZyb20gYSBx
dWljayBjaGVjaywgaXQgbG9va3MgdG8gbWUgdGhhdCBpdGFsaWNzIGlzIHVzZWQgZm9yIHN1
Y2gNCj4gcGxhY2Vob2xkZXJzIGluIElFRUUgMTAwMy4xLg0KDQpBbmQgaXRhbGljcyBpcyBl
eGFjdGx5IHdoYXQgdGhpcyBwYXRjaCB1c2VzIGZvciBwbGFjZWhvbGRlcnMuICAoTm90DQph
bmdsZSBicmFja2V0cyAtLSB0aG9zZSBhcmUgZm9yIC0taGVscCB0ZXh0cy4pDQoNCg0KQmVu
bm8NCg0K

--------------gqGz0fOcvXfTPhIYrwkwfMvv--

--------------UDjXqX6XGD6ACiAJLSGMU3k9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmkIj0FAwAAAAAACgkQUUu+Lrjhlh/8
3hAA21Ktd3fJSmkXmYsgFnN/foq1MIT42TlzbrDdpAS1NZp1hBwT/DFAvVaL5ZTx8lbCR5jdjkuN
l7aA4M5MWgutHQvJibBje+v+XpSN6WzWf3TgPbQdyzuixIhhBoxDim3Ge9GJ0o3YOQJlqg3RqmYi
gUEOW3LK0OgJ6NRBN0tUdyG8TySLvRIzNJgWhrAbgxElhQNiR+gvT07okSks3Zk3S45VssE6r0G6
M2fWSw9XtDAkEo1Bm9B3bWQykfP17xhIeuzg3TYnzYvdJnaNDKW+b5eII3AbKx8MvEj6ToWulni8
lKPfkViglTczYO8VRTjfu6I/9cFMbAfKfZpnqS9kcoPv88z05g9PzDeJ1Hd9IH1XrH8V8UMqxRLn
5Wox9Tca92/pnlHTrp/2mcCHERv8TT5AwajaQfzuAg6n5+JLbj0vDzU321vYb2dExXPdwDQlhFXu
m0ZLqyHmNtwedHj6RYJG/CBaOt18+uJigDJOloL3U/G2smdNtsL/tyhTPDXsVE6bGwsrlrnqFMFU
eyZ05DjF7DoO3E+Lf3CPzLEjaMW00OOHd5afFamgfgSpw20ldPaFuMh1w6VU/bKQVMbAizd/Zr4J
UHhbY/qU1O6xjSa2C1xHXeNinX8AWKoaKACiV059vzNZhlDjh+3w6kJkQvpsFeO5yGfUKaQKBBUH
nPg=
=EVIk
-----END PGP SIGNATURE-----

--------------UDjXqX6XGD6ACiAJLSGMU3k9--
