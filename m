Received: from us-smtp-delivery-109.mimecast.com (us-smtp-delivery-109.mimecast.com [170.10.129.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6761E86E
	for <util-linux@vger.kernel.org>; Mon,  6 Oct 2025 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759716187; cv=none; b=IshyxtPACwj2SIci6mSuw0d+RGfcyhEvFTflP252cs0wh4GWXWr+gqpq4GrBKCuKtWSeswve106JiZtbtF31WT3WuGxLR1D5DP5mfFMYDTdEOKWv/fhkVUOrDr0qWRqK0ZaNeTK8PKEPHfcCHJHTOuqd5c0RAxAWKmGb+5/eNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759716187; c=relaxed/simple;
	bh=+WpdGMNQpOe3l7JKYOfDb3I60o5nmo9sZEsgNrEeo4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+iG0KLq+R741LdD1d6NRtwwDBitKJqijZZSZU0qJZ8pnvAP/Q7GBFgLLp2C/8E6TxZLz9LULM8uNCs8wG2d/8mIq5RESpHERFjVkbTt6PRTurI5HDthAwMa6bdYePhigfdyFyRJzZ9TaIS/doHOdI+pOeEzTrtboPQDyODTPBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu; spf=pass smtp.mailfrom=wgu.edu; dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b=RovsULws; arc=none smtp.client-ip=170.10.129.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wgu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wgu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wgu.edu header.i=@wgu.edu header.b="RovsULws"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgu.edu; s=mimecast20181213;
	t=1759716183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+WpdGMNQpOe3l7JKYOfDb3I60o5nmo9sZEsgNrEeo4U=;
	b=RovsULws1NyqioN8kRCa/zoVuSSAJ6zIi8xJFQB6InEItf4eQq9f+VoWuItykCTt4Agpla
	PRIcx2vy1FGI8ImF9MUZtUl4Fw8SBOX/wMUJaZOLmSycu9Q/Xh4xsvQsD7bk44BRgmUlRm
	bQjj6v68HnlJlnLreyV2MuOmXli80dVdlv6aPwciZ11Vzweu/WWOn47NIX0B0k0L/4Qygq
	ujFJFyyrvr5N1daBRIPewJLQIzbRsJ/YlCUeL0fNDQQV0DSSkdGurNcRlkDJCAHPS5X8Q4
	Cj/HCNYmR83j0zQ4GXHtOuXyNbiXkDR7C6t678lEJmXtqjxmg6UdnzCJC9iCJw==
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11021099.outbound.protection.outlook.com
 [40.93.194.99]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-qwCBtVIWMuqp7kCGfHAAmQ-1; Sun, 05 Oct 2025 22:03:02 -0400
X-MC-Unique: qwCBtVIWMuqp7kCGfHAAmQ-1
X-Mimecast-MFC-AGG-ID: qwCBtVIWMuqp7kCGfHAAmQ_1759716181
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:3b8::14)
 by MN0P220MB0864.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:370::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 02:02:55 +0000
Received: from SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::8aa8:f866:6d8f:e86e]) by SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
 ([fe80::8aa8:f866:6d8f:e86e%5]) with mapi id 15.20.9182.015; Mon, 6 Oct 2025
 02:02:55 +0000
From: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
To: "bensberg@telfort.nl" <bensberg@telfort.nl>
CC: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/2] swapon: rename the new --annotation option to
 --annotate
Thread-Topic: [PATCH 2/2] swapon: rename the new --annotation option to
 --annotate
