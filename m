Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E21C432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1279560F45
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 05:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhH3FQP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 01:16:15 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:46174 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhH3FQP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 01:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630300522; x=1661836522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9paz+FF3nBsYBbYlh+rBb1rdkXs9WUJiSiaNowLgTrI=;
  b=luyMQJi/u/mvb98Da3gFDG7dmPx7cD3ZsC3G0BNfbW5B2ZRjwEdJUuSs
   HP7rqJZwM0EW0k/hvhG8GWQQh4NN2E3m8o3WKxWG4rVCf8xHKJqjZXLZA
   FqFsW87/9yo+DROPXpKSIsQ+pHtEPQhGG7K8nSNa7jCtnkvyvdGlhoLau
   TACf24ygZCmJu5c6hX+WK/yglawPtlRI84X+MAfVUbHgSN8MxIRxt/1Z8
   okJlUyE6XApgPpriBu50cNw7RGYB14QUFlt9BeGzd58KIImRtkLK6jLFY
   VxkHf+px7iuTJZuWp3JepXUI10iCfNjK2NhlDGiAYuMY4b8RSWe5CqYaJ
   A==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177844171"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 13:15:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqPhMGq+ouCFIQ0LB1ImkyTw8doOsV/4ga7BXTFri4k6Pqzt7gLIjDzQIEizG7jh7E4xVz4g2/Iwyoxy2bU/w2DV8fwDjMzMduHF/h7MsfOryqT/fovl+gdQZnjA3FvYroKuY3mxzWHex0DcSwBFEC8PHiwJWJu2wHr+I4aQLwgnEC4mrhq7yDd9jMuslkeK3xeLgG8vdcc0NrF9PkPCxWbZSvh0Q0e6Sb73xm1HJPKR9lObksKq0mfJC3TbBnNrbRcxf2sXSADikMr/kYNzZS3yiOjnBBrhw04OXtS69gVKZ9OntcG7m/f7QrrXSdK+P7yLeVGWUboVehtIPMutJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3ajWnxEFz/Ky9AjK9+nhdvBmRCMFGiL6Kpg0KpL15Y=;
 b=oXpDMU0iGWtAlG8zs3ftF5tW9EXeXDNBGWqaC2+GML8Y2Wa566a/ou4jXG5pcZr8PU1z/IA4VwvTqVrypb5C0E42Pq7/zz/wGoajgVVg5hTW55+W3/GbdmliFo+izQk9nzXhop5d7Hq4M8/PA5/XmnlBuAuDt1fXy/PWMzBgtIClSijjeM4WAUfc0qKZzX8fL2RRqXC1zoZOqLgyDQmZ/uXmcFa9689gSM6zi0QKMv1k9mKW2ZbeSv9PI4dew2DIckBscp8eRqNaYqonAOq1989CPICPyQclSGMVtUlevCGHzOQ5JFNPOztzuQsT26dtxYd1ehL5x5L3zWOG3nVKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3ajWnxEFz/Ky9AjK9+nhdvBmRCMFGiL6Kpg0KpL15Y=;
 b=xJwl3W9nkBlsaWGj/59lccdCkOMaTSkUu5QKR8zMGQCac+NNy0l3ep9hSuW5/sflqJIYMnBkCfM2iJzXq/VapVWep7AKPzfttWt0rwEn6l4h3ItBiuXVVH+2lbN+eTyml6XgPVwZ9Sn4jw0DHJ5mVKz4r9ri8KCng+wXn1NDBNA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8230.namprd04.prod.outlook.com (2603:10b6:a03:3f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Mon, 30 Aug
 2021 05:15:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::19a7:91bd:cb0c:e555%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 05:15:19 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXmxYS4yZ6jtZMeU63dvOu2p5XLquLhd8A
Date:   Mon, 30 Aug 2021 05:15:19 +0000
Message-ID: <20210830051518.5heew4agxipyr35s@naota-xeon>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-3-naohiro.aota@wdc.com>
 <DM6PR04MB7081F921F5DF2E1D8E35D350E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210830010806.w2v2zmm6i5smcoou@naota-xeon>
 <DM6PR04MB7081D86532E0B4658ED116DEE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB7081D86532E0B4658ED116DEE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 551f5884-202f-451f-bbf6-08d96b752913
x-ms-traffictypediagnostic: SJ0PR04MB8230:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB8230F9FFAB043D9E40677A718CCB9@SJ0PR04MB8230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2GlR0yrD14zrGjKhFLvzWt1Osjx6jORwApsNay7MWjV3f7HCUchsf1qFm5kEUyx/ZWAMkmOiRBCSTCG1AHW4JrFbgtRVxqnH0sYNjC1oDhHqikiLteJxAC43HQws8Tog4p3TKbh5NkctIaLLGXCh61/vi5Ww+SLkyeWr4Gwc5CeEOmOrx+t96rAaihsUvYKbFE5CFLa1lu1ynh7vS++QxDx/Y9E3+jnWyN8lMnNPXeuS0Y0TvNXYk3EqNohS77H+AIwlWBNZDCPuVQ57TsB4QuZ3K37EB9/t3YhKeeXZmsUfquHCq3iQ30wSvS92qfJR+BlG9V8jamwWH+gFXFNrItlOot5yGyxyCltAH+GQb3POBv0R5P2KuxuSvD7rOm5Dqdg2cjbslmibIuNHtA32LAVQcgo3y1jnOY7fcz6OnWQUSMon92SIJLp7Qz5tLapuKx0eVwqCAvguxr2NLQdRH1PhhmYo6JudGR2uY+H3dbkwJtgzn+snzacYcnWwQwA6qq3WF+wdUNWzFDiGCi+9F0+DPfInhr6QQD5FRvS8VB28sQWAhicB7nGlxUABd8Qug83pLSdSYW2QBqzoevXfKLLmhMQX4LM1snEfH/Q8KRQLD7a/pznF8ZlAf9ul4khlRznGlLvLHMN+GcJrQPacm1CpHofKzXYR37/FYiUcMU+kd6xhsyo4K/A9xLbborCqfvxCTKasIX2INdfb9z9X6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(38070700005)(71200400001)(91956017)(186003)(9686003)(122000001)(2906002)(38100700002)(26005)(54906003)(316002)(4326008)(1076003)(6506007)(478600001)(8936002)(8676002)(76116006)(66946007)(66556008)(64756008)(66446008)(66476007)(33716001)(6862004)(53546011)(86362001)(6486002)(83380400001)(6512007)(5660300002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HIAJnQxJd+0/p/iwM/z6D0lMO9aLsk59Nes6RDEN/57ll6/r1QIK8318FxDy?=
 =?us-ascii?Q?F5DNYkjaZYpSeGq5DWNvyfEmC94X+n2fPHS7mCOxv2FYXjuimoNS0/8S6Wdl?=
 =?us-ascii?Q?4p36NgE6iwiwRa2MQbJ12MF7wHc1W3i1QIU7aCMifE4lr1l9iJqPZ4ji0RIi?=
 =?us-ascii?Q?rc7xFDOTiXpFyvmHUGT6hLwm6c6UTBFLEiR6avHQlbdhb5WE5WbI2g8f1nQv?=
 =?us-ascii?Q?c6bWjpeUScCUJMu2LhguzHkjMz6JpANpqlQAYgmOG7Fg063IGPLHQ8NueV39?=
 =?us-ascii?Q?7LP845lY+hm1CmXPseIt3/5Y5LbJ9YAhB4g8+pBrZGZdcBv+Q22qIvP1ef8S?=
 =?us-ascii?Q?dR0RAFvrQrQCKCgyWHcD4AySzOUYlZvK/PqD+POO4LB1x6CMwwYdxlPITqW7?=
 =?us-ascii?Q?GQs+xIzMa3jtKzqtzMdjdYZ+HXjfeSM7nyC8wqnObFQE+V/NiJOy7ed3TNw1?=
 =?us-ascii?Q?+wlKFsE8ehjpTxz+4M6k8/BgfjJuchxz+h4LKxrCnWVoqkVtqECA1WyhVC4q?=
 =?us-ascii?Q?aJ+q5E3Ay93gTpyrgEHFHBLzerAoKa/87I9g8qzFs1zRgZP7DOJn8XenEcSW?=
 =?us-ascii?Q?O03ALp4hiUX0Wgwq7D5kcV98tt6aRcGlAT6BMwm0snW+DpuI4bPs9KZ3ALGS?=
 =?us-ascii?Q?EfbJmCSNrbQ3ht85YvlKTC2iLDCWZzSHsnwpiNmcioX7EX9/h34kmp7pA5Jv?=
 =?us-ascii?Q?L3ccFoLzUosYxr5Q7DqQ9sVmPsKwdDMMogTYLQAOoSoqpGj5uzRjqCSZ7JrL?=
 =?us-ascii?Q?Ed1np+thfzOSahIYTs6PNUIsKnrTqyqM/LVl1rCBGckLd30v2CWnt+epA05d?=
 =?us-ascii?Q?R0lfod7DwL3fjH5xbSzIpGvrXH9/2unJhZgpIjhncGyTmBD2K4hsBm4IEQrB?=
 =?us-ascii?Q?DJMgieZ3KMVN7qTiHDsQrhYise/hWE1sdHk42Eq5Fh8XjMLwDQec98UQNjlA?=
 =?us-ascii?Q?tzVdUFeiwZTm5Jbc0Xj9VlnUDK6maKWGj+XGm7IFiNxw/knrzGN4CM169g5x?=
 =?us-ascii?Q?NanpUYC+AcuE6MyGte3O2jppRCcDw48WUEeJmPhhxApTCs65tNAv/mTHmR4h?=
 =?us-ascii?Q?g4YNbOgCaJwCTLfs9B5Z7T0TJlYdaXXEtZ+bgXj/BdA1Chl29DkSOHxehJVs?=
 =?us-ascii?Q?QQ84nPDHMdZAidS9M/+1JXrkOg4FIvI59zhXi+NgMO6Yc/P5Ittp6zD+/vNk?=
 =?us-ascii?Q?krUSLJX6gSAJp3nf8qHj7mdQsPHIchoiYWEA+Nj83V+nqf0jUSVBbMTcehkC?=
 =?us-ascii?Q?IJIoPgpTJXd5hYSfDC48/AZYLB92ghoLPifpoKW9inyPhKNWjHN/kU01t8IP?=
 =?us-ascii?Q?E6ZfbtNjuu5jOnqdjGZIGbejXzPUbdBJUqPljaCeJTvruw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B2CE8910088EF34EB03149983896BA09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551f5884-202f-451f-bbf6-08d96b752913
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 05:15:19.1731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSY3c+Fxm3BAGqY1EetDt6gKZGXoQEzc0SDqK2cShY31A+th270Nl7K6lvScgwACfBWkh1HwNe+kr/01b4Wo0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8230
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Aug 30, 2021 at 01:50:58AM +0000, Damien Le Moal wrote:
> On 2021/08/30 10:08, Naohiro Aota wrote:
> > On Sun, Aug 29, 2021 at 11:10:18PM +0000, Damien Le Moal wrote:
> >> On 2021/08/27 16:35, Naohiro Aota wrote:
> >>> Several parameters for zoned devices are missing from lsblk's columns=
. This
> >>> commit introduces them as following.
> >>>
> >>>  ZONE-SZ    zone size
> >>>  ZONE-GRAN  zone write granularity
> >>
> >> ZONE-WGRAN ? (to enforce the point that is a WRITE granularity).
> >=20
> > I changed WGRAN to GRAN to follow DISC-GRAN (discard granularity) and
> > to have a shorter name. But, either is fine for me.
>=20
> "DISC" in "DISC-GRAN" qualifies the granularity: it is clear that it is f=
or
> discard. With ZONE-GRAN, you do not get the qualifier since zone granular=
ity
> does not mean anything. I really think ZONE-WGRAN or ZONE-WRGRAN would be=
 clearer.

Make sense. I'll use ZONE-WGRAN in the next series.

> >=20
> >>
> >>>  ZONE-APP   zone append max bytes
> >>>  ZONE-NR    number of zones
> >>>  ZONE-OMAX  max open zones
> >>>  ZONE-AMAX  max active zones
> >>>
> >>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >>> ---
> >>>  bash-completion/lsblk |  3 ++-
> >>>  misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++=
++
> >>>  2 files changed, 54 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/bash-completion/lsblk b/bash-completion/lsblk
> >>> index 731ef3f4095d..c9ebbdcedef6 100644
> >>> --- a/bash-completion/lsblk
> >>> +++ b/bash-completion/lsblk
> >>> @@ -10,7 +10,8 @@ _lsblk_module()
> >>>  		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID =
PARTFLAGS RA
> >>>  		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT M=
IN-IO OPT-IO
> >>>  		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MA=
X DISC-ZERO
> >>> -		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX
> >>> +		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-S=
Z ZONE-GRAN
> >>> +		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX
> >>>  	"
> >>> =20
> >>>  	case $prev in
> >>> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
> >>> index 775a6d832076..108c8187498e 100644
> >>> --- a/misc-utils/lsblk.c
> >>> +++ b/misc-utils/lsblk.c
> >>> @@ -123,6 +123,12 @@ enum {
> >>>  	COL_WSAME,
> >>>  	COL_WWN,
> >>>  	COL_ZONED,
> >>> +	COL_ZONESIZE,
> >>> +	COL_ZONEWRITEGRAN,
> >>> +	COL_ZONEAPPEND,
> >>
> >> COL_ZONESZ
> >> COL_ZONEWGRAN
> >> COL_ZONEAPP
> >>
> >> To be inline with the columns display names ?
> >=20
> > Sure. I'll fix.
> >=20
> >>> +	COL_ZONE_NR,
> >>> +	COL_ZONE_OMAX,
> >>> +	COL_ZONE_AMAX,
> >>>  };
> >>>  /* basic table settings */
> >>> @@ -213,6 +219,12 @@ static struct colinfo infos[] =3D {
> >>>  	[COL_WSAME] =3D { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max by=
tes"), COLTYPE_SIZE },
> >>>  	[COL_WWN] =3D { "WWN", 18, 0, N_("unique storage identifier") },
> >>>  	[COL_ZONED] =3D { "ZONED", 0.3, 0, N_("zone model") },
> >>> +	[COL_ZONESIZE] =3D { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"),=
 COLTYPE_NUM },
> >>> +	[COL_ZONEWRITEGRAN] =3D { "ZONE-GRAN", 10, SCOLS_FL_RIGHT, N_("zone=
 write granularity"), COLTYPE_NUM },
> >>> +	[COL_ZONEAPPEND] =3D { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone app=
end max bytes"), COLTYPE_NUM },
> >>> +	[COL_ZONE_NR] =3D { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zon=
es"), COLTYPE_NUM },
> >>> +	[COL_ZONE_OMAX] =3D { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("max open=
 zones"), COLTYPE_NUM },
> >>> +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max acti=
ve zones"), COLTYPE_NUM },
> >>>  };
> >>> =20
> >>>  struct lsblk *lsblk;	/* global handler */
> >>> @@ -1067,6 +1079,46 @@ static char *device_get_data(
> >>>  	case COL_ZONED:
> >>>  		ul_path_read_string(dev->sysfs, &str, "queue/zoned");
> >>>  		break;
> >>> +	case COL_ZONESIZE:
> >>> +	{
> >>> +		uint64_t x;
> >>> +
> >>> +		if (ul_path_read_u64(dev->sysfs, &x, "queue/chunk_sectors") =3D=3D=
 0) {
> >>> +			x <<=3D 9;
> >>> +			if (lsblk->bytes)
> >>> +				xasprintf(&str, "%ju", x);
> >>> +			else
> >>> +				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);
> >>> +			if (sortdata)
> >>> +				*sortdata =3D x;
> >>> +		}
> >>> +		break;
> >>> +	}
> >>> +	case COL_ZONEWRITEGRAN:
> >>> +		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortd=
ata);
> >>> +		break;
> >>> +	case COL_ZONEAPPEND:
> >>> +		device_read_bytes(dev, "queue/zone_append_max_bytes", &str, sortda=
ta);
> >>> +		break;
> >>> +	case COL_ZONE_NR:
> >>> +		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");
> >>> +		if (sortdata)
> >>> +			str2u64(str, sortdata);
> >>> +		break;
> >>> +	case COL_ZONE_OMAX:
> >>> +		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");
> >>> +		if (!str)
> >>> +			str =3D xstrdup("0");
> >>> +		if (sortdata)
> >>> +			str2u64(str, sortdata);
> >>> +		break;
> >>> +	case COL_ZONE_AMAX:
> >>> +		ul_path_read_string(dev->sysfs, &str, "queue/max_active_zones");
> >>> +		if (!str)
> >>> +			str =3D xstrdup("0");
> >>> +		if (sortdata)
> >>> +			str2u64(str, sortdata);
> >>> +		break;
> >>>  	case COL_DAX:
> >>>  		ul_path_read_string(dev->sysfs, &str, "queue/dax");
> >>>  		break;
> >>>
> >>
> >>
> >> --=20
> >> Damien Le Moal
> >> Western Digital Research
> >>
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research
> =
