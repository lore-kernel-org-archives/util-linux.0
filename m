Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36632C432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F8760F9E
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234794AbhH3BWr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 21:22:47 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23608 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhH3BWq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 21:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630286513; x=1661822513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wUwCE1Cp1Sipx4S+hUH5l0NK+3QZdc7CjL4fT9zS5iA=;
  b=gRZSwr3EnNEgWjNWVyM9cw3Uh2RvCWnhEOzs+r7h5DMsBJGkNyTCa56/
   X6sXa8SLIC5jJbq78YecOocY0JHO37FsdXtafPNG7AlUl7OkGph23ADSs
   j9gVVh/F04lfJLyZ0j9xyZGEU66C6mSca8f86owVUckKGj3g2F8wxVXu/
   eQCVAwMkMmpPA2f2zMjhyGHyeUuIMGiVXoQVUHuQgupdThUsGw9ng50QK
   ksQp0Ensw90koOvP8m0AQPp4EnpO3UXVoH/uKU+Mwdtrj8asG02AnbnqX
   yDAVSjhw+X1PUUR2H8pOZmRBBFeY8jPtEgnKkVBU5IQC2RWh8c7xMGANC
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="183501411"
Received: from mail-dm3nam07lp2044.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.44])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 09:21:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NmULpVHYCi0qKllFajILtvum3Xx2yMseQvrVHwj8VrzDFWRROSzcbTSnGG6gt6/SHBoiV4bPzdyHlYBvjU+Y+bbSFFi5aATAlT+oET07qw4BVVV3qaljl37nsNQaWiaorGJ7N0vzwlUvXf8TBl4NidZQvENNYozVUWsJ9SDSfLyrnhD6iDnKr36Gy7aBs7fGGM3KCrTLjqjQnfrG3M0uVtJmUw1n/2xY3OiilToHxIKN1usyQ9uDIEJikTzjY0hE6XqjRZwAR9a8SBlpnWyUMLgJrf3pPD4LoALs1PTD3EYCPWSiCCKmhOx2rrSu0JEAcTCRtqakXQlR4ywOLW9V5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIU29WHfWiyonBiGhqc9TLz6ht1DCCZ1LyinLh0cQ2A=;
 b=hUlFW/FedvrElIcqrfQLNz5aHTHhHMzy4n3dPw2i/vdcbvusQ7ZeCs5nbGBiMlYd2viYSzFPzsjXHWZeuqHbdGOGJQXMWv7jhaG15yKg7q48huc70n7bpDbdcmku9bLt/lfCu+Wlnc/h0VyTP8NNmllce20Nf+fMQ+mN3WeOK2t/EWIJXwoNqDhXhLmWk/U2HJZyCx1hcLjvvd6aGIAUTznt9ezRddjJbDhJU3dDPe0AHsHcqkgXxdu7M/ppZzD/NJn3EVQa5ApffbLcbIsghk3usdLAWvZqrj+KHu8ARKadsjoO6hGdKVivzLITACnjsV51BuGpO4aVC1euT65ljg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIU29WHfWiyonBiGhqc9TLz6ht1DCCZ1LyinLh0cQ2A=;
 b=m6k6i+d4QAph8vL0MJ/WalWgRTAM7XebuTWVV6P/EgLq3lGzMyYTneFEoaNOa9STw4lSNwYEke7ZSZ+1WYFJwrxE/ydoU8WblfT7Biget6Qdc+eYakOQd8NoxqyqBmxv8rjKYc2ofewYhUiSZTVXgJFh81v9HZphvl4r5c+FLtc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7824.namprd04.prod.outlook.com (2603:10b6:a03:3aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 01:21:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 01:21:52 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] lsblk: factor out function to read sysfs param as
 bytes
Thread-Topic: [PATCH v2 1/3] lsblk: factor out function to read sysfs param as
 bytes
Thread-Index: AQHXmxYRW2Dl6OpjEkWA4bshtFmInauLRKYA
Date:   Mon, 30 Aug 2021 01:21:52 +0000
Message-ID: <20210830012152.v2rfwoo4alxu5533@naota-xeon>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-2-naohiro.aota@wdc.com>
 <DM6PR04MB7081FBA5FEB9A90D022991D6E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB7081FBA5FEB9A90D022991D6E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 372a64c2-9bf7-4ec5-c144-08d96b548c61
