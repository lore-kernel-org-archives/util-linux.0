Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726FF35957
	for <util-linux@vger.kernel.org>; Tue, 18 Mar 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294678; cv=none; b=plw8lfZShC+U3uoPSlK+4zv6iVntcvzOfwqU1WYMeMBDt9Cg6JkXUigvG/oj7FwvtiVTKEe+Bxof/NZwcT0okYNlVYnY7EGiM7HRL6T3iunaWeLwglU/I7cgkwX5VIpC4K/YTgO7L0zauSLGfPbSFNoxfi8YAc+SOd0V9uWEbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294678; c=relaxed/simple;
	bh=pvYmUJkTrcqiFlURNhh9grsejodgU750nvxGDQyYOs8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=ewsiij4VoLJfi4/QP8d1kWQIpsoQXSFlzJweo9uNG4Z5mMLbHZPqSp8BXxfNtvaershhMMW9qHyV1ECqOmRyv9f6EUztlROV76/1cZKi2nHL1LiBmXfUdPdyugjETYu86K5RH7YJfjw4FBqJRQO3b/moiH55SIpRwVMR4ZDO4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MhtpzZDc; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MhtpzZDc"
X-KPN-MessageId: ffb96053-03e5-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ffb96053-03e5-11f0-86cb-005056aba152;
	Tue, 18 Mar 2025 11:44:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=pvYmUJkTrcqiFlURNhh9grsejodgU750nvxGDQyYOs8=;
	b=MhtpzZDckD/QsbokHEKlL5HJ5c9xz10VT4PERgLmP7Lu/2saj4kv2ZrcQLNVeDBDX6wfXkNgg7HUy
	 CjRG9qTg9MeCpEnuj/uY2mZz/X/uQnEoIGtT0AB/w9EcCRTeFh/vFBFloiO1UK4ut771g2S6wShiWU
	 eFYQ9hX09F1/fK8Q=
X-KPN-MID: 33|jZO2XxQKKTMiQk4FmhP/069P40bGzt7/6WhXZB/0fY3dT/HXYkupNmPn43bNOxs
 QWx0oinE74hEV/qjHEVTlLs2cQPTpqgUgxIalnGss1SI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Tf0zL/Xog84F+D7KuBQk5xeYzlDdTQiPs46R1COgdyHD2ePvSABQ12q2mgincLO
 nmmniFNtOTGeSJ/gcZAAe6w==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id f680738e-03e5-11f0-9bea-005056ab7447;
	Tue, 18 Mar 2025 11:44:26 +0100 (CET)
Message-ID: <370e8be9-2e4b-4375-80dd-fdaf5a78944c@telfort.nl>
Date: Tue, 18 Mar 2025 11:44:25 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: bug in `more -c` when displayed file has blank lines in certain
 places
Content-Language: en-US, nl-NL, es-ES
To: util-linux@vger.kernel.org
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0RQhYRL7eo28T4xjH1j2h6jN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0RQhYRL7eo28T4xjH1j2h6jN
Content-Type: multipart/mixed; boundary="------------qOY6YAMwBIZZnkkQJz0VfJmX";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <370e8be9-2e4b-4375-80dd-fdaf5a78944c@telfort.nl>
Subject: bug in `more -c` when displayed file has blank lines in certain
 places

--------------qOY6YAMwBIZZnkkQJz0VfJmX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpUbyByZXByb2R1Y2UsIG1ha2UgaXQgc28gdGhhdCB5b3VyIHRlcm1pbmFsIGhhcyAyOSBv
ciAzNSBvciAzNyByb3dzLg0KVGhlbiBydW4gYC4vbW9yZSAtYyBORVdTYCBhbmQgdHlwZSA/
IHRvIGRpc3BsYXkgdGhlIGluLWFwcCBoZWxwIHRleHQuDQooVGhlIE5FV1MgZmlsZSBzaG91
bGQgYmUgdGhlIG9uZSBmcm9tIHV0aWwtbGludXgtMi40MS1yYzIuKQ0KDQpUaGVuIHR5cGUg
PFNwYWNlPi4gIFNlZSB0aGF0IHRoZSB0b3Agcm93IHN0aWxsIGRpc3BsYXlzIHRoZSBzZWNv
bmQgbGluZQ0Kb2YgdGhlIGhlbHAgdGV4dDogIlN0YXIgKCopIGluZGljYXRlcyBhcmd1bWVu
dCBiZWNvbWVzIG5ldyBkZWZhdWx0LiINCg0KU29tZWhvdyBgbW9yZSAtY2AgZm9yZ2V0cyB0
byBjbGVhciB0aGUgdG9wIHJvdyB3aGVuIHRoZSBjb3JyZXNwb25kaW5nDQpsaW5lIGluIHRo
ZSBmaWxlIGlzIGJsYW5rLg0KDQooVmVyc2lvbnM6IDIuMzcuMiBhbmQgMi40MS1yYzIuKQ0K
DQoNCkJlbm5vDQo=

--------------qOY6YAMwBIZZnkkQJz0VfJmX--

--------------0RQhYRL7eo28T4xjH1j2h6jN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfZTooFAwAAAAAACgkQUUu+Lrjhlh8M
XQ/+KeXIEg15185YgZQvUc3SqhsUbc0KUDF1w9kq0kVhtjUMvC1KfzID9BlrRBUiuYImfSNDiG79
panA49QzYsbFQMlloOxEY8Z2f0dFCT2qr0+bcPXljtaL08UNA6KTc5HM5QSqyAV+WUFUxuf+Mile
be9TC5l7Xo5ZV5A9zIeAGphtydNd9MMFlBIolWsCHE2oyIVFBCyl/IGxTMcZMCX++m84cJZmfPwF
f1y8s1NBW5Hnpvz8iLYa+m+YD7bnGGYW18jmZiR99DyQ6dHhXROln5Pjz6Uw4VCjd1hR1L3Bo1Bg
Vvql+P9M6F7PSjVRyMxUllHyMsYSo8HyXW44/5uAIevi8K5BCq2dNOURcQV//C2wBJe9DoHe9lQ4
9F7S8CvlMNq2wBq6s1BfLjjeKabZm7CkRDX16uUslcPcBPS5h9FHmLxuCG3Io6i46DZ6jKFZ2DA6
+kpValFmFdT+IBcWX2sykB9xbp72kFnOmkk3PLel6ZKD9hnGfEBx0iW/iJE5Qe1dCenoIQcgeLvk
tCi6/vAruNut+RLI3Y4S66mAJGK76ULoNwV3Nq0KqWPRFLEEg+etfONN86suUTdDOWkZoFpzmucZ
A80jeraEPV9JXzSafwdtcFWVMiN0K5lO3DN2XbAUa0rZ/0mYskjDjYfCaTmsMXTZ25imjnUJcz0S
MhI=
=bbJJ
-----END PGP SIGNATURE-----

--------------0RQhYRL7eo28T4xjH1j2h6jN--
