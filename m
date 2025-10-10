Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7F32C326B
	for <util-linux@vger.kernel.org>; Fri, 10 Oct 2025 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089283; cv=none; b=AMw5FKcVwaAS3mL2TpsvETE3Sa92GNQT2vr5yd+Rlc08bIOv1BPIx7mAEOT/Eim/zPJro4Q1PUmuvPinwB2T5iHV5B1fzPwegStYILP5p9whOpO522nTpMiJ8DKa5xlIEUQasWuJR4A6n8yJ6XxnS4ATeLQK6eEY2xExtC4+cu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089283; c=relaxed/simple;
	bh=dTjVAlh1H3vyCcq0SNso8y1ADsuxR5QgymOG9WbnzeI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=ZzAb/XsPvHieSS4lDuoot4wiHaF8yF8JCtxbAEXClxt/uYAF1AnYhorWP0G4sXRENXFZlGyBLm83rKpmW4/vrggRtgTv0a1rfWBRe1zO1rg/9PE2O2KM7bCzzdZJW1gsv9du579L6Jtg0k+D6686CQl+ffsU0v7fIEoGwLURUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=fDGDakdd; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="fDGDakdd"
X-KPN-MessageId: 45b42884-a5bd-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 45b42884-a5bd-11f0-bd6b-005056aba152;
	Fri, 10 Oct 2025 11:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=dTjVAlh1H3vyCcq0SNso8y1ADsuxR5QgymOG9WbnzeI=;
	b=fDGDakdda0lZVKjxXdViT8OWZvS+0iytCWOhAMScGS5bg0pq5wcaHjuuZX7mQ+rK1OfKPNXg71Gtf
	 vg4f6PAZdRy6HMgFV4Gk5UKoWLYR4KzaR7+e2F0fRHsvVUlaF+z2xG1rbGwOvVPbXh0dc6L4GHuCVC
	 NlmaVzHE1zYLbVPs=
X-KPN-MID: 33|pFyzbdbyoWyJExKlVYCtH8C4Wotm8EZrMiSChzOYxXOrczZGX/bhvyOl2y2zzQu
 QWrzI2/CNr8sLaTSrC7nmf4EnAuId3Vd+OnNJSeZaEjA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kbtQEUvfm9KTOjwhdUGA3Z77L3h+2Gq01Gq02fWqfV7WWN3H1/Fe5Y3yK+uMpzN
 6rr9422p/lQPkP204GwPXXw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 401981a6-a5bd-11f0-8003-005056ab7447;
	Fri, 10 Oct 2025 11:41:09 +0200 (CEST)
Message-ID: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
Date: Fri, 10 Oct 2025 11:41:08 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: `losetup --remove` is confusing, and misuse silently fails
To: Util-Linux <util-linux@vger.kernel.org>
Cc: wguanghao <wuguanghao3@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------LXm3UcK0YfyaHIgio0AMuRwr"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------LXm3UcK0YfyaHIgio0AMuRwr
Content-Type: multipart/mixed; boundary="------------MU4FBCxs0e44hffq0IOqFwfy";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Util-Linux <util-linux@vger.kernel.org>
Cc: wguanghao <wuguanghao3@huawei.com>
Message-ID: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
Subject: `losetup --remove` is confusing, and misuse silently fails

