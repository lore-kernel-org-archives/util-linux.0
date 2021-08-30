Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12096C432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 06:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E6560698
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 06:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhH3GXH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 30 Aug 2021 02:23:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48469 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhH3GXG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 30 Aug 2021 02:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630304533; x=1661840533;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GqqEMcGrEvqYAEDt8K8cSqVOvvHqBwxMzDZF78od3I8=;
  b=UbO16PQj36X1hDdMfQzzpWsYbLc3Xy/6HFTXSQm3crbeFpMMdHTWkD7H
   VXgR+ZsgINamJE9mmS11/Bw1ByiK88BNiIdZffs6TL+ODTKlRgwyP41/+
   ckSwcstz9bENlbpVSk9mZY8xueLEtgTQV5EApqndt5Ybw3XSpI4APmRpm
   xetvjY+r0d05er+HeOWAWsgtEu3Dn0PtbIa3pFC9KGMmheTpczhp+6rzP
   MdbQFuEokqy/spvTbxO4CDm3ubrdkV3kWJCEFEk/RSWtS4n5lXSr+MMWp
   qYEIuXLXlBzBxp1xf8TRmmex/3SPxQvODkOPQk70DZ6OQHgjvEIl0KLFM
   w==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="183518921"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 14:22:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+ajm+MqYrRo07YZGVDe2rzewosa5kZMbjPtQD58SCrWtXOmbJl6AStWf2VDKasLc/evQljocsMpT6haZyUaXPXhB+PSWk09AEWXxIp90GBUrQQx4yx4vK+EEIQUglV+k5nNkBJPDo63RNP40YaxRG2hKLasKV6fAo1BamaFAdzWhyIwFXzGkwvhYUeOneHtcHxJIpNC+nMTQIIldzOBrqDW5vnA/HRuqQy3N2gjVbXo4rMjoxXazl2/8CAzUXv43z/Up7Mw4aWeYpVceCFfdno2gwh/+FtELEj1BaMcIcmc21o9xRKHt7Jd+F4Af2tQqeYB2Tw0PVhUuL6nvrk7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoZA2lvYW3moH3DzBiH5xwFe4HY3gI3psMwPUUyE/mk=;
 b=O+lnQceWRvirrOvzAJeh5N0AmnQB4jGos7a8qmBNIKjL3cLQdvcmxOLm1HP/19ic2cgwe5t3y/Qo3rhq1S54/UUboaxnhX6klgydaL6b4LtvyPIKA2EmalBFmIKZUFz/orifg/HP435tIko9hFzmjSGd5zOFw8YLOhWQRcjHW3Sx4V8Yw1NUthgC5+2XLKFKRtiIBM/bpRDwGno4Bnkq8G/j8+oPDuq89AoUEKKdlGdCjvgHFh6MNk1gSJID1jUx1nX6wcZfclkpK0evyJX+EtLlXLWbVBBXgETFpMAVlHfzWXXX6arB8LBiSWTdKmK2tznd4qNrgyHmsK0/cxMNfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoZA2lvYW3moH3DzBiH5xwFe4HY3gI3psMwPUUyE/mk=;
 b=vgb0i8sl4NsKOgMY+BfoKkbkTG5zFWrF1QQsVwEB0s9q5QiuZBxvwEbMM5Js92fANyxzXHqZf6mAkJ67+bB6ZeKusA7gQvQ4LJRPdNswFPtxAo+0lFKfHewtuY41T3ujXBPGmnS1uTCrWupBgE6GL3oKf0TrVZeuqJUEigacWOg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB0443.namprd04.prod.outlook.com (2603:10b6:3:a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Mon, 30 Aug
 2021 06:22:10 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 06:22:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v3 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXnWNVRk0KFQDp60OiUuVZn1ZmXw==
Date:   Mon, 30 Aug 2021 06:22:10 +0000
Message-ID: <DM6PR04MB7081927F22748C5651AF80B4E7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210830055257.1832523-1-naohiro.aota@wdc.com>
 <20210830055257.1832523-3-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fca6778d-3737-4ac2-5098-08d96b7e7fbe
x-ms-traffictypediagnostic: DM5PR04MB0443:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB0443126E1BFB3282213971FCE7CB9@DM5PR04MB0443.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:206;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCJNVGcae8jAHak0Ayqr1m0gkX8oCWnIbohFKq5j5vNytq93IGgzkKcWimnBW13KT2MFzX97G6JsQgFT/zAe66LAUoVpqawIvyIRISsI/jcW7U8HwXs5/f0FrKOjZPhVC5liqAZ5HEQyelURtIITzzqADl4Tw61cGUZTyoXYEiP7w8RmTER/7xX5/LDNCm172rBfQztDpvoo0hltBcHBFh+YDYtt3o4pOOlu2IQHcqvOPFyZEcHnA5WFYcL6gEwXhNWMxqBn048b/7D6SQBdFciKn79aAR2U71pqUpE2sMnrjn++F6N9O0ErbouL5Fp92Z+J6JC+3SJYSmZJLQAhhrq0i4C6kY1buo7gf5PKgw1JUfzY04gEkPNJUFHKoTvufvOMUFhtm7zYizNX1jxPBmxKs8zejRTmIf8XodhhV+dQKOLyOWstRUzy8n8dvlTV3lDUUHLrfspmevECHacs1vKhty0DrL8WLpVzMTdu6fAuHGc/H6snxkTySr0NI6Mbr7b8Hpc4WUvJoCj3bFdc0qblKkTrn/xhF6sXr6LZH2Fn9DaS71E3S1nmTnBH8Yw6Kef85xvwm41PACa+xuScR9zOsTRs9KpVjEORtHBC/uGiznQ7o0A8fyWpVX9LuRjiBxNi31u1fnEYMZ/ab6WiZb8nENCfyPqsxblPmc9SlMOYStK3Znf4I28jqH1YnRC8Edhr36enwC+auCm2odjSyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(66476007)(38070700005)(316002)(66446008)(64756008)(66556008)(6506007)(5660300002)(110136005)(76116006)(91956017)(66946007)(86362001)(7696005)(2906002)(478600001)(53546011)(71200400001)(55016002)(83380400001)(8936002)(122000001)(186003)(4326008)(38100700002)(33656002)(8676002)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D/dJ5GpJb999ya9Ludq3/n2hu5A7Hdj6fosiAN4QVkcq83OyQt9t4Z/s4Kxc?=
 =?us-ascii?Q?WrPaM49MQZE3UZuUnlPVurfU3iraEd4CtgunEqfr7tMFlqgh/Z4pDS/RV5vG?=
 =?us-ascii?Q?uX8ZB/FzW9j3IhMf+vV1dYrjwD/Pahk69rYt6CG7GmXcQZQV57uT+CTPcRKt?=
 =?us-ascii?Q?WSz8pOCMMEFYkW+MiJMuIeBFLTJ881r21js+3ae1W+z/h7QNsnuPDKiHHgU+?=
 =?us-ascii?Q?6Q6NAhme6abygY6uXygA2L8LrQRR4DvvTy2S3Arqe5uTBK9SYhYPTyAW2PTG?=
 =?us-ascii?Q?HVkhoh4E6f6ng5vsuPpilQYYTZyVd8IHAU1NyBl6qROLpY8KzdtpVxMQzU8N?=
 =?us-ascii?Q?Z6g5V1AGSUcDOfhI+EyNrZp3c8vRttesBcXJOJTTFGUBYBmijU8gMWwl4zEI?=
 =?us-ascii?Q?8GrXvQmjuDWEwl5nJWczXwYV1aiOWkRLmxc+qzj4P3Qvw7MUErzSX/Z9OGF5?=
 =?us-ascii?Q?kzZ5nXW4ztaWJKmc3lcoptaOPPI57sVSZhyg7u2Z5XHa4opmlFKwP6KxYSii?=
 =?us-ascii?Q?N+z/YFM39i7z1rNQeN+YssVFnsKbJfonPci3HJFouiDAsWB3a1NrdXy5atmh?=
 =?us-ascii?Q?jIhLE4u0P8C12NaZo5BfmSR9HgYF8XhVTJQCtd2dkZsTe36Gd3odWbsYzYag?=
 =?us-ascii?Q?c8/S4ejUviIvdHnxAk9SYcdKpz2klvaibjd5hDe2EBQc7tA9akv+NGgcBgB5?=
 =?us-ascii?Q?8KbGi9LLFAenyeD2k4Bc2f6wdPDC5mhB8UlDIjyYi9MM4Ga7XfNB2NmhYyYE?=
 =?us-ascii?Q?7jS4bWM3hgcUvuw7mPZU6YCi+QP9gLi/DCtQ9waPLbF4PyBGade35u/YOdC3?=
 =?us-ascii?Q?Wc1ObdOC26Zr9yokKdcMBpmXkpxBCZ4VodWERYp3fqRvGFtsj6nUNpCVEWjg?=
 =?us-ascii?Q?3at+x0mOCWVKYDU2xlTovT3cyTsKOP599kdpimhJgYewCiGQKaNkzMJrsTG+?=
 =?us-ascii?Q?LPmDu6gp7GEgOtaM4T94ljoffXObNeaEHPFfNBw9Mrw2IM+yWISliZHF+ft1?=
 =?us-ascii?Q?kEahvUKvtItLo6ecmAPU+VQLJi9bOL3hhmJaUzd/hsilgoewyvQa1jC/tYaW?=
 =?us-ascii?Q?4g0FlsVnoFal8uu2YYlrM6jiM1iVik2EC3hI9Tb9BbSj6bisQu+IYNSs49e5?=
 =?us-ascii?Q?An4f9NQBIPFYXezlc7OhPq+L344/PsiwdpPle4oywFcyoyrkGL4GaNjtXY3P?=
 =?us-ascii?Q?277fl9/TlZ3Vk0IvjMrxh5qJK8o/vcA9nXSHzrNuNGkHIFmtrOM7UrrLQv+4?=
 =?us-ascii?Q?NM+hvO8Q2kGKQUIZiNBAhjb2nkVYjHR9tyE/6Ep3B4V/dDd7OXgqKK/4OTMm?=
 =?us-ascii?Q?lK3zANNt0pFhrokXs+PhvBUr6k+sgcMYPFsuxkT+DKLINXpet1vXJhcraxDb?=
 =?us-ascii?Q?eOdpD80/SfjmK4/Wzh44Wns3Q6HysbpB3yUh2tiaA3J8QzavZw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca6778d-3737-4ac2-5098-08d96b7e7fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 06:22:10.1681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CyHppelxlCK5SsYXNzCQzBnijKJpFmaUAkWkxfzVz+98HYjRP3kKN/xbd7MYD4WMsCYIjdoV3/dSW+IpK+7EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0443
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/30 14:53, Naohiro Aota wrote:=0A=
> Several parameters for zoned devices are missing from lsblk's columns. Th=
is=0A=
> commit introduces them as following.=0A=
> =0A=
>  ZONE-SZ     zone size=0A=
>  ZONE-WGRAN  zone write granularity=0A=
>  ZONE-APP    zone append max bytes=0A=
>  ZONE-NR     number of zones=0A=
>  ZONE-OMAX   maximum number of open zones=0A=
>  ZONE-AMAX   maximum number of active zones=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  bash-completion/lsblk |  3 ++-=0A=
>  misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
>  2 files changed, 54 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/bash-completion/lsblk b/bash-completion/lsblk=0A=
> index 731ef3f4095d..ca0ad39d7345 100644=0A=
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
NE-WGRAN=0A=
> +		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX=0A=
>  	"=0A=
>  =0A=
>  	case $prev in=0A=
> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c=0A=
> index 9c41e70adad7..807ddcfea631 100644=0A=
> --- a/misc-utils/lsblk.c=0A=
> +++ b/misc-utils/lsblk.c=0A=
> @@ -123,6 +123,12 @@ enum {=0A=
>  	COL_WSAME,=0A=
>  	COL_WWN,=0A=
>  	COL_ZONED,=0A=
> +	COL_ZONE_SZ,=0A=
> +	COL_ZONE_WGRAN,=0A=
> +	COL_ZONE_APP,=0A=
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
> +	[COL_ZONE_SZ] =3D { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), COLT=
YPE_NUM },=0A=
> +	[COL_ZONE_WGRAN] =3D { "ZONE-WGRAN", 10, SCOLS_FL_RIGHT, N_("zone write=
 granularity"), COLTYPE_NUM },=0A=
> +	[COL_ZONE_APP] =3D { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone append ma=
x bytes"), COLTYPE_NUM },=0A=
> +	[COL_ZONE_NR] =3D { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones")=
, COLTYPE_NUM },=0A=
> +	[COL_ZONE_OMAX] =3D { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("maximum numb=
er of open zones"), COLTYPE_NUM },=0A=
> +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("maximum numb=
er of active zones"), COLTYPE_NUM },=0A=
>  };=0A=
>  =0A=
>  struct lsblk *lsblk;	/* global handler */=0A=
> @@ -1068,6 +1080,46 @@ static char *device_get_data(=0A=
>  	case COL_ZONED:=0A=
>  		ul_path_read_string(dev->sysfs, &str, "queue/zoned");=0A=
>  		break;=0A=
> +	case COL_ZONE_SZ:=0A=
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
> +	case COL_ZONE_WGRAN:=0A=
> +		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdata)=
;=0A=
> +		break;=0A=
> +	case COL_ZONE_APP:=0A=
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
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
