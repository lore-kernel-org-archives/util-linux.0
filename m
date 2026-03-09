Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3DC3DFC85
	for <util-linux@vger.kernel.org>; Mon,  9 Mar 2026 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773072506; cv=none; b=jmELA0IqSsFFR+Ou8CF507FnIiDuokDzfOFVUJaAw49ZxZ/WExFobOvEo//4rymPJkQ/mz7+pVsi5EwZIcwuJnMPhmuqalAlWaSkALxnwKaIUiS6zBHcXJ0Pmnc3HyLgCCI16l8XAdFzekvZYI+Xt9Hke1HHpr9qzz1aVvJYaUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773072506; c=relaxed/simple;
	bh=62U8YXRiZgQpiNwrwA2Okks2rSNs57JcxN1NHZNMjRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ax1jHatbqKgu7waU82pe67cEuUdhPlt2d3h6W9IVwuFR9zSNIHI+dj47a4OeJMRmwX9+cvYvAL2yWeuW9sjumxdtWA22Tu38fZQ+Fq8NtednWndPTX3t6Cqo1p1bWPWJM+TsqK2PfNmtri1ANZjX5zfP9n5SgFTiMfkiVfwaPCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=EHzun8pr; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="EHzun8pr"
X-KPN-MessageId: 30f59f1c-1bd2-11f1-92a5-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 30f59f1c-1bd2-11f1-92a5-005056aba152;
	Mon, 09 Mar 2026 17:08:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=62U8YXRiZgQpiNwrwA2Okks2rSNs57JcxN1NHZNMjRM=;
	b=EHzun8prJlmqPoSeNWVez153SYV786WOB6VFOIErvjGEaY0fX7F/fXLFEJRUiHglMfIl2rF4qTO76
	 +LylrRizqZZ2R5bMRoTr70XXWuMdOOk5UkCSwUTzvyM3jGtcKBQXHpmBPPwrY76TsryzoYQ5UQyFQR
	 xpiq6jAN6WXCwTeI=
X-KPN-MID: 33|xhdZaFaxVK/ezJ4DtUQua80vRX1fN/HkZL+the7yOohs9ZD84tT/wd5ZHKQeXMM
 i/n56lenQSneIUHMfqqYsmxQX0JVo14gRKOpRf02R+4I=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|w+fF84QmEQimRBnQviadgjOd8DEjNvNfkGCplaTp3TszS+yTqZ9PyuRFFsIOTuc
 wUy+XO1bc3rWNG4FP6Wdxow==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 30dcd359-1bd2-11f1-8011-005056ab7447;
	Mon, 09 Mar 2026 17:08:20 +0100 (CET)
Message-ID: <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
Date: Mon, 9 Mar 2026 17:08:19 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: improvements to terminal-colors.d.5.adoc were undone
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
References: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FbLqfDu9Kh0J4pyYA7gHtaFd"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FbLqfDu9Kh0J4pyYA7gHtaFd
Content-Type: multipart/mixed; boundary="------------P0oOh5OdjOROJZU2sGL0zjbt";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Message-ID: <713c6323-e80e-47fc-9389-520b963a3129@telfort.nl>
Subject: improvements to terminal-colors.d.5.adoc were undone
References: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>
In-Reply-To: <cm7cun3pymf6quqcupreoegjj6ycwv3rvbap6ezpvfidvtt4lf@rq74bm7girgz>

