Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BA0C432BE
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4920D606A5
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhH2XQg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:16:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42782 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XQf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 19:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630278942; x=1661814942;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KIVJgc9wFczrua3x02edkaixfbLd1G9rpFysrZ/iqBQ=;
  b=M0DGW4fdhkmTrCoCeDWJcFvyeBkSSSAvDGo7I+1fsdVt2aoEvoM60OaR
   8bXkS3+hXo8HI4LYyG5j8jXatWMGeGD95O1bYJmCn5eGODZLjn0HWjF7w
   9XZOynN7zCvYhTaNx95s7jnksTaQLbfxcHsh1PtR8gqMH4q9Bg7hzKHyV
   /oXPjwERf617emegdqpper/0o0eGCLikbM33ybma8WMIHLXPavkOmYupy
   4gYUQZF+b7tHVbT/nSujK1xhITUpW+JxDsmOWCSpxus3/wrPdCdeaQIeQ
   0++34vhu5cDQcLCk8vt8NIsEud/utLoy0EWLnJJ0aNlZttDPhxrxJnobY
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="178718102"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 07:15:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvYiWdtKSMjUsVW0XzOFA6nVQiJPMoxH6mxFRUX5ZRbZ+eutT7ltpYcMdZqjOesERJhxhWlgyOwmufYspBUcFj2LYU2dgs0xQXbwzo2CIwUE4S5nBbBg1MTH1KWEXZPL9/Y9EsOCjVfLPAVLnZVHTVhP7QSjJgxFxYUt98efZxmu3TFVVhedWslNfZm5zb9TTpbjJ7AzIjQFjA6LsUGN6YF12qh3FnvlHVubWukW+Ozv5QKqCNLzLdLNARKWjeaDgchqp88TnFo6xrf+NrH/SNjJL9BJURfw4I6fg+SAGHSWmixdNM9Np1h1rrTG20IIZPShKd5m9+D8ZEHiCZD8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO0XSLlPWhx066Cz2w7cAMksjGAfXnkYqk5diSwqkyE=;
 b=a7Jcda6mu0HIgKu6NoFWKVNvg+g8YlOj4aNNZEsyPtdRg0pd3UuXpFlBPxSTDxixkMpltCmxX/ffkRGAyimzLCDou0JscsRlx62CDy672Uww2yUDgO7EXowz0zMB6V876K/m+xRkbiP3+SwYkOEQx207Y4Nrgk847CoeRicuDIEoNgADUQXcog5u4k5/+qdZ62Kama67wawCfo69kuKI+/Ab9wj24Zt345SL0Yg2N1B/G9zjVeBRjOw2ElKVhYO3gV4nushjeUOl9lzAEekP2YXKHgRH9SWwS+TusmbehcLH29vtP3cxkg2I1FQHHnb8h42oM/uRHfPDV3j9UtBVOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OO0XSLlPWhx066Cz2w7cAMksjGAfXnkYqk5diSwqkyE=;
 b=A00Xjmbstkt+F10c/3C5fTVkX3iMq7edcNFPgxmsvIEy607uB/xgK7dNJeTDzMuNsN/pIB9xHDYC3bzSj3dfqK3M5/o5JxaCMFSdlc0v85zWMiyyZAjtraSQMI/qyNdFlmJh7Z8gGZN8KDrFmnezq13jpWBoPUjNnUIolUGTsrg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4409.namprd04.prod.outlook.com (2603:10b6:5:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Sun, 29 Aug
 2021 23:15:42 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 23:15:41 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXmxYSqEoC9GplH0GLIlxliojy8g==
Date:   Sun, 29 Aug 2021 23:15:41 +0000
Message-ID: <DM6PR04MB70818A20FB7980CD268C5790E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8259ad53-e43c-4037-f081-08d96b42ebed
x-ms-traffictypediagnostic: DM6PR04MB4409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4409121DA87906CA92B04477E7CA9@DM6PR04MB4409.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9kFR0vQ607oRiqIKu+7sv/9S1g8TCvDIQTHdG6lWrdFnFn1zAxBUkn71ATS6Awh1X23LQCCevrWA/1RYZrkTvPS1Kw2DhSXcSDlEuK/JLGnIg76WfA7oPuDVbmTcGzzhXfXBrlyRVAbSxYcnyuQiweSQJaTGZVgF5Up1sj3Dg89CWM7hnWxcJghOf2eSeaB2e8Zl2TEdATqDyJdcG43Iyi+PFVZdNtEoKYUIQSCNmDICrS5AJcYRiD2PNP0Y4MLoITQ204eQNgCyeS0xCa+WjNFpEvze2aGcL9nizXrLPWTfhC1wim8feOHG6w93aqcIO87qiGbIeoBh4tf47ZQe/D5y07L1/wQZ1ddx09Sz328mbaIgpROMHhyRTtN2VQqLVrVV1SwiY9CF4kp2DYuKytSstbCxM5oqWIVW+A9dNrEpXimtxH2xaX4Pc8EEqxhIQHtcdDzNjt/I+q/WAk5rgV0aTuWCw7WP3iqD1uhxr2VS0uN21P6+poMGkg7siCEwE8vcCJtyqsHfn202RvRtkOALwA9bQiMzis/jYlnfeRIqOmFnZ35GVUBSWUboCt5NScoNW6NLLOFv6WKNNe1pfewplJ+JjVPzDFkiutQnLV6e9eRLLVQod4c8bBwX4yReaUlc09cxegGsLJ88C4f6+euRSWquPhdMgoKil8q95V3JdZfNjYzsGKmGZpKMCZHKokk4gHEMDbbr12vXpy08jg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66556008)(64756008)(8676002)(186003)(38100700002)(86362001)(33656002)(83380400001)(38070700005)(91956017)(76116006)(71200400001)(66946007)(66476007)(2906002)(9686003)(66446008)(55016002)(7696005)(5660300002)(110136005)(6506007)(122000001)(316002)(53546011)(52536014)(8936002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+oqWwuXp56xufpXEb27oFTT9uCvGUtTIjSjLGkIivr7FQvdVrmeRXHAVXOxk?=
 =?us-ascii?Q?kmWFsqhcBLLBLyEIWZy2pYLjFXYgKgfPYL6UFxlrJFh9vz0W27OeHhPc8lsC?=
 =?us-ascii?Q?QH5aD0fUjNS7M6racqWw1BN31Bxgi0/rW1jlxU0F8TSUWe2qMdqZT/tQKL4n?=
 =?us-ascii?Q?r50N8X8iwgPEnQpas4HnLYBbwSuNwZMFXDeWTPnrPthuTUXu80aJXAVLPPvW?=
 =?us-ascii?Q?g+jT3nC1hiWD72Tl3hAI4iufHIYaGStB7VUAngTyv2w1BTTvO7i23zvmx6U2?=
 =?us-ascii?Q?a/jMm18ZWjcXVkOn0HTYjU9wxs8Bv8G2Ykr6BYx2fiNNeconbU5arVCI4J/Z?=
 =?us-ascii?Q?9MhLMYxHAirbVUrZ6PU2sZKgqaO6jtMGFLsQG/hY/qunaEluJdh0Tcyjt3kp?=
 =?us-ascii?Q?lUpedQVtTpHj9GXdJRK8183vxMuTCig17KGTJEUrk6ACpWoPv08rYAxxZfdq?=
 =?us-ascii?Q?wEJyqMbYzs2SOpI9CH4RoS/e7ZzbUwihin0WusYuFwkOjcvpqmB6wD8rkUnB?=
 =?us-ascii?Q?l80Dn42ncpoxZwouREQ6YYzWFhm6jyTGy6PGIiJ1eqc7eL5MwtOrpFnMg3Tp?=
 =?us-ascii?Q?fCx/EYl4RPfscUd6bw3e1VSZ1x+f6M+el6Bs+x+pHEfLDTHJ2QoO+/OC4Lok?=
 =?us-ascii?Q?EI51/U1ta7w/VOF4/E7QLi+YzKbAWeqSb1BMQoospR2m3dPAaWy4vEe8vnTv?=
 =?us-ascii?Q?P8+N4fzUr0jIJBgeVevtnn5fcQFIk0mMJzowBCKFCnXGyQvAKsHYI4j+a/Yu?=
 =?us-ascii?Q?XKfRusSV9p6XVfkDNl78/0ZUeiBAIAu2nMdCKt9JrHDK6wkIq5bKrBU8x4gT?=
 =?us-ascii?Q?A+R/gi8yxHaGsRq2wwwzVe/qzOYfAXaEIYr1jq5XAV4TPRh+vc9Fxa/FskqB?=
 =?us-ascii?Q?ifumpnGx0OHP6s8cTy24PaBVy8LyTpwp4fNbOynXG74sv47/9tHN2anlGGku?=
 =?us-ascii?Q?Cu4pWuuSbnm6BbFLB5ejvrBUrEUrmr983nUpvZruhHECwx6kXkvSpDEuoJ4q?=
 =?us-ascii?Q?vLcrMSzKQC/SkO1ykO5NKyYZUeHrfOfDKKNnYms2oREgbrGIgPOx7fZTlgwX?=
 =?us-ascii?Q?IXNlw6G4UlYGmw7W4OlyhW9zC48SVZtQVcyE0P0/rQ7uWw7SvOZ7JFClPVTj?=
 =?us-ascii?Q?cG15JhAcYt82K+ZLpNDWrnxv/3TRuff0embBZ1+ECWwNvr4IxgLzLRDZX+L9?=
 =?us-ascii?Q?YI3lD1U1Q8vmPGYEyZmxnkH6dfiL0s16aXguWy5hrlKfH+Aw4xRv+tOC1nWy?=
 =?us-ascii?Q?6FAnFGWTftWlNVlM2A6DSr87M4JTHXHO8kucXOrOgS5iJBN9W0IJ0aHnWc55?=
 =?us-ascii?Q?UU1eHJPl6mLbpWaXJOTp0HpbAmGC7fugAT3BIhfy5o7IQkPHScGrs6YLSF2T?=
 =?us-ascii?Q?5GTEgp7DE5LFPe/qdPIvMRIWGB2TiQTTE5yJ5yJrlIdABpCXzQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8259ad53-e43c-4037-f081-08d96b42ebed
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 23:15:41.8634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DRJR8ZRMWcl5h0i6PLKO3IphWpJmsxxTbfolHFEKSANudIk6VryVnd7+DYeLiacwk/VFSzKdlDPg7YRPZVSsA==
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
=0A=
"maximum number of open zones" for the description please. "max" is not a w=
ord=0A=
and adding "number of" clarifies the unit of the value.=0A=
=0A=
> +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max active z=
ones"), COLTYPE_NUM },=0A=
=0A=
Same here: "maximum number of active zones".=0A=
=0A=
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