--------------MU4FBCxs0e44hffq0IOqFwfy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpBZnRlciBzZXR0aW5nIHVwIGEgbG9vcCBkZXZpY2Ugd2l0aDoNCg0KICAgIyAuL2xvc2V0
dXAgbG9vcDQgc29tZS5pbWcNCg0KSSB3YW50ZWQgdG8gc2VlIHdoYXQgaGFwcGVucyB3aGVu
IHRyeWluZyB0byAicmVtb3ZlIiBpdA0KKHNpbmNlIHRoZSBtYW4gcGFnZSBzYXlzIGl0IGlz
ICJub3QgcmVjb21tZW5kZWQiKToNCg0KICAgIyAuL2xvc2V0dXAgLVIgbG9vcDQNCg0KVGhl
cmUgaXMgbm8gZmVlZGJhY2ssIGJ1dCBpdCBmYWlsZWQ6DQoNCiAgICMgZWNobyAkPw0KICAg
MQ0KDQpXaGVuIGEgY29tbWFuZCBmYWlscywgc2hvdWxkbid0IGl0IHByaW50IGFuIGVycm9y
IG1lc3NhZ2U/DQoNCg0KVGhlbiBJIHRyaWVkIGRldGFjaGluZyBhbmQgcmVtb3ZpbmcgYXQg
dGhlIHNhbWUgdGltZToNCg0KICAgIyAuL2xvc2V0dXAgLVIgLWQgbG9vcDQNCg0KTm8gZmVl
ZGJhY2ssIGJ1dCBpdCBkaWRuJ3QgZG8gYW55dGhpbmc6DQoNCiAgICMgLi9sb3NldHVwIGxv
b3A0DQogICAvZGV2L2xvb3A0OiBbNjYzMDZdOjU5MzkyNzMgKC9ob21lL2Jlbi9Tb3VyY2Vz
L3V0aWwtbGludXgvc29tZS5pbWcpDQoNClRyeWluZyBhIGRpZmZlcmVudCBvcmRlciBvZiB0
aGUgb3B0aW9uczoNCg0KICAgIyAuL2xvc2V0dXAgLWQgLVIgbG9vcDQNCiAgIGxvc2V0dXA6
IC9kZXYvLVI6IGRldGFjaCBmYWlsZWQ6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkNCg0K
SHVoPyAgV2h5IGRvZXMgaXQgdHJ5IHRvIGludGVycHJldCBhbiBvcHRpb24gYXMgYSBsb29w
IGRldmljZSBuYW1lPw0KDQogICAjIC4vbG9zZXR1cCAtZCBsb29wNCAtUg0KICAgL2hvbWUv
YmVuL1NvdXJjZXMvdXRpbC1saW51eC8ubGlicy9sb3NldHVwOiBvcHRpb24gcmVxdWlyZXMg
YW4gYXJndW1lbnQgLS0gJ1InDQogICBUcnkgJ2xvc2V0dXAgLS1oZWxwJyBmb3IgbW9yZSBp
bmZvcm1hdGlvbi4NCg0KICAgIyAuL2xvc2V0dXAgLWQgbG9vcDQgLVIgbG9vcDQNCg0KT2gu
ICBTdXJwcmlzaW5nbHksIHRoaXMgbGFzdCBpbnZvY2F0aW9uIHdvcmtlZC4NCg0KICAgIyBs
cyAtbCAvZGV2L2xvb3A/IHwgZ3JlcCBsb29wNA0KICAgIyBsc2JsayAtYSB8IGdyZXAgbG9v
cDQNCg0KDQpIb3dldmVyLCB0aGUgbG9vcDQgZGV2aWNlIGlzIG5vdCByZWFsbHkgZ29uZSwg
YmVjYXVzZSBvbmUgY2FuIGF0dGFjaA0KYSBmaWxlIHRvIGl0IGFnYWluOg0KDQogICAjIC4v
bG9zZXR1cCAtLXNob3cgbG9vcDQgc29tZS5pbWcNCiAgIC9kZXYvbG9vcDQNCiAgICMgLi9s
b3NldHVwIC1hDQogICAvZGV2L2xvb3A0OiBbNjYzMDZdOjU5MzkyNzMgKC9ob21lL2Jlbi9T
b3VyY2VzL3V0aWwtbGludXgvc29tZS5pbWcpDQoNCldoZW4gdGhlIGRldmljZSBpcyByZWFs
bHkgZ29uZSwgYXR0YWNoaW5nIGRvZXNuJ3Qgd29yazoNCg0KICAgIyBybSAvZGV2L2xvb3Az
DQogICAjIC4vbG9zZXR1cCBsb29wMyBzb21lLmltZw0KICAgbG9zZXR1cDogL2Rldi9sb29w
MzogZmFpbGVkIHRvIHNldCB1cCBsb29wIGRldmljZTogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQ0KICAgbG9zZXR1cDogZGV2aWNlIG5vZGUgL2Rldi9sb29wMyAoNzozKSBpcyBsb3N0
LiBZb3UgbWF5IHVzZSBta25vZCgxKSB0byANCnJlY292ZXIgaXQuDQoNCkluIG15IG9waW5p
b24gLS1yZW1vdmUgaXMgbm90IGEgZ29vZCBuYW1lIGZvciB0aGUgb3B0aW9uLCBhcyBpdCBk
b2Vzbid0DQphY3R1YWxseSByZW1vdmUgYW55dGhpbmcuICBBbHNvLCBpdHMgbWVhbmluZyBp
cyB0b28gc2ltaWxhciB0byAiZGV0YWNoIjoNCndoZW4gdGhlIGNvbXB1dGVyIGFza3MgbWUg
dG8gIlJlbW92ZSB0aGUgVVNCIHN0aWNrIiwgSSBkZXRhY2ggdGhpcyBzdGljaw0KZnJvbSB0
aGUgVVNCIHBvcnQuDQoNCldoYXQgLS1yZW1vdmUgYWNjb21wbGlzaGVzIGlzIHRoYXQgaXQg
cHJldmVudHMgdGhlIHNwZWNpZmllZCBsb29wIGRldmljZQ0KZnJvbSBnZXR0aW5nIGxpc3Rl
ZC4gIFNvIGluIG15IG9waW5pb24gYSBiZXR0ZXIgbmFtZSBmb3IgdGhlIG9wdGlvbiB3b3Vs
ZA0KYmU6IC0tdW5saXN0Lg0KDQpCdXQgd2hhdCBpcyB0aGUgcHVycG9zZSBvZiAtLXVubGlz
dD8gIFdoeSB3b3VsZCBvbmUgd2FudCBpdD8gIFdoYXQgaGFybQ0KaXMgdGhlcmUgaW4gbGlz
dGluZyBlbXB0eSwgZmFsbG93IGxvb3AgZGV2aWNlcz8NCg0KICAgIyAuL2xzYmxrIC1hIHwg
Z3JlcCBsb29wDQogICBsb29wMCAgICAgICAgIDc6MCAgICAwICAgICAwQiAgMCBsb29wDQog
ICBsb29wMSAgICAgICAgIDc6MSAgICAwICAgICAwQiAgMCBsb29wDQogICBsb29wMiAgICAg
ICAgIDc6MiAgICAwICAgICAwQiAgMCBsb29wDQogICBsb29wMyAgICAgICAgIDc6MyAgICAw
ICAgICAwQiAgMCBsb29wDQogICBsb29wNCAgICAgICAgIDc6NCAgICAwICAgNDAwTSAgMCBs
b29wDQogICBsb29wNSAgICAgICAgIDc6NSAgICAwICAgICAwQiAgMCBsb29wDQogICBsb29w
NiAgICAgICAgIDc6NiAgICAwICAgICAwQiAgMCBsb29wDQogICBsb29wNyAgICAgICAgIDc6
NyAgICAwICAgICAwQiAgMCBsb29wDQoNCg0KQmVubm8NCg0K

