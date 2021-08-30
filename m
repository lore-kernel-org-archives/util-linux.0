Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1561C432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C628E60E90
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhH3BJC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 21:09:02 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22672 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhH3BJB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 21:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630285688; x=1661821688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uN6dz4a0YqKr6/KVVvhz8O1lL/rfaCzgCAkTQAbSBRQ=;
  b=HJShrpXAlBJEfHEPNpbesJmy8qajOLH+Ve79cf1HLfGJgrcgdNrr3d/J
   TY1xCwjkhoMs4JdwwnFo14+mT2/eYYkLIfEU6VSg1Xpbrje0MsOkQTUPn
   1Xs/8ZUl1I+dVzWOGx8yp2oH/lRJLF12Ccx83Nrz6ePixW8AIjyOJKaIx
   uuqJ8CJq5nR8IM5v1Yz8VazUbE9qK/5IuGgwljaDqYF8CPtAxFync4o7W
   1N5ER0i6s0EqpaDNZKCB+pWfOnP/7URGFYZgc0PBSrAAs7lrb9Cn08XNv
   39IRJE9vO17e2g6dDB3rTlzel1aBw03PduYznw318Fs0A0yBPulR5q5fv
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="183500717"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 09:08:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dgqu+0XI3kvfv1OowiXSO0lvdTp3M2FxskeEIOyNMFcX47z2QZ9G01Mfwy+CmLOQFU9yUskQEvHf0cn4HahN8iT5CXl3qa4deX4+jMTjI3S1OaLhCq5VHy3/+aFqJAyPe1KzOg1I0k06P6WdObKwaC8Fprgp0DJK4iaskNCJzLtcwkAgpQthRekI/zYJ+CwHVNq7JbQCe4i8i6+OJjRDfMF2Wn2fzR3EnhgpQT/FMgVB8oOUUYT3pKHLHTBCNiZdPfLVbzzepJb7nPwA6hd2Ix+VpExgAVAoQnGnECkEOovGkGSRiFtuHiNZZVhjtpwiz/XSh5WTyl5KoZj4TXzdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbLvjxfQr5fbRrq00L4wQvv49BOBorvL4lthefaMIko=;
 b=OCVKx3ognPzl+qnpILv71jOp7sekEinx4h5hNOQJHioEseL7irSdjpwidsMGMCI3rK705gfEoDaNsZhp4JNVGPGdjJP7w7ZjKokg73Jzv4qX6FDvnitk+vog7QVdjWxCrUIBmDpKk2NwEkJNg6aAu1VYFCLgKSpqTHdI8BdE1rKEzuRZ/OZZ/MgXbgruemWKzaTMPi06anxM+32KIK5I6zzFUijL4NiyaMkoYHaxUE0yjHMCoChgplj3xNg2eIJoCwG2Tf7PRuxh/fmUJAtN47uTpncaGEQ5vVDGNcyITwQS3gMOSJjI8I26DpJtZS4iNk0D6ppiHJkeK39XcBtOJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbLvjxfQr5fbRrq00L4wQvv49BOBorvL4lthefaMIko=;
 b=UqmLTDgvLew19SPX12gEl/bftRxPeW8D0APwStVVGkah1cEbf12DjtEhb/nJlutLeSgOfRLjGdzpZEbGuNxUmwCwnW+32nW7CVu0q7APk4JmVY9eOR2KW8UB4Hr8dU9fRP8pxP+QefetKDHAy2FBVia+JfnRqlE9NLsn7dFQJeU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8375.namprd04.prod.outlook.com (2603:10b6:a03:3d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 01:08:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 01:08:06 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXmxYS4yZ6jtZMeU63dvOu2p5XLquLQM4A
Date:   Mon, 30 Aug 2021 01:08:06 +0000
Message-ID: <20210830010806.w2v2zmm6i5smcoou@naota-xeon>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-3-naohiro.aota@wdc.com>
 <DM6PR04MB7081F921F5DF2E1D8E35D350E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB7081F921F5DF2E1D8E35D350E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 836ebba5-0f7b-46fa-ca5f-08d96b52a01b
x-ms-traffictypediagnostic: SJ0PR04MB8375:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8375CB1F0691254A260C46198CCB9@SJ0PR04MB8375.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dBj+LwlOctSh91Kc9EXO+H7dSzWjYzyFVbZjjUtf5MY57QeO108nqNFRisLVxOKfjX4m7M6Yziwl9tog126F3nIE7tqBT3b43hPXMV70J5q2AY3/f84AsvGwbogRyMKtRluyh/axr2bmm9+0EMIoA4RZtv+bTZ3PNr3B+ap+LhmnBBFREE9EpCa3YwCK4QZZGfa8CiM4p/gHquxbrYIxFgrgcTU4VhXC189PF2qyMugEn0HlBEQxoc1mdtkBtC3YqTC8A5LU2f78BQBauQgwqFwh+tWrjNc0DM9PEb4Y8N8+iGLuG3MyYKPq/5Gt9AvhcQ3fb/0wsT7mfP3atSHHm+p1SBpZOEaEXN/RcsDYyfEAzNxjEKC4rs0wZlH8eK9K+YGZwu5wClovQE+2YpDnmyxelL3jqqQdLx2FJVvQiL0XX04NvbGjg2aLNhEKEQxTZITjAwGRggI/9nAhY9T0ccRShRNuNZrKDJIw89SDMGyRiNWlndb6qpP7hiV/rE9TwzC9nfrbLYbjl2iDQsBGTU3g9c0HX56y6k327zQEz+yOK38FGzT/VuWERhl7XAYQDonWlLNHO1NpL9MB8Pj5mcoLT4WRbugtgRhokCQHDBKYtsGZ+yXmB1ps8A829MpZg+SmdEg+RMA1N3zEKJunZbzkDOzwCQJ99H+OGHNfZTp6BzcSnqBtAS0iiqR7Sk9TqDhmn9jwkriJCNBSFFEcOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(6512007)(9686003)(6486002)(83380400001)(6862004)(71200400001)(91956017)(66946007)(64756008)(66556008)(38070700005)(66446008)(54906003)(5660300002)(186003)(4326008)(33716001)(86362001)(26005)(508600001)(316002)(2906002)(38100700002)(122000001)(53546011)(6636002)(76116006)(8676002)(1076003)(66476007)(6506007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iSEkVVloE43u8xHPis3ynczF36TGLC/eyrCUUjS+ee57CFc6cDaTuS0Vei2c?=
 =?us-ascii?Q?sqY7YpQc4ZKYfa8lAxurViyFVpAxmg0DlUqAh+Idpc2GX9w1LDw0vLLDt1jR?=
 =?us-ascii?Q?ouRMm5BziHcsEAEVM+qPcOxT/cGY8ikLnxmiJ6nLJNWIct6m+48b1XNpTIxy?=
 =?us-ascii?Q?8S3CKpwLlLZuJh3WmSlDScfYVIrZo9NqLK5+ua2cblBTEKl8tOPHJS5XihXx?=
 =?us-ascii?Q?gcFk3EljqFSQx3RFzJ1uzzdLW2kq5gnbJN5+kwly8y7JQauGd9o23JxQ7HMD?=
 =?us-ascii?Q?jsgpmcvPomb3CmGV9kzxYW7iGK6wx3Rz15SEYB4PZA63gQBXGs7OU3nW1S9x?=
 =?us-ascii?Q?HcoJ5y9FaFsL7WZvVdrgUiLB8tlqMWlcJOJO+6XScrUn2URv6IhA59rYgeDa?=
 =?us-ascii?Q?BwNvBFOVe9ev9C324fihLcz/zE+7h5OZlgYJ8gWRoHHDZdMY+3XZvwdxiTen?=
 =?us-ascii?Q?vozjoXo5EeUOhex3rAEJLARz38JijKY7VbDp6QO7Lifn6Q9OcxUcpWQxgnvZ?=
 =?us-ascii?Q?NlK+i0Cl4DQNjfOx/I5gBI5cTZo0KxETEPBA7ZjFEGqqRWC7S/bLRgrRoWFz?=
 =?us-ascii?Q?QfbYEuP+h07vUoPz0wlUydxzapWD2qxuh7G5KW36SkKpqRrN78d53XJbqVW4?=
 =?us-ascii?Q?frWJ4ODQxq7XoWXQwVqvTH81rFt6yWmWiONaU1clDggT8Pdi/ImYKOsleiFm?=
 =?us-ascii?Q?i2aIAE8ATsndHLXjVlFI86reaxWKA+Ov/ZIszt4qwSA9G9v6EQrknee6ptNm?=
 =?us-ascii?Q?6zIE1JfF1iw4ost8HnhLPPhWLAlp0D5zIKIHclhEWN6qpchJWSLbJ9A0E07+?=
 =?us-ascii?Q?4Ut0eDe0LMn6Ba+7Bct+CT8OazCkqGHTStLSf94BtC73JIyklbvA5GKTqTCs?=
 =?us-ascii?Q?TvOc6NpJVvusUE5Yc9bZLrLxnxNxvc4RXcUR09r80KYa6miNTdt+2bpfK/PG?=
 =?us-ascii?Q?ksCkV776KW07y5ezxKii6EIcpClNBQQFP4K5XMZ3zpp5qE+ViQxdceq4s1lr?=
 =?us-ascii?Q?Wsb7qd0jhr7KuUfxOWl2HJQu5uQ8ivwa4s3EHUnJOPf7o10osElcKe0d4+BR?=
 =?us-ascii?Q?3diqehGUFeB8kr1qoVJsoearh62YtbrY5ZsieR8VvkeLaoe6zprciNv8gtCo?=
 =?us-ascii?Q?IJZBd2cVwEGOLgHPavWfaRwNKb07GB5nsA7NOs5YbcbbrxtVXi13DhoIzKZN?=
 =?us-ascii?Q?/1SPMWFo7XjkA4ZMjP8ZRmuY3ASokLmeooRyxbByE54nX4nDjfEBH2/I/XF7?=
 =?us-ascii?Q?MDBEAtA0pDpbBFi0Mo46B5/9lAxuu76UxFkHQrr86MkDny+P/6jexRZKles1?=
 =?us-ascii?Q?W4BEz0gw5D66+xxe1sNBxhOpgx+tGX2mfQI4WKkblVi6rQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B766930C7917E04896ADD749C32EBBE4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836ebba5-0f7b-46fa-ca5f-08d96b52a01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 01:08:06.5390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pn/5L/1DBlnqb6ADVgKsc3LJtZtR8ap6/jc6NNT0++49w5PwWfZZzKNLtbK2R5TcwdopUpJo6hRpg+M/CLfJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8375
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Aug 29, 2021 at 11:10:18PM +0000, Damien Le Moal wrote:
> On 2021/08/27 16:35, Naohiro Aota wrote:
> > Several parameters for zoned devices are missing from lsblk's columns. =
This
> > commit introduces them as following.
> >=20
> >  ZONE-SZ    zone size
> >  ZONE-GRAN  zone write granularity
>=20
> ZONE-WGRAN ? (to enforce the point that is a WRITE granularity).

I changed WGRAN to GRAN to follow DISC-GRAN (discard granularity) and
to have a shorter name. But, either is fine for me.

>=20
> >  ZONE-APP   zone append max bytes
> >  ZONE-NR    number of zones
> >  ZONE-OMAX  max open zones
> >  ZONE-AMAX  max active zones
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  bash-completion/lsblk |  3 ++-
> >  misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/bash-completion/lsblk b/bash-completion/lsblk
> > index 731ef3f4095d..c9ebbdcedef6 100644
> > --- a/bash-completion/lsblk
> > +++ b/bash-completion/lsblk
> > @@ -10,7 +10,8 @@ _lsblk_module()
> >  		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID PA=
RTFLAGS RA
> >  		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN=
-IO OPT-IO
> >  		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX =
DISC-ZERO
> > -		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX
> > +		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ =
ZONE-GRAN
> > +		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX
> >  	"
> > =20
> >  	case $prev in
> > diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
> > index 775a6d832076..108c8187498e 100644
> > --- a/misc-utils/lsblk.c
> > +++ b/misc-utils/lsblk.c
> > @@ -123,6 +123,12 @@ enum {
> >  	COL_WSAME,
> >  	COL_WWN,
> >  	COL_ZONED,
> > +	COL_ZONESIZE,
> > +	COL_ZONEWRITEGRAN,
> > +	COL_ZONEAPPEND,
>=20
> COL_ZONESZ
> COL_ZONEWGRAN
> COL_ZONEAPP
>=20
> To be inline with the columns display names ?

Sure. I'll fix.

> > +	COL_ZONE_NR,
> > +	COL_ZONE_OMAX,
> > +	COL_ZONE_AMAX,
> >  };
> >  /* basic table settings */
> > @@ -213,6 +219,12 @@ static struct colinfo infos[] =3D {
> >  	[COL_WSAME] =3D { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max byte=
s"), COLTYPE_SIZE },
> >  	[COL_WWN] =3D { "WWN", 18, 0, N_("unique storage identifier") },
> >  	[COL_ZONED] =3D { "ZONED", 0.3, 0, N_("zone model") },
> > +	[COL_ZONESIZE] =3D { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), C=
OLTYPE_NUM },
> > +	[COL_ZONEWRITEGRAN] =3D { "ZONE-GRAN", 10, SCOLS_FL_RIGHT, N_("zone w=
rite granularity"), COLTYPE_NUM },
> > +	[COL_ZONEAPPEND] =3D { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone appen=
d max bytes"), COLTYPE_NUM },
> > +	[COL_ZONE_NR] =3D { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones=
"), COLTYPE_NUM },
> > +	[COL_ZONE_OMAX] =3D { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("max open z=
ones"), COLTYPE_NUM },
> > +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max active=
 zones"), COLTYPE_NUM },
> >  };
> > =20
> >  struct lsblk *lsblk;	/* global handler */
> > @@ -1067,6 +1079,46 @@ static char *device_get_data(
> >  	case COL_ZONED:
> >  		ul_path_read_string(dev->sysfs, &str, "queue/zoned");
> >  		break;
> > +	case COL_ZONESIZE:
> > +	{
> > +		uint64_t x;
> > +
> > +		if (ul_path_read_u64(dev->sysfs, &x, "queue/chunk_sectors") =3D=3D 0=
) {
> > +			x <<=3D 9;
> > +			if (lsblk->bytes)
> > +				xasprintf(&str, "%ju", x);
> > +			else
> > +				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);
> > +			if (sortdata)
> > +				*sortdata =3D x;
> > +		}
> > +		break;
> > +	}
> > +	case COL_ZONEWRITEGRAN:
> > +		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdat=
a);
> > +		break;
> > +	case COL_ZONEAPPEND:
> > +		device_read_bytes(dev, "queue/zone_append_max_bytes", &str, sortdata=
);
> > +		break;
> > +	case COL_ZONE_NR:
> > +		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");
> > +		if (sortdata)
> > +			str2u64(str, sortdata);
> > +		break;
> > +	case COL_ZONE_OMAX:
> > +		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");
> > +		if (!str)
> > +			str =3D xstrdup("0");
> > +		if (sortdata)
> > +			str2u64(str, sortdata);
> > +		break;
> > +	case COL_ZONE_AMAX:
> > +		ul_path_read_string(dev->sysfs, &str, "queue/max_active_zones");
> > +		if (!str)
> > +			str =3D xstrdup("0");
> > +		if (sortdata)
> > +			str2u64(str, sortdata);
> > +		break;
> >  	case COL_DAX:
> >  		ul_path_read_string(dev->sysfs, &str, "queue/dax");
> >  		break;
> >=20
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =
