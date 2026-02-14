Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DE3EBF37
	for <util-linux@vger.kernel.org>; Sat, 14 Feb 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771082757; cv=none; b=Ql4D9oFVi070bNUBfosFouvDrbYYJzgnoSDcg7s3cmf47SWUHpNznz3t4yeY41MTzpwiZOgD3gRDTPqXHQrpwYGDv0ic+p0SXV6L45XPr++4k1u0hPpxAqqW+IqDw7u5hjfvBvRKhyCOX3unZbVoOfxsIIUxkndj4oRlGZNmbyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771082757; c=relaxed/simple;
	bh=nU0M8+vcSPTzXQ/nsiIYVwJlJVStX8pzfGxx4FSN66g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hmwHGJV7HwDxqt4zwQJ7evtZZeqS0qS0RomJCP1jLGmpPyzpfDS+zYwTKuE1iMVVSV87JZSERRQLjQ/FO2LQtWdznT5ZA0cU5M/KxPmK66mK6S4u0Pcqp+zWIQNYc6tAHNoOrJemoRsuTeWPnbYmfCzXAPo2u6KzyJ+o3Jgr3hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=coevern.nl; spf=fail smtp.mailfrom=coevern.nl; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=ft4SktJ+; arc=none smtp.client-ip=195.121.94.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=coevern.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=coevern.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ft4SktJ+"
X-KPN-MessageId: 49ae13ce-09b9-11f1-929f-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 49ae13ce-09b9-11f1-929f-005056aba152;
	Sat, 14 Feb 2026 16:24:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=nU0M8+vcSPTzXQ/nsiIYVwJlJVStX8pzfGxx4FSN66g=;
	b=ft4SktJ+tbTbPn4Nq19MLm47bpdN8qLN1eVaev+gFvyYsY3vvU/+AkQKV2jyl3kIERpgoV4prRc7Q
	 V9qj2XIyBfpmpJRtPfatRj5ThgnjMSZQuL+mFMpX8+ngQV9bM6+LG4tx5uYur0rF8x31JjylmE+EtA
	 Up3NL+pPvt4d3ePc=
X-KPN-MID: 33|axvHz5pvG+1TrTlwHYjxH/JiRG6NYJKd8xqJjFGwYzUlJQdaCg3/VLnv6V32rNU
 X+Xf70T+Lbi8531i8mSpnlevOCP8V3WIVfAUI8yrW1Z8=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|aUECizDu3677hSNdfX7D+RXOf/B4FRNeN6oAdlAi0ylKlSKSF3lMSTT5h/0IwLQ
 AbQopZnfhzAYJeAIAsgSGfg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 49960d30-09b9-11f1-b8dd-005056ab7584;
	Sat, 14 Feb 2026 16:24:43 +0100 (CET)
Message-ID: <ff9b88bf-351b-47a8-95d3-dffa23f059ea@coevern.nl>
Date: Sat, 14 Feb 2026 16:24:42 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lsblk: improve error reporting for invalid device paths
To: sina-abroshan <sina.abroshan@gmail.com>, util-linux@vger.kernel.org
Cc: kzak@redhat.com
References: <20260212112423.2400888-1-sina.abroshan@gmail.com>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@coevern.nl>
In-Reply-To: <20260212112423.2400888-1-sina.abroshan@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hQuW2CJPcWZ0F64qvFQKe0U7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hQuW2CJPcWZ0F64qvFQKe0U7
Content-Type: multipart/mixed; boundary="------------QeUQWj4gUirT9YHTduaQfzCe";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@coevern.nl>
To: sina-abroshan <sina.abroshan@gmail.com>, util-linux@vger.kernel.org
Cc: kzak@redhat.com
Message-ID: <ff9b88bf-351b-47a8-95d3-dffa23f059ea@coevern.nl>
Subject: Re: [PATCH] lsblk: improve error reporting for invalid device paths
References: <20260212112423.2400888-1-sina.abroshan@gmail.com>
In-Reply-To: <20260212112423.2400888-1-sina.abroshan@gmail.com>

