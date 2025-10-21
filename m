Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573223396E8
	for <util-linux@vger.kernel.org>; Tue, 21 Oct 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054619; cv=none; b=N1ypLMYRQg4zyxBngkTWM7fasbed2sUqYpGkgxKsz5JQr3OiRJSh4ZQX5gZxcWpm8z0ngkUEoX7CJY7bvVMltSsBxziEpCkpZ0K3EXdpgTPj09uirx0/MPfdX5+b1Z94f1b14M9Hl6tyrPF/tCJ9XOqEvbIiUdY0Dh1ePAoh1II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054619; c=relaxed/simple;
	bh=yVoiQoJScoOPbMNI1Mb1O9AlQN08xAxP6fbdsW66jHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqBK4XlJIg2ZvB+EJA0yluTqfr+4gn4lubGEviAcXVW67PpSV9Kx2B3iADVYT6/OhmWcU2CnDdGewJ3/Y8A4060vVaHxTFvBGdt9KaO332bIVfnxeMetscshuBvkurYG47QFZRbEfrnwPpO5QgsDB9j9Lu1yT+4uVxzDmmT2+y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gK9ozkdU; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gK9ozkdU"
X-KPN-MessageId: d5412fc3-ae84-11f0-bd6b-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d5412fc3-ae84-11f0-bd6b-005056aba152;
	Tue, 21 Oct 2025 15:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=yVoiQoJScoOPbMNI1Mb1O9AlQN08xAxP6fbdsW66jHY=;
	b=gK9ozkdUTnVd2/qnnd/9waazwICsf4rYWfAcCJBVkviEwkPKqZkQS75RnVJNMbls9LmMwa0gOPEgt
	 vPTszLN+78XDGAu0fdhDE9PMqwTmfFw+McTpXWnrfTTfgxwNdK6pIjTdOk8SgJSi9I5yGaUrAd16/6
	 1FJPE6bqgQ3F/4hw=
X-KPN-MID: 33|49Q9I6nvWFqjWXJj/dDWNYplFTgsPRrwBYdhBPWM0S9/1pr4Gth7wU60+R/mHj4
 kCshj+E+kc3Hf7GZciom1cxXPtvJc5yZCysDbnvhrwCc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XkSnerlb0fae+sI2brr0Hs85lGzMfxZobwUietCsuai4r/7vyT7aiiTMbcVco9U
 ZZ1+ZD+vERMx+7CCBfz6Kbw==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b4323396-ae84-11f0-bd9c-005056ab1411;
	Tue, 21 Oct 2025 15:49:03 +0200 (CEST)
Message-ID: <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
Date: Tue, 21 Oct 2025 15:49:01 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
Content-Language: en-US, nl-NL, es-ES
From: Benno Schulenberg <bensberg@telfort.nl>
In-Reply-To: <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------UMI4ogX8EXF0v6LYAYJFPe0t"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------UMI4ogX8EXF0v6LYAYJFPe0t
Content-Type: multipart/mixed; boundary="------------7GTkuCNl0rcCndfAg8s9Ruar";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>
Message-ID: <8c27aa14-495b-42f9-8ab6-6456daa1daa4@telfort.nl>
Subject: Re: `losetup --remove` is confusing, and misuse silently fails
References: <a5909aac-3f54-4fce-8785-410535dd4098@telfort.nl>
 <wog3s3sk34ewa6ulgspplk6fhb4hwd3nd55wse3gk2dsl6avyl@yqoq3miwfx5n>
 <f875b695-a682-4ab8-bfb5-95dd5d861236@telfort.nl>
 <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>
In-Reply-To: <ymw6pydao6vwwvav346losfnhvynbxapxxoiv77eoendsgnqa4@dcimzsl3szvn>

