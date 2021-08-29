Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B210AC432BE
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F264606A5
	for <util-linux@archiver.kernel.org>; Sun, 29 Aug 2021 23:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhH2XIF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 19:08:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50112 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhH2XIE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 19:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630278433; x=1661814433;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tR3twQU9HFXcmb5NkCCMm8W64f/J7g24lRiwpra2ZaE=;
  b=XC6LJaWnDk0y3nrKgoQj7X2jl+V/xd1flFEts6Jf0FIg3YU0CelV5yso
   K8cXcPGiPoeZCtbilkX7oP/MPQjMzKFaTy7kN/L8ZzjELiDoDFOESWG4z
   bZWku/h/0sV1QfDBOM4z1MLpfyMY3AD+NaGKP6pAcwbCvwzy83urPQiS8
   bDd1udGQUrFEgjFsLnI9gyQuRezU3iZXOqnW3oDsVfmuWBSIfss5r09Kz
   zt24+3LQPcI2NUTic/dydWpbNXDjN5BY/GemnolKUmxE7zYYt26uugdGV
   RSmLUuv1EvrS/klsBWWU4MslYMXsLgc0l0N8bSZ6SNJzZ/bVAB0vbb8P0
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="179269865"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 07:07:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUZr4boSDeIhEzuh+XXPdXYT+dMSDYehTdHhFNgrD4lwpRKUADL9AtI//H/jVREhN32pogl8r7YWPTFCOW8fV9WRHHR8A3ZyyPOfIo3F0DRyJ7AXlWJuNpjC3PZ8RuCDhSTwoWXp9vpwoEyttNTJI4Kkv9uE7qDSlLiFzo/czQ+gNq1mJ6svM4IBRBUkAM4LekSB78iat8GSD7+aWgPlATqz1hQLTLGfXM2jRiHU4bOd2R+iydrROzOJD6Vbg+H5fdZ8lsYFOtfom5f/E7qKd8qITbCAMJkgDkI9CnXtJVnAbxMgjskFE9W8nEq+rI/gEe22I3huXoMKheEgY/zLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykUicoXuQIA8sHZs4jIaRWMl8es+3HBbCvHJ9+3dACs=;
 b=RWWKr+Qu9VHuY0uY9in7CmoKAOFpnjUD2mMuqAGno+1Twzgo+xRO0zrDypsVU4wSmBzw1LeSQ0dHnoMqCCQZpH7RSa/d2iXYC8r7xTw1uC0U6onccyQcqUEIRvzMO9IGVmbYy+lhFCcrNoIUss2kytvRgKHIrO8hoOgLHwNJpaBD9B27GLdz7oNaBZTnOWX0QYZJskq2WjDZO/oDDbCqjQCdsdwcN1DqiA5777a+T3nwWUc0GFXpSBO5yPOPGEWdr6U4MYAjBUnRiLyPjST75csNC/3uZgILyH0yq8jStVt1CjrDja/6SPjA16KX0OqqvSFxrM7IsEs0rb7XsLAnGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykUicoXuQIA8sHZs4jIaRWMl8es+3HBbCvHJ9+3dACs=;
 b=eroeHNYE3VjrhDwI2JxjpCTY3ebfCzaBwvK8n8e7pfZ3zPb9P8yGtK7EgfkOjs7H8MOV5+y3UIoVCzy3NRJbr2yH+tacfcmeu/0UovkrDhawh5KWQoirjeKhbDgqcbAi24gMBoEzgbdZBVR9a3gb9c6v7XKsaWtC4WGGSDh5iqk=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5562.namprd04.prod.outlook.com (2603:10b6:5:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Sun, 29 Aug
 2021 23:07:11 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Sun, 29 Aug 2021
 23:07:10 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] lsblk: factor out function to read sysfs param as
 bytes
Thread-Topic: [PATCH v2 1/3] lsblk: factor out function to read sysfs param as
 bytes
