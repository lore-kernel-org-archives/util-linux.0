Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2070.outbound.protection.outlook.com [40.92.18.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F94221FDE
	for <util-linux@vger.kernel.org>; Thu, 24 Apr 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745494103; cv=fail; b=h5FEL4e8BMik5b6b1jlXaeAr4+W7fNp7KaDHu3l7+GApqKe9QqeN1kXX5AbeSrAACuDHyPAZueZjnsIZTSWXYpqvC6waZItDi+u8iyLpQCRbaF+YsoNAM4G4h6DIu7O+iVsoQG8fEgFbssDGKDry49mBwOcahPBuY0b6MeDOYs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745494103; c=relaxed/simple;
	bh=ymJ3kBPWxYaCQg+1SoBOotg6b13Mit/UUzfI/5kIGbE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BZWbjaj6bKJY5Hvnj49RvCh5kS3C0Hv/g3ArgCD7sTBkMrs7Iesg80Xkw8scmdEA3+Qj7IF/T1rCJV5HjwPV3I/R7dRVgsuI9/D/zcl/5DkKMeIZJbKYiSRp1gmPtp2K7J6thHy9Z4T11Ld8NGZxPPDr3LFxboB+ZW8xMq+pDoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fJJVU25h; arc=fail smtp.client-ip=40.92.18.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fJJVU25h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T2wijxxfRXejHm4eC+h9pZlO1rFiK/woHf3GCR77HYXUWrLuy+J2QS1e6NnQh/Ldfqh+2XSpCqGEb0MTtvVzq7qj8jdJnCIJ9QG9GYAADoGe+j38gec2n7fCr1TUGfZ9AMCukbu9o0h9T/p7d7fIkVTWrmQIOdkxIDopnhz630W8Verat7pB3juo58p4iDKklZsTFJYmVjlWpDtsdQ9EbZCwYZGUZAn4eYwTtAsp60+cWmufudeM2mQXYhjqP4H4g8hg+jd7yad0HGJIalbADGdVrHniUXExkm1hDktszft+os8ZRgK4UHZpn/HspD1AsBuZTA11awG/Zt7StFEoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sx03nZ0QG1NHcySslQ5qaGrxWEBNfXkZSkDxMvmd2Ao=;
 b=cyBqvQ4V9Gmgzysd76tpaz+bYkV4/RLfp75B5jbFPYRGipRRi8LAcLRNpKrX9LdNwue7Y/ISUYk4C4yj0FIz81WgXv+esFGPskAxeA1VkLgvCZ7zClD20HTIlQNYNp/lJz66c13iFOX2w1weogX9sVtBVIiVKKNMQPJ9k3vJ68tRM/30AoIS1E0O7xUnue+s69+RaS1nWA+uqnBhzXMWgHXOgVEllMgtRUJrmVIeu1L+f5hY3Wi6ugqOPo+AhIoXEptZmtjCh+GZS29hE74Z3NwC80hD/ZkpXg3otggU2iCqsMHTZN6vwm8y/s6B8BScJo7DG+roxR5b00hIdiWMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sx03nZ0QG1NHcySslQ5qaGrxWEBNfXkZSkDxMvmd2Ao=;
 b=fJJVU25hiivqchnKyMvecVUmilWCLbnHjuAkfBfll1w1BcxDOn+hnPmvcKTNwlB3ZdyS2P88Oz+0pb2ZVF+hsOpWAHu2LTqJYSSbsiVQUsHXOqKoxBqxmS9uAtL1x+EyE2eljH9jarQR1yxlVtZQncN0OgobAzKSXCO928oyIRZ8cMTjxG+DWU6bg3RxqH1H6Vuyx/pfyJS1tyFNhmoMgei7DhHWWt0n4h6WneKcg+dMQiwVvMVxjci/fggVB5xG61VYW8W50bS2Ty8RFBvmNRcMZJCCd+7pczdBeR7aRAVDqr8lXxYrcpsHEZmgCnhiOXqrPeSEQB6seO1mryhmIw==
Received: from MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:4a4::15)
 by IA4P221MB1772.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:566::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.21; Thu, 24 Apr
 2025 11:28:19 +0000
Received: from MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM
 ([fe80::2285:cf14:2622:95c]) by MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM
 ([fe80::2285:cf14:2622:95c%6]) with mapi id 15.20.8699.010; Thu, 24 Apr 2025
 11:28:19 +0000
From: Nathan Sharp <nwsharp@live.com>
To: Benno Schulenberg <bensberg@telfort.nl>, "util-linux@vger.kernel.org"
	<util-linux@vger.kernel.org>
Subject: Re: [PATCH 6/7] pipesz: report default size in --help, instead of
 referring the user
