Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4C01D86DC
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436051; cv=none; b=l4u5RoISfGCRgbY7Z3hzcT1z1L/Kyv+3Z5kAGV2bUUY+4Xs4tXeJhiN/YeZ4M+pHRh1NkUmgzRukwMMH/s9ELV2RjV21YeZguSYsGhhhNawnVd4zrhJf6cOlBNiaoArv3U/IECIVTpq5N/+7GyejPSGVz5uJ1y8iBlGPJH9L7B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436051; c=relaxed/simple;
	bh=H26gFAR+ckq2Y2IrLxIkeLHjJtZtB62J7/UaqZOj1SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgdD8Xvw53/hl3LZi0MLNCkPtqAN+0tNv75lnina9cOXia/szfTo/tcpKgyH1Qvi3x2vsJlAsFDSJTay77Ws+8y4a5gr7+AJOlP1QUhc0GoxOKLb0hi1X3xDGj9fL/sRBX1f6d0sDhKUb/fonkM3DYnNECLzwoFAM4XOYM53mMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=CyWA+tOW; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="CyWA+tOW"
X-KPN-MessageId: 819e2941-0e47-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 819e2941-0e47-11f0-86cb-005056aba152;
	Mon, 31 Mar 2025 17:47:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=H26gFAR+ckq2Y2IrLxIkeLHjJtZtB62J7/UaqZOj1SU=;
	b=CyWA+tOWnwhvnHRU3q6ntuhath67KCAUEUqnjkR3CFQzTfTi0XLIpjifRs9DXCo/H5QC0rJw4Lks2
	 VjTpowAVTKnCeWp+iShFfZdRCRzAQ2HfWCeYbbaJs3PUZy/nlOlH/3w1XLyov0phiEP7Wfhccz40s0
	 YN4hcSTSEE5rY6ZI=
X-KPN-MID: 33|nv1VHDUpXsvyhAEzrHKmTY76asTkFM7/VDAYYi2lfeWP8JSQuA/VExDPJJlpiow
 ZJ4/YSqlSQM6+m9pKDxUmNYAWHxkw8QtLp0XCRh3Pqqk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zEm/SdSK4orCG0duzI1aMA3YMsvFEbmGFok4vGT0Weu4QFM7hhZ43iPMYYPr8OY
 mo6GKu9YBd21fTOEYS63T1A==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 6fa5fdcd-0e47-11f0-9b4a-005056ab1411;
	Mon, 31 Mar 2025 17:47:22 +0200 (CEST)
Message-ID: <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
Date: Mon, 31 Mar 2025 17:47:22 +0200
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
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C0XBBP0v07m5TeJTP7nQmIWc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C0XBBP0v07m5TeJTP7nQmIWc
Content-Type: multipart/mixed; boundary="------------vqNMlmnzNlwAfrz1IXDXvmPo";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Joe Jin <joe.jin@oracle.com>, util-linux@vger.kernel.org
Cc: Zhenwei Pi <pizhenwei@bytedance.com>
Message-ID: <7c31b1e6-1510-4066-a565-2d8343b99b36@telfort.nl>
Subject: Re: [PATCH 05/10] irqtop: improve several more option descriptions,
 and align them all
References: <20250331094443.9619-1-bensberg@telfort.nl>
 <20250331094443.9619-5-bensberg@telfort.nl>
 <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>
In-Reply-To: <a001f0dc-2b73-42bf-ad7c-1271e9727c36@oracle.com>

