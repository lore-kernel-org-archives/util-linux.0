Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4CC432BE
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA92860E97
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhH2XLO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:11:14 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42387 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XLO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 19:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630278621; x=1661814621;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UtCvoHTkq1F758tz2YyWUwC9ie7k6WTcawZMECT7wa8=;
  b=TrCznA914PY3mrlpwJ2fzYlf0EqlSQwI/Zgssgryy4X3YzC6TLCgFb+n
   cIqECKLJiSJsw9MTJu6QAkDA0jDpglaqAhU3+XjuffTW3ICuAj8Awr80j
   fuQwaCerEW3zpQblfYlBsNcIudiCToyGlZvMJkghXbUpa6PFzzpit6xff
   7Hf0tj8rqT8h+xUIhNV/zAsyB7ETuw1VYArpxHhEf5gNkI90CRgcASKCV
   RKjr+meALQdsIwvimwZimrUiL4BE8ntmA/Nyxew8dnhPu8JS8SjvgTe/E
   wr1BnZnOx5THq0ufcnCBQnMytw4ea/sHEfJIVtN9FdREKuHbzvKZJp+9K
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="178717953"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 07:10:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F92nZBMP/20B7fgBkaF8cyYr00mnnqJ40HDa/stFYAEgPdWA0ZIxoZDZSwZsMVHei2D07zU8lRLQo90X7imaR4qvnVky9f6tXQIdJq8a8xTVYU7kLFjz0q6ZDrcesGxHyCjnt97eQHJ3QHBMpUJADdjrx9B+T2I4e9zw88b4Qr0BQ8eHe6XpZsCBXC5E+x7eukhpdeY1Zo3e8TEDHbL4WcVkKw9WdvES8dxfmllo2QSx08MX5oMUWeUh3fmyxKWoe0id8XCu4qyqvw1PpybXMWYbHaRXh7MVmhaA8sHG8YRSbcdjh2C160dz4os+9P+Vy5UAHgBfVVzty6ow1+vPYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AodEkwlMSlwdFj0n8MDyRGAKr2yz+YG0eEGh+wI3ATo=;
 b=jikpLwaT0eqi6H1yG0xpTe1FcrP8dUcB0hiF8VBYk6yG61SnhcMKQWPMI8Bv9MgTA5R3MOKyp4M2MK0gltk/9bAQNh/1VdOklAO5Kbod59H5NWUClELZ6rKZVvCawqvZmI4/IYbjlGB1C9Zk9Mg2myXBYmUvCJQQV4Bo7CqTUWAcrd9rQcGgJ/xDWYiIwJrSxOBC+VDRCIdw1uJ2PaBPHs5AlX1O+hgw8GaRVRZI9AThYHFhOpgyB0/YY4pSlW1U5cKUKUABuiYeZc0C7hUjIfnFxRa+YgYSBKxIqewg7fkHV+1OAjJyc7K1qO7ba8M3I2cQ/tAF6xN9vXkKpa2tjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AodEkwlMSlwdFj0n8MDyRGAKr2yz+YG0eEGh+wI3ATo=;
 b=F48KrOuLHj4+VeHCda53egAtSxKxO38khPdEEEkg+5TKWuKppuU2oF4Q2nVCEu4k2oI2Eza9mUrXanREVhnPlXDUnIKi2r0BYhm9xeW0ayttyn6otF99zyQzl+5pRFzQ6ANVIWsNt/qkqW+kn1XI0fwh8Kux0HjiHCcewEFL4Ls=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4409.namprd04.prod.outlook.com (2603:10b6:5:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Sun, 29 Aug
 2021 23:10:18 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 23:10:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXmxYSqEoC9GplH0GLIlxliojy8g==
Date:   Sun, 29 Aug 2021 23:10:18 +0000
Message-ID: <DM6PR04MB7081F921F5DF2E1D8E35D350E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae69f93-81c3-443e-4269-08d96b422b16
x-ms-traffictypediagnostic: DM6PR04MB4409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB44096C0F382CE9F577692757E7CA9@DM6PR04MB4409.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R2Y8I3nH3jsmaznEyWE2kqTxD/u0zTAxDxH+y+6SO5QzohDnTUYCy86jcc3L0vfhsV6M+3Bc60F4HELzuoLDZ8GSkD6KOD8svvqwQSgnAKRIQE5US5M5klD+yYM3bF7NaXozgRQ/nJTPVcFBg0I5RBGDUGWhwp49mr7iFGEEOy7v3nLE8nrUbPQLyZcuy4Mz7W8+exyI7cABvmBvIEJ9TnCwBNfmkRFsgLFCHHkr2JCusrm2cVIctSmHVAKK9nth0gNw2VAabojg1eQrMJALzlHWt7E0pmt+s+o50NbCzTv8G0QviYxyWKa6nf/bhsC+s8aIG7qxyhlp6tRRiYMMrz/b0OqjJap0IpFPt2rBfKc0qro1vtxNNh1zgqV4l5TZFyv1AVZakvNa04TSqaBV2ddt73L9PjpN5Oj4dhq/GFEYPv1EBimAZwzKiAu8PwSBL7fx7l7M0FNVJpmD8vnUnU0FoTIQC06OKDotsjaY3Ae87Sm+viojh9KcywEj/Lbr/Ykhqrco4d+yS0dRXAoZ13UinqrcNeJO67Ceh4AC3ZsAhs8z7f1856SnOgaoc+Y/h1M0ehzd44TS5TPlX9lLcIIhWS8eeCMpS2mhSJcok7CTdGtN4PJ9ygYxGLYvWnVwy+dBR2TauGyq0RhQDdamC+FUNNIUu08nNHQDW4MBP07SF799Pe/PuYXOyPAFax53HUemVcwqMr4K6rsypQHhqA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66556008)(64756008)(8676002)(186003)(38100700002)(86362001)(33656002)(83380400001)(38070700005)(91956017)(76116006)(71200400001)(66946007)(66476007)(2906002)(9686003)(66446008)(55016002)(7696005)(5660300002)(110136005)(6506007)(122000001)(316002)(53546011)(52536014)(8936002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BCU+aDwvqLArQC1T7V4lZ0gqjXbSyWPuNRRWqzApJrwuEcutdb2aWPjy6xBZ?=
 =?us-ascii?Q?I45nTJ28hH7sWnHOKehLBeX0FqkjBedsVS6MMPTVzvtK6mjXuLCS7sjNbb1d?=
 =?us-ascii?Q?EVOZaYWmkqSi0/3Yr1DCrSbyGsHoNQNtXbHEze5csIICZfIAeObTcvUqqR2b?=
 =?us-ascii?Q?/eHobV3oDUU0DOQqnOGpP5y7Chp2YlHLdZVbcRs1jYOQkWSxUOlWUu6UHPl/?=
 =?us-ascii?Q?n+JuYXURdBefijdGylqQ9SBXeayM03g8ktzGvt2nPuSMwHIrATUzvuR8nHew?=
 =?us-ascii?Q?rAolswroLE34peEe8Bb/Nvnu0SAr4hALvwgEBcXK8XEAkUpXwKOYIs2UAedH?=
 =?us-ascii?Q?z1kymB/c6HbcnxXyUhwuiSevpjaK3W3+9rtOYF3vel+QSUSCwnUltuWklvq3?=
 =?us-ascii?Q?3ORUS8Dh6UD+abGWo64TR8Sr94FZlPUkXsytJfveTNdCmK/BXFq7KORhTc1A?=
 =?us-ascii?Q?pXvZaWQuRbLCHLiWXikCdUTuyJQSBnbFDoRa6p3efr5Ocn+tmhRzYCzK6x/e?=
 =?us-ascii?Q?Z8ogvzJvNxduqjJx2YBbD8GkL+JCzJrRZpPrwJmJ8pvUOR3R3XUBP6ZgTvA0?=
 =?us-ascii?Q?6KkCcHZ23TZoOnNB4XH/SggxKG6dAxML2RKBI8CBOfG6Oq4Cx+OZvEmbHzuv?=
 =?us-ascii?Q?Nc0CKMFGLOwj/o/IIDKgJVqh7buhvt98RE4mr8qvtCL2RU/zpadBmqV/Eusy?=
 =?us-ascii?Q?Uw1HuEfrVTrj7kV8vuDmLvLisowX0RK3sCPk2LfaQaIyc42JoAN808ew3+Yh?=
 =?us-ascii?Q?WRYWJ0DKMmwV9l21WjAeZggPFqJQgplnHc99IsNKImOEaZyx9xDfx2DPc1/h?=
 =?us-ascii?Q?F0ZABxIU+ha8uhWGdLo25dlTIzRqLNoOspbcEr9rKvNRamLtV04XV8xnsWaP?=
 =?us-ascii?Q?C1MIVJHIz+UEeZx0ES30if/WSiPu3VDPfiaBCtPbA/zhBNzufgUl8/ir6pWL?=
 =?us-ascii?Q?NK52o0NqoXVvx2VGiAx0Qd3Iw5AmVdVXFpyc2jsUBOPlM3Z9Sl+hY2k5gLn2?=
 =?us-ascii?Q?hbxY46bO2VD46qVGyQJksmL0ARpTVfJxwnUWFsA6xy3nr+ayh/lywYAlP/k9?=
 =?us-ascii?Q?rCXVJWUY8VcC20J/D8OW8+QpBb6fMbNTuiHSRxRTJ+EkY6YDLKPpjracV7I/?=
 =?us-ascii?Q?IWiZWGMuo3tZe90bX83kYPTldn9Uq6GBagxV81JeuPnLWGQ21w9Cq4XfrCAi?=
 =?us-ascii?Q?9dU80DAi4qgpnzAdiDX4g2dVLHOWfL260siKb8YFY31fB+Z0RUkuPe2A0RMZ?=
 =?us-ascii?Q?mvJbK9afrZ0/Vru/+RyVJ2dAgJZ8H0aMMjIuGGL6rXrGT3kWQ3ZNpG9+9BLm?=
 =?us-ascii?Q?4+gL1WPpNfcu7MmARSjROwCC8mQy6Ve09ldAeZAs6JerNYIMlE8ej7ZtDTfI?=
 =?us-ascii?Q?vpD436C7ac3/5IVQnsEfkjnx7tHINlIQvsIajTD/LW9sEwWliw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae69f93-81c3-443e-4269-08d96b422b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 23:10:18.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbcSZdt44+QcjmeHLokOTUGQgDU4e7HaE1iA7++rj8SQsrFRSGvOsxp8nFbEzrtQSPhRLsXa3IOyHygKKz1h/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4409
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/27 16:35, Naohiro Aota wrote:=0A=
> Several parameters for zoned devices are missing from lsblk's columns. Th=
is=0A=
> commit introduces them as following.=0A=
> =0A=
>  ZONE-SZ    zone size=0A=
>  ZONE-GRAN  zone write granularity=0A=
=0A=
ZONE-WGRAN ? (to enforce the point that is a WRITE granularity).=0A=
=0A=
>  ZONE-APP   zone append max bytes=0A=
>  ZONE-NR    number of zones=0A=
>  ZONE-OMAX  max open zones=0A=
>  ZONE-AMAX  max active zones=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  bash-completion/lsblk |  3 ++-=0A=
>  misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  2 files changed, 54 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/bash-completion/lsblk b/bash-completion/lsblk=0A=
> index 731ef3f4095d..c9ebbdcedef6 100644=0A=
> --- a/bash-completion/lsblk=0A=
> +++ b/bash-completion/lsblk=0A=
> @@ -10,7 +10,8 @@ _lsblk_module()=0A=
>  		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID PART=
FLAGS RA=0A=
>  		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN-I=
O OPT-IO=0A=
>  		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX DI=
SC-ZERO=0A=
> -		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX=0A=
> +		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ ZO=
NE-GRAN=0A=
> +		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX=0A=
>  	"=0A=
>  =0A=
>  	case $prev in=0A=
> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c=0A=
> index 775a6d832076..108c8187498e 100644=0A=
> --- a/misc-utils/lsblk.c=0A=
> +++ b/misc-utils/lsblk.c=0A=
> @@ -123,6 +123,12 @@ enum {=0A=
>  	COL_WSAME,=0A=
>  	COL_WWN,=0A=
>  	COL_ZONED,=0A=
> +	COL_ZONESIZE,=0A=
> +	COL_ZONEWRITEGRAN,=0A=
> +	COL_ZONEAPPEND,=0A=
=0A=
COL_ZONESZ=0A=
COL_ZONEWGRAN=0A=
COL_ZONEAPP=0A=
=0A=
To be inline with the columns display names ?=0A=
=0A=
> +	COL_ZONE_NR,=0A=
> +	COL_ZONE_OMAX,=0A=
> +	COL_ZONE_AMAX,=0A=
>  };=0A=
>  =0A=
>  /* basic table settings */=0A=
> @@ -213,6 +219,12 @@ static struct colinfo infos[] =3D {=0A=
>  	[COL_WSAME] =3D { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max bytes"=
), COLTYPE_SIZE },=0A=
>  	[COL_WWN] =3D { "WWN", 18, 0, N_("unique storage identifier") },=0A=
>  	[COL_ZONED] =3D { "ZONED", 0.3, 0, N_("zone model") },=0A=
> +	[COL_ZONESIZE] =3D { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), COL=
TYPE_NUM },=0A=
> +	[COL_ZONEWRITEGRAN] =3D { "ZONE-GRAN", 10, SCOLS_FL_RIGHT, N_("zone wri=
te granularity"), COLTYPE_NUM },=0A=
> +	[COL_ZONEAPPEND] =3D { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone append =
max bytes"), COLTYPE_NUM },=0A=
> +	[COL_ZONE_NR] =3D { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones")=
, COLTYPE_NUM },=0A=
> +	[COL_ZONE_OMAX] =3D { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("max open zon=
es"), COLTYPE_NUM },=0A=
> +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max active z=
ones"), COLTYPE_NUM },=0A=
>  };=0A=
>  =0A=
>  struct lsblk *lsblk;	/* global handler */=0A=
> @@ -1067,6 +1079,46 @@ static char *device_get_data(=0A=
>  	case COL_ZONED:=0A=
>  		ul_path_read_string(dev->sysfs, &str, "queue/zoned");=0A=
>  		break;=0A=
> +	case COL_ZONESIZE:=0A=
> +	{=0A=
> +		uint64_t x;=0A=
> +=0A=
> +		if (ul_path_read_u64(dev->sysfs, &x, "queue/chunk_sectors") =3D=3D 0) =
{=0A=
> +			x <<=3D 9;=0A=
> +			if (lsblk->bytes)=0A=
> +				xasprintf(&str, "%ju", x);=0A=
> +			else=0A=
> +				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);=0A=
> +			if (sortdata)=0A=
> +				*sortdata =3D x;=0A=
> +		}=0A=
> +		break;=0A=
> +	}=0A=
> +	case COL_ZONEWRITEGRAN:=0A=
> +		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdata)=
;=0A=
> +		break;=0A=
> +	case COL_ZONEAPPEND:=0A=
> +		device_read_bytes(dev, "queue/zone_append_max_bytes", &str, sortdata);=
=0A=
> +		break;=0A=
> +	case COL_ZONE_NR:=0A=
> +		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");=0A=
> +		if (sortdata)=0A=
> +			str2u64(str, sortdata);=0A=
> +		break;=0A=
> +	case COL_ZONE_OMAX:=0A=
> +		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");=0A=
> +		if (!str)=0A=
> +			str =3D xstrdup("0");=0A=
> +		if (sortdata)=0A=
> +			str2u64(str, sortdata);=0A=
> +		break;=0A=
> +	case COL_ZONE_AMAX:=0A=
> +		ul_path_read_string(dev->sysfs, &str, "queue/max_active_zones");=0A=
> +		if (!str)=0A=
> +			str =3D xstrdup("0");=0A=
> +		if (sortdata)=0A=
> +			str2u64(str, sortdata);=0A=
> +		break;=0A=
>  	case COL_DAX:=0A=
>  		ul_path_read_string(dev->sysfs, &str, "queue/dax");=0A=
>  		break;=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
