Received: from us-smtp-delivery-109.mimecast.com (us-smtp-delivery-109.mimecast.com [170.10.129.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBB42E091B
	for <util-linux@vger.kernel.org>; Fri,  3 Apr 2026 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258634; cv=none; b=eWg0RfBLrhzEbJo2C8WfTe7B02Tb28Lx/Kr1FTvhEfH89MVxIKo6mKAODA8B4ZmddtkXpHyNJ2zk/UFZYOg7XHH/ivbHkF3q3s5U2GiyZ5sEsfA4qTzakTclrRPW71L4NS1reOCYvhkhlFjhNVgeYJA/dRmMPcKoA5fTwh+hYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258634; c=relaxed/simple;
	bh=ePMF8lhwUIXaGMOgbX/ZcQYVqMlfutEW/UoElXsf+jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KIX8ZWe/09KJMZ3A8D0lNr9bl0iy4c2pduhEmj94tl2SsabzhC0dDHsLfnj82FIToLUiEhyT5KwpZ0X5aVN9yKH2UNsocuJpXq/t8TAftWAec3LCVONafpEoCxHSn7/OnODklFCpF7wKnW3P+9yYQoJMs537wZvFkROx3SxvXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu; spf=pass smtp.mailfrom=wgu.edu; dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b=lAUwT36S; arc=none smtp.client-ip=170.10.129.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wgu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b="lAUwT36S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgu.edu; s=mimecast20181213;
	t=1775258631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ePMF8lhwUIXaGMOgbX/ZcQYVqMlfutEW/UoElXsf+jY=;
	b=lAUwT36S2QE6juX+xv91c1u94ks4G0LzCcKIK0V2OpJ3q3I+Mz2BA2aDtMnv0oqnDwTMIQ
	vQOA5FxUGSUYDaYip6qrDx5ta3R+uYppySWHTe3hqvzP3ySUYzBSw5xXM3R7O8z5RGfFVD
	MKdhB1voP+sFZYVw/LY1i2skgzZ1TiZl5bHRLpGgXwBzn6FxWcaRGAWdVKM73/Pke2U7Ws
	sCDkng/s44asAsITUO/84HRQ0y6w6DdrLjtEyYe7pkTBSKef33oM3/39J+Rde8as4pDVId
	/WZptmmexQxl/ZNZ335++dPix7qAk4svYEkm7O/wN6EuOpvae5hObxYK1CUhAw==
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11021103.outbound.protection.outlook.com [40.107.208.103])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-wTOEKFG7P02iXp4bFHxI2g-1; Fri,
 03 Apr 2026 19:23:45 -0400
X-MC-Unique: wTOEKFG7P02iXp4bFHxI2g-1
X-Mimecast-MFC-AGG-ID: wTOEKFG7P02iXp4bFHxI2g_1775258624
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:3b8::14)
 by LV3P220MB1855.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 23:23:42 +0000
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa]) by SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::45c:bdd0:163b:39fa%5]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 23:23:42 +0000
From: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
To: Chris Hofstaedtler <zeha@debian.org>, Katie May <katie.may@canonical.com>,
	"1132588@bugs.debian.org" <1132588@bugs.debian.org>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, Karel Zak
	<kzak@redhat.com>
Subject: Re: Bug#1132588: runuser: missing whitelist-environment option
Thread-Topic: Bug#1132588: runuser: missing whitelist-environment option
Thread-Index: AQHcw1sRxqjqBBzUoUOR9Qs9s+2K7rXN8rf7
Date: Fri, 3 Apr 2026 23:23:42 +0000
Message-ID: <SJ0P220MB0541E236A2387E8EBDB7C94BE95EA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
References: <CA+499YPv1qATJg3SWqz_UrY77Lksibs5UJAaAhck0Vct3EdSuQ@mail.gmail.com>
 <ac-hE5WXBkG4pKZa@per.namespace.at>
