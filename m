Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481324400
	for <util-linux@vger.kernel.org>; Sun, 19 Apr 2026 14:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608996; cv=none; b=Nv/2MSik4U/h2pdK0c5x9qnqSOyrS4T+30H1Oh0j+sgs9PfWDn6I3oqcUXJi0vHIi/c3dTEiu0Aj15TEjkbXmwqa7xi4mXaxNT+an8WcrdNsuaCblafDQ4k/+yk9L47hSerXvbS1VIxUF+k79tIKBgTmLltjw/EXuyIf4Fcxpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608996; c=relaxed/simple;
	bh=nMVH49mh8OmRVVVH72ePfam4u14YKFHJoVaa8apcvEQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rP04PgQgXow9zWfIVSPJJeoD3iB8tYSWNQxaw/yFeP6mZgKDDDNJEM+5BbFQeDW/4F26y3UPTioEJyvFewQLqHk/WwtdqphrSTCLrvpe52h6D0+Ji2EBu3GdGH2u3eQ9//aYlV82I5yjs9R0mgU7xlzisl4pEj1ZppJtvicD5hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=tPUnYb84; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="tPUnYb84"
X-KPN-MessageId: 3622ab3a-3bfc-11f1-8a9c-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3622ab3a-3bfc-11f1-8a9c-005056ab378f;
	Sun, 19 Apr 2026 16:29:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=nMVH49mh8OmRVVVH72ePfam4u14YKFHJoVaa8apcvEQ=;
	b=tPUnYb84RFylZ1EIfSlNcuFEETCGaDvfv/cwYgwOe6xlNuILadDBIoPyrs1zIDoko5xGub966qJBd
	 27FmQccMZwyWzxvFT3aAmhf023nfAw8k2iip/ZUaq42WCM4ub+ZowDLHmOUVJiEn/Ide0MEEWxwgYx
	 M6jZKgdLtv3Ih28k=
X-KPN-MID: 33|2uEyGtoNA0irFMc73pvsUn1DLvlJPKimBnbofXaslT/4ByojvCN1/u0FxWbfQmY
 366V7CRxjk+NwWikjjYFeaFhs1yeljaFAAs2YxcDYfHQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|dSRCm+Ydoc6KI2suTgZWovaRqaw69vdIu1iDGtKyplFVjw5x1ESRz/RSNPTfpl3
 kdGTMvQFLCA8EO+hj1vWJnw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3602f1ef-3bfc-11f1-8011-005056ab7447;
	Sun, 19 Apr 2026 16:29:45 +0200 (CEST)
Message-ID: <b0015454-813c-42fd-bba9-733e07efe19e@telfort.nl>
Date: Sun, 19 Apr 2026 16:29:44 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: Re: the bad effect of tables on msgids
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
References: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
 <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
 <dseehzodgm5vt2bmqewjf5oilq2vgfjno3ty6svabzf5q5ulo7@obi2pce56mfh>
Content-Language: en-US, nl-NL, es-ES
In-Reply-To: <dseehzodgm5vt2bmqewjf5oilq2vgfjno3ty6svabzf5q5ulo7@obi2pce56mfh>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oq70zORdVCH2RZGt9KOnR0tb"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oq70zORdVCH2RZGt9KOnR0tb
Content-Type: multipart/mixed; boundary="------------GOSl5kS4uDMkp1lSQoas6BjL";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>,
 =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Message-ID: <b0015454-813c-42fd-bba9-733e07efe19e@telfort.nl>
Subject: Re: the bad effect of tables on msgids
References: <a6d150cf-b653-453f-a3a4-d6750cf9f04e@telfort.nl>
 <8de6593e-f696-4b6a-a431-a09dccc4263a@telfort.nl>
 <dseehzodgm5vt2bmqewjf5oilq2vgfjno3ty6svabzf5q5ulo7@obi2pce56mfh>
In-Reply-To: <dseehzodgm5vt2bmqewjf5oilq2vgfjno3ty6svabzf5q5ulo7@obi2pce56mfh>

