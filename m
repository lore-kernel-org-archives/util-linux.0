Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703D620B818
	for <util-linux@vger.kernel.org>; Mon,  3 Mar 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003937; cv=none; b=MZqpuio6QCfMi+YLbvZzZg3cmozRm5C6TLyt1EkH9m2E77pcGMypeyGOePJjsVGEAPOMw6roQpyU1SnQwsW++kx9kmqOYSwj09Bay1Ii3j+pf1ZRl7yV5EnxbXS76shQfPrBPS/X85tQsv7+0Ftc6zQFwjwRQFM/JF08zVKZV6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003937; c=relaxed/simple;
	bh=mRu78cuFO1+wGfuEDv4tMxyEuh+JYi+1cmCIC2EgnSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6YTwHkiFqXQQe+kGadUc3xE5hV3t4Yk1GAOWy+mA/QhCA0GvskYM1P4M0OXf2w3X43pYCPga2YTWbs2yFPB4ioIVayEFm7sccR2HhHjo1aJZYf0IFUY1q+V+wPM+P4KLqsXjnfYCmYaZnOeejP2bsan2sOjGtY3N2ddnSvJDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=UehIlh6d; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="UehIlh6d"
X-KPN-MessageId: bea76862-f828-11ef-b99f-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id bea76862-f828-11ef-b99f-005056abbe64;
	Mon, 03 Mar 2025 13:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=mRu78cuFO1+wGfuEDv4tMxyEuh+JYi+1cmCIC2EgnSo=;
	b=UehIlh6daVy35+hDd7H08OPcHVWZ4lgtc8bafpWRu5RvriNHtZcnrGub1DZxrJaItynEBN+h+Qp+o
	 lTH9kNTj8GI1mntx88JbBCb+XVx09Jq2ykh14hRLGEhuK2XweVvYviUWRb+2bWxJmre9EYKiRpRsHa
	 rwXBLGy6PscNBIP8=
X-KPN-MID: 33|79SLwwn2IF/460ZH2WQTOV3ZVWkFqZy2+mLEv2BmkUF1BKNCsi03/xn/6mQZ+jp
 0KaKuT1h7FEzvHxKr5AdogffnqCQGPBenLxHZI4DX/fY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|LXhZ5wS62+wbHwAeVgLQ/Sk4EZwUsp/dMd1C9++lgbbmRjptYON2S7DtywpSJxt
 3ROIoINgk3MaWUUVDPVEmRA==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b94fa02a-f828-11ef-9587-005056abf0db;
	Mon, 03 Mar 2025 13:12:06 +0100 (CET)
Message-ID: <ad13fd05-8d24-4fe2-a0ad-741fb857a899@telfort.nl>
Date: Mon, 3 Mar 2025 13:12:05 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] column: replace a mistaken word in an error message
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250303102137.4020-1-bensberg@telfort.nl>
 <mtr3urghiu2ezk2uprqwuvkgfxktdb3md5vc4zwbidgxeckzny@2n7vycofqgom>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <mtr3urghiu2ezk2uprqwuvkgfxktdb3md5vc4zwbidgxeckzny@2n7vycofqgom>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------midwKRKAjyvZrXs0rReIR398"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------midwKRKAjyvZrXs0rReIR398
Content-Type: multipart/mixed; boundary="------------Lx45XQctYDvdDTGuvxkL9n0D";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <ad13fd05-8d24-4fe2-a0ad-741fb857a899@telfort.nl>
Subject: Re: [PATCH] column: replace a mistaken word in an error message
References: <20250303102137.4020-1-bensberg@telfort.nl>
 <mtr3urghiu2ezk2uprqwuvkgfxktdb3md5vc4zwbidgxeckzny@2n7vycofqgom>
In-Reply-To: <mtr3urghiu2ezk2uprqwuvkgfxktdb3md5vc4zwbidgxeckzny@2n7vycofqgom>

