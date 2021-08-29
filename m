Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F49C432BE
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE8560E97
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhH2XO7 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:14:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:1363 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XO6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 19:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630278845; x=1661814845;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3h983Ja15bhlgh+78v+GgvuNuoXIXbEXTxA4VuvnxTY=;
  b=I6LvXJ+6wTlwYMIpvB2CzSVyCC8ROkDENbj+N1yVS4meXHIUt8KMxCyN
   TKshvoAuhQJO/rvipPClZf0mrvFYVEW0/kXmRKF0vC7HeW2XeLfBeVN//
   OLLtlurhXHHHn0RobHJXJEpHL8p0DPMQO/NScwVSx+G4PK6nFId4WdZ7Q
   seg/BUKwP5czJ4dFTo9127tBueTFxeJsfIwfTK/+jaacPaI4Ew6eOboVK
   zSG6tPnMYPNpK0qTJTvyIHx0xnoWzMnkmsMN6NmPJRSHTy+gD3qfFEoly
   zp6hhv4UBFuxLvJ37dnv64sKO3AbtyXXjckSJqkpunfqVZcIqagd1MDcW
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="177825928"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 07:14:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq1L4dXZAW9vzN23XB4QIdKWozsvYfE9Hpb2T78iloBVo7JNbd6q49n2ASFeJ60RXv+LGW2hGpr5PFmcxPp82gzr/QQ33IU9e+bk2FMtJsWSaxT6hgCGhjkd7WgYAfV3BL8ldltM7zl/ct3J2QeU1OGOgC/jUoaGB+iUZizTNyilT3F/q8EGYpiaLgqdNyeoq+uaEEftK47SvS1nPjMHinD60teSHnwikJmYry6ik+YmXrkhIljj4L3gToBaUv96YX26JQXmHF0SpEf4BfnLHVwoxGtjkHQHtIYtDVbfE1Qj3NpUOY5Ha6dFLqIuhDJHZRe9ea7ehTzVoB1FXJ0CXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XQcBXVHqFXVVsO6+04LVf551nbXP8cNvpcn1NOOMEY=;
 b=FiST82LOf6V53j8Qwx5VW/KFtdVncXJyAHK6Y0iamn3ntnOL2FYltdwqRyWk4mgUELe1+gbtKJ62wSPrm5gkzGGC7jXic34+tarfTx78dXUKVJi3jZjqdrd+5CHQofLO+L2X4P04pDTiXIac4T4hpL739ESmamZuv9iyz6kTQ/Y31lHF5a+LUVKj9P62ysKl4x+VPzWYIK5P2eEqYOQrvGhi9Y5qQpl8CxtvGbXzkROFKiKCeS2HGV8Z4cLlddclVZbQG6qeeyOiGTKa1fCy4ql2MUdWjMn3CBc22t/ikYEy1DShH3dikj5byF0s93F2pDwh44SyW9PT5qUa7CNHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XQcBXVHqFXVVsO6+04LVf551nbXP8cNvpcn1NOOMEY=;
 b=LadBHcQEhjECJmuwdoxxr3kbZDyqpbCYuqVS4cElfxsCCYpmVflA0YNmCDaZoBRtDClTsIWSNQShQuDayNSV/Ei6P8yl605ylKyPEhdNfb9qJ3YjTIgGOtU1PwvV9qJZsA9uoP0jquhYCK9iuSD5pCqc/nDky9ffvMTqFYqgYAQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4409.namprd04.prod.outlook.com (2603:10b6:5:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Sun, 29 Aug
 2021 23:14:04 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 23:14:04 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] lsblk: add zoned columns to "lsblk -z"