--------------7GTkuCNl0rcCndfAg8s9Ruar
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpPcCAyMS0xMC0yMDI1IG9tIDEyOjAwIHNjaHJlZWYgS2FyZWwgWmFrOg0KPiBCb3RoIGlz
c3VlcyBzaG91bGQgYmUgZml4ZWQgaW4gdGhlIGJyYW5jaC4gSSBoYXZlIGNoYW5nZWQgaG93
IGl0IHVzZXMNCj4gLS1kZXRhY2gsIC0tcmVtb3ZlLCBhbmQgLS1zZXQtY2FwYWNpdHkgdG8g
YXNzdW1lIHRoZSBkZXZpY2UgbmFtZQ0KPiBmb2xsb3dzIHRoZSBvcHRpb25zIHJhdGhlciB0
aGFuIHJlcXVpcmluZyBpdCBhcyBhbiBvcHRpb24ncyBhcmd1bWVudC4NCj4gDQo+IEl0IHJl
dHVybnMgdGhlIG11dHVhbGx5IGV4Y2x1c2l2ZSBjaGVjayB0byB0aGUgZ2FtZSBhbmQgYXZv
aWRzDQo+IGludGVycHJldGluZyBhbiBvcHRpb24gYXMgYSBkZXZpY2UgbmFtZS4NCg0KTmlj
ZS4gIFRoYW5rcy4NCg0KPiAgICMgLi9sb3NldHVwIC0tcmVtb3ZlIC0tZGV0YWNoIGxvb3Aw
DQo+ICAgbG9zZXR1cDogbXV0dWFsbHkgZXhjbHVzaXZlIGFyZ3VtZW50czogLS1kZXRhY2gt
YWxsIC0tYWxsIC0tc2V0LWNhcGFjaXR5IC0tZGV0YWNoIC0tZmluZCAtLWFzc29jaWF0ZWQg
LS1yZW1vdmUNCg0KTm5uLi4uICBNeSBuZXh0IHJlcG9ydCB3YXMgZ29pbmcgdG8gYmUgYWJv
dXQgdGhpcy4gIDopICBBYm91dCB0b28gdmVyYm9zZQ0KYW5kIHRoZXJlZm9yZSBjb25mdXNp
bmcgZmVlZGJhY2suICBUaGUgdXNlciBkaWQgbm90IHNwZWNpZnkgLS1kZXRhY2gtYWxsLA0K
bm9yIC0tYWxsLCBub3IgLS1zZXQtY2FwYWNpdHksIG5vciAtLWZpbmQsIG5vciAtLWFzc29j
aWF0ZWQuICBUaHVzIGl0IGlzDQpjb25mdXNpbmcgdG8gc2VlIHRoZW0gbWVudGlvbmVkIGlu
IHRoZSBlcnJvciBtZXNzYWdlLg0KDQpJdCB3b3VsZCBiZSBtdWNoIG5pY2VyIGlmIHRoZSBy
b3V0aW5lIHRoYXQgY2hlY2tzIGZvciBjb25mbGljdGluZyBvcHRpb25zDQp3b3VsZCBqdXN0
IHByaW50IHRoZSBmaXJzdCB0d28gaW5jb21wYXRpYmxlIG9uZXMgb2YgdGhlIG9wdGlvbnMg
dGhhdCB3ZXJlDQphY3R1YWxseSBnaXZlbi4gIEZvciBleGFtcGxlOg0KDQogICAjIC4vbG9z
ZXR1cCAtLXJlbW92ZSAtLWZpbmQgLS1hbGwNCiAgIGxvc2V0dXA6IG9wdGlvbnMgLS1yZW1v
dmUgYW5kIC0tZmluZCBjYW5ub3QgYmUgY29tYmluZWQNCg0KDQpCZW5ubw0KDQo=

--------------7GTkuCNl0rcCndfAg8s9Ruar--

--------------UMI4ogX8EXF0v6LYAYJFPe0t
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmj3j04FAwAAAAAACgkQUUu+Lrjhlh+4
Kw/+NZGCYd5B2qRF+sgEOgslfJP9P/AOPpPXVn0vuo2LzXmVC4FAi4tDQWZjBeKwW1S4iZ45SwBL
PtcyQ6oZSP9zO7XNgX201TjroPxNE/9B72sT2bXArKJMJkvw28AX7lVIGoCSFfADSOX5UQVSjWGL
5DkpBZBcvE7j8VHM3grB1nraVUNkMTgXhPoLBsjCYEwAJ3gQh07iC6ib/UEiI/N65kf/mi8cmp/O
d9DHCY0LO3omw6VFaYyQpv2TKbl1zTUq+nH/v+CnnBAxu2Fffuf7t3IuZUp/u3A+y1FTmsslDkYJ
LTQXepka27b+xKvHEuE+GPrGgYr39hzoBT85JhGUkCR7F9OvGWj9eRSOfuANrGvybzm6Kvv6srII
fKQLKQJ3s82BxhlvWFkzvp7LveK2ifV8jPlIjhfLTB5uosWx8aOb4NcSRd//BOgdz2DNn+gnd63A
CvUXbDUq5Ss+raEoPnmrE6mnn8jj0UMUSbJYf3i+NHo1JpbuKSe5yjpN8zxL+k9tW49YC80sd0n3
epk00FU4b2FCH+tTyEXmHqdJSpr5IFiqWfBTmXYz8A7UXP5W1u9WR1OMMhesFzXPVWLCbcJlIUn3
WfQNRU/4qK4k+AMDhLNzzDP4nWxwHqlwJW76P2sJitHY0KmVKLA40c2VypkG3GPa/MVX+IS+dyra
r10=
=rNGj
-----END PGP SIGNATURE-----

--------------UMI4ogX8EXF0v6LYAYJFPe0t--