--------------Lx45XQctYDvdDTGuvxkL9n0D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwMy0wMy0yMDI1IG9tIDEyOjMyIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBCZW5ubywg
SSdkIGxpa2UgdG8gcmVsZWFzZSAtcmMyIEFTQVAuIFRoaXMgbWVhbnMgcGFzc2luZyB0aGUg
dGFzayB0bw0KPiB0aGUgdHJhbnNsYXRvcnMuIERvIHlvdSB0aGluayB3ZSBuZWVkIG1vcmUg
dGltZSBiZWZvcmUgcmMyIHRvIGNsZWFuIHVwDQo+IHRoZSBzdHJpbmdzPw0KDQpObywgbm8g
ZXh0cmEgdGltZSBuZWVkZWQuICBZb3UgY2FuIGdvIGFoZWFkIHdpdGggLXJjMi4NCg0KKEkg
c3RpbGwgaGF2ZSA5MDAgc3RyaW5ncyB0byBsb29rIGF0LCBidXQgd29uJ3QgaGF2ZSBtdWNo
DQp0aW1lIHRoaXMgd2VlaywgYW5kIGNhbid0IGxvb2sgZnVydGhlciBhaGVhZCB0aGFuIHRo
YXQuKQ0KDQo+IFRoZSBjbGVhbnVwIGNhbiBjb250aW51ZSBpbiB0aGUgbWFzdGVyIGJyYW5j
aCwgYnV0IHRoZSBjaGFuZ2VzIHdpbGwNCj4gbm90IGdvIGludG8gdjIuNDEuIEkgaGF2ZSBu
byBwcm9ibGVtIHdpdGggdGhpcywgYnV0IEknZCBsaWtlIHRvIGJlDQo+IGNvbnNpZGVyYXRl
IG9mIHlvdXIgd29yayBhbmQgdGhlIHRyYW5zbGF0b3JzLg0KDQpUaGFua3MuICBBcyB5b3Ug
c2F5LCBhbnkgb3RoZXIgY2xlYW51cCB3aWxsIGJlIGZvciAyLjQyLg0KDQoNCkJlbm5vDQoN
Cg==

--------------Lx45XQctYDvdDTGuvxkL9n0D--

--------------midwKRKAjyvZrXs0rReIR398
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfFnJYFAwAAAAAACgkQUUu+Lrjhlh+g
mA/7BHrKDn1bLI3m61e0+tb5T0ZLNbLviumlyBAtQDCbUp0trqkjwJ4N/vro+woO7UKQjmLvU3xx
e7lnM76q5MXmCN37iOh9B6EiOuzwOGadm73hzgexgnnAYs12xqjW4t0jIl8KJx/1XgDCJpIYQm73
M9farmW1ySeTNBlAvqLl8fUj5L/nTdRxMa+PUKYQe92IEbLtoFiU6exRhDl7G38anvKxXqK/mUbC
05pSYrFyrKOVMKTE9FCJgHbySDR46H+6EdUfGXGVJ/Rd20f+h+vxO00eN75gyA+zCMCdwWIz0ePi
oj04KpOiwF35JEcE4HUMTQSuqqxUgejg6axH8rDm8LYxtIK9QjZSI/dA13lgn8TZe7CYd8dG3WOp
lhHcqEoFnea41nn4ORsftsF3EqpSPMwpp4tEn68sd8MYPv+SVQpFgpCm2YRu7IKa0QPvU0m9AR4l
krAcMhWqPExoglopXjlSuZMK4XVwHQmZUl3AQJ3ywQiK2d3vtdIfkj9RjGvSFIT9HwCGRJEwcqPe
M8dH1KV/jHyBK5gDrnuHxPY105T5EFh83fX88jjBbVu8oA2PcBAaRYI+MUrpO8tK5Aisfhe7FAe2
TudxZXiMaV/FsrA7y6lrpGfngpir33q5i3h1sc8OInE8mIiBbKHRt/SLBbT5DgenMnlcK8oJJbAJ
HPA=
=98Gn
-----END PGP SIGNATURE-----

--------------midwKRKAjyvZrXs0rReIR398--