Thread-Topic: [PATCH 6/7] pipesz: report default size in --help, instead of
 referring the user
Thread-Index: AQHbtPvwyKKbuESYEEmxDyT5AiIF+bOyrTIu
Date: Thu, 24 Apr 2025 11:28:19 +0000
Message-ID:
 <MN0P221MB153040E15108F790D57E9698C2852@MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM>
References: <20250424093237.6432-1-bensberg@telfort.nl>
 <20250424093237.6432-6-bensberg@telfort.nl>
In-Reply-To: <20250424093237.6432-6-bensberg@telfort.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0P221MB1530:EE_|IA4P221MB1772:EE_
x-ms-office365-filtering-correlation-id: 82b49174-991f-4386-ac9f-08dd83231d24
x-ms-exchange-slblob-mailprops:
 gMiuAN0LASI7fc4EPd4bfKCsouzBTQ7Xk+WWcwMcXnjVdUQG41Jy2oeyMQmhSgqdiKXMmJZwHFyH4NL2ipIcc4mb8whsECuVoC9gWh7bCeR7xh4fjs+CiupzGXW9DeKJT+hR8eCasYkb1odg6bPbrrcZTe/0fqcVqIVBvUYapHXaehEBEdpDMC/LCVTdHV+/1s7zsMRzYhnse7fCPMsL8Tb8XhzQb0J1/Ckwc59Ny57GXrI8GdSTFCPWb4BzGKRcEtHgpyUzlMr4F/r1MJp3oVmBeveeAcZdnpCLZ3Fce4op6te7/KIq7rAspb9OQUf4afP3NYisVh0k/pC8Xr/cl7givBg58aTUEUyioP7bVOnX6f4sS3IWOFyczS619A013p+fp/PyU+e3QFqrWtmM3GC74dcgXMc5p1lj4APp9qw9UWCdSE0ozorBM5jM3ggRxUbkTirpdIewHasAxwrVq+SFNKEhN0t0uNjwW0yTLmh83dOpovDgsEr40TvGBlZ0yDLQFHXnnCL3vuwPPQHFJvPzrup+OIstn757LdKQK/x4ecqCs7rdznnJS3J8vvYMAUqEtr3/Nhu3KUev6JKqZSxCO19VvS2cp2UA5+4ZAyDBZJxtGuJfrwwrZLH9cGEZJkFlwGxk9W3hT3ybMqvuCaqD/rvXuCENf1OXUacKlzbRanxn43RPOO80EFeoTlMkdjndYCEHqplUa0P9ketZyA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15030799003|8060799006|7092599003|19110799003|15080799006|8062599003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pLuMihoKhLqeeTATjNheWQH0LKevVa0B8pTVmErGJEhdihcsZAXffNwtX3?=
 =?iso-8859-1?Q?EYrr59ESy6SvOG6iPcvYTPEyxfBoxrXBZk11BMOS86RaJ71jqntIMbSVNJ?=
 =?iso-8859-1?Q?vcTjiZvN7GK9bMt+bIj8EOG9QMJ7J/h3KtPEgQQuhu6hF5Ei8J5SYliGtK?=
 =?iso-8859-1?Q?BQAoekAMW0hxnC8mzbIKvC+3+NrK53kvbxnSrT9D31I5V6mJKzFwtEya1K?=
 =?iso-8859-1?Q?K+9Jn7gze/58bFfKrgEhLcPlBHJBH6+WJsgpoKqWtjeNefrKqJ5DGvrZS9?=
 =?iso-8859-1?Q?JFpv56bdc4n4DvZm06qlIrV1h4zBEvVxB1x+0roWpxv1kwphPQQ0udlxV4?=
 =?iso-8859-1?Q?yoR5xnzbfc+bxtyFMH1oDyZuucvv6lnrPOHvsYmaMYHwu/q1PoZfStwE6/?=
 =?iso-8859-1?Q?0l5nmzG3AokqvOyu1vZ78ghv7CUfppXlkoJOhDNcexFyw6myyph58bgxcQ?=
 =?iso-8859-1?Q?R0qpLVWO5dgTYUIOiAtEYAN9Y5b7Hc+M4HJ95MaFifPWUPQwTsumDLQ7Bc?=
 =?iso-8859-1?Q?HBib94N5RsFskGJ5naIr/803KB4H3nYF0lgcBX1qo9wboNG+Sezc77mjO2?=
 =?iso-8859-1?Q?+u1Egh6yqz6Wbu5cFqbHIa/R+fSGgsVABLx4iDYwe+s7j1H/w7HxXon1RW?=
 =?iso-8859-1?Q?lBn92S+0ZQejmn7r2No1w1rf0iFC+k6ef+sRk4mWzwUtNiPP2N83XoWqQw?=
 =?iso-8859-1?Q?BRxjjMK+MtgNOkzYyL330Sb1dUpkuuNIOxcGZRk0OehDPr9crkvjkKz1AW?=
 =?iso-8859-1?Q?V9zqZuTMjpVJlnYtO6cE0pZ7vQHYRRWFYem2eloFJ4NqFQh3SYtFCWEUIl?=
 =?iso-8859-1?Q?rhP8PQzEM2MYJmGNC9IJ21mGS2YSTbk0jmI/752vZ3U4RdMf9L695ojr5x?=
 =?iso-8859-1?Q?zjOBFb2nUZ20z7jqCbz4hnUUcgl2ws5c855MRWGe3VhrM4qFXjUk76OEWk?=
 =?iso-8859-1?Q?xHJU6nfZBzGq7d7P6pTq8FhgHr0082+SiBn/6v3MEbu/TPyQxmGKRj2f9y?=
 =?iso-8859-1?Q?mWnMArMJE8PHittmLa+asT/HEjZvZcFovfZPjd+7eUs2mIhDQiIzRfvj2d?=
 =?iso-8859-1?Q?iGI2x4TWlh42wsfgi0P2wNN9ZCHvptR3Ogdbb6K3W48EG2TpO6IyfzjLYA?=
 =?iso-8859-1?Q?QDNvg0QN61LUHAEzQTmwYMEe9co0XgELjRZTl1i0rB3GOKvrhsycSDCCml?=
 =?iso-8859-1?Q?+5E9/Rk5mfNCeQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?D5pdC0N0sVQKNCO9uuguYZzczyo5qSXtIggnVq/j44was1U2QDNo16iwqP?=
 =?iso-8859-1?Q?WEN7a6DvJL9Dd0ZJNbxfqW4xThbN+W1pxAjUqD4crNxagRXPf5kgKZGcFX?=
 =?iso-8859-1?Q?DSPQbFvmFVocfVdhm8KP2XybUmEym+dNy54JMZLoCipAwAzF+CWLdUqcFT?=
 =?iso-8859-1?Q?SbOGGFuBRS9t2Eo/7OoJBY9KqpwYORYlyRpvvwL0P56NY4Ob1rdPnjrieB?=
 =?iso-8859-1?Q?jjyCYvH/RdHg9kYsIittCoY9fLeiPCtlS0+ys98k6R8Bixizoe50B+LIo7?=
 =?iso-8859-1?Q?zP4BsHZy3fMj5oLoqbAL5Lbs6kx0CzBxzwvvyoYDcPX9VuZPZCbVf6lU4Q?=
 =?iso-8859-1?Q?IT4VDs04txnpVkMQ/FzGINDL6rj+cWDfrNbnSP03FmcBXvQLbjICjwQ0EG?=
 =?iso-8859-1?Q?KesbdVco6f+Sc5+WGi7SbciX+mEvSA5GaVDlcJ0G6qPx9Qslr+qxtpIW+b?=
 =?iso-8859-1?Q?xjudizorjglfCOLGhiBaAkrlNdmA5JO4kqc0bGBWcJ1N0tDYrA/SrJAxxi?=
 =?iso-8859-1?Q?Q5inbMFUfNO6VV5EtUCb1SmkNZJlPoIX77nykSCPHtvAp+gYvX/8mvEhsH?=
 =?iso-8859-1?Q?h19CtX1oBKY5dJVxKTbxt8HFwPWEKPZnsQ3HhvZEEjE/YfSYcW4G/k+wII?=
 =?iso-8859-1?Q?yvDsc9IR34a72JwSxmsQwEyUvXZyL5Uxh7GNlPR976KT/Q3yWT2qeLCqSE?=
 =?iso-8859-1?Q?TojJLC8UBJ4Vx/G/OlhNVialH+nb7/HI4yxJtQlPVWGs7C25IjfYWKIp8H?=
 =?iso-8859-1?Q?M2RuYIrOYwCq1gLHkg92DTHP/EbehkYgOG/v3MPxYHZw/hnNEXfn5sArWC?=
 =?iso-8859-1?Q?j19/le+G2iLhiXmzXAuJDKlvQwpmzNpVxSRwDG+xIaNYhnFaxJNuRqQfWp?=
 =?iso-8859-1?Q?JfZ1b8Jy/XMrCA3OqkRaTsQPIr5tXdsO2/XNOJPybKuG/fQ4vS3osV0Wo5?=
 =?iso-8859-1?Q?w5jxl7Rf6pe4LW8s+5wIbokiJ7sois/730ehSMbi46WGXuBzZbeF6y+6f4?=
 =?iso-8859-1?Q?53mpLnx5EmCBy7PvEMM05vBApf6DYI5N6DVTswNHEkLcYc35JVxbd3o10D?=
 =?iso-8859-1?Q?PF5ZEr2nJjj4vcM1MgRCHPL6GtEiCr9Bs12ScBqj9P5NM0GSOetqoGS2aj?=
 =?iso-8859-1?Q?xe0gbmOsdXnfd7ubYgyLKnhHzb2UwbT/t4w4GGurBKUMefrQFXRy36knoP?=
 =?iso-8859-1?Q?VCk7k7s2LBWwUFrJ3MLO1SJ5nBWQ31Sl2oSlJ/VlFZJnijGdPctdOYrn0u?=
 =?iso-8859-1?Q?OyPpQf+gZQr2oDqhPjCQPgKsEyM5Huvq6SkQP4wKsvBAsytQTZ22L7j2e9?=
 =?iso-8859-1?Q?eh0DHthCmIwudXDnfKKJk8fpcQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7762-17-msonline-outlook-7d150.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0P221MB1530.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b49174-991f-4386-ac9f-08dd83231d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 11:28:19.2153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4P221MB1772

