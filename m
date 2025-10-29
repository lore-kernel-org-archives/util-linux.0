Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FE5324B25
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2025 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736096; cv=none; b=DOzp+bdFiezZRhmWUCg8yc5ov3wn0CwZSS5m5JTzRYjZYR8KPWhB/P2XXflrBd1DGHyTENhnL3ld5afHwvim4PJNCns2DTNnYcbABba6M3tT96CbB0o2u5JALpicAn5twDU/zh1aO6il1waWeQ4xXD3ckeYNGGQZ4zzy7Dqubw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736096; c=relaxed/simple;
	bh=80jcV0fpom45iECStwNiNXo4Y8Gypqh1PNEd8fiFaGk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=RIhBbq87+q/SwjkL+dlOvZzF1gmj1GJ+eQJ9gQKM8JzutpxAiEasSVkyaq3iW84Pz2NVov1DJMFMRhAO4UaTB2xUdF4KyYsZD9D/gpE2vV8c0/qx8LDyOPhgBLj7i9Y3QBLtIYhywe0nzhHCNzX4SnSDy2ib7Pp/8BzJ27b6sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=mgQPDO2j; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="mgQPDO2j"
X-KPN-MessageId: 9244c7ae-b4b7-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9244c7ae-b4b7-11f0-bd6b-005056aba152;
	Wed, 29 Oct 2025 12:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:from:subject:mime-version:date:message-id;
	bh=80jcV0fpom45iECStwNiNXo4Y8Gypqh1PNEd8fiFaGk=;
	b=mgQPDO2j9ZQPjQKA9wyW2YLTuEqSy8hiiPpytSrPtFuIoRPgnPD/VGS36T6SoHJqzLJx3kfsn+z/k
	 b13q9w0aFO2vYG8/+OuGtSCaYI52NxdLqL3QUaYot5xyed1ZODyUpIj7xN6hF9G1AFUlzAQIY00ozn
	 clsJ32O0M1rMNJsk=
X-KPN-MID: 33|Hd3uoVQXnt0sO7VaQBQNjIOC6OgBGcZiiXtAxWBx1j1LEpe+KgilmMmjvIWHHyW
 ZWyEJORswQlLxWl7PK9In54+OzV5AW/gSSWQ3UNxl34M=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|AXdQwJz4UMK2tIIsgikNPV4iGJWPvJ+oi+ZmGVpX8JplJsmXmyGdUe8wFY3I5op
 A9a0urcf75aLFT4KwLdj4ig==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 666fb3d5-b4b7-11f0-bd9e-005056ab1411;
	Wed, 29 Oct 2025 12:07:04 +0100 (CET)
Message-ID: <65268166-345b-45af-961c-43e9778fcb50@telfort.nl>
Date: Wed, 29 Oct 2025 12:07:03 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] losetup: remove the --verbose flag, as it doesn't
 actually do anything
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
References: <20251029110358.18170-1-bensberg@telfort.nl>
 <20251029110358.18170-2-bensberg@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
In-Reply-To: <20251029110358.18170-2-bensberg@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Lyf0gRv5kcfMwUEi3pQHvBW3"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Lyf0gRv5kcfMwUEi3pQHvBW3
Content-Type: multipart/mixed; boundary="------------mIiKYT028qWj08VN05GXS07H";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <65268166-345b-45af-961c-43e9778fcb50@telfort.nl>
Subject: Re: [PATCH 2/3] losetup: remove the --verbose flag, as it doesn't
 actually do anything
References: <20251029110358.18170-1-bensberg@telfort.nl>
 <20251029110358.18170-2-bensberg@telfort.nl>
In-Reply-To: <20251029110358.18170-2-bensberg@telfort.nl>

--------------mIiKYT028qWj08VN05GXS07H
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPciwgaW5zdGVhZCBvZiByZW1vdmluZyBpdCwgbWFrZSBpdCBhZ2FpbiBkbyBzb21ldGhp
bmc/ICBMaWtlDQpyZXBvcnRpbmcgd2hpY2ggZGV2aWNlcyB3ZXJlIGRldGFjaGVkIHdoZW4g
b3B0aW9uIC1EIGlzIHVzZWQ/DQoNCg0KQmVubm8NCg0K

--------------mIiKYT028qWj08VN05GXS07H--

--------------Lyf0gRv5kcfMwUEi3pQHvBW3
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmkB9VgFAwAAAAAACgkQUUu+Lrjhlh++
MRAAoWKejrW1t/0Xavfqb1fKLhS4sE6IyKo31VhBMDrbsWVK/xsFPCO7RPm78cmPtsIQ3f6QQ4Je
d/qFvkeNEq6+51P8NY4TKPjCJr7TKXF+PtwhG8MuQWl2EjkH3CQnT1+xBtHuGyZAMNxwi9eA6mrR
oWK1r17iczY87PprOP8vwq9I/KbXGk9cr3I0ER+pEpIKk/ZjpCyQAjSu/Eoxhw0y6yWZtahhUCIq
TB6l6qMJW7sCv/POKE/dBcpH+oXAU998wCLDMeZXps25S57sjzvkjXEYtAgyzvGX9q1XyV8ygFHk
Acl+LSfnkrD41WOgswhEYYMSIWRQ6A43x5qwTqFK0dac8FbAtIKijEjcx4nmCaVfHxQU0UOLiY5B
WX6CM21zo2QURPB6r/Q5pQl2+0w2zoPU2SgvuMHGOtn7r6nksN2rT+JRkuc2cXyCI3C++xg4JSvd
IjXP5DQ7ijB9JmL5jtTM1aRfX16du0tih7w/1l1LvGCq8xefJQfwkb85jXjiAUZzgQM9I/3kdo4+
bPA5Dw6CQ72yOliTeUqszv3b2YMtSt9ArIq+o3n6jPc04ckhgtV9nGVjiU4lu6d1M/jV5c6z6hF/
V91aknZ8zGDn/wmXOf2WVc2bVGZvE3W6oHETDayLS0sueE6Ezkaz7cdJyivmPqiaP9R2s6OAcR95
1jA=
=7a5l
-----END PGP SIGNATURE-----

--------------Lyf0gRv5kcfMwUEi3pQHvBW3--
