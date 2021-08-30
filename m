Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB175C432BE
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F98560ED8
	for <util-linux@archiver.kernel.org>; Mon, 30 Aug 2021 01:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhH3Bvx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 29 Aug 2021 21:51:53 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59221 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhH3Bvx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 29 Aug 2021 21:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1630288260; x=1661824260;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cyX0HwHByvm/i1OLj3RFRLeEd8yHJbNJq8M7dNEkzjE=;
  b=hfCQaG2U7gjl2TMfHZJhwp9rDLb4OAZUbFTlzW3NHpf26QvjlZe7n4S0
   dp4Uv0GOKam4h780LYxzsK4aWu6YCJ5WMkYG1JMtrgVI4l6tSrcMJ7Evc
   PNAN2gXravLLU6p9vT759rpYVfLhJNlv+S4U56Cz8QO1R6yKjqHOYzLYl
   I4mP++QjeLIAU9qmp5GouSsJzZ0pxLzSPreQ6bqYrm9qtKUi/p4ptlIZH
   7SwqKBYT6yZ6VnJrKPhZEv0Z9dM8ezqRLAjIB9IR2T33FWAE+NWq0Vf+/
   wNNx84nWKdwXy3vftlr/Oih8Ow9gTmAVkIbb32nu8MYO3u8pg7lLIXJst
   g==;
