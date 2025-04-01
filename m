Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E791EE008
	for <util-linux@vger.kernel.org>; Tue,  1 Apr 2025 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499074; cv=none; b=mFPfJLH71B7k06pie973Mdipz9Ui0jT7KLFiPtjLZypz8GzcmMiOaDYvtriTBBL86h3E4IIjmbaH5JCuE8n/xfxpLo/DCHDLhpG2SZGd78KMfEebn8tauSNPkyOlvx6rxR0wlLM4BMG0fCDu2vBbLN6/9OSyoyBQkTfUIy66rbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499074; c=relaxed/simple;
	bh=oHO+qVbDeQwQreZt9Yb8GicSaweT6rwgYHPLRQUHBsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LhR4GU7sqtqm8+oIOh93BttSHEKyE5nnIvAaWa8qeOoZOHNpQeTZuPvGJKD4NNwHLdmYvYXXnmZQAR7Y5LAG9JgaXz0NstrOA7NCG1HYpRJl9T74ekhTkvatMwERfEVlOZVqcndkr1q4nI7bL5fyQEh7vHTEm5XtqEBba/RpDV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Z2g+giQy; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Z2g+giQy"
X-KPN-MessageId: 412e08c9-0eda-11f0-bc28-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 412e08c9-0eda-11f0-bc28-005056ab378f;
	Tue, 01 Apr 2025 11:18:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=oHO+qVbDeQwQreZt9Yb8GicSaweT6rwgYHPLRQUHBsU=;
	b=Z2g+giQyg2yjDejxz82bZjNqFVLVjGlj1X/v0X7AdqI03WsWtPaE5gbtu9xm1prHqbDXqj0Wlx8tX
	 EhwXYBpEy5gtW7BbvU5u+9mb/CbmtE4+do9A6caNU2cHhQs1h85MgVTKzyYI7KTBSoflxhHHmlNpwj
	 g2rhOgMkKofknvVM=
X-KPN-MID: 33|j+zI//Y94VxZz3u+T6dMsfHz61FkH6CjDYcjx7CEIPcXG8Mt8ZRifO9Bh3X5JWI
 sIm5i7lTCn+G6KmA5QWYW6w==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|NFzvuO+0DY2puCF3flplgGm6nnfMqBPteAfyl049X96ITDXQSW1toxoLxUcVxuP
 mLQVeeZff0CagqIMY60wtkw==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2db298b2-0eda-11f0-8518-005056ab7584;
	Tue, 01 Apr 2025 11:17:48 +0200 (CEST)
Message-ID: <3b638c6f-e304-4771-b952-3f7172779966@telfort.nl>
Date: Tue, 1 Apr 2025 11:17:47 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
To: Joe Jin <joe.jin@oracle.com>, util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
 <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
 <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
 <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zjae4PB4vzCRTIKBQ30cTDpf"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zjae4PB4vzCRTIKBQ30cTDpf
Content-Type: multipart/mixed; boundary="------------5DnvZClVxyxGJtfY60E10VXz";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Joe Jin <joe.jin@oracle.com>, util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Message-ID: <3b638c6f-e304-4771-b952-3f7172779966@telfort.nl>
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
 <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
 <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
 <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>
In-Reply-To: <e45f45de-62f4-4263-ab71-828780e878bd@oracle.com>

--------------5DnvZClVxyxGJtfY60E10VXz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAzMS0wMy0yMDI1IG9tIDE4OjEyIHNjaHJlZWYgSm9lIEppbjoNCj4+PiBXaHkgcmVt
b3ZlIHRoZSAiUSI/DQo+Pg0KPj4gSXQgbG9va3MgdWdseS7CoCBBbmQgd2h5IHdvdWxkIHRo
ZSB1c2VyIHdhbnQgdG8gaG9sZCBTaGlmdCBiZWZvcmUgcHJlc3NpbmcgcSwNCj4+IHdoZW4g
anVzdCBwcmVzc2luZyBxIHdpbGwgZG8/wqAgSG9sZGluZyBTaGlmdCBoYXMgbm8gZXh0cmEg
ZWZmZWN0Lg0KPiANCj4gVGhlbiBzaG91bGQgaXQgYmUgcmVtb3ZlZCBmcm9tIHBhcnNlX2lu
cHV0KCkgYXMgd2VsbD8NCg0KTm8sIHRoZXJlIGl0IHNob3VsZCBzdGF5LCB0byBhY2NvbW1v
ZGF0ZSB1c2VycyB0aGF0IGZvciBzb21lIHJlYXNvbg0KaGF2ZSBDYXBzTG9jayBlbmdhZ2Vk
Lg0KDQpJIHdvdWxkIHByb3Bvc2UgdGhlIG9wcG9zaXRlIGNoYW5nZTogdG8gYWNjZXB0IGFs
c28gdGhlIHVwcGVyY2FzZSBJLA0KVCwgRCwgYW5kIE4gZm9yIHNvcnRpbmcgdGhlIHRhYmxl
IG9uIHRoZSBjb3JyZXNwb25kaW5nIGNvbHVtbi4NCg0KDQpCZW5ubw0KDQo=

--------------5DnvZClVxyxGJtfY60E10VXz--

--------------zjae4PB4vzCRTIKBQ30cTDpf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfrrzsFAwAAAAAACgkQUUu+Lrjhlh/Q
mxAAjVrhEsJcM9KfnkDa316M49g2nUUSk/a1p4ZbNcIUN74ll9N3P9a52s8KZCdP1GroJm6eKKmP
9BJ2FXeK+ZhU+BtAIBi8SceukgXHE/GJ3rXzD2euLN4N79DiFKavgyNR8jVJc75HNfuvKJ/W+EBu
P56bdiIG3DPVdFkRWq5fmMRirzH31a6tGoAabOzdR4bQUEvJcFOCam2+i/WCM6MiLQqbWVOk2b+z
0u8fZwmGR4sPO4IAXWiaUcZtBnOicAsTZY6UPtZBIhV8sjZ42c+jRpbzlpIi0f77Q+EgyiMAdkFO
QLA+6RN7EJ4RigEpNkt9vx+otY92Phzj3dxyPmNroMElb6iv5NfzuSoKtAKpg8yHUOcihI678zSf
CSkmkXQKDYI9jN96CBO8hU+nA7eSlyh7G8yuVSXwSA4SYpsaf2y5FB8Hprj98J8invdhybb1f+ck
6TPPwf9Y1nyytGgYwSgEFg/5V2EIkhhZ+MHjQSVo37Jzu6d5hD4vVZ5CWunpq5MrWXHBLKOZV1ks
/iRbk5Zqps6LVVL6c7EJyF4/aWbCfzZ6FNyUA2wp7x06ryyyzJVb0Zqt85ptazbhjmSTl3OR5UVg
riTin7vguc5vrL77pO+uUGN+hm4Ve3e8uBaUbAveQbTLQshRBuuojqdxPGE1A4QLdQ9T0d0g5UBo
ZPc=
=oXs7
-----END PGP SIGNATURE-----

--------------zjae4PB4vzCRTIKBQ30cTDpf--