--------------MU4FBCxs0e44hffq0IOqFwfy--

--------------LXm3UcK0YfyaHIgio0AMuRwr
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmjo1LUFAwAAAAAACgkQUUu+Lrjhlh84
sg//Y1f0LZLuwKeXn9dPxZLW8xKJRIAirMGcdRfEqjatTzqLoYmWiEdsoV2z+3zL9cVgy03plKTq
NHVgR5LuAMH79xsIvzfmjTXNqPJJyzB3VH58oy8ZLO00cB4B1SUpU76lvZqp+jdpu4W2BSsWdIS9
lpkutBZhwp7U3h0Cf3RUkh++n9hhDi03gEMOWHq9EwTptUUtka4/14DjsK8kJBRr7rIDwgfug0H6
Y5gEGonjtS/bm0FaA33aQ9A57njTdvzxOKsbiPSjWG3TtCWD4RjkOhuuRgcHSux9s76qHw2foju5
Wt/WAghfcJ0CsEMK84c2VDEHVsoU9y1ZKv5Pp0aTzJtRstz+EyhYeH0gag8b4Z2yKPwlOaJxdB2s
KzguWwNsZYJkT+sx2BgMLKD2zDwzsCVMsbQgrD6pVJ3pI9OuZI6N72KyxC90XhlGnVlTgm7bx/I4
930JLPmGfBU1y1nYC+EZlJjY5kUra16PTbWAHGZyS3bZSiOo11goC6rSmAFTWmt8ihsOjCSZPnOZ
IFFpbEAu8607Rs1dVmqNnvdVEAYGS5Pkg8RXNbn8WKnYVDBXh8NKduF5ss16/7tEijOifVLAyWS1
iNCEPwY63tLHlhP/M/Rc6fOzZYEbvOZq5OkbIV5eDEYLtRRsO4HgiW+i/7kknrUAnHUub3zisXnI
nXc=
=eyS4
-----END PGP SIGNATURE-----

--------------LXm3UcK0YfyaHIgio0AMuRwr--