Thread-Index: AQHcNmPL/LTwnY2230mbiuwk6QsOKQ==
Date: Mon, 6 Oct 2025 02:02:55 +0000
Message-ID: <SJ0P220MB05411D798786BF09146DF3A8E9E3A@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0P220MB0541:EE_|MN0P220MB0864:EE_
x-ms-office365-filtering-correlation-id: 0a5e75e5-6e70-4f47-9474-08de047c775c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KXXfe0IUsazA3zciimSlG9iWEjoSklh/8QR3mZaBcxHq6I7PJLViBp3ruc?=
 =?iso-8859-1?Q?3iqZc1QgfiWZcuTfQYXFl0wgmTwooDfOiFENMJD0VAKYeAQ/PtGn54YI5s?=
 =?iso-8859-1?Q?XdowAsRg4u0Gj5We7OEcDn/+753zntic8YQnOLaXkh8kXfE5+Rwt03rR1B?=
 =?iso-8859-1?Q?VQzLviaRRu+6dtr58qyhB04LrJ5Er8Hjorr/LF/i2Chk5RxOGggRc/iXfN?=
 =?iso-8859-1?Q?twdgbpGVK+FOkWpDcMLnbBBFVbwgItMHmlnNiekFHSVz9XGWb0LFHQRaoU?=
 =?iso-8859-1?Q?BK+jKpNvOjc2b7D/qgeQbqVwjfUXKDtWXOJ5ZW+VjGPnDlzCXbWzESgBBk?=
 =?iso-8859-1?Q?I4jMK22T+iQSLPrY13RA5CokiBlO8Y7dwygvgwjvF2CXVM5+74nxX1kCSW?=
 =?iso-8859-1?Q?1P9JkfjfdWeiAUFBU2mUeYii8w+UXRX0CPvhMo5l8CumngJ9/0Fm+U9Dyo?=
 =?iso-8859-1?Q?UKLUcm1qmgVIv/ea1IDJAMloNboYcn2u3fZoD36fNp7FWUO+yIGff43aFF?=
 =?iso-8859-1?Q?HUefS5KffvWeKTXO02U68knjffXSY4woWvrjzQb4CghUmACdulWBOSa/da?=
 =?iso-8859-1?Q?EPmDtWPPUbAq8o3lRMRi5UDY7N9JcMveHLDo2K/mrU2UJHMtKwct95S9a1?=
 =?iso-8859-1?Q?5P9325KXDzKI1Gd1OqKtwqOgQgDXnbroLHOEGMNgdPpviUWzT1ZS2uVOMH?=
 =?iso-8859-1?Q?cNWp8OH508sZ8rg9MCUggjcptYpBMD0M7JOFkbSvBX5OTLmnGFli65FT/C?=
 =?iso-8859-1?Q?eynapdMJPJ8jFqH2koQ2yfG5nF/qgTwEMeDfHps0t3ROhIVZSpC47AtA16?=
 =?iso-8859-1?Q?2DPepZ3xL0gy7QRSQlqAY/1jI5j4NwCQAKSokHZDLXEgA4Hd/dkupjt7LX?=
 =?iso-8859-1?Q?jiK0Ph8KGpvf6nMR1JPgmL9O1b1y0owmohPOOY6Q93fYxVevJ+ZQdE2Xbq?=
 =?iso-8859-1?Q?4tHfLPFPS+iLVEIrJ1i0FLuhqPVnMb1f4OxjrD8Tg0RzFKHf4DrAN6lcXW?=
 =?iso-8859-1?Q?ge8Kjj/rvMgs5Vnf9s1A5aDKElmtNE+0mrSAlfGiYNKNsUmAH1p+zznBcb?=
 =?iso-8859-1?Q?stMfkzfiKLbkzP2o/3GkSCe/0yXPfGvpoLvSSwgJdb/ZEveYMj9X3TTUZP?=
 =?iso-8859-1?Q?HRu2byaRXVSRFJrkMgcy3loZArKd2xwbYDOGMVR4JEmSz/ikXF229nMs9/?=
 =?iso-8859-1?Q?mtuOGEeghV5IiQ9M+VhdhKD4M6LKru+M+pQ/yHkJGICzgaXmOkmpsqq9L4?=
 =?iso-8859-1?Q?k6aM6NDFQ+i/hgtnJmW8MW4/8RqXebm/6qUC1p5jkgHQ7al9mhk3NjC4ar?=
 =?iso-8859-1?Q?CtPhirBJ8z2UCDhQRTyvArBYtDgdRg22J0ivXDPiCm1/n+/o59u4B1oZKe?=
 =?iso-8859-1?Q?3YgzKjmKumndi/dqy9Lg2bMdmVNCa4UeAPxkW9TgXwodqoPokERGARS26N?=
 =?iso-8859-1?Q?5W6z171wAFldjNhz1oBdmuFucO/lsBpst9YGnCY5J9eXUFFQoTihPejeey?=
 =?iso-8859-1?Q?mu1C9DP3ndCEk1VgtsMrw4fF9B3tfjId+E6wihk09P6C6yjQN8KdemZ9CK?=
 =?iso-8859-1?Q?nDjZvucxW8w3gX0JhQ5jwufQVeHQ?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5UndXu2hiL3YEGENvK/hN8M/TB+NUl6RydDNO3wLzoWsZymnrDqmDOAXIh?=
 =?iso-8859-1?Q?dxfNWDvwkalHNLCwnE4qejmBAVE621tKu+avH5DImTIafNMa7MGOI84llq?=
 =?iso-8859-1?Q?kIN7JAlXHCHKvDdUQkWzm8QQWcQFdbyDZZmYBlgoUS0OZm8UMb+cjOih8f?=
 =?iso-8859-1?Q?sG5Zpdx9U4L6vAfmk6sBC74w3UCWeSkdQo1C3/bfenkHX8Z+Dd3Mmdg/bn?=
 =?iso-8859-1?Q?0eLsX/H1Kl7KNYTxkK5mjqnqIhp6L9N6CB7aWRNTIgK3GO8enWaHcXpxXb?=
 =?iso-8859-1?Q?/6rN75i5MVPEnGljC02s0LPigpcIw//A5CV3Vg7SrQPvyXbuUUDAlEBtBA?=
 =?iso-8859-1?Q?BRUI/Q0fjSpgmruqqdNJTPZG/MhQTlSPJIsmh7SY/ma4kqUvNPBjxx7beH?=
 =?iso-8859-1?Q?MuBPriUubY9+8Wg31KII1AxZsi40JF7Z10T3HIyIAXR5NvgKwlgTDULnbM?=
 =?iso-8859-1?Q?pXWzqZfgiDySL8Ira4CLyd4vgdxaitGH3lbzOV5in1DZXig86a0wvKhmee?=
 =?iso-8859-1?Q?j916Ms8Qo6UNGt+Hd2AK1n0H5LttPDDJPii6y/lxEPoCwidG9irDjMAjB2?=
 =?iso-8859-1?Q?ublyUa69AGpQyyQzf4XH/H/yTCN7MoOCm5LgcMKVeTZSu/phI26AbE6lKq?=
 =?iso-8859-1?Q?Y7Hew1TawrT2e5zdsZ0v41F7uUJlhWCHjkDNo7JCuXMYpfm4FYW6RBfIVQ?=
 =?iso-8859-1?Q?ZO7vFOQUICCz7YlJ2BIHVF9aQ/mC1vgD9x9pmeOK8ZoInRTYRsoc4cQBLk?=
 =?iso-8859-1?Q?VWa+Zh+tdW3msvQILIc8LqT3p2GDVBYVj7FAtK5Oc0wUHCzrwkWHfSL3c1?=
 =?iso-8859-1?Q?CkoIMUnaVq4Gs48Ly30Z6V6Pft1jp4XRtkeLSfzy4gVaUMMyJ3rZsla7qP?=
 =?iso-8859-1?Q?ix2+iMQG4Qo+Hp/wcyPOhZ2odlYL5Z0FGn8iI2QVor7bOy7xOIevLxiz4V?=
 =?iso-8859-1?Q?RYPYebScpcTl+LAbOvkHT0HpK6mpyvhPQZbjwb3tztxSXNv2P44MC/THAG?=
 =?iso-8859-1?Q?TsXuJpYm5O/eyaeQuWwovZgL9pHNji5O2F8nOCGZ0E8UltQwhJZLxw95p3?=
 =?iso-8859-1?Q?YTvJIPPQFBwrJM+nd6wiglPSWQ6d7U20qakOD2VY1ysLEElkusdfPebULj?=
 =?iso-8859-1?Q?HUoGBIc69KfwmhfrgZi0WfvON5MuKTScX3o4rNIIG8//J1VBkV0BCgsHmE?=
 =?iso-8859-1?Q?+WXyvjT4mjKsniOx2tBPWutHKeDWghisSHaq6prGSBY0YG77whppi0ZEga?=
 =?iso-8859-1?Q?gsyhbCUq+2krwG0Bf5L3yW5ixfZsCmiiQBLofGn3Q7a0LIMzBwH6ht7bMw?=
 =?iso-8859-1?Q?dzjBazZLGoTktZLqdIoeTvAjfv5Vi+HzLYC/wmeKPa+DKVJfdOpiYM9K3d?=
 =?iso-8859-1?Q?uHpqXlAfcKxfs8uKefWs3CO3TXY+a3NwhrCMjt4pXurQOvBRpVZdVBRwyi?=
 =?iso-8859-1?Q?Rpv2i+Lk+FJu2XyqXyluwcxJMKCmACizRuJWOdK8+KykVwLGaBFDLYVyVW?=
 =?iso-8859-1?Q?ti0+kd2gQPk4a3iG1dvNbPmVkJ2JxwwtTcudD1SDle8+EyT91DUp56JkTw?=
 =?iso-8859-1?Q?IqhGyp9YWEi68Cow24IOT07Gd8CybY+GftTJzjubL2NlMv2A8ia4QiaTw8?=
 =?iso-8859-1?Q?4mxWb3Nez55ag=3D?=
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wgu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5e75e5-6e70-4f47-9474-08de047c775c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 02:02:55.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cfa792cf-7768-4341-8857-81754c2afa1f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O/O4kK/OPPSSy82/SowblA0IMGbS+WX3ZWuRx6QJDWfdIpvsY+hl7SHrPcRn5V6g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0P220MB0864
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ye7CJKlsotTgtVPwBvm1EG5qchNEJQNXNV2BqgZdbQ4_1759716181
X-Mimecast-Originator: wgu.edu
Content-Language: en-US
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

> The form --annotation gave the impression that after the subsequent=0A> "=
=3D" comes the text that each column name should be annotated with.=0A> Fur=
thermore, the other two options with optional arguments (--show=0A> and --d=
iscard) are in the imperative, so follow that style and use=0A> --annotate =
instead.=0A=0AI prefer this name, it is more intuitive.=0A=0AFYI, I added y=
our patches to my pull request* on Github and for completeness I renamed=0A=
man-common/annotation.adoc to annotate.adoc and adapted the name of some=0A=
variables for clarity.=0A=0A* https://github.com/util-linux/util-linux/pull=
/3782/=0A=0AChristian Goeschel Ndjomouo=0AB.Sc.=A0Software Engineering=0AWe=
stern Governors University

