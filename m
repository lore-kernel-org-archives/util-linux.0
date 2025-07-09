Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701A1D516F
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752045157; cv=none; b=La+j9F62o3xKMR8Zm+WuXvE0INZf73YLfvPPDRSnVFlTTnYwmvX1fAMIXgKCWYVt71cSnenpDthmFrGyZbJlpXIzjajZa+DRIpR5MKs5+vY6Eq/POc8a0O7xWxLtsocYUYxQ/0Wa/lR5QLPEZ3g2vuj7wxGM6fVYLIH06V9kfcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752045157; c=relaxed/simple;
	bh=oPzRS9zUmqd5WbIDoadCn8n6bnw6gi44KjRHs0qF5ZE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tNudqwIfFURXI3WLsmEc2C8/kC8ifFVov/wamD8nWxl4WYdrgMAJv7ipPVmmLvzbjLTdCNdXl1zaLyN95senK5hA7boBhNEbeqQXg81ZMJADGpKRxAKTxQUKuFvss8kkHQBwcRVl0pR4g6YwGhlumgqr01WaLqVuEYKGcJikv68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=nOYTGvnL; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="nOYTGvnL"
X-KPN-MessageId: 50eeb341-5c94-11f0-b9a4-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 50eeb341-5c94-11f0-b9a4-005056abbe64;
	Wed, 09 Jul 2025 09:14:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:to:subject:from:mime-version:date:message-id;
	bh=oPzRS9zUmqd5WbIDoadCn8n6bnw6gi44KjRHs0qF5ZE=;
	b=nOYTGvnLuwA3W5ZDAZes0HlD7PovrLKGhWDDqalrYa7CFrk6KPmynoSlI9JDSBdZ91rMyI/Us+lFx
	 106ge+8/EYEOv9wr0lMDv+QPETu85NuUrnTrYUGVKtZpz4yM4gsoVsiKvqnUFySIfvqCOlz3XIuvzX
	 cDLA3yn0mWb7U6aE=
X-KPN-MID: 33|7rSon3NyTCNWwx223d4eYLKieWMD6hsGipVzg86oewTOkYJbIaWNF2M+le9V48P
 eBIHrlZ0gagvnq2gROo5xqvrIW3tWS/SPNZqDAZbGfhA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|T5MyAy2c7juSq7MrKUjX7aeYDi+pUsv6y6GzJwtTczKKnh5syuwjCXLcWtZ2PWf
 0A7+urEKoYp3RYmvjvCxroA==
Received: from [192.168.2.23] (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 10797ef9-5c94-11f0-95bb-005056abf0db;
	Wed, 09 Jul 2025 09:12:25 +0200 (CEST)
Message-ID: <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
Date: Wed, 9 Jul 2025 09:12:24 +0200
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Benno Schulenberg <bensberg@telfort.nl>
Subject: chrt from git segfaults
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
Content-Language: en-US, nl-NL, es-ES
Autocrypt: addr=bensberg@telfort.nl; keydata=
 xsFNBGNRHa4BEADxMujoSa2zyg1mTh2xxbhowLjDYWMEh68CvPNcKDx0tlEd30Aewp/OSdoK
 D8Yyv0EdsR+Rs+s9EkoQZx0odBJQLrtbP8+F3xpIqxWbON9VlDpLiMgjNmbYZ/I+LarG7PNN
 tNHbIMQb0jgHrdY4AJPmKCk1sPCNoDJ3uxuhdHhkAKT9Gd4C2jxx4hpLNAha1pwDSiogf8ae
 skjqiIDM65gp5G6vK4XqvUX3Z2kgyVxsuOphlm5JjJ8DE4Y8GU7c6WGKnkF65h/BWUgAgIYr
 gMSpb18h0CyDmN6nxSphJBlJwwda5R1MEEXjeTx46sYZHFyoA3FH2d+JydhPx7PYD+65jvWC
 OX+CUrRvopvyJ4EqImH953pu1suqkT2cRaKDc2/a4fAYt0cTKyB9wnuUQYM6yeke9D2D2/F6
 9hQrJO5kbB1M4W1T7LPfai9stz1hbtc4EIJ9q6F7qzHWuEK3dFXGqpKr5DOjTYSTXlHsPH/0
 nR81zVEUZDrc1Evoi9XOSuazgw+Rp1ThnuOO6NXTxSQiu4XpFOI0yLW0u0ZtuSLt7ac9QuKJ
 BDkdkzBoXgmcGoxOoMOh7Ta2VUIloHbdHpYlKqUF+L7R1+weVuSJDP1Gh2zHFJMPvBa16Qzz
 5BMsEtA2kX37LEqJWQ2x+Xy2LdJ5LC7JJp6Gme6g3lX/jtIWawARAQABzSdCZW5ubyBTY2h1
 bGVuYmVyZyA8YmVuc2JlcmdAdGVsZm9ydC5ubD7CwZQEEwEKAD4WIQQWjm9Cl7/Xp5r9RJZR
 S74uuOGWHwUCY1EeYAIbAwUJDYdhKQULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRBRS74u
 uOGWHw6wEADCrPgV7X89gGr0itbTvpaHrfhqmqP0L0vwETOMzsUop40jBwjuM/TWJyEQIqNy
 75EX+Ss5xJ4or3kUC26oveM4zBIYY3Ul7Zl6nkCWgIhyD/8gK7B8t3XHWAJct64Cb7wqWHUm
 +kCs+EGEtC7R50/D75p9WQqtX+r1UMSC+Znn1O1H4qn9JHaQVHUxm40wKNcJYC+ElCoHMt1D
 4daSVxxvsGQimHdjAEv114zxVkRUFlSXRV7oEXaRTaQlwHMsbziFd5VvUqmL5SSOzE8dt3nD
 LwK5YljkBKxCESuPPql69O7/r5GV8dWAlMRQx/tsDnyZQPNV8Mu7Sf2T12iVhcvtWD1NBLDM
 RF27gk29FRI5kLoloP4+oFO9IqKIgMcsClLrLTi0gk1UQgglpNBlIq9OO+5nm1bcfItZgoHm
 5s07bt78a+prw2PkllUOMiuw8LkdUBtzzqS9J4maoxRFnzTvTp2Lk2KBLf8fmlY7CU7BbMwD
 LBqPRR8ormf8FX/ANUKPL8J7E+vChafuY5H2O+ftFl7cawrCuejzFuvAdZVyge+CRb/qE80N
 RSfhpufH84TMwhDXuQY5MICpiDUe/fiZy7zYVtc21HAUwpwn6ciSVpu6/BFH5uPu62EcXQX5
 NZMHSSrnLq/Q41AjMUqQkkizPyjarCaGiLtqsgzHEO9UkM7BTQRjUR2uARAA0Vh3Q3cG/5WE
 40etL7MSkOKpKHgkDJBLUGFxGw7kh0gEG00wlcCzC7zbkl79NdstHT+wE3DAkczaDGyP1ODy
 tzov7k4lIUkh9vFep+cyoMKEWCm9edl8Xjswz7K3Vf0hRTWwPzFo9UQ3zQJ8cUlSCm3lpCmc
 H4CU2SHnHHfCMJ5GbnzfDEqLWZVz8qOF5M018uzpQDTXW2PXlqG9Qdz3e4ujq8QpUyn+0NWp
 U9Iq6RmR7TDTYFQiDVHG4KMG+G8CF5R7EhD3bwpRBb/yPGBu+S9pKh5DKWfUPGGwDeAdZvZ5
 NIPNr7Ptgs1BNYB5+0/bG7OLync2v+1k05qybNeL8Z3Gn5Uvhr8R7yi1WqG7yDlRPYL/9220
 BMv/THykh263AdZxJ/hErJJ0zGWd+MlSPeeN0uvU4tc9o1G1+sih4+VtyZizA/vf/kG2VNi1
 d0UfEMmoytHH1UOJxHYJmbDYh7seXpZHVpWFDn/TDtPgoxguhUaxSRXEQAhPVSBoV9SoEgSr
 5I8Y7cgwu9ql5aYw7NbzXiy0hlgy7tBeStolr0IJuBNMu3NnEZhJhFgjsWPMflydllVFT+0V
 oahKxS8IH7OGAV1LUeNMsK8itpr1EG4BX84FhOCdUHMZpV+ldWxiBof39t2RDYWX1i0yg2Pv
 1R+nqt+iFb2cZbQIkcj89ysAEQEAAcLBfAQYAQoAJhYhBBaOb0KXv9enmv1EllFLvi644ZYf
 BQJjUR2uAhsMBQkNh2EpAAoJEFFLvi644ZYf/mQQALa9HqcvhaH2R1ftxwI0CO/Uhem/NTLx
 1L8gwCLbAmyH+tSOm0ybFhocTmvmCcZmTyKXkOuujr0oaFx0jktwJvegHU0heMdeEE92c3vM
 TlR4tpFGx8E0XU3Mj4J+kaMvwCUeozi4ZC9Csh4V9W+pIyJGaGQlD6ZJpgrIH+R3qIdrO1hb
 ZeijmgbciT7FyX8ht9KTK898IdwQM09w3HNDvNKpbux2QsWEdFbezUBto2KZGek68oA7AQ8w
 DHmASp1ML6Jkl2JbyJz57Bazj+Fb47et2dHfF/3ISEwt+/9Q9U22aiT7JDFvdvChlezNFIVl
 rN89p1FO8LC6dSUaaoX7W3zRyydcxCNTpQv1HalwgEzxIsL+msaPyrO5NVn40EmNSSsE0GPg
 15BgyhM9yjizJhaU74dgQECWuSHKFj29uVyVS5Y2A1XbsPPqiB/yOFKq3kZBnT1sHX91k7EK
 K8dqxmXCIqkG9iMh/vId/gI6d9Ci57nY0FluIrbE/L9z1Gei2eMFsFmSvnW9fIc3NtKfnvQR
 BOXedCw0kmvyScJ6EZ3znoV0PFstgvmp4wSlnb2Dw74euRcBe5/wxX1VAHSYhqKWMnoe6snY
 nUQR9h5Wm7A5sq4D91+uMVHTr/1llbSDS+6J1tE6WNg5gpiULhOr0IoxlSTtUCDY2c49wqh8 50GA
In-Reply-To: <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------waJzXNZVDJIfXFaHWsiW4NrJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------waJzXNZVDJIfXFaHWsiW4NrJ
Content-Type: multipart/mixed; boundary="------------dYelsPkBHqUwVIRce0NYVwOY";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>, util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Message-ID: <42f6841b-973d-4e18-b91b-6ef98ef85b9d@telfort.nl>
Subject: chrt from git segfaults
References: <20250703144752.29971-1-bensberg@telfort.nl>
 <20250703144752.29971-3-bensberg@telfort.nl>
 <246a9986-6a79-46c5-9832-9cb9e30ba8ef@linux.ibm.com>
 <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>
In-Reply-To: <e118a2c7-4e25-4240-b585-5de0ddf16d59@telfort.nl>

--------------dYelsPkBHqUwVIRce0NYVwOY
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpIZWxsbyBWaW5lZXRoLA0KDQpKdXN0IGluIGNhc2UgeW91IG1pc3NlZCB0aGUgYnVnIHJl
cG9ydCBidXJpZWQgaW4gdGhlIHByZXZpb3VzIG1lc3NhZ2U6DQoNCj4gV2l0aCBjdXJyZW50
IGdpdCwgcnVubmluZyBgLi9jaHJ0IC0tb3RoZXIgbHNgIHNheXMgaGVyZToNCj4gDQo+ICDC
oCBTZWdtZW50YXRpZWZvdXQgKGdlaGV1Z2VuZHVtcCBnZW1hYWt0KQ0KPiANCj4gUnVubmlu
ZyB2YWxncmluZCBvbiBpdCBnaXZlczoNCj4gDQo+ICDCoCA9PTM4MzcwPT0gSW52YWxpZCBy
ZWFkIG9mIHNpemUgMQ0KPiAgwqAgPT0zODM3MD09wqDCoMKgIGJ5IDB4MTBDNkVCOiBtYWlu
IChjaHJ0LmM6NTc0KQ0KPiANCj4gUG9pbnRpbmcgdG86IGlmIChzdHJjbXAoYXJndlswXSwg
Ii0tIikgPT0gMCkNCg0KTXkgcGF0Y2ggd2lsbCBwcmV2ZW50IHRoYXQgY2FzZSBmcm9tIG9j
Y3VycmluZy4gIEJ1dCBpZiBpbnN0ZWFkIGl0DQpzaG91bGQgd29yaywgc29tZXRoaW5nIG5l
ZWRzIGZpeGluZy4NCg0KDQpCZW5ubw0K

--------------dYelsPkBHqUwVIRce0NYVwOY--

--------------waJzXNZVDJIfXFaHWsiW4NrJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEFo5vQpe/16ea/USWUUu+Lrjhlh8FAmhuFlgFAwAAAAAACgkQUUu+Lrjhlh/o
Rg/9G1n8x44xdMO1UsVT7Y+Yn+5GU2+XUV3tfJ2dBgBlTHQ3s9NWLmyn8QXqAuEq21hyhPa+xRqy
dsmKbV4fwx4bVw/VBsromRB0ZxxML2CeIixhChrP7u6Q9Cr5KBI4yyELE2+5xwdAixXk2KA1SAcq
xm0fzeeOCI05HhQNqo6eXTwTWz0zENlYLy1I3x0RHt+T5I4lRzo4TH+jNWxqZ4QLT9U704+c+90S
RyGL2Acd/ya2OaFwSLnKHXJTjGT7m+04uIZIz3WjUP5yxYxeyQcpG+H2cMLltM65lQ+j1eOIsL/M
FY3xnPD+QwIFs0CPz6x6LETsIiGMYjMB0ZUOW7EQeklBeFJ5cDRIFOz5xj6S3Fnhw3NYgymkd3hc
u3NfqvUf5y2uw2AsD3iqbrjFMNC+2pGq7/7r4tThx9yc9UWFw3oyivGXjR96+vMHnRyo0U/5dWQE
0u/AjxgtqDDLiikl5+ZnlTUeMgWXT6qcMEGqGNzHztaiGm2TwTrQgq+zs0x3RTHON0uBo8QsEYfL
PZSKmdQQg42DtdiufqawfPgR4nSZsu7slXzo/D0Yxj/nbZfIdOIdsBF5rYu7pbh0eEVVPlWV/7Mm
zvhcO12DYP11z4LACymeA+ludD4YOFBYmAJQeZAOjNPh4pBqsC54ksnPvnG0rDzfu6BFQf1J8vB6
I18=
=YDAU
-----END PGP SIGNATURE-----

--------------waJzXNZVDJIfXFaHWsiW4NrJ--