Thread-Index: AQHXmxYRmtsLutos6kO3py1CzuRY3g==
Date:   Sun, 29 Aug 2021 23:07:10 +0000
Message-ID: <DM6PR04MB7081FBA5FEB9A90D022991D6E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-2-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c82acf8-f9f8-414f-f53d-08d96b41bb49
x-ms-traffictypediagnostic: DM6PR04MB5562:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB556244D19ACE4C7A772687D8E7CA9@DM6PR04MB5562.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jb/lJFVbT/n4CDyT2AZFLOWEC02ugA+r1qz+jTuqS/sjNc7EOnI/lYfRFLfP1o5070A2MdnIhDmkdrJeq9KBs99MUXi3025afKSsZm6HN/9fhLI2y3bDxcfsxDkrDym4I5OwX3QH6VMwiNoQi3RHe2aFxKN6BD3Y4JdamabLPiICwQb5k4a/YIaWzbcPVEf1ypcGIItaLyeLiTkbkT0R+8VOnv9ltG1Du8BXK5CfIAzLph2rT8IsLFJKfA9KJOkS2z7pWu0BDD3HyqdVS09VhqFsfAys8+QUFERkmKW1Vpc+a6v12zNSiMU3/tfrrcpM7v6JDHr9xq60OBHtQB15txSLtQEMj4Bi0RUiwCFabm3wVTz+tfqGMH9E5anGFxELmEOxeVzvO4F3cwd6QoIvREjLPhr7FM0Xeifr7fScH8KRTT6R6VfBvPfxzBqS66otygFx2YV3y84DG3c9idv6o5em5xrCpbRFLvBdIntrTYU4RtBFObJNda7JBivm5mzOdzXzKznzAgE6UCqG2r7hZZ8bvfDMhp+SC5Ei1x93yMoJPFkx8rCgXnO1eW3K4HKjTV0LvYQ9dG8RXV8ZASA7eZ74l4r9YvKbwmkFpJwEoddV2bL+h0wO/ZranoF/lY6x2yIg2LLe38Y17sxHTeRqExYUhT4jgsGacfrmEsY/wnrpG8sL6wvPzzN5r2PpRMoG80VI+qKR/nt1wZY36iT2BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(9686003)(33656002)(55016002)(83380400001)(71200400001)(66946007)(91956017)(64756008)(5660300002)(66556008)(52536014)(38070700005)(66446008)(186003)(4326008)(110136005)(86362001)(76116006)(316002)(2906002)(38100700002)(122000001)(478600001)(53546011)(8676002)(66476007)(6506007)(8936002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eBXwCW9alAkT0QgQGgZ7ytirVH+HzKp4ijq0xb5fvkCqyo9rla7ufPpHpZIl?=
 =?us-ascii?Q?4JogC7M2nBvsO9stVNjQXyfVkKM/BZwJyy9GCe2P4WsMQzj4FsAGjCHRA4df?=
 =?us-ascii?Q?rYmLI1hUe5fJ8FtrmTyz6rC2J5m6O+GiNrOI+qDYGB+K1hsr389FisiDu77B?=
 =?us-ascii?Q?aBG7g+afyiNPqVRyqiCyvPSiTOhjVmaEfdIwO8NkwgFD05UGLG1UtjXxxkNY?=
 =?us-ascii?Q?V2vXTj4Ie7QfE72WCXbRpDO9gTyXwcrMA+daxRo9dseUwU+OOsEQRNgLxqYK?=
 =?us-ascii?Q?gMRzr1AxFyStQ/tPwg+EveObc2+kiDN5wZVzdL7wl3VV2CEPYo2aOCKDQhnO?=
 =?us-ascii?Q?s5t6VSnkS56GLOgV/LKPhQWMhR9KBcRHOIlD1JWrelZvvF+k0MajVnH3HI1h?=
 =?us-ascii?Q?pAIvNXXkTr/7IX/fOkjSdDPQ9VWIifQwSDI8qmRFoenlMBnVs1ZnbPTEb8rC?=
 =?us-ascii?Q?zfxZnlePl9F6+7PzT9aw29Yo6zMyP+OBYFxC/AnVGmlzB6Dz4lQPU8PRLFrP?=
 =?us-ascii?Q?u4ZTtlWzr4qoO7ZrqU6Tbou0IzE9sqGB0jeNlMUlSXdNM3vdxIbHvZZ9FJwl?=
 =?us-ascii?Q?BIGGpv0PCQcP5yUkb9l+OZlvAVFQWFSBYoBObKf6nJq3yG4JOj/Rb4/zfGop?=
 =?us-ascii?Q?b382KguPHBEmjoZYZYwYcllRmGvQRVtpWy5E0SEpNtl6h48dWFxar0en+Wf6?=
 =?us-ascii?Q?Dz466mnu3NvkNqMJpGPtZcJmwwXZ2msX7g7VsuGgvTx9N/T8tmuwuw+ZfBwk?=
 =?us-ascii?Q?l4FB7GRYD+nKxP7kzu4QVke1ZHhuRWwH8/vDoqyS4CEOnltq395yn/yy6qHa?=
 =?us-ascii?Q?xBM1YthrTchoGSeUQp/7vkFpgy4Yq6FrNAhYEOQIk1w2jXCm32f8fb4KZmfJ?=
 =?us-ascii?Q?a3ZxiQTF+YZtJ7d74ML0mj+N+Z57dANgB6T50o5Zn5G6YCbtE5uXMIOzoEfG?=
 =?us-ascii?Q?GXOsPMNxMNDTMgE5Qmi8tx8SZwu5G8hgYa1YZy479J57ehdriQlopIpf1nxJ?=
 =?us-ascii?Q?lmQfuDJ0SxklOMXFTdORKmw2Vj1C2F+ehBdJkL6dJyf/zSj3l2L49DTPnT+G?=
 =?us-ascii?Q?gcP62lQpeDZF77ena2fUK7uk9frTP0QkgFWXcwjXYZf5TGw6a4pCzh8iJh2b?=
 =?us-ascii?Q?6dnDgy82nrtO4I8GIJgrjd06i0MpFgT6ShuIhCz/j4VF19FRKm8AlskMD8we?=
 =?us-ascii?Q?vsvikVBQlF6NnAayuqVJoiwJ5JqekDqWX68J8mG+Gy0f2dDiyIwlfXwnFSLL?=
 =?us-ascii?Q?5ettfy3rcxemEWvqR7ch/RBKPw1fVe7yIuKfyLDN/plj0VZb0iZy1AFwoYUU?=
 =?us-ascii?Q?z+Hsaj5RcPajtyRPzxAy8BnGcEAcWefvg+gLy9Av6A+3NkaEq1S+4WgzWOt7?=
 =?us-ascii?Q?a5N+d35QhRbvcCqwmkHs9WVNVXxJOs2FCzILRVzmnhIBLQqj+g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c82acf8-f9f8-414f-f53d-08d96b41bb49
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2021 23:07:10.7773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xd+1SvJgXlvyAJf761FtVeS66HTxsK1zn/5scyGo8mlFT7DvWgqfOop+1XE+C+DY6F8FpR7JI/duQMfUr7NxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5562
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/27 16:35, Naohiro Aota wrote:=0A=
> Factor out a new function device_read_bytes() to read a sysfs path as byt=
es=0A=
> for a preparation for the next commit and to reduce the code duplication.=
=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  misc-utils/lsblk.c | 45 ++++++++++++++++++++-------------------------=0A=
>  1 file changed, 20 insertions(+), 25 deletions(-)=0A=
> =0A=
> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c=0A=
> index 100eba0779f8..775a6d832076 100644=0A=
> --- a/misc-utils/lsblk.c=0A=
> +++ b/misc-utils/lsblk.c=0A=
> @@ -708,6 +708,24 @@ static uint64_t device_get_discard_granularity(struc=
t lsblk_device *dev)=0A=
>  	return dev->discard_granularity;=0A=
>  }=0A=
>  =0A=
> +static void device_read_bytes(struct lsblk_device *dev, char *path, char=
 **str,=0A=
> +			      uint64_t *sortdata)=0A=
> +{=0A=
> +	if (lsblk->bytes) {=0A=
> +		ul_path_read_string(dev->sysfs, str, path);=0A=
> +		if (sortdata)=0A=
> +			str2u64(*str, sortdata);=0A=
=0A=
You could return early here to avoid the else...=0A=
=0A=
> +	} else {=0A=
> +		uint64_t x;=0A=
> +=0A=
> +		if (ul_path_read_u64(dev->sysfs, &x, path) =3D=3D 0) {=0A=
> +			*str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);=0A=
> +			if (sortdata)=0A=
> +				*sortdata =3D x;=0A=
> +		}=0A=
> +	}=0A=
> +}=0A=
> +=0A=
>  /*=0A=
>   * Generates data (string) for column specified by column ID for specifi=
ed device. If sortdata=0A=
>   * is not NULL then returns number usable to sort the column if the data=
 are available for the=0A=
> @@ -1033,18 +1051,7 @@ static char *device_get_data(=0A=
>  		}=0A=
>  		break;=0A=
>  	case COL_DMAX:=0A=
> -		if (lsblk->bytes) {=0A=
> -			ul_path_read_string(dev->sysfs, &str, "queue/discard_max_bytes");=0A=
> -			if (sortdata)=0A=
> -				str2u64(str, sortdata);=0A=
> -		} else {=0A=
> -			uint64_t x;=0A=
> -			if (ul_path_read_u64(dev->sysfs, &x, "queue/discard_max_bytes") =3D=
=3D 0) {=0A=
> -				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);=0A=
> -				if (sortdata)=0A=
> -					*sortdata =3D x;=0A=
> -			}=0A=
> -		}=0A=
> +		device_read_bytes(dev, "queue/discard_max_bytes", &str, sortdata);=0A=
>  		break;=0A=
>  	case COL_DZERO:=0A=
>  		if (device_get_discard_granularity(dev) > 0)=0A=
> @@ -1053,19 +1060,7 @@ static char *device_get_data(=0A=
>  			str =3D xstrdup("0");=0A=
>  		break;=0A=
>  	case COL_WSAME:=0A=
> -		if (lsblk->bytes) {=0A=
> -			ul_path_read_string(dev->sysfs, &str, "queue/write_same_max_bytes");=
=0A=
> -			if (sortdata)=0A=
> -				str2u64(str, sortdata);=0A=
> -		} else {=0A=
> -			uint64_t x;=0A=
> -=0A=
> -			if (ul_path_read_u64(dev->sysfs, &x, "queue/write_same_max_bytes") =
=3D=3D 0) {=0A=
> -				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);=0A=
> -				if (sortdata)=0A=
> -					*sortdata =3D x;=0A=
> -			}=0A=
> -		}=0A=
> +		device_read_bytes(dev, "queue/write_same_max_bytes", &str, sortdata);=
=0A=
>  		if (!str)=0A=
>  			str =3D xstrdup("0");=0A=
>  		break;=0A=
> =0A=
=0A=
Apart from the optional nit above, looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
