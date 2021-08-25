Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE6AC4338F
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 02:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799B66121E
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 02:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237757AbhHYCt5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:49:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20746 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhHYCt5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Aug 2021 22:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629859751; x=1661395751;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NCBFx8vUMRbSfaM9GOBtNEGee4wG6dgScoHmmgL0v28=;
  b=H5cCz4XsBx3GIUsL7CMiUuwB4mslqUdtq6dBDc/BCbYuxFC9+143NaQN
   yUqqAFAW0QQwbSTTLgpssxCH1MvQl06d+Ht2QvYzmgyUVWNkeAwIFXmrQ
   Tr/OChaGouFOyjs4otUzSDIJUwJt7Gx/vMvttNWEDrgSaAfS/Ct/qNBfC
   ZCQV980hAnwDnlOryONrUPSSZRaLINuL8C900IK48uYH88ZGMKqhOne3S
   HjuGhX9s4v9gZvXnAd6ut5v2LK+rxjXdlwNIhofjXpwpE+ct5BHnY9qfP
   xiMeVDYkk8aOdNm5uZNkJ7ODkod6qCayvMG7knaReWIkaw7ha5FAONFnh
   w==;
X-IronPort-AV: E=Sophos;i="5.84,349,1620662400"; 
   d="scan'208";a="183084023"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 10:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VicBN4D4jBE5jiU0GgZw76epq1PKr14KVTxRhDUc97R94ZC9uqQI02ycMFFQfyBblWKhs6H/R5ykFXNv2aTDSgwiZfZiUejeXPavyzO48YR/N+KgqHVABJ2MF03oZRPOmOohQRDxgZIvkveafnEc8Bz3RAqa8lSYNoInCBoPS3cvMqtAjVDALQL6Uoww2KaJukpwxCtgChlmDSicji4xLJ95cdrp3WWrPF68M8N7Rs2o4rHmB9/1G6FYvY90FKCPbSi6/748phD97AxvKFVOfDQSI+eXDy8Yu0toNHbVsnyFEOCob6t6vUlfuXqi9l9+CSNXWAHTRdnrVeToXGM0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7kcE7tWYEJ1x6MUJAoq3jUhn6CUDtNhX+Lok2HzhHE=;
 b=VGna13a0lGvj8alQmfrBiTvj7LRK5jip7QkN5y/4mBCXddNzsi8RHGF3LfFEmz/kNMbhfsO96nh+mgowC6mnyDsKK5azc2pQEdbACMXjpxYHyLdCWv0D3PQCEho/NOrHRa8dAeD4yTWYr7D2X1gObS31yv4ecblQbkNHZ08r4Duwac/IUvRFET9sYYSOFW1b/Nf3yog7P63Q9roKUh9bCy+7WbVkNXKhGAPyx6Mkrzt+AGA3trO0V2Lq3FHgbS8womY+5/OSEeUMEbsg9q7SxMgERSPMf1TZ66lMBzCBbkEMNxxSd9TPpgtKDdhUaBj+9OEGj4te5naWvmcRXaXr0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7kcE7tWYEJ1x6MUJAoq3jUhn6CUDtNhX+Lok2HzhHE=;
 b=vBHL9Ts4ptWovxGVMkDx+Q1aUDLfXiRmtLu1goBxbkZi4V3ASuLd40golGl+WM5nJdPkItAlUSx/dqiF+3c6mVkZszPcmmiuItBwXS+J7UR8qpJRT3qu7VFtqSTz2BVKnOu2T6767QVI05pmLR9wxGzovDW/EOWQEHG216dy8Xs=
Received: from CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9)
 by CH2PR04MB6982.namprd04.prod.outlook.com (2603:10b6:610:92::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Wed, 25 Aug
 2021 02:49:09 +0000
Received: from CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::db:f463:b03c:b3d5]) by CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::db:f463:b03c:b3d5%7]) with mapi id 15.20.4457.017; Wed, 25 Aug 2021
 02:49:09 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/2] add columns for zoned parameters