x-ms-traffictypediagnostic: SJ0PR04MB7824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB782418026F0F824C9897A5628CCB9@SJ0PR04MB7824.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K9gP4g+ulEyrGr4spBdKNTrluU7YPJuJqZdaE42yYDugSQjBKuIF+D8MTUa8e0+CDXwv+wquxtOD3xAJMox5Uz/AV+tE50jAjeIBnByuM0nuZITWJPncgbeY1s/qr/RrALOFFdbsv7tFCb7pgdousJ0zQdHchoMG560ETm7FMSkaqBb5J9Oe0bfZnOrObapQ4Ys0UMWjtl6qqaLBdBcY6THKNCj6sLf28fLSTqzKfCiOqlvuhwi4vLRDAILO/hwFDTEENLGzCuWVQQLWOyVxktJXGAGlXvpbKTTZSPFoJ+agIeFh43PCbCpSk1DviR5RiC9OfdFZhxM+oRm+cVQ7hHY/3kV0uTSW3Ep2Ea5B8Cpynonc8l/kpcAp3tIOkrvb+8nLzkFa4OLsJETgFekJQhMa5metyVkNk4BO1tQkso1mFTcIcQrCUelmM78d8xo3l3J5acqROxhDUBOQN+X+RNOYJr+eRN697u0P9ypR1HeoJknJMad11zHBrx97w/wKgrC1q09PAO665E0GCL4JLVKfjBLAziKvRpg/inMlhjSHmpQcKZqvYPU8nnnYdrMxDRuOW0gLryD79WgCsmoT8QvkitHb9+EiKoAXfcfv7m2/Z+nragMPtxuh339HBCbsAFi3A4/nPu7sUm7JVC6JKi/WFuETX/RqmycVBghVvUtnnDuFWbBxaUh5HvAIDngAAnqk+DQAwLMR0VUPpYr9Cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(38070700005)(64756008)(2906002)(91956017)(316002)(6506007)(4326008)(53546011)(66476007)(508600001)(54906003)(5660300002)(66446008)(8676002)(71200400001)(186003)(9686003)(6512007)(66946007)(6862004)(38100700002)(33716001)(8936002)(6636002)(6486002)(83380400001)(122000001)(26005)(76116006)(66556008)(86362001)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rIW3TP+TDekNfCBMIDQZPLCmQx1/UiG2m1xePxmEyb1c0KZn0BFEDMH5pxVz?=
 =?us-ascii?Q?XnerOF2hi/z4zLeRsKqwNnXPcrb0PcC7m/hS1LxKqCqQObI1Dig2oCqMYyvK?=
 =?us-ascii?Q?qZl7AQsWZjp3Cs3SUFPbEmsQ/uNaAR9TTN0HJ9yw1yg0/0PDNYNIo47DjWph?=
 =?us-ascii?Q?AaRUA4oL/GmES4iVL9REze+a4AW0n6njJOBLfxp2oskjScwmMshuPLZ4japi?=
 =?us-ascii?Q?k8pl+EJpmaHgDdsrzUd3uPy8tb+rrAnyauglvl8TKGk4FWoD48WIxY6w9L0s?=
 =?us-ascii?Q?HyNVDwGpoks2uKTxRZv4EQ8IaDpe/6buSCwHgq5sa/xwIyVp2uYgaOYvgYFS?=
 =?us-ascii?Q?xaHl/LCWTOjaAyoeInBt52w/Nuc3VnL2uWwhNA8tQ8GReugRuZrbjfcY/+EP?=
 =?us-ascii?Q?z+HOmZUCCybLp8lLKIyftGDVu+nDZinK+VHcbysdGWdGGhBl4f4fp+9M/WiB?=
 =?us-ascii?Q?H5nuJ7rHQ3EJzJ/MHVjne0+Cq1ghtTcJvMw6qThoSEJKZv7/f4kpMH0IcJlA?=
 =?us-ascii?Q?1bgcoq/D3U/FOQrkGMUUUKTNZkWlaO4rVzwBeVy/k8Fv+GcqHuE6Ir65Bd1y?=
 =?us-ascii?Q?EBjTxbWC5+gnhK4f4bjvnkiQWmlRwD+TqciFkusNv1c0+SPkbebrhZ85jEQS?=
 =?us-ascii?Q?nUdIUC5W0lhDrnSugY2qnVtZWT5Kc/AhAwvfVk9LuwV++CKU3UPAMor0kyJN?=
 =?us-ascii?Q?ld9YrESnJNhGbcS3iUSRO6I58+2v7nLSaesK7n2WIdZY/H90y7h2b8EQiAqL?=
 =?us-ascii?Q?UeLLRhzrNplNReaoHsz1GG5SKq21H2pIYay7R2SVmFJydx/3giSk+LtB4WsM?=
 =?us-ascii?Q?Y0YxpyIx4OZjp7eiIkiYOxJrU5WkfYyz/kicdqlX9gCaIsNWJRSIY1HPByFV?=
 =?us-ascii?Q?lt0MIyh5rVoMiNdcuPF794T1jDn1y8vWBN5QN9OE/VHwJtwzZMB/6EQrf+Au?=
 =?us-ascii?Q?Efisvhmm0CE1fI2QSIkmU8QLPC94Hqgrtwzda6BKTBEViwdO+8yXebb/yI4G?=
 =?us-ascii?Q?5sifVjWXBiUfgomaJ1y1QCDjNCMo38Vh7bh1u4UFYWWfLGSttSUdmMBLJix/?=
 =?us-ascii?Q?tHtjzbctohBcwFBOyy5bRIrEUomoCsFZAPJhkcB4A23gJpXod2eRIZopjeEd?=
 =?us-ascii?Q?xO0L5Oi0UYeDEZzzxFY3SdSZIg0YIPCyI3UPNNZRNzjY/71iU03QLWnKKSf/?=
 =?us-ascii?Q?WrDcQDUvMdEG1qIrThwlRkGnDHsrXIFVEU463VuzD/1QUwvF1ND6jPcbG1HI?=
 =?us-ascii?Q?i7G54x5nzmWfyoDs5tM/Ihd+5nOl4iyf30ZUXfqtFnP8XJhuE0y2jy53ZEO4?=
 =?us-ascii?Q?kEOFaHeGmPOViQbVt+rsGr8vzrin6586J/qDlXbp7m/nGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BD3F2C13B9021041A2B907E30D5B051A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 372a64c2-9bf7-4ec5-c144-08d96b548c61
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 01:21:52.5032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSx+1ycTaxx6X9lEao6/KIpJM7DS9zEDsvrGCu713Y9s7exh38sV5kus93Ua35+D4Drhnom0rq7IJ039i8ovTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7824
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Aug 29, 2021 at 11:07:10PM +0000, Damien Le Moal wrote:
> On 2021/08/27 16:35, Naohiro Aota wrote:
> > Factor out a new function device_read_bytes() to read a sysfs path as b=
ytes
> > for a preparation for the next commit and to reduce the code duplicatio=
n.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  misc-utils/lsblk.c | 45 ++++++++++++++++++++-------------------------
> >  1 file changed, 20 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
> > index 100eba0779f8..775a6d832076 100644
> > --- a/misc-utils/lsblk.c
> > +++ b/misc-utils/lsblk.c
> > @@ -708,6 +708,24 @@ static uint64_t device_get_discard_granularity(str=
uct lsblk_device *dev)
> >  	return dev->discard_granularity;
> >  }
> > =20
> > +static void device_read_bytes(struct lsblk_device *dev, char *path, ch=
ar **str,
> > +			      uint64_t *sortdata)
> > +{
> > +	if (lsblk->bytes) {
> > +		ul_path_read_string(dev->sysfs, str, path);
> > +		if (sortdata)
> > +			str2u64(*str, sortdata);
>=20
> You could return early here to avoid the else...

Yes, that will be more simple. I'll send a new series with the fix to
the "max" description.

> > +	} else {
> > +		uint64_t x;
> > +
> > +		if (ul_path_read_u64(dev->sysfs, &x, path) =3D=3D 0) {
> > +			*str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);
> > +			if (sortdata)
> > +				*sortdata =3D x;
> > +		}
> > +	}
> > +}
> > +
> >  /*
> >   * Generates data (string) for column specified by column ID for speci=
fied device. If sortdata
> >   * is not NULL then returns number usable to sort the column if the da=
ta are available for the
> > @@ -1033,18 +1051,7 @@ static char *device_get_data(
> >  		}
> >  		break;
> >  	case COL_DMAX:
> > -		if (lsblk->bytes) {
> > -			ul_path_read_string(dev->sysfs, &str, "queue/discard_max_bytes");
> > -			if (sortdata)
> > -				str2u64(str, sortdata);
> > -		} else {
> > -			uint64_t x;
> > -			if (ul_path_read_u64(dev->sysfs, &x, "queue/discard_max_bytes") =3D=
=3D 0) {
> > -				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);
> > -				if (sortdata)
> > -					*sortdata =3D x;
> > -			}
> > -		}
> > +		device_read_bytes(dev, "queue/discard_max_bytes", &str, sortdata);
> >  		break;
> >  	case COL_DZERO:
> >  		if (device_get_discard_granularity(dev) > 0)
> > @@ -1053,19 +1060,7 @@ static char *device_get_data(
> >  			str =3D xstrdup("0");
> >  		break;
> >  	case COL_WSAME:
> > -		if (lsblk->bytes) {
> > -			ul_path_read_string(dev->sysfs, &str, "queue/write_same_max_bytes")=
;
> > -			if (sortdata)
> > -				str2u64(str, sortdata);
> > -		} else {
> > -			uint64_t x;
> > -
> > -			if (ul_path_read_u64(dev->sysfs, &x, "queue/write_same_max_bytes") =
=3D=3D 0) {
> > -				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);
> > -				if (sortdata)
> > -					*sortdata =3D x;
> > -			}
> > -		}
> > +		device_read_bytes(dev, "queue/write_same_max_bytes", &str, sortdata)=
;
> >  		if (!str)
> >  			str =3D xstrdup("0");
> >  		break;
> >=20
>=20
> Apart from the optional nit above, looks good to me.
>=20
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =
