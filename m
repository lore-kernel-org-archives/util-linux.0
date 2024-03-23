Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796B1A38C9
	for <util-linux@vger.kernel.org>; Sat, 23 Mar 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189482; cv=none; b=G0ZCChu3eMoBqb3LV9GZNNldU2KeLta3q6ZTgK0Ifa54HMIMNvJ+jFgnNjHJivmscWHaahbAFZnbpDjBxmdHH34C7f9E8H8O2kMi9xt1yVC92HfDbKo/CoLRscXo90ZMKkwDvF9SWF+0SqhySt6Kp3Ymoi0i0Gvkb6tCITPZtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189482; c=relaxed/simple;
	bh=ahTUDxAKGsVbeJmCiEBdmJXUUAcLGa+gE+NHVUF1AcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ix7aDLIEoWH8zfsAmJ4ZSy4d5ruklTt9SjIU3u68TLpq2wIwv8voNyyg84yg3riGIBTZRqYx5CPR9ZGHbUKcUf3xvjMrx14hOTBExO8u9UZ6UgEQ1TzFOuBWAttG/+LeKqn0cOorfDjmBuF90qE6REkyQGMOJRYHHpOPmi8dKrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de; spf=pass smtp.mailfrom=bernhard-voelker.de; dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b=RmC6O5vx; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b="RmC6O5vx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bernhard-voelker.de; s=s1-ionos; t=1711189457; x=1711794257;
	i=mail@bernhard-voelker.de;
	bh=ahTUDxAKGsVbeJmCiEBdmJXUUAcLGa+gE+NHVUF1AcE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RmC6O5vxU6SugE7OYwasWla3cR7jvmvhTW4XOV/CLA3Lp/K/Ye0Y/BLJ88M23wgL
	 yb/i8szgoHFocrqsyERfpEm/k6S3YPXhNAN22MX9XMR7g37r1CCXnIhzZjkwPxKe9
	 A2Y206gosaD2EXYYv6TmCaexmPA1lWvQS1qAjK9ox8UnerfuOxE0mr05TABCvEizv
	 +7gZuWLaxr3imEinW0YXPIgjGzDY9nBKvKIc8dT/foy5NHkhHYKTlznc1yVLhxJO0
	 E4BJvNeeFauwhDb7PIsAHhZ5gcLZajBzpVy3NaSw+8n7ax1kb3T52z37DeuI0Tx4R
	 demn8XOQ4M3+0pO6ug==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.101.10] ([91.49.76.118]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MTiDV-1rKZZc0Xan-00U3fc; Sat, 23 Mar 2024 11:24:17 +0100
Message-ID: <1429185f-f57c-4252-b6ec-4e60cd5d3341@bernhard-voelker.de>
Date: Sat, 23 Mar 2024 11:24:15 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Paul Eggert <eggert@cs.ucla.edu>, =?UTF-8?Q?P=C3=A1draig_Brady?=
 <P@draigBrady.com>
Cc: 69532@debbugs.gnu.org, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Petr Malat <oss@malat.biz>,
 Karel Zak <kzak@redhat.com>, Rob Landley <rob@landley.net>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
 <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
 <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
 <e1269c19-c2b9-45ac-b683-47a473326662@cs.ucla.edu>
 <d6530404-4fc7-40d0-be99-cb37426be32d@bernhard-voelker.de>
 <47c15dcf-3054-4a0a-9ca9-d9f7601db3ca@cs.ucla.edu>
From: Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <47c15dcf-3054-4a0a-9ca9-d9f7601db3ca@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NW4AqlCwMgkFEOpsctolvBYrDC2rv44Mswhr5dz6yJn1Rtmy2Ox
 wHT9y1aEa25MD91NFk4AtE2gG3D97k2UmdwoQlS4CYps3V59vJRYU9zetLqWguc2Z5tw7Yl
 vwS0R7Ortjh7bBMggmEMApSwhntqeWv+ulDC2CyL7gANH5IgUF+9A89Ug4dI8cMejIY+1iY
 GU/PK0h3nmnpvaH+DdUrw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:biAe6E+RSAs=;FmBBs0JS7ABF0XP6Dg/Vnq4bUz6
 io265J8cv1t9QZ59swhLezPZNfmauCdb1xpFV9L0h5Ot52cdcL86ziBTxtWfr3iUV/IRNS65N
 VNpiBMF8nE5RXNypCkVIhvJX0tOXlMLDJHswE2lOsaA+lR7k6/+/vyUhzwNqvOUB3HpPurd1M
 tLlhDIVN4xsQMoCTwRsMHLVQ02NOPp1Lk1H5UGWJX2CgbwxtO29pIJQdwEQWHcOCeA31dFgHr
 70nnoM0ADJv49XfApfg/mr/XRDh3fqCdzJQnL0We8MKjcGTAVP/+1Qpn0wmGkKToczXvbQ3C8
 cM+eJWRGVfAxgPuM8Uyj3b+jecpd7MhQMw7ex91n+y+AVXP8hz5sGtkUYsO31Acj2nAQqmI5h
 wdpW1J1DwerkWaAplLutiKnrnf34IMCpkAeiJk9h5e0suyDGFvAmymbMCesN2gfdxW6sQ5eVF
 9wz82pYTpS68YIJmsJU0zwJdneGcNsKxr6YAv+t1H7yH0w4FHqPdK8kyyM8PJEFzkU+Rw7AWi
 ZfqMypHP/XPiWONlbdBsFFzpIhyOiCnJqIHghcCuWhW6NrvoZf1xy1oLzSSft95U8G+audtmP
 MdQFiXV2WMjip1ZLAMSwqecNMNDEuJAfxYukT3sALxJlNIt4CtRAutENyxYwSpyAWY4k1mGI1
 Z4qJV7OttjyBr+ZAPv0+yNK8iFRLyVDZt43LO1o3E7/emtY6NZ6iwYJmt6PySb5yxx2cTTAtn
 gaJqNXSeE/pQuCG5E7MQG7gvsBtpYSq4b49Ratgb05gV50ibBl7VWE=

On 3/23/24 02:44, Paul Eggert wrote:
> I installed the attached patches to do the above. (Basically, the
> problem was that my earlier patches were too ambitious; these patches
> scale things back to avoid some optimizations so that mv --exchange is
> more like ordinary mv.)
>
> The first patch simplifies the code (and fixes a diagnostic to be more
> useful) without otherwise changing behavior; it's more of a refactoring.
> The second patch does the real work.

Thanks.

We should put adding more tests on our TODO list still.

Have a nice day,
Berny
