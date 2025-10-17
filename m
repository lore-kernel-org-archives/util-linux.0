Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5EF26F2B2
	for <util-linux@vger.kernel.org>; Fri, 17 Oct 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760690283; cv=none; b=X3Q/RnBFifAmC06ayhURjxCCJlxAS3531ykNUgAwsgwmpqw6DEeCknjk4wWuJv/ss+Ts5viy5BUEH9tg8IJp1TpC+IaHOMhvRbqowFlerhjhOWyaoC/kwVaPZykG1GxJysOZkm8qr15OLX1YfzOEGNZn6c1hbUMR8QalqY+VWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760690283; c=relaxed/simple;
	bh=TtyE5G9A7i6+Cbpz+NEnb6Wz42c1fBryolSnIELhrSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWsG8/gLr7jxAiqqeu7ib1PHWIIBFY1ze0qQF2igoXKjB3cJWpeI6AggfnNhGR2ow4b/1rXzhpIdDj8ny0fOcVbNUphYzC3ZpmLuRxzFc09rNTGi27Rp3BUVEcswRv9+KjBH7J7kWd1FnOmpVHuPhP499WkmeOf1QoX4p0R8CP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=WHSsW//5; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="WHSsW//5"
X-KPN-MessageId: be01100a-ab34-11f0-a27d-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id be01100a-ab34-11f0-a27d-005056abbe64;
	Fri, 17 Oct 2025 10:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=TtyE5G9A7i6+Cbpz+NEnb6Wz42c1fBryolSnIELhrSs=;
	b=WHSsW//58AM0DEEqjfQwJHyL6PueGPJdNY1yBj0UzYX89q2LEXg96n7p/5UKt2bZ1wZXf3VH2NRPe
	 M8WbS5AaQSTtsQE/xrZSk5lQE1zUmlSHSFHo1iUoL1LvkUluJozBQ+HYX6kYt1l5rzn07kREBtA0Fv
	 /jAtiWRnGva9AP5M=
X-KPN-MID: 33|BSYnotMn3BEDIPgIS4ytrxbVj9FauKwWirmnFL7aa9GpjK0IJc+Y2Cn+OS3dm9U
 jEOKxcBWIBudZj6W5LbJm7zPNH9PJbDaZYFcyBFYA/5g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ivYUhDWj7wpgwVl3F3lHILReWANvCANsNVeRVG5dbqj1AXF2sYirg99WlH1kR29
 McOZSHNKzXBDRLkV4xgInAQ==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 91b8e8e4-ab34-11f0-a6c9-005056abf0db;
	Fri, 17 Oct 2025 10:37:52 +0200 (CEST)
Message-ID: <3ec10487-0195-4dff-b056-37ada0d6d5ee@telfort.nl>
Date: Fri, 17 Oct 2025 10:37:50 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 wguanghao <wuguanghao3@huawei.com>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------scsuti0YzfEQf3uNdF8lLuEd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------scsuti0YzfEQf3uNdF8lLuEd
Content-Type: multipart/mixed; boundary="------------NJYj08dCmP6WjcrMXByjv6Db";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 wguanghao <wuguanghao3@huawei.com>
Message-ID: <3ec10487-0195-4dff-b056-37ada0d6d5ee@telfort.nl>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
In-Reply-To: <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>

--------------NJYj08dCmP6WjcrMXByjv6Db
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAxNi0xMC0yMDI1IG9tIDEyOjI4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBodHRwczov
L2dpdGh1Yi5jb20vdXRpbC1saW51eC91dGlsLWxpbnV4L3B1bGwvMzgwMw0KDQpMb29rcyBn
b29kIHRvIG1lLiAgSW4gcGFydGljdWxhciB0aGUgZG9jdW1lbnRhdGlvbiBwYXRjaDogaXQg
d2FzIHRoZQ0KcG9vciBkZXNjcmlwdGlvbiBvZiAtLXJlbW92ZSB0aGF0IG1hZGUgbWUgc2Ny
dXRpbml6ZSBgbG9zZXR1cGAuICA6KQ0KDQpJdCB3b3VsZCBiZSBuaWNlLCB0aG91Z2gsIHRv
IHNlZSBhIFJlcG9ydGVkLWJ5IHRhZyBvbiB0aGUgZmlyc3QgcGF0Y2gsDQp0aGUgZXJyb3Ig
ZmVlZGJhY2suDQoNCg0KQmVubm8NCg0K

--------------NJYj08dCmP6WjcrMXByjv6Db--

--------------scsuti0YzfEQf3uNdF8lLuEd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjyAF4FAwAAAAAACgkQUUu+Lrjhlh+k
JhAAuxEgspqKHI891E2Dl6wG4taq80Z0oW2Gx4TPEFZUHekurQBxtvg+KwwlXEs1zcfBna2UxMRj
Em6fG5dM0yMoYqhzUQ1irceuTwRYaP0TG/+mzaj/BeEcaHX0MOvOPqDexMI5KiNfLg0CYgp7a/1n
Y2CY7VPQ5KhnkGBoe0aBmHR/Qh/441FSH2hqFOgUwpVKftfLSzFwmkgdquEa8klyAzQlWgEtJ5In
fguh2liOR18eYYIt8jI6ECzEd0JnEdqkmZMeAjVT94Yfebx5U61VpJIcQvIOw6F5AeOYnW5CfPHh
fUP452ILptCQ12LEcLso0WtzFEk3CzLRJyiNqwSSmNhB5De7hHgojz8eppnNniELyJwXamzVrV82
oazXJ5loPFrLVCSJDm3R/ziCPZcCXv054u36b9zdlYdV5bGoCJl/sJjY7qLklWLWXdgjP/vXsx9+
Y9obIoyeOXtKvCBL4U6d+e1rRZgHUawvtwFsbHh0HhkYBHxQKH/A9gwK32hd3LGJPjSL6byc+x4H
EPyLAlEVNTZ/YGrKIOYrUYu4Y1PqUiZ58GuayUU06XNUUNs79SyWjEcUxuhBmhEN0dqohSBUJp+A
nvnM0hmAN7j0k5uALcjeabXSoNKUusYlon429+DFZuwBT1bz9y/eoVsDm+WxEhVqOJsY0MrV2YTq
Nus=
=nt/S
-----END PGP SIGNATURE-----

--------------scsuti0YzfEQf3uNdF8lLuEd--