In-Reply-To: <ac-hE5WXBkG4pKZa@per.namespace.at>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P220MB0541:EE_|LV3P220MB1855:EE_
x-ms-office365-filtering-correlation-id: 5b2d4148-f08c-48be-69c7-08de91d80b43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|786006|1800799024|38070700021|56012099003|18002099003|22082099003
x-microsoft-antispam-message-info: 4kwR7FqmyJA0b3NnL6dVCEW3/PUT6TrqlMZ6n8PTscDzOsdRJvRK4wjW6WW1IfIFufl1pJKHNKsSnJJPENVhVO7USKw2ND3mEyXMkXwIMIZx1+CJdKTdicF9Xw6mtFRUYkI/VX6KPx9cWtBHBtoiJTVbDM8tbi/ddEiV7RT/p9QX6N+L8dRPnMWkNedRpv8t/vdX383volyn5U0ZX2kzima/GbLIVp2qyZORvrhI3KdCP92PUuwh/NHTn1wmUXoZMJUT2UnETEOQFLsu8SRnF9jVCMGS3gUrrn+9POUjwKwyUgPgTrZn4LPdBivP912yIWBpQeR/GdQmKpqf4+GQFyiRLnC+uZIOPq7aTjRcUDyyrdWtVvH08C+SkVuqIK28gbOmeUx/4wxYDx5nHGgyz7clI4BCbGY9KISEVNn7wihvetsvwGhmjgUbNyMTU9lLYU54OYXM86KMTjlid5zcZ2TJMdMB37WWXsTp6kYCxZPqEQahAD6ji3b0PkfMlgdIWBuX+LxE63eQZT1bs1aPdNHXNYxMJW5NoasQCYNOpASQvlpYF0HROpJf8JwUKhCtpHIlroLFx9xtaST6I0zgdwgPP3kOBDKgx865OpiopZtF7fToOKibTcffgxH3Msu7U1N9hEvBgxUpD2J2u8ol3wlQOcPGu5YD99JV2g576DMZcohNV4acMqnSCiGAd0w5qPQaKgHAKSFniZXnF8sbfT+vjhPuIGB0QEdwW3JgmSmsw9TZARbrGopeHHPmzyjytbRXoNB7yqx2C5zz2QKsy2PlEhhsF973ZzsSLH6UKds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(786006)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?piiUOdog1ZIVdxQ+Z7Lh2Dd93fOYfVDycgxS62/HUcu/OOxG4p0suHv83d?=
 =?iso-8859-1?Q?JHtY1iVf+vWTTs5wpkoAvA8hTYpMAdMIQd82CuwuD6+DQK0aHxc8yPUPeQ?=
 =?iso-8859-1?Q?7eGUHgfo6QouD3A+xS7ln0CbrIBr/0p1nmYLFGa0a/YYAL+o6RxjiS46mi?=
 =?iso-8859-1?Q?6YqRhaIGwssB9CRKMU/KzS7c6tnuixb6aMbO74NglvuDG0G12XnaaPfn6c?=
 =?iso-8859-1?Q?1NhLtj7/9Fk8rADyGQINIjGK8sFot86zA2aTD8ql42xrx9d4oAiGza/eco?=
 =?iso-8859-1?Q?W1Sa7/jD63H1kIqEG0c5C1q3ta+nodFzAuX9sPd5cIYDCc3y1PEQUFdAfJ?=
 =?iso-8859-1?Q?vQXBh6CvjFppzZMB8FAA0/ypM2d/79gwW/9Qcg+oHjlFOLQnGOUBfzlnHJ?=
 =?iso-8859-1?Q?94HXr2hZa0r4YbWSP3/mz1xv4SMjDu3wy8fO9yGBmrbLRMUd3Gh3Q/cxmi?=
 =?iso-8859-1?Q?vHetWnGEmCjp2B9Ef9mPXmqZXZyUZL1Bu8MNYhpRjAKr3iFiuZ82ixbUNz?=
 =?iso-8859-1?Q?N8/rhNQr3jjALnSPzivUYPXFsAassTnLkLoHVJbluvjQ14b41zH8MoKVgO?=
 =?iso-8859-1?Q?a+gKPVDFhuf2b+NXq0JqXMoqDD/X81jBqP1ktCOjT8pVm6FzmRtusqo6/q?=
 =?iso-8859-1?Q?wj6hobnU27gsIXwXpxIxx/7jPYSiEYdKYuMK4G/QgwoaQqegm5wNfq9Rco?=
 =?iso-8859-1?Q?C+JqoE3nDRmgmznX0DL/0qfniWudRA7IWs6ktVzn8DNJyHJGCsepmrqbWt?=
 =?iso-8859-1?Q?kcXYTkuns8sKjt0OTTLmz7H4jcS5ieRNwp7/qdv1Y2go8iUXCF4CEj3IR9?=
 =?iso-8859-1?Q?W4vvlLmoUntu4bReDiF5W636pHxaDyf3I4OghQ4c+sePu88eAxwBe84wQy?=
 =?iso-8859-1?Q?yMAi4UkkB/1JjtPtL+SyzSyoitEn3fMh1kUyBKza9HDw1u4PHABQPkqEBK?=
 =?iso-8859-1?Q?nYDleVd0SYJLyx+7muieoT3DDpIu54G6eMW9lkmwjgkRToBdZknJbLaoAw?=
 =?iso-8859-1?Q?HIaXFkZfWRSGqk7Fspj7hjQ5OuB4dj++2hYoGVmxP4OPUzXHst6+DYpQ8Q?=
 =?iso-8859-1?Q?MxJOZH83YIcVo6/138AmirknbI4eSgLoJcBHFBKE3T93zOcrPB1i6fDXmF?=
 =?iso-8859-1?Q?JAPWy0L0/G5t85ke9XtcXfxCp4cHOHlPYDCOG7Y0wYEij29iTEqnv9iPkm?=
 =?iso-8859-1?Q?9XWE9Nz7et5lMmHG0RH/z+QyzBKNGPfpikfQXsqS4WdD9uVH3VdPV/XcZi?=
 =?iso-8859-1?Q?sGlgKqvYiCxDmJd4ierA+TZN9P4x5XMEDTmDxCzHr2VW8cv6+uqhu+0r4f?=
 =?iso-8859-1?Q?3Z68Ze73YdEKehXNeqYhhX8+I/QhQ+9OPulb3iSbkZzNjKPMir5tf7fhY8?=
 =?iso-8859-1?Q?FE/t2sukMKXS3oyt49d834NDr5Gvm+ckrlSAukmXGDjz4xVfikMA8t1PH1?=
 =?iso-8859-1?Q?t+E7PL5ly0n6XufNglhiFZbCn54s8xzve1uQe93hl1ieaWQmKXGK5V9UWP?=
 =?iso-8859-1?Q?uJUgBxb2Pl3By1o8jjBfm1G6rnr1ocfBXEdWFkRxMp+PDPj/zc/NyXIqBa?=
 =?iso-8859-1?Q?cDPg5kgZp1X6M+bJc0UG//2WtRCwujg+IGzLdsrpSziF7Tn+KabeVufGvs?=
 =?iso-8859-1?Q?CLueoU9Bs6D0XBmVUL8jOX7OWnMOGdLLtwHJNhywcNK8pdfpDkrGrxCR0X?=
 =?iso-8859-1?Q?0817cwciRmX8PH0yuP99rdHvKWo39ejADL/R7vmNWsx20qWCbCGfhSMWJ0?=
 =?iso-8859-1?Q?orOqjskTw7NAxQ6LHRoaZ9XV1/Hj0CggYhws9BXi8nWW6/Cfy2bT7xE39Y?=
 =?iso-8859-1?Q?KZjT+yh1McZYpaA8WwQ6RTpDUyI5d0ap8byCdhwwvtvZW/z84c0y?=
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GV+7ha94IrKlFnVaZLkHL4GGmZqx3Qb+WYnjRVV+14wORx6FQJV+XyGQ9ifc/d3JxtehXdQ6/vultT2erQY86u8a2E7RgL6dD/zJ4j/u7DaZsyovLx+y47pv3QQqMBDeZlYkno10WFqrJZi0wWIAdlWAf/yAm2kGCxCZPPVwYSFg3pf/rjPa6bxLkOqAb2d+9YVemXlQtgVtF93gtvXN9cTsa+mCj6QEhZ/a8CKq4ePrGk0EW6ngjqwqgCrQfMrBKw8/6O94BjMPy0SbvhqbZ2Y6ys+wAcYCywhvLn4vAvC9oQPYAxpmT0r7/D99w7Sir5YhFJXJyU81QuwbhS0/KA==
X-OriginatorOrg: wgu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2d4148-f08c-48be-69c7-08de91d80b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 23:23:42.0502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa792cf-7768-4341-8857-81754c2afa1f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8g5dJeMnF+GbNPstfDd2NCXj9nBgMM+iJkENPlRhSLAjxMcWHE/CfoT0+mkeV/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3P220MB1855
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9bcL-xP1J4hFQ1acPYGg-iZGrYjPJu5Fb2bCAni5beY_1775258624
X-Mimecast-Originator: wgu.edu
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

Hey Chris,=0A=0AThe issue is indeed caused by the mentioned commit ac0147f,=
 however=0Athe change is necessary for proper functioning of su(1). Neverth=
eless, I=0Ahave created a PR that separates the short option strings used f=
or su(1)=0Aand runuser(1) as we need a different scanning mode for the form=
er.=0A=0AI have also added regression tests for runuser(1) and slightly imp=
roved=0Athe one for su(1) so we can catch regressions earlier.=0A=0AWith th=
e patch the issue with runuser should be fixed. Can you please=0Avalidate t=
his ?=0A=0APR: https://github.com/util-linux/util-linux/pull/4185=0A=0AEdit=
:=0A=0AAfter taking a closer look at the runuser(1) man page it seems to me=
 that=0Athe actual documented syntax implies that options should always be =
put=0Abefore the username and potential arguments that are to be passed to =
the=0Ashell or defined command. This aligns with the usage of su(1) and see=
ms=0Amore coherent. Let's see what Karel thinks about this :D=0A=0ARegards,=
=0A=0AChristian Goeschel Ndjomouo=0A