--------------QeUQWj4gUirT9YHTduaQfzCe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxMi0wMi0yMDI2IG9tIDEyOjI0IHNjaHJlZWYgc2luYS1hYnJvc2hhbjoNCj4gLQkJ
c3RydWN0IHN0YXQgc3Q7DQo+ICsgICAgCXN0cnVjdCBzdGF0IHN0Ow0KPiAgIA0KPiAtCQlE
QkcoREVWLCB1bF9kZWJ1ZygiJXM6IHJlYWRpbmcgYWxvbmUgZGV2aWNlIiwgZGV2bmFtZSkp
Ow0KPiArICAgIAlEQkcoREVWLCB1bF9kZWJ1ZygiJXM6IHJlYWRpbmcgYWxvbmUgZGV2aWNl
IiwgZGV2bmFtZSkpOw0KDQpXaHkgdGhlc2Ugd2hpdGVzcGFjZSBjaGFuZ2VzPyAgVGhlcmUg
c2hvdWxkIGJlIHRhYnMgdGhlcmUsIG5vdCBzcGFjZXMuDQoNCj4gLQkJaWYgKHN0YXQoZGV2
bmFtZSwgJnN0KSB8fCAhU19JU0JMSyhzdC5zdF9tb2RlKSkgew0KPiArCQlpZiAoc3RhdChk
ZXZuYW1lLCAmc3QpICE9IDApIHsNCj4gKwkJCXdhcm4oXygiJXMiKSwgZGV2bmFtZSk7DQpH
ZXR0ZXh0aXppbmcgYSBtZXNzYWdlIHRoYXQgY29udGFpbnMgbm90aGluZyB0cmFuc2xhdGFi
bGUgaXMgcG9pbnRsZXNzLg0KSW4gb3RoZXIgd29yZHM6IGRyb3AgdGhlIF8oKSBjYWxsLg0K
DQoNCkJlbm5vDQoNCg==

--------------QeUQWj4gUirT9YHTduaQfzCe--

--------------hQuW2CJPcWZ0F64qvFQKe0U7
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmQk7sFAwAAAAAACgkQUUu+Lrjhlh+O
1w//cf6USHhr5+1OCmYZjjfreKZ+rtIYkabhyQW1aBdWyDtUU94EiXfGXlKHc8sbLCIm3GjoFs9M
M5iMAUt/TMreFiAnjeQhYRFZeowb2Gyas7E7ZxfM++zu089OMJ335cGJLN86PGyF8IG9OQ+WSIr0
1ktLcOnlzZlZQsc5HEpTeHwf+yX2sWVDigLK+ygrDR7h6Zi6l4mNUJmO++/zJt/x0PTTgxUg0d7H
NYaI/ToUA+iXG6Pfob/0wGUxwe5p5y+1TyPfz3noNxJIHtWCloiCoHZM55Rw/A94IynRoYDtn1d3
akxOJaBp2LLzptIObulIUn1C0gUn3FVx/sbERaFu7FqWIB4iSuTKOgrKrGJccUUfzXMb3SOpJgfp
h3t41OvjD1cOWeC9EEiEfF9IFYWS5GHK/UPhgkiu/6qn/YpmJRdNrqq+necBR+30nYQRqJhtRudW
VpbxI4+jfLXod6HMKC+clk8QY1SLtL9XrxCuFNFFG97kIBgmIlKnB37gy0T3z7JAfqD6E4amljcq
X+ajZinORQHOCHZdZK4nTvY86U/0x0P6TOsu6EdLpZD10ezBEYd75OguM9pvUY6nsbed/tvhWB19
mJx/xHDoNYutb4UzF566dXgI+v8fPOfkNZqEh1g7GDojYY24UP0421M3YBhqnqNXfUcQTYXg9bX5
3ZM=
=dxR2
-----END PGP SIGNATURE-----

--------------hQuW2CJPcWZ0F64qvFQKe0U7--