Thread-Topic: [PATCH 0/2] add columns for zoned parameters
Thread-Index: AQHXmIXSkQI1LFph0ESPD5DZqyQBig==
Date:   Wed, 25 Aug 2021 02:49:08 +0000
Message-ID: <CH2PR04MB7078FDE557F761AFAF00419DE7C69@CH2PR04MB7078.namprd04.prod.outlook.com>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
 <20210824124729.or5nyoadc3fbla2y@ws.net.home>
 <20210825021227.xwt3xl2c3kbmosjb@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbb5387a-ddda-440c-2bb2-08d96772e985
x-ms-traffictypediagnostic: CH2PR04MB6982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB698242670E463767C62E1DA6E7C69@CH2PR04MB6982.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4yfwwlyr/BUP/ggA41NDoKUTEYrAmVhjeLNPiRdx4g1usWPBRq9i6D5jXZzsmR0mox/v3nn6CztUQ7R9D38vcIL9fSH/7Tu6FYSsCda9vc7XrNACEx6Xh3i7vfBZjAoLoETSCNBQ5SiwywR5jHf4ttsB7nZ2lTm85wupCJiAw1F6MrzaUGUQYGZ64rTaXkDkJM9Xxat4ZfUoppSTomOBOtQWW+8A+ZSGrPotCDKiKwnutv1rcUwfT7pcI4eIiMtuzBcxmFTVFvaEGOCS5tvZEoV8hyDoCzsOgi+cElICwYH3SY7sgu76gChrOSBdxCjhAGd5ZREFFZQJOd7SXepjTs6M2gIXmqCijkma/NM2xnf5bF4laLKZJ/oDO5v3/oF8J9L48ADgu27lFkZ3a5sBux4BRflO/u2RYpIzJ7tytrheF0Owt7U6pwrZxwPJyPERCZ3gbj8S5bpSBVwPruRpdrtKTYfs5tCZ+gDwqSXELatRvFzmrqnKXmfCxs72ud5tulEdN6mYkEgIADLY+in48TpVTgJDgJMF7hXLNlUXGsNRpVLZ6zGPNOueVC5sRRgubOUO7zM/VA221STapglR/0SNN7J2V8+UbHqpeUxnJWmc4NvB9aT/aCSXeRBsqD0sH5lyV9UPHij1FzdI9PJE2QwfBYMUxB6TLyxP2Npm29k22mr5BsoJGwDmh1zFPTYYKh3iYasFYfCYN4T94hQGhxanKQCm6V3fAr0j92lK5LA6ZdKkthwAG9XG5tMgUBmSV5PGSJzWw9gpHrKkzD+i1H2liQX4mGrEl1XvbqJXzY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB7078.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(91956017)(4326008)(66946007)(966005)(33656002)(76116006)(7696005)(66556008)(64756008)(52536014)(186003)(55016002)(71200400001)(53546011)(6506007)(66446008)(508600001)(86362001)(5660300002)(110136005)(66476007)(2906002)(8936002)(83380400001)(8676002)(316002)(38070700005)(38100700002)(9686003)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PvVTW3RgS+aHuxScRPRrT39N+2RC1r7RS+q+k/sY/Z4r6go8CRMR/fb5WAQT?=
 =?us-ascii?Q?XJ0zN+MdlJP4bgdW1yzgC1MQHZtdwWkFjXqcNh7lZro/jsYBiqiLZxmF0amE?=
 =?us-ascii?Q?CgSU7SFSWgQ3OVXi2R0wwgx2KXrYqRXsV73TyijdoIRTiJjCV5X5UgbnbznB?=
 =?us-ascii?Q?B9/pHCJJ5FGNVFDPKYdCuitpIizNoto8GX0yAw0bm0RRAjHq3zIW3nVVF4Fq?=
 =?us-ascii?Q?UcHAVe/TnE+vum76WtLvU3Y8lNHUEkjtKqzZsSUU64ty0tlq4g3mimPnrtxj?=
 =?us-ascii?Q?o/GtcmrDXl6AjXFkILO9aWRlpCLKuhnV4CMGe8hfSsQcShKrISB61kz0fCa6?=
 =?us-ascii?Q?YpOkbY5CVcFxqhVOk738flO1MRCxYDY/H0mTEzRXOsbMVgtgNCV/EnLkACT3?=
 =?us-ascii?Q?K8Mp0kBGqK3wLuNwvPQvuNLXcaVi8nMntvIAnSVNXEwErCB3Czs+6RUnWWhp?=
 =?us-ascii?Q?wOlvB8vKPDTxVzDpq4Lf3dZuOTY992zB8R3agWc3ICCA/rgUUjIoxAdEjlYj?=
 =?us-ascii?Q?yCgJ9hvnFigw0Aeui//yEgnk46U2dkd+BDkKOmetIiZ5wlxuoZejXouVxdlk?=
 =?us-ascii?Q?IepwZ24NCwYzW9uKB4FJswgzxUA095Gbopr2BH1WWw6YNv1z1RTdWwFWJOUV?=
 =?us-ascii?Q?QOdqlMDvr0xoDd8YUSlQOusGo84BTQSDJyKzUNMuy2XMvByrgHAI/Cl56+Wd?=
 =?us-ascii?Q?6WBG2BZsnE7JN0lM9zzyNbbKZ8WuCgAYroXJY3ERybjN+GSwlkiuvfOnKGEk?=
 =?us-ascii?Q?9iGNKj8tPciqJHjLX1Mtyc3eZfhq2CdzUfSI9GFcOXCbbQ5AyK4kCxv2pDCz?=
 =?us-ascii?Q?eafy3YQApS6jV0alGu1HaeY5Mpo4wtv10Bji8MIrDkvzqCmtH2+nElw0fBa+?=
 =?us-ascii?Q?mXAcQmSGmkG5PEeyn6SS7wDUEwJ9FVeY1AZ62a/6dQMFsE1g2XLde8piFFy6?=
 =?us-ascii?Q?wU86yjnKPVmcju/FpJ70rbfyIvl89hBW59WtZ7zNMcyr1LfVOhVIFORNMy/i?=
 =?us-ascii?Q?p3LGGxGpaQTOGdgN/fkI73n5ZieBCScohJzkOYcg410GAsT3/9USyXPIdULe?=
 =?us-ascii?Q?6L/c+DW2zD4KHf15iwzyaNb5uqymDvjiTTdmVnmWy721QOCQKbKVaEqMpdgD?=
 =?us-ascii?Q?xEYxMRRDpJwgelxoqEwQopi9ziCOJ/h/yUf49kRiIFAWga0ISb2vRSTr5fZ2?=
 =?us-ascii?Q?JG++E+m6mqY7VjbRmHjr4ECvrIVFsRxrl3/WSH9mBbsqQIhtEvRoL5yDU5hG?=
 =?us-ascii?Q?wVnXlQ35wNiTp81NsFLECWbTD8YKvNVnPMJmMRCU8EkMR7EHFkZOT6DrrZI3?=
 =?us-ascii?Q?ZigVrhyoYP0gAq+5OejEeS3tfzgYydfd09DlEnsV8bmPVT0a7AJtxMtm0Bi2?=
 =?us-ascii?Q?9UyIiEUsJZpx7EWwn/qAZdyK+FxBokq/Qf5tU/1VxizcFw3Wag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB7078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb5387a-ddda-440c-2bb2-08d96772e985
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 02:49:08.8470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhLxeyfUCsSHG26Y75JonP88NBADTsigQuEEuZUeFSyefMVfN/etI5jNN8pfpd4PE6uTVLPdY65U8/DyqJ9ycA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6982
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2021/08/25 11:12, Naohiro Aota wrote:=0A=
> On Tue, Aug 24, 2021 at 02:47:29PM +0200, Karel Zak wrote:=0A=
>> On Tue, Aug 24, 2021 at 10:17:16AM +0900, Naohiro Aota wrote:=0A=
>>> Several parameters for zoned devices are missing from lsblk's columns. =
This=0A=
>>> series introduces them as following.=0A=
>>=0A=
>> Thanks! I thought about it a few weeks ago ;-)=0A=
>>=0A=
>>>=0A=
>>>  Column Name      Description             Sysfs path=0A=
>>>  ---------------------------------------------------------------------=
=0A=
>>>  ZONE-SIZE        zone size               queue/chunk_sectors=0A=
>>>  ZONE-WGRAN       zone write granularity  queue/zone_write_granularity=
=0A=
>>>  ZONE-APPEND      zone append max bytes   queue/zone_append_max_bytes=
=0A=
>>>  ZONES-NR         number of zones         queue/nr_zones=0A=
>>>  ZONES-OMAX       max open zones          queue/max_open_zones=0A=
>>>  ZONES-AMAX       max active zones        queue/max_active_zones=0A=
>>>=0A=
>>> Sample output:=0A=
>>>=0A=
>>> $ lsblk -o NAME,ZONED,ZONE-SIZE,ZONE-WGRAN,ZONE-APPEND,ZONES-NR,ZONES-O=
MAX,ZONES-AMAX -i=0A=
>>=0A=
>> What about to add all the columns to "--zoned" output too? =0A=
>>=0A=
>> We do not keep backward compatibility for set of columns in outputs=0A=
>> like --zoned, so it's open for changes. I guess we can use --zoned as=0A=
>> a generic option for all zoned stuff and not for a model only.=0A=
> =0A=
> Nice idea. I'll add a patch for that.=0A=
=0A=
+1=0A=
=0A=
> =0A=
>>> NAME        ZONED        ZONE-SIZE ZONE-WGRAN ZONE-APPEND ZONES-NR ZONE=
S-OMAX ZONES-AMAX=0A=
>>> sda         host-managed      256M         4K        672K    55880     =
   128          0=0A=
