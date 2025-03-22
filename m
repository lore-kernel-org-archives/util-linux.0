Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7D22D7A1
	for <util-linux@vger.kernel.org>; Sat, 22 Mar 2025 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639796; cv=none; b=JCKib5OZvzvIB/CCH8l3h4HgaHTVaaAvQWgTEnAM6Zpw9u1tQnYktyfjKfJbKjAThTIlL+V3xY+cLvzjvTqu2QEroXC1ikFvGw/pSu0qDYjkiqR+2qq0dv4mNR8s6TCacdukiNWmC9dggPIR0jyMBcJkPViOO8ZyDZ9mGhUuRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639796; c=relaxed/simple;
	bh=dU9dhAX7f2EIMr6Hua0sVRa2p9XFxiRW+OJgkgTL3fc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HWcsSJ9vFp0/Eum5K/4v42wS2UQgPkwFQ/UQHgZYAQDZB16pFbw+MBIZkxinkWOJaCDzoSkvi2WqxC0Wq/WXhYy+htazXge9DngVDS6LewSTUPpiNWhyq0+h/vrJ3r4CV2CR9iza9EnRCLTOtFso7MPq7fZebHBEBdvG/cX4iTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Km4lTyVp; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Km4lTyVp"
X-KPN-MessageId: 67442a64-0709-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 67442a64-0709-11f0-a82d-005056abad63;
	Sat, 22 Mar 2025 11:35:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:from:subject:mime-version:date:message-id;
	bh=dU9dhAX7f2EIMr6Hua0sVRa2p9XFxiRW+OJgkgTL3fc=;
	b=Km4lTyVpr6rDECOEh43dq45K2OXgvJa1OBeBb7DGFCULO2twNsFb8wsiCkm4uewsbTVhBMsWL+SGC
	 +mNNJoI3MjncIxYp3h6yEbJdDebRbF3B8amAdC+TTBEZPySf0rVokywCOeZHZsre9iZXwloJUhVOSh
	 q9IPEof+jOEqsXCk=
X-KPN-MID: 33|IRvBrIgT/RptZjxV/URkqKUyBLT6HDVnSUkWewmyM0szzYmeo9jjlTyQgp3LE/b
 0itl03L7HmulCuv8HxAy3EjeWPW65ItAsisiRh8FpK/w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PLIOatY8OYSSsUlZS3bHohdReO4t5Aqve0Pa3ILg0Jp48wCdWvuFcLvqQxz5Zm0
 kmAeb+3oe9di/JEYJab7ECw==
Received: from [192.168.2.2] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5c5719e4-0709-11f0-84f8-005056ab7584;
	Sat, 22 Mar 2025 11:35:23 +0100 (CET)
Message-ID: <60fa0e5e-6a93-477c-a126-a1ba394a58a1@telfort.nl>
Date: Sat, 22 Mar 2025 11:35:22 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: on small terminals, irqtop showed "(null)" -- bug in ncurses
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
References: <477ecae6-0ce6-4463-9c38-8181910fa9c3@telfort.nl>
 <wz2wsk3nmgctdtcdelnrei7x72r7k3cjv4pcju2vpl6yt4j42b@ypw6ceya5n5e>
 <bad0781a-742e-465b-8383-81757a767ee8@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
Autocrypt: addr=bensberg@telfort.nl; keydata=
 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 50GA
In-Reply-To: <bad0781a-742e-465b-8383-81757a767ee8@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yNIui0QpldXxOodvxBxI0LxB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yNIui0QpldXxOodvxBxI0LxB
Content-Type: multipart/mixed; boundary="------------L0GYBPMHX6tbB0S7Gnd0TPsX";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <60fa0e5e-6a93-477c-a126-a1ba394a58a1@telfort.nl>
Subject: Re: on small terminals, irqtop showed "(null)" -- bug in ncurses
References: <477ecae6-0ce6-4463-9c38-8181910fa9c3@telfort.nl>
 <wz2wsk3nmgctdtcdelnrei7x72r7k3cjv4pcju2vpl6yt4j42b@ypw6ceya5n5e>
 <bad0781a-742e-465b-8383-81757a767ee8@telfort.nl>
In-Reply-To: <bad0781a-742e-465b-8383-81757a767ee8@telfort.nl>