Thread-Topic: [PATCH v2 3/3] lsblk: add zoned columns to "lsblk -z"
Thread-Index: AQHXmxYS+A0mAID8JEWCYn1KRaz+6g==
Date:   Sun, 29 Aug 2021 23:14:04 +0000
Message-ID: <DM6PR04MB70810B6213142A1CE6CFAB60E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a91960e-c697-4355-9db3-08d96b42b196
x-ms-traffictypediagnostic: DM6PR04MB4409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB44093283214A9C27784B8A92E7CA9@DM6PR04MB4409.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmrjJxSYdL02ReggpCjESHJbulUtxDxm8jecWWVJWiK9n7rS0tA9kWI0dV87+BtWbxzEUNGSiRke++4XFvjtJn9rfGqZr+fu7hg2trtpwPTOF08ZMjV++F7H2v4huOmsoYXEH/9csRD1iu2nShRUfaqZ5sYU8Rl7ToQtSmi23Ho+303XlbzUmI4vWjr7/Vm5rf7/f6Iz0XOjv4NbRvoFxmDljPH2o8I1Xc4TNyg5Ap5OraVsQeNjDpyxdd+jj8vUoOWgRCGOjuImqU29zmbpDLIIwuMvnFL98gYhu3GLjBsQOzhO2SdInYYbzQiCcXsdqSDxj64pI2/I580L+hqllUMxj/etAgKZBbyrQb0Nhm3mcASH2G+XjUTtnJnPECtZWdsHBBa+mgWE/YhiBziV6b0Vz2o6r3UNq7gCplPkFQH+wr/yOIabrBredDIuh1+oKNUddcuind/8f7AS8rwLlJ9rmFThQszcbRprIC0O8hGCmM5FrTV/B0u8QKvQg0BXcOHbVkXjct+p8PuvI9tCrI/OA9KKpJgMlP4MCCYvMKmyLe23osII7iDAioSQkVy3e3gslxlvVCZR3J8MSkMtH30w+MzKQ5MGZ6ehS5iKRmPKmyyBU6BmNBVt0oHt0L1RNjFZr8T2Vg3XOGqh8MFzQe/zVvgT9W9V5sB52y0y+JZSJcfeOUc0uAwk6wE4MVoMSmLfkm8CHVorsyZQoT5GfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(66556008)(64756008)(8676002)(186003)(38100700002)(86362001)(33656002)(83380400001)(38070700005)(91956017)(76116006)(71200400001)(66946007)(66476007)(2906002)(9686003)(66446008)(55016002)(7696005)(5660300002)(110136005)(6506007)(122000001)(316002)(53546011)(52536014)(8936002)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NVKx/R1a7+eyUGwkuyingwgHvNplqY57hGkvQd+DXSuUTPevfxLEZO9XPigZ?=
 =?us-ascii?Q?Jl8NYSEfZ/SU0ETIHMXu58EoU9FZpWdMKMFOFkpMks6eplXfYzHFKpixQUgD?=
 =?us-ascii?Q?8jlcDsHuFDwYErjTArt/qWeLSOmTiVdeyGeRorlBFrKu4S5/CV06c+CwO6t7?=
 =?us-ascii?Q?2b4+gm0IP8+Bxxet/x8BaytDjbDV/iZ2n5UErzyJ2c+S2XsBRtKpohvzV2L4?=
 =?us-ascii?Q?TjImrKOB36BcaPoE+MqDpr0CxSpO0Clg1Hgp4j/joiSOF1pYP72WQm7T+j0Q?=
 =?us-ascii?Q?P3jlb9NxPANdQ8eWMOjYL9MvcCrVgPJsrrKZGkD+RHSH4gDIsnN8ZLHm6fxh?=
 =?us-ascii?Q?meuhvfAxM59hpCeXjsLdzlMG5i8NXhJNlUptPNJu8eHUtKxyjwSPJbyAWa+v?=
 =?us-ascii?Q?NzxoyMoDYo4+HiGIPCv1uvKWaU6gYt9YwIiCRFflMtivK5mVdhHdbhIpcivG?=
 =?us-ascii?Q?SfAuml9MORtmTR7ZgurJaNwPZnQqor0vqhRSIB18tLTlVlDClaPd0YgxS7Yh?=
 =?us-ascii?Q?weeaKG+41fVQu3hAcc/B5xSjf1h7XaS6lKpUUGu8G90+PR/gDcuS1Ddg9Av5?=
 =?us-ascii?Q?SU4RZTZhsUyJwVTiD/bWK4dPUpuRDbiFXi4ekq0iPG7sFsMMkY+8sMVJHv7W?=
 =?us-ascii?Q?KxiP5YXXrkKaUS1kGlBUjWOU8bzHv4O3cgioxLrQueLjW/zV6uyWTXfd4GAR?=
 =?us-ascii?Q?jqBgxF2S06dy0+aW2oScLwVQLbu3PBi68HJ9AGvY0F9Md0ytiMWsdLqfATTz?=
 =?us-ascii?Q?xvkPSN7c6MF2s00NeeUqLumNQhBqxOBrhTZaSzSYij6dindXe+WGKPRKq2cN?=
 =?us-ascii?Q?ShBOGo48QnzmbIIXGoQMx2/ElmSoUV85IGVGhs8NAeMKOYXiUFpA67nqTwWL?=
 =?us-ascii?Q?g0RRD9eyUTEIOFVWo9yqJ+OgA8eJaOI/oV9JrWUoxsJQY3hWR50bTs9xvfjg?=
 =?us-ascii?Q?ROMrLUgtkDkdzXn/xzPryBfN7aoj+xpVmenzGiUJDJ+tY2QmuXN5ceG8sUtm?=
 =?us-ascii?Q?UtIm4kczQmexz5g1QqMtRhTxOXbvyH4TJfyVOsBA9rnhjcZ3tDMwzFuect9d?=
 =?us-ascii?Q?LjhIfImDgywRyJy9Jy7UGDsWX9pT7vc5aW8/5vati5KdM0M8IgqI8whLd2SU?=
 =?us-ascii?Q?pXN+0jKHJguqu/nm75Uj3ITtqh6X+0yi/naeEnnshrAQcqDm3CfermwJuu2g?=
 =?us-ascii?Q?ZF7z81ww1Pcv9pFx/2rPKeUftpQTSepXsubAfn4LQC9k4qI8yg8Fn2tSGGrM?=
 =?us-ascii?Q?tYiUANtktiWjU3x9kiUVxK/yCMmgsQCSU1tmymLZsqm7KE1k+WcklIOpxsWJ?=
 =?us-ascii?Q?IzfeF4zE/Cgoh5QTWjM2MhN7ay1PdgsWAUZM4iUJ+06wTEw6IN3o6juBgg6f?=
 =?us-ascii?Q?Zhqr+56B9w/g+Qc7lVjpTnfDiKtYaSPx9ditgBOjo8f9CdiblA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a91960e-c697-4355-9db3-08d96b42b196
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 23:14:04.0669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7yNWIldDTHRPPUb5G6OHnG28XDbI5mchDVEOt2I/MZes5WB8soXW0rMIUghdZO1Ucjs9jz40eQPyaFOi67hPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4409
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/27 16:35, Naohiro Aota wrote:=0A=
> Add zoned columns to the "-z" option as follow.=0A=
> =0A=
> $ lsblk -z -i=0A=
> NAME        ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZON=
E-GRAN=0A=
> sda         host-managed    256M   55880         0       128     672K    =
    4K=0A=