--------------GOSl5kS4uDMkp1lSQoas6BjL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAwOC0wNC0yMDI2IG9tIDEwOjM4IHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBJIGhhdmUg
bm8gc3Ryb25nIG9waW5pb24gYWJvdXQgaXQuIEZvciBtZSwgYXMgYSB1c2VyLCBpdCBpcyBp
bXBvcnRhbnQNCj4gdG8gaGF2ZSBkYXRhIGluIG1hbiBwYWdlcyBzdHJ1Y3R1cmVkIGFuZCBl
YXN5IHRvIG5hdmlnYXRlIHdpdGhvdXQNCj4gcmVhZGluZyBsYXJnZSBwYXJhZ3JhcGhzLg0K
DQpBcyBzYWlkOiBzaW1wbGUgbGlzdCBhcmUgbGVzcyB0aGFuIHRocmVlIHRpbWVzIHRoZSBz
aXplIG9mIHRhYmxlcywNCm1ha2luZyB0aGVtIGVhc2llciB0byBuYXZpZ2F0ZS4gIEFuZCB0
aGUgbGlzdHMgYXJlIG5pY2VseSBpbmRlbnRlZCwNCndoZXJlYXMgdGFibGVzIGFyZSBmbHVz
aCB3aXRoIHRoZSBsZWZ0IG1hcmdpbixsZWF2aW5nIGEgYmlnIHVnbHktDQpsb29raW5nIGVt
cHR5IHNwYWNlIG9uIHRoZSByaWdodC4NCg0KPiBJZiB5b3Ugc2VlIGEgd2F5IHRvIG1ha2Ug
dGhpbmdzIHVzYWJsZSBmb3Igb3RoZXJzIHdpdGggYSBsaXN0LCBnbyBhaGVhZC4NCg0KV2hl
biBJIGRvOg0KDQogICBnaXQgY2hlY2tvdXQgdjIuNDINCiAgIG1ha2UgZGlzdGNsZWFuDQog
ICAuL2F1dG9nZW4uc2gNCiAgIC4vY29uZmlndXJlDQogICBtYWtlIGdlbi1wb21hbi1kaXN0
DQogICBnaXQgZGlmZiBwby1tYW4vdXRpbC1saW51eC1tYW4ucG90DQoNCnRoZW4gSSBnZXQg
ZGlmZmVyZW5jZXM6IGFkZGVkICIjLCBuby13cmFwIiB0YWdzIGFuZCBhZGRlZCBuZXdsaW5l
cyAoXG4pDQooc2VlIGJlbG93KSwgYm90aCB3aXRoIGdldHRleHQtMC4yMSBhbmQgd2l0aCBn
ZXR0ZXh0LTEuMC4gIFRoYXQgcHJvYmFibHkNCmV4cGxhaW5zIHdoeSBhIHNpbXBsZSBsaXN0
ICh0aGF0IGlzOiBhICJkZWxpbWl0ZWQgYmxvY2siKSBsb29rcyBnb29kIGZvcg0KbWUgaW4g
dGhlIG5ld2x5IGdlbmVyYXRlZCBQT1QgZmlsZSwgYnV0IGVuZHMgdXAgYSBtZXNzeSBsb25n
IHN0cmluZyBpbg0KdGhlIGRpc3RyaWJ1dGVkIHV0aWwtbGludXgtbWFuLnBvdC4NCg0KV2hh
dCBpcyBpdCB0aGUgdXRpbC1saW51eCBidWlsZCBlbnZpcm9ubWVudCB0aGF0IHByZXZlbnRz
IHRoZXNlDQoibm8td3JhcCIgdGFncyBhbmQgdGhlIGV4dHJhIG5ld2xpbmVzIHRoYXQgYXJl
IGluIG15IGJ1aWxkPw0KDQoNCkBAIC00NjEsNyArNDYzLDggQEAgbXNnc3RyICIiDQoNCiAg
Iy4gdHlwZTogUGxhaW4gdGV4dA0KICAjOiAuLi9kaXNrLXV0aWxzL2FkZHBhcnQuOC5hZG9j
OjI0DQotbXNnaWQgIiphZGRwYXJ0KiBfZGV2aWNlIHBhcnRpdGlvbiBzdGFydCBsZW5ndGhf
Ig0KKyMsIG5vLXdyYXANCittc2dpZCAiKmFkZHBhcnQqIF9kZXZpY2UgcGFydGl0aW9uIHN0
YXJ0IGxlbmd0aF9cbiINCiAgbXNnc3RyICIiDQoNCiAgIy4gdHlwZTogVGl0bGUgPT0NCkBA
IC01NTIsMTAgKzU1NSwxMSBAQCBtc2dzdHIgIiINCg0KICAjLiB0eXBlOiBQbGFpbiB0ZXh0
DQogICM6IC4uL2Rpc2stdXRpbHMvYWRkcGFydC44LmFkb2M6MjgNCisjLCBuby13cmFwDQog
IG1zZ2lkICIiDQogICIqYWRkcGFydCogdGVsbHMgdGhlIExpbnV4IGtlcm5lbCBhYm91dCB0
aGUgZXhpc3RlbmNlIG9mIHRoZSBzcGVjaWZpZWQgIg0KICAicGFydGl0aW9uLiBUaGUgY29t
bWFuZCBpcyBhIHNpbXBsZSB3cmFwcGVyIGFyb3VuZCB0aGUgXCJhZGQgcGFydGl0aW9uXCIg
Ig0KLSJpb2N0bC4iDQorImlvY3RsLlxuIg0KICBtc2dzdHIgIiINCg0KICAjLiB0eXBlOiBQ
bGFpbiB0ZXh0DQpAQCAtNjk1LDcgKzY5OSwxMyBAQCBtc2dzdHIgIiINCg0KICAjLiB0eXBl
OiBQbGFpbiB0ZXh0DQogICM6IC4uL2Rpc2stdXRpbHMvYWRkcGFydC44LmFkb2M6NTQNCi1t
c2dpZCAiKmRlbHBhcnQqKDgpLCAqZmRpc2sqKDgpLCAqcGFydGVkKig4KSwgKnBhcnRwcm9i
ZSooOCksICpwYXJ0eCooOCkiDQorIywgbm8td3JhcA0KK21zZ2lkICIiDQorIipkZWxwYXJ0
Kig4KSxcbiINCisiKmZkaXNrKig4KSxcbiINCisiKnBhcnRlZCooOCksXG4iDQorIipwYXJ0
cHJvYmUqKDgpLFxuIg0KKyIqcGFydHgqKDgpXG4iDQogIG1zZ3N0ciAiIg0KDQoNCkJlbm5v
DQo=

