Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ABF25A624
	for <util-linux@vger.kernel.org>; Fri, 25 Apr 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577840; cv=none; b=Fyb3H+UouX3BrmGEHBiEH9zHYpIyh4PvUx+kWDNjog8KR1GUVhv3J79jH4EWLHeEpngMqTf4P0I7Kee0V7jOWBv5PYdmzvvHVupy3OUWsJ7oS5tjgLzV0LTHZlQ2icU1S6DK3d5XKq1QniZKQnvOSvVJ2yQBaDu993+wEvd2Z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577840; c=relaxed/simple;
	bh=cFj5W4Iek86bn/l3d8BeXEYgvDwRRynPxLHkKzOKXjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9CEk61XiL6vBi2CiZ8sV4VBGuMPekP2BZVCME+ur7iNaaTfkhwEQYV6nm4PNg7NaCvLrF720jSNxdEvR2Vj9Kwig+ti9pbfqr5e2Sw9hmWI7uXzp7mDKErtTMVWpm+RRNUrHLMFlIxudrX9aRMJuliVCN+7ugA+j/RBVB3rTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MKQ2nEV5; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MKQ2nEV5"
X-KPN-MessageId: 49936d07-21c2-11f0-86cc-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 49936d07-21c2-11f0-86cc-005056aba152;
	Fri, 25 Apr 2025 12:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=cFj5W4Iek86bn/l3d8BeXEYgvDwRRynPxLHkKzOKXjs=;
	b=MKQ2nEV5AvMBRuCc2BIKAcNLoNNZF1+ascVINA9VMA+6yaspN262jQaOKN3sLbw2pt46RtqBYrIaz
	 QAMEpOzBMVGSjmzQOC9xtuWpzXyrvjlELd6lQrcl37ONeDDAkyRSGg04+qYJZ1pabfx9yzwmA/zwRO
	 VifSEvE+3DunSQn8=
X-KPN-MID: 33|Ofl5DNMR+74x34UGt5OMXdmRwvMh/lUr9aKWi8F7zMm/PiXolvZDw2nKrcnFAdH
 ekP6Vv2YM4FmsYBVpF/Sy0XBelBCEdgDNbFqs3nOrOIM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/fkv9OCyHTWaOR64VBpw0FxgPFRfRJve5jA32KiR9yly+IDPiSe5MhXDNXQ7DjK
 u7xwHcdBfG3BvyK9ueswuZg==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 307ecb74-21c2-11f0-9c06-005056ab7447;
	Fri, 25 Apr 2025 12:43:57 +0200 (CEST)
Message-ID: <f8faf6a3-1da6-42f7-a231-29c47f56b888@telfort.nl>
Date: Fri, 25 Apr 2025 12:43:56 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] docs,usage: harmonize description of --hyperlink, and
 add 2 missing ones
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-4-bensberg@telfort.nl>
 <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1nowgjrSfxj8kBVVJcxgJ0f9"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1nowgjrSfxj8kBVVJcxgJ0f9
Content-Type: multipart/mixed; boundary="------------J3JgkObkuGVM0ooqJAYyb635";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <f8faf6a3-1da6-42f7-a231-29c47f56b888@telfort.nl>
Subject: Re: [PATCH 4/7] docs,usage: harmonize description of --hyperlink, and
 add 2 missing ones
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-4-bensberg@telfort.nl>
 <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>
In-Reply-To: <6sucmcn7scrug4shj2lebkrfdz3yyayoj37b3akusib6mxtyjw@kapl5f3xlvzq>

--------------J3JgkObkuGVM0ooqJAYyb635
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyNC0wNC0yMDI1IG9tIDEyOjA4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBIb3cgYWJv
dXQgYWRkaW5nIG1hbi1jb21tb24vaHlwZXJsaW5rIGFuZCBpbmNsdWRpbmcgaXQgaW4gdGhl
IG1hbiBwYWdlcz8NCg0KRG9uZS4gIEFsdGhvdWdoIHRoZXJlIHdhcyBhIHNsaWdodCB3b3Jk
aW5nIGRpZmZlcmVuY2UgYmV0d2VlbiBgbHNmZGAgb24NCnRoZSBvbmUgaGFuZCwgYW5kIGBm
aW5kbW50YCBhbmQgYGxzYmxrYCBvbiB0aGUgb3RoZXIgaGFuZDogdGhlIGZpcnN0IHNhaWQN
Cmp1c3QgInBhdGhzIiBpbnN0ZWFkIG9mICJtb3VudHBvaW50IHBhdGhzIi4gIFByb2JhYmx5
IHRoZSB3b3JkICJtb3VudHBvaW50Ig0KY2FuIGJlIGRyb3BwZWQgdG8gbWFrZSB0aGUgZGVz
Y3JpcHRpb24gZml0IGZvciBhbGwgdGhyZWU/DQoNCg0KQmVubm8NCg0K

--------------J3JgkObkuGVM0ooqJAYyb635--

--------------1nowgjrSfxj8kBVVJcxgJ0f9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmgLZ2wFAwAAAAAACgkQUUu+Lrjhlh/M
VRAAyHtSRP/Xyqu2br0hGygt0PVzzzjD6Kzsj1g84ixINmpMRhhwQUueAU7ulnTB9b/wu9HGSzLo
SKr9oqe2uPmL9nxHZtTvMsHOfLZ+3a81M2EmrWcUpVRh0H2pZSu4JOwFpzPCo3v4rlz3AuLIha4K
KpCCRhVlR++EFluLOB7wgaPGFXomkFkulNnWnhfeOeO20YgnanFAgrbACN7e0PxZujJBI4LrzZVt
mX7U6dj/yiDE+GWy26OVFERltC0n5zgoylTWHoqZTTrq6raZQ8l9/OcAjomnJT4Mu806d5n+Liwm
pZifUnJdLfEEgr79UKmq5qMBirpD0h7Zy9eHr/7PVgfQeldWRhBmlBhpvRwuKxuhQ0clZY8MqWcK
syhuSToQkgn2+uEFOMqTzNX/FvCgt411slxAWHHxHyeqFvZYWqXqzhF+MOAiXHoIqJPbdWW4po4R
bF4tf41015AxBQPx90zOyO5yOOqxRpgXDvYQGDOTzUGdXIt0ElbtmSnd9wF5jqKNySoQRm6/zSmo
f6BbHxRR342NE6TLla/jXgldz4JeybPIwoUwMcOxHTSsFte/GdER4KZsL1S2yZDDjTl4atTwxeBc
miK8+FJHATljZvjtcflz3creMlhCEDTxd0vii8oRseH5Ltwl59DFsuahMv6PDhwqCaPd7MrPA//2
hdE=
=45SJ
-----END PGP SIGNATURE-----

--------------1nowgjrSfxj8kBVVJcxgJ0f9--