--------------P0oOh5OdjOROJZU2sGL0zjbt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwOS0wMy0yMDI2IG9tIDExOjUxIHNjaHJlZWYgS2FyZWwgWmFrOg0KPj4gICBsaWIv
dGVybWluYWwtY29sb3JzLmQuNS5hZG9jIHwgMjQgKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
DQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMo
LSkNCj4gDQo+IEJvdGggcGF0Y2hlcyBoYXZlIGJlZW4gYXBwbGllZC4gVGhhbmsgeW91LCBh
bmQgc29ycnkgZm9yIHRoZSBkZWxheS4NCg0KVGhlIHNlY29uZCBwYXRjaCB3YXMgYXBwbGll
ZCBpbiBjb21taXQgMzI1MjE0MjUyMSwgYnV0IHRocmVlIGNvbW1pdHMNCmxhdGVyLCBtZXJn
ZSBjb21taXQgZDcwOGZjN2RiNiB1bmRvZXMgYWxsIHRoZSBpbXByb3ZlbWVudHMgSSBtYWRl
LiAgOi8NCg0KQWxzbywgdGhhdCBtZXJnZSBjb21taXQgc2F5cyB0aGF0IGl0IGp1c3QgcmVt
b3ZlcyB0aGUgYmFja3RpY2tzIGZyb20gYQ0KdGFibGUsIGJ1dCBpdCBhY3R1YWxseSBjaGFu
Z2VzIGJhY2sgdHdvIHNpbXBsZSBsaXN0cyB0byBsYXJnZSwgYnVsa3kNCnRhYmxlcy4gIEJl
Zm9yZSB0aGUgY29udmVyc2lvbiB0byBhZG9jLCB0aG9zZSB0YWJsZXMgd2VyZSBzaW1wbGUg
bGlzdHMuDQpBIHllYXIgYWdvLCBjb21taXQgYjNjM2Q4NjVlYiByZWR1Y2VkIHRoZSBidWxr
eSB0YWJsZXMgYmFjayB0byBzaW1wbGUNCmxpc3RzLiAgQ2FuIHdlIHBsZWFzZSBrZWVwIHRo
ZXNlIHNpbXBsZSBsaXN0cz8NCg0KSW4gb3RoZXIgd29yZHM6IHBsZWFzZSByZXZlcnQgY29t
bWl0IGY1ZDJjM2U0YjAuICBBbmQgcmVhcHBseSBjb21taXQNCjMyNTIxNDI1MjEuDQoNCg0K
QmVubm8NCg0K

--------------P0oOh5OdjOROJZU2sGL0zjbt--

--------------FbLqfDu9Kh0J4pyYA7gHtaFd
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmmu8HQFAwAAAAAACgkQUUu+Lrjhlh81
iA//TWfM+OddX4AMYcI70VGZjxmT3Seb43G0YYq3jFJb1+TrEW5wqoJmkwrFhuR6d6dyn9uwBdwQ
4HA/LhVzYdae4aXAOmq9ZlHJhLKK0Df/DGAWULVFIlb1r5z/N22Cr8OtaOquPCKT8MgfDkWYxfUz
7vF9JZgEWCoz1UM3xJFIVdhZjkYxzew6K8rZy/70Crwwvh/LpdUlTwXDf2BAyCIr+d97REmfHx+l
DKbgWGTbKycp/QrR0T5PK1BuI7yN0I53+ySFcb1pWBa+tcNQZmiCcwvjnxv5Gpi6C7PN0YqB5lSZ
0GnPpqdrGF7RhmEUoQMk+5buWrkrK3oTSZp2sZLmhl4yYF0+tLHH5QMnlozJ8kW7qynEVtXIUrxO
FFWpcAGzljKEUWxLYYwS6Zz6KPf2Tkiso3PiBAr52oub+1PHu7bcSuARW3Qmj0ZdmqrXESvOpTyn
j+1xE/j00tnGsmW5ajCrZgPeDynKLzzlqKp0bE0Y+yJ22GcOLfExTqBGxxwxXachO+m0m6fsuGIg
H0SCZwcZOKp0FvDWtjmX3cEChaIhsPXs+G55G1cJADp45+6ISy55lbhRHh8CuRAnGMQfui0hqgnc
24jEyjjylXNj90WZlPz5490kech79ykNsXyIPMESmrSGKTci7Y1AIl/inYzXzieInFDA+EvQcrt3
5HU=
=VXgY
-----END PGP SIGNATURE-----

--------------FbLqfDu9Kh0J4pyYA7gHtaFd--