--------------L0GYBPMHX6tbB0S7Gnd0TPsX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyMS0wMy0yMDI1IG9tIDExOjA3IHNjaHJlZWYgQmVubm8gU2NodWxlbmJlcmc6DQo+
IFRoZSB0aHJlZSBtYWNoaW5lcyB0aGF0IEkgdHJpZWQgYGlycXRvcGAgb24gYWxsIGhhdmUg
c29tZSBmb3JtDQo+IG9mIExpbnV4IE1pbnQgMjEgaW5zdGFsbGVkLsKgIE9uZSBvZiB0aGUg
bWFjaGluZXMgaGFzIHNldmVyYWwNCj4gcGFydGl0aW9ucywgaG9sZGluZyBvdGhlciBkaXN0
cm9zLsKgIFRyeWluZyB0aG9zZSwgdGhpbmdzIHdvcmsNCj4gZmluZSBvbiBGZWRvcmEgNDAs
IERlYmlhbiAxMiwgTWludCAxOCwgYW5kIE1hbmphcm8uDQoNCkR1cmluZyB0aGUgdXBncmFk
ZSBwcm9jZXNzIG9mIG9uZSBvZiB0aGUgbWFjaGluZXMgdG8gTWludCAyMiwNCkkga2VwdCBy
dW5uaW5nIC4vaXJxdG9wIG5vdyBhbmQgdGhlbiAoaGF2aW5nIGEgc3VzcGljaW9uKSwNCmFu
ZCBub3RpY2VkIHRoYXQgYWZ0ZXIgdGhlIHVwZ3JhZGUgb2YgbGlibmN1cnNlcywgLi9pcnF0
b3ANCndvcmtlZCBjb3JyZWN0bHkuDQoNClRvIHZlcmlmeSwgSSBidWlsdCBhbmQgaW5zdGFs
bGVkIGEgcmVjZW50IG5jdXJzZXMgbG9jYWxseSBvbg0KdGhpcyBNaW50IDIxIG1hY2hpbmUs
IGFuZCAuL2lycXRvcCB0aGVuIHdvcmtlZCBmaW5lLiAgQWZ0ZXINCmEgJ21ha2UgdW5pbnN0
YWxsJyBvZiB0aGF0IHJlY2VudCBuY3Vyc2VzLCAuL2lycXRvcCBzaG93ZWQNCiIobnVsbCki
IGFnYWluIG9uIGEgc21hbGwgdGVybWluYWwuDQoNClNvcnJ5IGZvciB0aGUgZmFsc2UgYWxh
cm0uDQoNCg0KQmVubm8NCg0K

--------------L0GYBPMHX6tbB0S7Gnd0TPsX--

--------------yNIui0QpldXxOodvxBxI0LxB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmfekmsFAwAAAAAACgkQUUu+Lrjhlh8t
TA//XdBCVI15OF39a30FbloyVvCTr3JOz4sT08Pa5DJ1+0P3BVHgPH9iUpiXH4GsmMugX316Tx3l
NW1WskP64Sx4YtVablROO18ehWRPID49qAVvoTKbnsiNp4DBmgrnm2HUxb9Znc/NEyMoYpGcZETd
RQAYBySI9qJ2d5DfnjmpoRAgSC/st2S0uEE8w9VPMO92aETZyOA8NQpS8BnimPM82hHHQ+ak2xIW
kC9VRGviDL2ERc1ZanJHq1MVQ2lmo+wFJcHm6uciTGi6KupwZVOzYco/5oQ/hBx5FzdMED2lxQlp
hgP+6cv/8patp54HWOTDFIvLdZzlb7/9/tkOZwv22YpQPYYFisx1CWn9PoIQy77aX5mbVXg/L/dW
Gvfzk2t0RyzYOoy1gFB+pu5loxN/y8by5B+wOFHQLssOy/X958gf6O64iraoeT42i3HPdsF+UCpD
et7ZDFKpW3EVGse9GdzVbAabyv4/nwy/gKYkot4zsbug9fZoPOS+WwxF8yTtrnD5to+3FmKl73g3
EfirQybBA+5Eo0J88Kz6mHuD7KK74hGDdScg8F6nh81Oev9WK5y4a18UC6cQ36eGpMZQtMPjp3ND
4lLQUozgP484fmrj4OrWubbnifqjIyIvKktzraxOrc/HgmsZVBf40/0apIa4BknfEqty9IO8vtgl
CRQ=
=yUx4
-----END PGP SIGNATURE-----

--------------yNIui0QpldXxOodvxBxI0LxB--