X-IronPort-AV: E=Sophos;i="5.84,362,1620662400"; 
   d="scan'208";a="282512223"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2021 09:50:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEBFZa53oz0mo0YNDE/3jhc5j+cJKSagzzzIQCmqedeMG77tq4p6ecnBBUYMGRzHmGC782WV3ITMMQk+457l+MzC5icU+AryBtv1fugLYEB+ECTqEo/dZezvT3GcwcNdxroqKWDH6ulawWKog6UAG5xpCbEJpwXvEIWPREeRyYDAIi599lQ2BbKo3RwZsS1dqZxcisuSmIHCbQFBE1Y/XlkCspMcTGIlEhAPOzrCAxeiE1ONi3g7voWYeQbmH6hBvFevGJmFN6Uie6lawVEHTAr4a2OM2CzYCGwlaljPeADXnbOWwbeC7T8cXRon4YjeUW5HYKFBACU2vGMSYCuMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqln6TAf/Zzs8BLCy7T6G+dcYEqg0FHsURqMnN0SJQ=;
 b=ZABpp1wZ7mA3W72y8+xZY16GtY+wJCuWXYRFzc7Itc+Qh+kZ+xTcwVg4Gtv64YSEGaEwoQ1uLlgAe1hnX5Hroh8gqHtvkci1ME7ZZ3jX2gv1/yImu7GK2Cgfq3pp5f5HbcGchUU1uUF5Mpjiy7LAfDnJEyITPnWkHOVHAwLf/cZOpUWPk/OobBuGMjdYgLjpVry8cQQsrpNSAmvRqRJi+aDoUz+I11cjshFyf4npMBeN8JuTl4mbLDtf5PEqiRFk3hqLDOt7bRGmlVyPY3YgaP/Lc923BcSxuL3l03pjHmExxZpodzx9sO5NIYi5ZiexBZ/LIxSV4HoCBLjRHWm04g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqln6TAf/Zzs8BLCy7T6G+dcYEqg0FHsURqMnN0SJQ=;
 b=CFBn0SE35IzYuNWkjJdLl/98HuR6SJ3d5LbHeB5+GtS0+0ZaIc9ebmJ52KpiWoFvvMbgExJDaHVDTt1nHTsGh2CoPYp1AskxmLdPIu7APMJgHPyoxEyGczuENvkRjM1hY2ywkBrDEvcWkBFxyxI3ywju1SRyVtMOUuxiyPxTg6U=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (10.186.141.213) by
 DM5PR04MB0442.namprd04.prod.outlook.com (10.173.175.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.23; Mon, 30 Aug 2021 01:50:58 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 01:50:58 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Topic: [PATCH v2 2/3] lsblk: add columns of zoned parameters
Thread-Index: AQHXmxYSqEoC9GplH0GLIlxliojy8g==
Date:   Mon, 30 Aug 2021 01:50:58 +0000
Message-ID: <DM6PR04MB7081D86532E0B4658ED116DEE7CB9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210827073453.4079636-1-naohiro.aota@wdc.com>
 <20210827073453.4079636-3-naohiro.aota@wdc.com>
 <DM6PR04MB7081F921F5DF2E1D8E35D350E7CA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <20210830010806.w2v2zmm6i5smcoou@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae5cb93d-60b6-4e30-0d12-08d96b589cf5
x-ms-traffictypediagnostic: DM5PR04MB0442:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR04MB04429FC643D717EDA573D4B7E7CB9@DM5PR04MB0442.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MoaYJhJ0PCXG4aLjjGn78IlEfCQyAEm6D+D2o8EHyJKDxR69GTub744GNFmGUkvaBTYeo6LbAbVZ/DfwcgDu/y0Oz/N7c5nFsj402tp9WIQRkW97XpeyGSX7cveF2KJyxDp4ZK93Mb4rWM5wQ4e66QSJSQ1Owo2Vi8Y2zL70ES4SwYvQc8r04j/OQcAD1lF+50z8wGUlHR5tj65OaBO4Cx5+h6iQG4ZpM4BDGKrcWv88Ir66xnsVIuSqduSdz33HhFAtzOn5fKGM+VoVjJgJe0c3YtNlTxfRr+pbi2m7eRs6TcTiBHhLBWCkz9fQQeqMgWAswMsH3uOxyNRQJjwR5r/Shlh6c7O1Lz9aX2ke9w91o5lxWpxtJKMdIWBfdDdX1a5Y6JnzKmoXohKZxxbuJPhszMaOT3Bqz0tbOBAhX18Fa/+wMkYN9mX3x38qDbbNGrSMROzEIlW+hne86HBCWABeCPh/BWHovj50ILipqLrPCyU5uSZMCvzTeCwzo/IAzNNXwV6F1B3dlj5tFj1C2p/sGe2m7aHLK4JLExXPg6recsWKSW4KJDLBsLGSMSrKUoBTY/O9WW8K/x45O0r38RUA+JmfO2Zqxryniv7CYWTLybmnvPXPq9sPoVWp+t4giZBQWR7ZSe9KTOx43P/LowBrFpxR3IZ1FQOS8Geo/uACA7Rch8SjeWxSnrU+3JHHKS4qWO3DuxGOiNx8gG2M/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(66556008)(66446008)(2906002)(66476007)(64756008)(6862004)(54906003)(52536014)(71200400001)(6506007)(53546011)(122000001)(7696005)(5660300002)(38070700005)(8936002)(4326008)(316002)(33656002)(186003)(86362001)(9686003)(55016002)(66946007)(38100700002)(76116006)(91956017)(478600001)(8676002)(6636002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/C/YgWarFYfQfZbZQP4RLLmlyNyRilQKEPnmJj68ZGmP4ad9JELNFzxVKTxa?=
 =?us-ascii?Q?aSy32EEENDzLzMw7Ft+szOYSQmbzb/HCcVX7a94OsWD4uELjo2BA6khaN3ty?=
 =?us-ascii?Q?ID/4XrfTaojFBe6aCXTLgIgUBHY46BYZOf8T70KzxiHNZXLyMygjyJQJIBlW?=
 =?us-ascii?Q?QpWpyor4ihi7WwdlzCCVDhCOI0MHvU292U3DQsGILwSPx+qymECt+LwcFnRo?=
 =?us-ascii?Q?bLx8ehN4779S+rl+w6/uwveVjbgdyrfDU3rbIK/kKNBMObeEHttkxgx3WNDv?=
 =?us-ascii?Q?kt70yowd4mNZvWcsnOFjoDjFTyjBIlordVe394a1fylWFwEAQPUxjJ0HKoW3?=
 =?us-ascii?Q?t1Ss+HnYvzHqVjnlp9j+Qxpzma8+f4P9Nexvhqe/6WMEmQzg1yg1eUiFP120?=
 =?us-ascii?Q?8qQn93h2zrAkmrG8mu9QdrKtRNiMioB6sB1OVz2PkkjcUU0GE//otVP9o4fj?=
 =?us-ascii?Q?3c+tAIKrtCI04HKMdOBRDCIG7EM8lxfLDTwas4KUlX9hhItv+rpBVMBOk1We?=
 =?us-ascii?Q?LRbJEEslwEDNK913x9pFnpnF9lmkeu+fee8UNHDqP/nP8vbPXXV3csYJKvhK?=
 =?us-ascii?Q?JRyts0nYOw0InD2okPURR/37GoP4QsHaG78RVsBojApunDlE3Yzt+mHWuIXk?=
 =?us-ascii?Q?2GdR0UL1eIrUsfKgDVkZ8AB1pRrhsFyuTxVko+TtVWUeC0YDPjd1QtOTMp8u?=
 =?us-ascii?Q?MVY4mCwwUCT05XguJPM9EcBLoAcIv6lb7fU7t+fotBWhE1Q6UM++Vyv3iKYt?=
 =?us-ascii?Q?C60IumRaz6sEOT7cA7Rcp945xuF+PdOfMyuqdgqv5C/sxKUesLz4+H7D3Ru0?=
 =?us-ascii?Q?Xz8jQB+tkA6YBn1KVEb+5a7X8FXptxWhdVzZziWDDaQHUOhAW/FoGtTckIqt?=
 =?us-ascii?Q?WAWO6jpSoxXoAtUNN8gj6gqqS2NtZ+zdxEHZak9BkWmSQsOIm5EnEH3iT6Tx?=
 =?us-ascii?Q?hOSFWD5b/M8Ci7XfICop9ZyK9PF3YLocty60BErSLKqBcTyWBq7Dlu2AcXen?=
 =?us-ascii?Q?CBBQZYBo+IQaAzX4/RNgZ6Q2QgP24TYb+I1/v9ncKVpPXGTUO/uAQPR/M4/b?=
 =?us-ascii?Q?pdqnli4n+jUaCa7o/v3ABhEQQqzjnbuZK0QAan2VRBtHhRdMg6fRr4KmCoKd?=
 =?us-ascii?Q?DDetZWeCIRee8Ax3kkFf9Rgtfl4sSuuXJz4EjMQ62RIfTJ6ZaUgnFcgM1GoZ?=
 =?us-ascii?Q?MzAFnHWCIo+AkmT5XrxKFTnPKN123j7P8a+RyV1F8I0a9+YPOhzHV/nv8SgQ?=
 =?us-ascii?Q?H26y66nedpzudXQ9zc8ceHwqezRDY8pFS0eywWsQl+Zqge3w6T7LPZgN1LSy?=
 =?us-ascii?Q?mzsLcfent2TAUZpsQLVH/69ORy35xH7KXdJs0PzxP/jePoqr1a8tBPt6jpFy?=
 =?us-ascii?Q?UPRVWFKMQ23r17zq99cHuI9LObTuGjA8G5/9tFPDA9BOIhBDfw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae5cb93d-60b6-4e30-0d12-08d96b589cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 01:50:58.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckKR50ZPMyLk73xtIoIhj0qIgy6wDbNCYxAWYccdyhxXI7E7Fo1LqTveL1ZwJT6gtgZAa8J96l8+D4R9z9RtMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0442
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/30 10:08, Naohiro Aota wrote:=0A=
> On Sun, Aug 29, 2021 at 11:10:18PM +0000, Damien Le Moal wrote:=0A=
>> On 2021/08/27 16:35, Naohiro Aota wrote:=0A=
>>> Several parameters for zoned devices are missing from lsblk's columns. =
This=0A=
>>> commit introduces them as following.=0A=
>>>=0A=
>>>  ZONE-SZ    zone size=0A=
>>>  ZONE-GRAN  zone write granularity=0A=
>>=0A=
>> ZONE-WGRAN ? (to enforce the point that is a WRITE granularity).=0A=
> =0A=
> I changed WGRAN to GRAN to follow DISC-GRAN (discard granularity) and=0A=
> to have a shorter name. But, either is fine for me.=0A=
=0A=
"DISC" in "DISC-GRAN" qualifies the granularity: it is clear that it is for=
=0A=
discard. With ZONE-GRAN, you do not get the qualifier since zone granularit=
y=0A=
does not mean anything. I really think ZONE-WGRAN or ZONE-WRGRAN would be c=
learer.=0A=
=0A=
> =0A=
>>=0A=
>>>  ZONE-APP   zone append max bytes=0A=
>>>  ZONE-NR    number of zones=0A=
>>>  ZONE-OMAX  max open zones=0A=
>>>  ZONE-AMAX  max active zones=0A=
>>>=0A=
>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
>>> ---=0A=
>>>  bash-completion/lsblk |  3 ++-=0A=
>>>  misc-utils/lsblk.c    | 52 +++++++++++++++++++++++++++++++++++++++++++=
=0A=
>>>  2 files changed, 54 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/bash-completion/lsblk b/bash-completion/lsblk=0A=
>>> index 731ef3f4095d..c9ebbdcedef6 100644=0A=
>>> --- a/bash-completion/lsblk=0A=
>>> +++ b/bash-completion/lsblk=0A=
>>> @@ -10,7 +10,8 @@ _lsblk_module()=0A=
>>>  		LABEL UUID PTUUID PTTYPE PARTTYPE PARTTYPENAME PARTLABEL PARTUUID PA=
RTFLAGS RA=0A=
>>>  		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN=
-IO OPT-IO=0A=
>>>  		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX =
DISC-ZERO=0A=
>>> -		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED DAX=0A=
>>> +		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ =
ZONE-GRAN=0A=
>>> +		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX=0A=
>>>  	"=0A=
>>>  =0A=
>>>  	case $prev in=0A=
>>> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c=0A=
>>> index 775a6d832076..108c8187498e 100644=0A=
>>> --- a/misc-utils/lsblk.c=0A=
>>> +++ b/misc-utils/lsblk.c=0A=
>>> @@ -123,6 +123,12 @@ enum {=0A=
>>>  	COL_WSAME,=0A=
>>>  	COL_WWN,=0A=
>>>  	COL_ZONED,=0A=
>>> +	COL_ZONESIZE,=0A=
>>> +	COL_ZONEWRITEGRAN,=0A=
>>> +	COL_ZONEAPPEND,=0A=
>>=0A=
>> COL_ZONESZ=0A=
>> COL_ZONEWGRAN=0A=
>> COL_ZONEAPP=0A=
>>=0A=
>> To be inline with the columns display names ?=0A=
> =0A=
> Sure. I'll fix.=0A=
> =0A=
>>> +	COL_ZONE_NR,=0A=
>>> +	COL_ZONE_OMAX,=0A=
>>> +	COL_ZONE_AMAX,=0A=
>>>  };=0A=
>>>  /* basic table settings */=0A=
>>> @@ -213,6 +219,12 @@ static struct colinfo infos[] =3D {=0A=
>>>  	[COL_WSAME] =3D { "WSAME", 6, SCOLS_FL_RIGHT, N_("write same max byte=
s"), COLTYPE_SIZE },=0A=
>>>  	[COL_WWN] =3D { "WWN", 18, 0, N_("unique storage identifier") },=0A=
>>>  	[COL_ZONED] =3D { "ZONED", 0.3, 0, N_("zone model") },=0A=
>>> +	[COL_ZONESIZE] =3D { "ZONE-SZ", 9, SCOLS_FL_RIGHT, N_("zone size"), C=
OLTYPE_NUM },=0A=
>>> +	[COL_ZONEWRITEGRAN] =3D { "ZONE-GRAN", 10, SCOLS_FL_RIGHT, N_("zone w=
rite granularity"), COLTYPE_NUM },=0A=
>>> +	[COL_ZONEAPPEND] =3D { "ZONE-APP", 11, SCOLS_FL_RIGHT, N_("zone appen=
d max bytes"), COLTYPE_NUM },=0A=
>>> +	[COL_ZONE_NR] =3D { "ZONE-NR", 8, SCOLS_FL_RIGHT, N_("number of zones=
"), COLTYPE_NUM },=0A=
>>> +	[COL_ZONE_OMAX] =3D { "ZONE-OMAX", 10, SCOLS_FL_RIGHT, N_("max open z=
ones"), COLTYPE_NUM },=0A=
>>> +	[COL_ZONE_AMAX] =3D { "ZONE-AMAX", 10, SCOLS_FL_RIGHT, N_("max active=
 zones"), COLTYPE_NUM },=0A=
>>>  };=0A=
>>>  =0A=
>>>  struct lsblk *lsblk;	/* global handler */=0A=
>>> @@ -1067,6 +1079,46 @@ static char *device_get_data(=0A=
>>>  	case COL_ZONED:=0A=
>>>  		ul_path_read_string(dev->sysfs, &str, "queue/zoned");=0A=
>>>  		break;=0A=
>>> +	case COL_ZONESIZE:=0A=
>>> +	{=0A=
>>> +		uint64_t x;=0A=
>>> +=0A=
>>> +		if (ul_path_read_u64(dev->sysfs, &x, "queue/chunk_sectors") =3D=3D 0=
) {=0A=
>>> +			x <<=3D 9;=0A=
>>> +			if (lsblk->bytes)=0A=
>>> +				xasprintf(&str, "%ju", x);=0A=
>>> +			else=0A=
>>> +				str =3D size_to_human_string(SIZE_SUFFIX_1LETTER, x);=0A=
>>> +			if (sortdata)=0A=
>>> +				*sortdata =3D x;=0A=
>>> +		}=0A=
>>> +		break;=0A=
>>> +	}=0A=
>>> +	case COL_ZONEWRITEGRAN:=0A=
>>> +		device_read_bytes(dev, "queue/zone_write_granularity", &str, sortdat=
a);=0A=
>>> +		break;=0A=
>>> +	case COL_ZONEAPPEND:=0A=
>>> +		device_read_bytes(dev, "queue/zone_append_max_bytes", &str, sortdata=
);=0A=
>>> +		break;=0A=
>>> +	case COL_ZONE_NR:=0A=
>>> +		ul_path_read_string(dev->sysfs, &str, "queue/nr_zones");=0A=
>>> +		if (sortdata)=0A=
>>> +			str2u64(str, sortdata);=0A=
>>> +		break;=0A=
>>> +	case COL_ZONE_OMAX:=0A=
>>> +		ul_path_read_string(dev->sysfs, &str, "queue/max_open_zones");=0A=
>>> +		if (!str)=0A=
>>> +			str =3D xstrdup("0");=0A=
>>> +		if (sortdata)=0A=
>>> +			str2u64(str, sortdata);=0A=
>>> +		break;=0A=
>>> +	case COL_ZONE_AMAX:=0A=
>>> +		ul_path_read_string(dev->sysfs, &str, "queue/max_active_zones");=0A=
>>> +		if (!str)=0A=
>>> +			str =3D xstrdup("0");=0A=
>>> +		if (sortdata)=0A=
>>> +			str2u64(str, sortdata);=0A=
>>> +		break;=0A=
>>>  	case COL_DAX:=0A=
>>>  		ul_path_read_string(dev->sysfs, &str, "queue/dax");=0A=
>>>  		break;=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
>>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