> sdb         host-managed    256M   55880         0       128     672K    =
    4K=0A=
> zram0       none              0B       0         0         0       0B    =
    0B=0A=
> nvme2n1     none              0B       0         0         0       0B    =
    0B=0A=
> |-nvme2n1p1 none              0B       0         0         0       0B    =
    0B=0A=
> |-nvme2n1p2 none              0B       0         0         0       0B    =
    0B=0A=
> `-nvme2n1p3 none              0B       0         0         0       0B    =
    0B=0A=
> nvme0n1     none              0B       0         0         0       0B    =
    0B=0A=
> nvme1n1     none              0B       0         0         0       0B    =
    0B=0A=
> nvme0n2     host-managed      2G    1844        14        14       4M    =
    4K=0A=
> nvme1n2     host-managed      2G    1844        14        14       4M    =
    4K>=0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  misc-utils/lsblk.8.adoc | 2 +-=0A=
>  misc-utils/lsblk.c      | 8 +++++++-=0A=
>  2 files changed, 8 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc=0A=
> index 7356976403a7..9e68a847ce0c 100644=0A=
> --- a/misc-utils/lsblk.8.adoc=0A=
> +++ b/misc-utils/lsblk.8.adoc=0A=
> @@ -116,7 +116,7 @@ Specifies output width as a number of characters. The=
 default is the number of t=0A=
>  Sort output lines by _column_. This option enables *--list* output forma=
t by default. It is possible to use the option *--tree* to force tree-like =
output and than the tree branches are sorted by the _column_.=0A=
>  =0A=
>  *-z*, *--zoned*::=0A=
> -Print the zone model for each device.=0A=
> +Print the zone related information for each device.=0A=
>  =0A=
>  *--sysroot* _directory_::=0A=
>  Gather data for a Linux instance other than the instance from which the =
*lsblk* command is issued. The specified directory is the system root of th=
e Linux instance to be inspected. The real device nodes in the target direc=
tory can be replaced by text files with udev attributes.=0A=
> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c=0A=
> index 108c8187498e..8a2578312f0d 100644=0A=
> --- a/misc-utils/lsblk.c=0A=
> +++ b/misc-utils/lsblk.c=0A=
> @@ -1919,7 +1919,7 @@ static void __attribute__((__noreturn__)) usage(voi=
d)=0A=
>  	fputs(_(" -t, --topology       output info about topology\n"), out);=0A=
>  	fputs(_(" -w, --width <num>    specifies output width as number of char=
acters\n"), out);=0A=
>  	fputs(_(" -x, --sort <column>  sort output by <column>\n"), out);=0A=
> -	fputs(_(" -z, --zoned          print zone model\n"), out);=0A=
> +	fputs(_(" -z, --zoned          print zone related information\n"), out)=
;=0A=
>  	fputs(_("     --sysroot <dir>  use specified directory as system root\n=
"), out);=0A=
>  	fputs(USAGE_SEPARATOR, out);=0A=
>  	printf(USAGE_HELP_OPTIONS(22));=0A=
> @@ -2041,6 +2041,12 @@ int main(int argc, char *argv[])=0A=
>  		case 'z':=0A=
>  			add_uniq_column(COL_NAME);=0A=
>  			add_uniq_column(COL_ZONED);=0A=
> +			add_uniq_column(COL_ZONESIZE);=0A=
> +			add_uniq_column(COL_ZONE_NR);=0A=
> +			add_uniq_column(COL_ZONE_AMAX);=0A=
> +			add_uniq_column(COL_ZONE_OMAX);=0A=
> +			add_uniq_column(COL_ZONEAPPEND);=0A=
> +			add_uniq_column(COL_ZONEWRITEGRAN);=0A=
>  			break;=0A=
>  		case 'e':=0A=
>  			parse_excludes(optarg);=0A=
> =0A=
=0A=
Looks good, modulo the change to ZONE-WGRAN.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