--------------GOSl5kS4uDMkp1lSQoas6BjL--

--------------oq70zORdVCH2RZGt9KOnR0tb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmnk5tgFAwAAAAAACgkQUUu+Lrjhlh9E
VA/9GHj6SU7z/QFqoj1ZsvWiwpKmV9f60eUjimGL+ReYnzM+c9q6hjxDsrgLuLjMQ/brBxhQVmFy
ZpXlqHBqkQX8rPF7I6klq3HBdsgXzrjb/pc+GUUkENb+yAvKMhuwxgJVrSrIMMZmmlTevZwo+5iE
Wq1ba1ucFVAQwWpUnfIOCr+qEDQlHtxOmrvp8bUl/Jw1bgzQdskSFHoOMR9XbMMdXCUW3X2hS0xD
nZDrce/14fX02E2DuKlxi6/+gXv+etya23M43/LWdnTUaWo2BTCNvuqicSeNC6MaLvjeYwIjs6kG
X/Jnb2gKa0iTWahf9o9OU2+XZrOMbqYGrN0lzwhzY87Aq59okALPnJCakoEzBM64vSc3OhsACSsy
5gdFGcAPavS3+7XN/Py+RCTs2rJ4LSK13as0zwcvC05Cazxistf87L8AQoBROJRGGFdyYCPDy8Cl
YHY7f5pLqmYwtC76Wx7xmp8RMG076xOwGAogqjcyw2avWQBjI51jZcRoc0+d6px42HKHTtuBvppe
uKNbQYICfbIkbSd1O9iqFUEl1tPK/mKbdx0FpAfZjsLLhR2l9fpjlrLd3isdu3trXK+ZCe5gM+3w
eCHw3Q7/JRY/wHzFbB1XModtO1dIVFwqanJMpUBl7bdojLtm9I+xml34m5R7Ejm52qviKp95BpRm
seM=
=M3Aw
-----END PGP SIGNATURE-----

--------------oq70zORdVCH2RZGt9KOnR0tb--