Hello Benno Schulenberg,=0A=
=0A=
    I do not think that this change is a good idea, especially in this loca=
tion. If it is to be done at all, it MUST be done inside the usage() functi=
on; so that it is unlikely that future changes will introduce a read of an =
uninitialized global variable.=0A=
 =0A=
    However, I do not think this is a good idea in isolation, as it deprive=
s the user of the knowledge of where the default size comes from, and addit=
ionally could cause the help message to print a warning! A path forwards th=
at I would support is to keep the existing text but include the value read =
from the file as a parenthetical, if and only if the parse was successful.=
=0A=
=0A=
    Kind regards,=0A=
=A0=A0=A0=A0    Nathan Sharp=0A=
=A0=A0=A0=A0=A0=A0=A0 Principal Consultant=0A=
=A0=A0=A0=A0=A0=A0=A0 Scherpzinnige Oplossingen, B.V.=0A=
=0A=
________________________________________=0A=
From:=A0Benno Schulenberg <bensberg@telfort.nl>=0A=
Sent:=A0Thursday, April 24, 2025 11:32 AM=0A=
To:=A0util-linux@vger.kernel.org <util-linux@vger.kernel.org>=0A=
Cc:=A0Nathan Sharp <nwsharp@live.com>=0A=
Subject:=A0[PATCH 6/7] pipesz: report default size in --help, instead of re=
ferring the user=0A=
=A0=0A=
The man page says where this default size can be found.=A0 In the --help=0A=
text it is more useful to directly say what this default size is.=0A=
=0A=
CC: Nathan Sharp <nwsharp@live.com>=0A=
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>=0A=
---=0A=
=A0misc-utils/pipesz.c | 7 +++----=0A=
=A01 file changed, 3 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c=0A=
index 48f07aed7..c317959e4 100644=0A=
--- a/misc-utils/pipesz.c=0A=
+++ b/misc-utils/pipesz.c=0A=
@@ -71,11 +71,8 @@ static void __attribute__((__noreturn__)) usage(void)=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fputs(USAGE_OPTIONS, stdout);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fputsln(_(" -g, --get=A0=A0=A0=A0=A0=A0=A0=A0=A0 e=
xamine pipe buffers"), stdout);=0A=
-=A0=A0=A0=A0=A0=A0 /* TRANSLATORS: '%s' refers to a system file */=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stdout,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _(" -s, --set <size>=A0=A0 set pipe buff=
er sizes\n"=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size defaults to %s\n"),=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PIPESZ_DEFAULT_SIZE_FILE);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 _(" -s, --set <size>=A0=A0 the =
buffer size to be used (default: %u)\n"), opt_size);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fputs(USAGE_SEPARATOR, stdout);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 fputsln(_(" -f, --file <path>=A0 act on a file"), =
stdout);=0A=
@@ -232,6 +229,8 @@ int main(int argc, char **argv)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 while ((c =3D getopt_long(argc, argv, shortopts, l=
ongopts, NULL)) !=3D -1) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 switch (c) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case 'h':=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ul_=
path_read_s32(NULL, &opt_size, PIPESZ_DEFAULT_SIZE_FILE))=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 warn(_("cannot parse %s"), PIPESZ_DEFAULT_SIZE_FILE);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 us=
age();=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case 'V':=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pr=
int_version(EXIT_SUCCESS);=0A=
--=0A=
2.48.1=0A=