>>> sdb         host-managed      256M         4K        672K    55880     =
   128          0=0A=
>>> zram0       none                0B         0B          0B        0     =
     0          0=0A=
>>> nvme2n1     none                0B         0B          0B        0     =
     0          0=0A=
>>> |-nvme2n1p1 none                0B         0B          0B        0     =
     0          0=0A=
>>> |-nvme2n1p2 none                0B         0B          0B        0     =
     0          0=0A=
>>> `-nvme2n1p3 none                0B         0B          0B        0     =
     0          0=0A=
>>> nvme0n1     none                0B         0B          0B        0     =
     0          0=0A=
>>> nvme1n1     none                0B         0B          0B        0     =
     0          0=0A=
>>> nvme0n2     host-managed        2G         4K          4M     1844     =
    14         14=0A=
>>> nvme1n2     host-managed        2G         4K          4M     1844     =
    14         14=0A=
>>>=0A=
>>> $ lsblk --help|grep -i zone=0A=
>>>  -z, --zoned          print zone model=0A=
>>>         ZONED  zone model=0A=
>>>     ZONE-SIZE  zone size=0A=
>>>    ZONE-WGRAN  zone write granularity=0A=
>>>   ZONE-APPEND  zone append max bytes=0A=
>>>      ZONES-NR  number of zones=0A=
>>>    ZONES-OMAX  max open zones=0A=
>>>    ZONES-AMAX  max active zones=0A=
>>=0A=
>> It would be nice to have shorter column names, but I do not have any=0A=
>> sane suggestion (Z-SIZE or Z-APPEND seems strange).=0A=
> =0A=
> Hmm, considering we already have DISC-{ALN,GRAN,MAX,ZERO}, how about=0A=
> ZONE-{SZ,GRAN,APP,NR,OMAX,AMAX}?=0A=
=0A=
That work for me. One nit though: having the ZONE-NR and ZONE-SZ columns co=
me=0A=
first would be nice since these are the 2 most important properties that us=
ers=0A=
will look at before digging into details of other limits.=0A=
=0A=
I also wonder if we want to add max_zone_append_bytes here... We should onl=
y if=0A=
attributes such as max_sectors etc are listed too (I have not checked).=0A=
=0A=
=0A=
> =0A=
>>   Karel=0A=
>>=0A=
>> -- =0A=
>>  Karel Zak  <kzak@redhat.com>=0A=
>>  http://karelzak.blogspot.com=0A=
>>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