--------------vqNMlmnzNlwAfrz1IXDXvmPo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAzMS0wMy0yMDI1IG9tIDE3OjAyIHNjaHJlZWYgSm9lIEppbjoNCj4gT24gMy8zMS8y
NSAwMjo0NCwgQmVubm8gU2NodWxlbmJlcmcgd3JvdGU6DQo+PiAgIAlmcHV0cyhfKCJcblRo
ZSBmb2xsb3dpbmcgaW50ZXJhY3RpdmUga2V5IGNvbW1hbmRzIGFyZSB2YWxpZDpcbiIpLCBz
dGRvdXQpOw0KPj4gICAJZnB1dHMoXygiICBpICAgICAgc29ydCBieSBJUlFcbiIpLCBzdGRv
dXQpOw0KPj4gICAJZnB1dHMoXygiICB0ICAgICAgc29ydCBieSBUT1RBTFxuIiksIHN0ZG91
dCk7DQo+PiAgIAlmcHV0cyhfKCIgIGQgICAgICBzb3J0IGJ5IERFTFRBXG4iKSwgc3Rkb3V0
KTsNCj4+ICAgCWZwdXRzKF8oIiAgbiAgICAgIHNvcnQgYnkgTkFNRVxuIiksIHN0ZG91dCk7
DQo+PiAtCWZwdXRzKF8oIiAgcSBRICAgIHF1aXQgcHJvZ3JhbVxuIiksIHN0ZG91dCk7DQo+
PiArCWZwdXRzKF8oIiAgcSAgICAgIHF1aXQgcHJvZ3JhbVxuIiksIHN0ZG91dCk7DQo+IA0K
PiBXaHkgcmVtb3ZlIHRoZSAiUSI/DQoNCkl0IGxvb2tzIHVnbHkuICBBbmQgd2h5IHdvdWxk
IHRoZSB1c2VyIHdhbnQgdG8gaG9sZCBTaGlmdCBiZWZvcmUgcHJlc3NpbmcgcSwNCndoZW4g
anVzdCBwcmVzc2luZyBxIHdpbGwgZG8/ICBIb2xkaW5nIFNoaWZ0IGhhcyBubyBleHRyYSBl
ZmZlY3QuDQoNCklmIHRoZSB1c2VyIGhhcyBDYXBzTG9jayBhY3RpdmF0ZWQsIHRoZXkgd2ls
bCBzaW1wbHkgcHJlc3MgdGhlIHEga2V5LCBhbmQNCmV4cGVjdCBpdCB0byB3b3JrIC0tIGFu
ZCBpdCB3aWxsIHdvcmssIGxpa2UgdGhleSBrbm93IGZyb20gb3RoZXIgdG9vbHMuDQpObyBu
ZWVkIHRvIGV4cGxpY2l0bHkgbWVudGlvbiB0aGlzLCBiZWNhdXNlIGl0IG1ha2VzIGl0IHNl
ZW0gYXMgaWYgaXQgaXMNCnNvbWV0aGluZyBzcGVjaWFsLg0KDQoNCkJlbm5vDQoNCg==

--------------vqNMlmnzNlwAfrz1IXDXvmPo--

--------------C0XBBP0v07m5TeJTP7nQmIWc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfquQoFAwAAAAAACgkQUUu+Lrjhlh9y
ZBAA7Zpmx57s1vEATSXlYDvj1vm2B2HSztlvRytO7t073sLj6X/gtXmZpMz7s1E/br6BNSqA1woe
O1fqmRKxE/I1tRJ2M25b3WDfS9KakGrrNa5YiNAE3F+JeYgG4RLQ0cSpUE7GdeAe+9xRq8TBLKbK
9/kxxJ2sIhWIbB7+iGxv6USsceK05uUg+WI5xxdB0gHjvgFighD+/OGgPtWNFqE30arkJkB2BoRv
dk8os+oIpS0tiTGpTZtr931LZzHRtbA1Bkdm9nLEq9tdVcGV+bNW+ldNpqIxkmUTeDDMy4BI3lL4
FD6ed2HjVy7DspD3k72HT9W06mLEXKEkaPG9eQ6sUH9Q3i0GkYoj9KWtnHl310zdRPO1xJKJIPuK
nC+9HmjtNbCGszka3/z6L6+QrGoiTzAD8u7aOuIVU8e9Al98z0nFDxYzqeOboQyQJg2yWQk3fLPG
0uqISP0Iv0hf8W7ux/RZIgG13/gqbFsK+FORt0AAwrnd4lMOgsPvniCYo4IQmPUlE3fNWe5Z0M56
VUy0t+bM8W3qcU4bC3+vSBirrOosbFA8n9RhMUmVRcN9cIJ6cVBsq1KjwV+PwCiM7HWt/xEBR8UH
Qd5P+Ik57TCF0crzR+7kSn4jdhDS3IrVvhGpMo9xGwSd/OfLfDRXbzRPa3pJQlqDMkCMJXMDt4JO
cgI=
=zRx4
-----END PGP SIGNATURE-----

--------------C0XBBP0v07m5TeJTP7nQmIWc--
