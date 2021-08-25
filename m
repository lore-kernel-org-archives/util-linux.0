Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD8C4338F
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 02:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E1F611C8
	for <util-linux@archiver.kernel.org>; Wed, 25 Aug 2021 02:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhHYCNP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Aug 2021 22:13:15 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7755 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhHYCNP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 24 Aug 2021 22:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629857550; x=1661393550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=35BQVLI6zFqCWoHyssRs5U/vdFSepICkfv/5eJKHF9s=;
  b=e6nf5RwQoQwUc0CxZqwamP7MBvWd6mL8X2JiAu7LzzD0S/J1YFi2eVDY
   w3mR49PsWwUJ5p6RaudRxIJw3pzpzexMYwtxMX0ttBbcx5hANbEjl1qlL
   S6TxZ6Gmnx/kpVwGeaXeDPfHVHCJ5hRsz61VnQNOXzgxdz6U8fAYZtYYX
   XaTAfhsAR2d/5rIjXi8/DryvxrOtot0e3VJjG67z+6ETqQB7ZQHn40xUF
   ylxvROKZAxWWN2lVd0Z5CYMCRJboyc3tITCRLQdIvt75UNFPwuTpQMECk
   gD8M9w+E63gmxedcVLe07W92vZqeBsK1XmoFp9YUOsWoEZ1TURzvT+008
   w==;
X-IronPort-AV: E=Sophos;i="5.84,349,1620662400"; 
   d="scan'208";a="282092280"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 10:12:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsSn9cAxGgRmlRGqP7nDkvHkpL3653lRvuRKf4bw4Ctuv8okaP7zttCsqtxeRlBkgYNBLT1B6ht/ujVUI0+j5up6I/ZnC6DE0St6ZvNloP6bgou2bjAWyugNGF8KoR8kKLMDiOm+CS5QQoNbSFeUxkQXSS7P6buO8GoXIc2j8RQL1GQVaKLAMtAJPemtaUeG0UIRQlEk/As8Q5UlosVsuuqFL2GMfT7Cm1oGXt0Nb7AMqASKXrrJn57YVqmdcQuJZHlvLYqvCzUXuP4c7BA5lfSyz3PbD1Xw5p7C7AAUuSowKymi5pXTudaEWmlBZ4NKVebwxia4aNpSoFqwCvnNgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AvlvZI3DBGWq5ACq8WQQ5Fn9Z4X6DDAI3IFcmgVJZY=;
 b=N9lDvF7vCEQThrpj0SjT9L8ZiOYeICCBAnqtGzjuWkPHgb0e3SO5Tal/HHltSG9l9XPLTKX6LrNenAMz6WPcqGTxkKHex2rjn2eyLYcstL2SNyPF+oMNPZuzBwnQhVncA5DRk8fRvUxaLmDEyMASyJq0OOoMzIZif2Ju8bj+gzar7PrP9UVH/S8Nk2OkpthI15IOenC6fn0EiIJmdYZ9yrykrRT+A/hrtTU73BwShbRzgeCCyLEKRMvu8buaSwoD/B24Y7cVDpiylyhx9VbrDwqWRaDb6uqN6lPDAKQ2Zfe1lI9C3HQNQSC7q18C9/v1iyVs6nRNuGOI7FTl9LXqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5AvlvZI3DBGWq5ACq8WQQ5Fn9Z4X6DDAI3IFcmgVJZY=;
 b=mStpAkjn/0qlljs7kqmK9RGkFnFCk5cdEYRoBNtggmu+Fi6xUbWsRWo06USyS+uPfIpFbb96b7Z06uDW3XbObUh1iYPVQiXUdJmIP/ATfZOFRT7If+sM2bENXJfjmHLAX1pEBS7Odw29gZTBNa9hbJjeTCM/tY7kwrwFLFE2WsQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7822.namprd04.prod.outlook.com (2603:10b6:a03:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 02:12:28 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::413e:7e96:6547:b28b%5]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 02:12:28 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 0/2] add columns for zoned parameters
Thread-Topic: [PATCH 0/2] add columns for zoned parameters
Thread-Index: AQHXmIXSkQI1LFph0ESPD5DZqyQBiquCm1mAgADg6IA=
Date:   Wed, 25 Aug 2021 02:12:27 +0000
Message-ID: <20210825021227.xwt3xl2c3kbmosjb@naota-xeon>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
 <20210824124729.or5nyoadc3fbla2y@ws.net.home>
In-Reply-To: <20210824124729.or5nyoadc3fbla2y@ws.net.home>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 22b3c964-478e-44a2-7af9-08d9676dc98e
x-ms-traffictypediagnostic: SJ0PR04MB7822:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7822F305621C11F3C1A6F00E8CC69@SJ0PR04MB7822.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l8Z/Z8dCCyZyO88JiFS3kWUZLoKMtt3aDspJw71tN5A/U0FAVS2fQ1BxglmjLzw9HxMiqPllSw0dQdKNQvYUhw9eQsE35y1QgmE8CgGYiZ/QIbdXJKjFa6ibDs0SpREe3jCcPMR31F4wChZpPTVW78hFi5qqVnokQgz9Q9in+QT+SbBsEMr+9m2WjOicfQvLlzo3K4XhD0Y3y3N76DBvIygRvoOcnf5y421sxYPUualo4HdhEwue02UGIwCH4EXdIYhpZyFAfN1rGRoaDmU3wTQpDK+pXijkh/EKpH39qQI1XYCzJtilA+mA32x4rjHuFtmnoXM2tSDvDQ1KKa7300isI0cHJJRz07vBM+S7YTEvwIbV5Yb2k8H5fzD636seAHEKDWAyp+OBsg7ZqwR63yNsWqCa6BvXpLOd/gmxe2lknYUwbfUsCSAtXxY1E0Tg1prbfV3Ewuv+Q/map5avUGdlIXSXbMQensW/B4LHmpQHYdSfUK2xj/egBni/DWGIQbnJbU3/gaaRLqqXclZ+sm8M0vdy4CZnzOicJvKfK9vc1tlKFdpIC4eEKjq9+VQt0qxAotQzSsf52+bUzwunxxH+wZVpUzDhoWiuVurFV0BeO6DVckJWqJLYGb6Rmv0SDxeTJNlSdGNNyRe5VaN3e9jy3DXArEQ9e6OCWj7JaTnxk9rkX480X3AQaMLIFESxbHI0GPXgMX6VEnwL7hqjEEEeJzVT61OmClFqHCrcNb5yrnNXvhfm/ptuLHqtiiJmdL+tKZ2IN81l9YKcf9tGOvezHQPFNcadPZPsyWAMg8U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(186003)(54906003)(66446008)(66476007)(66946007)(66556008)(64756008)(38070700005)(71200400001)(8676002)(33716001)(1076003)(26005)(6506007)(8936002)(6486002)(4326008)(122000001)(2906002)(6916009)(38100700002)(316002)(478600001)(9686003)(966005)(91956017)(76116006)(6512007)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+RVBao6eouz+19x5M6wWgLqm80T043s8j/LLdmVwQIL/xBeKqk/s22JhrpGQ?=
 =?us-ascii?Q?4+fCLbxSBKlqeJWAI+4/p1TRFCK1ryNTdJterzbrrou67sLeSIplrMRTaSm2?=
 =?us-ascii?Q?/8oZJun80zJfJnNmkViZzUh1PK6l2yR/+1ji7O3B0zdwvnv4OqQDGKPpJrWl?=
 =?us-ascii?Q?oUlvujiZK8T0HI2a/RgmYeaYXibVxBZ1p/kWUQ/L+AJOzGXh+Jzf+MRyk5zZ?=
 =?us-ascii?Q?pszDOvdHHHTUGJzGaW0MOOeN+4mG6sen8GOGzl4xVroDtrB9D5vWAmxlZm6B?=
 =?us-ascii?Q?VdaIvvW/621lIZAaRANlbzaDDsqTpiljD0iYOfonIdGjgOgAeMmO0Hd7hXuc?=
 =?us-ascii?Q?lSlQ3MYEM6eYtQF/cz/1blQzsYpe4NmtAfvOs5uOBByAEtvHg27k586VXzXg?=
 =?us-ascii?Q?oZs6t/LeIw/fvq/snFZ+ot+5W3Oaa8YsfaXGNlf9glhmZIWP7MzpBrz7Fktf?=
 =?us-ascii?Q?ypkw5lg0F5Ea6USGCQLCg6RZH6i5pVEI5fU0jOU0gPYZP/d/OelwgrengjdF?=
 =?us-ascii?Q?YAPX/TjxC/rL3v95u01POP8hvxnol5cZ8LsGY5oauL10iqmkogAkrfrM/Muo?=
 =?us-ascii?Q?xOxi9voF3hSfK0qydFd5RolGvsipOJU5t5Lzfb/jkUAZPJzRaXK2A8l5WUwd?=
 =?us-ascii?Q?hBe6hQ0qRn78emeo0XCVkphU8jK1v7UgGaQ4qdqr1bmF2pJEPGOvAHVgiYDC?=
 =?us-ascii?Q?5BiTfd/ZowcBhUEUFu55zLg0zE3kc1cdRqbIGcaHokWb/cFioZS+Tm9HvzN3?=
 =?us-ascii?Q?oSRKx7FIUvsnBoAWIYEDqaQ1reVSLNIrG8cX2w1MS8IeAYwMB75MNB4m4EAq?=
 =?us-ascii?Q?4/oXBSJstwxvTpCFS882nCR7QU/bInuvoc9SDDsEUd/TTofEOmmtmntQoWQo?=
 =?us-ascii?Q?FLAYoMGmpcDfz/jqYcB8B+phkM38pmhq2r8G4KMF6mp9Cg1uAtARHEtJL6qZ?=
 =?us-ascii?Q?Rvb7DQymDGPu22WUpsUFpeYSmWIM/kNsSMP0dip1qGhRIG/Zuph4Jtur8nBr?=
 =?us-ascii?Q?4sn4zgRaLyqev+Ncx3CSUPPZG1kWCa5KG68glaJSJKmFbp/lTGdnVBtzlbm9?=
 =?us-ascii?Q?HwkDEe7heKZcZkJp/CZEfkxZWS+psumTY2kTTBHLB8OiQSwYQ5zDqM/E01DY?=
 =?us-ascii?Q?F/kr3t7uv4KZ9yp9CnR9kTQcVrcoeXPbGk0GZSVq1L8UOlskq9Ws1BZ5MYbo?=
 =?us-ascii?Q?Psln6ZzQTIsko9k7nqTi1J6OAcsoMXJuw8cwGR2DnjztxAyx9QlPxg7yv/Ll?=
 =?us-ascii?Q?QtrjqTru8K8tCZWoqfDaxN+eU1SAJaM8nMHOnfsRqDef6qIBdIaC9iQcj8i+?=
 =?us-ascii?Q?v7v6upnABZ9JsPusCCevU3Pmwae7rbrJg2Ba2xsjSzrvvA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7B935B354FED57429BCA4E7B23E0B53D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b3c964-478e-44a2-7af9-08d9676dc98e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2021 02:12:27.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DKZeKdxR0EAIZPEWeH4e5lgIoUjpS7hKM/nVDeXkFCpMEar/Qx0E59jiNu1IMJxV0ufth9GNr/BusF2NSgjL0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7822
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 24, 2021 at 02:47:29PM +0200, Karel Zak wrote:
> On Tue, Aug 24, 2021 at 10:17:16AM +0900, Naohiro Aota wrote:
> > Several parameters for zoned devices are missing from lsblk's columns. =
This
> > series introduces them as following.
>=20
> Thanks! I thought about it a few weeks ago ;-)
>=20
> >=20
> >  Column Name      Description             Sysfs path
> >  ---------------------------------------------------------------------
> >  ZONE-SIZE        zone size               queue/chunk_sectors
> >  ZONE-WGRAN       zone write granularity  queue/zone_write_granularity
> >  ZONE-APPEND      zone append max bytes   queue/zone_append_max_bytes
> >  ZONES-NR         number of zones         queue/nr_zones
> >  ZONES-OMAX       max open zones          queue/max_open_zones
> >  ZONES-AMAX       max active zones        queue/max_active_zones
> >=20
> > Sample output:
> >=20
> > $ lsblk -o NAME,ZONED,ZONE-SIZE,ZONE-WGRAN,ZONE-APPEND,ZONES-NR,ZONES-O=
MAX,ZONES-AMAX -i
>=20
> What about to add all the columns to "--zoned" output too?=20
>
> We do not keep backward compatibility for set of columns in outputs
> like --zoned, so it's open for changes. I guess we can use --zoned as
> a generic option for all zoned stuff and not for a model only.

Nice idea. I'll add a patch for that.

> > NAME        ZONED        ZONE-SIZE ZONE-WGRAN ZONE-APPEND ZONES-NR ZONE=
S-OMAX ZONES-AMAX
> > sda         host-managed      256M         4K        672K    55880     =
   128          0
> > sdb         host-managed      256M         4K        672K    55880     =
   128          0
> > zram0       none                0B         0B          0B        0     =
     0          0
> > nvme2n1     none                0B         0B          0B        0     =
     0          0
> > |-nvme2n1p1 none                0B         0B          0B        0     =
     0          0
> > |-nvme2n1p2 none                0B         0B          0B        0     =
     0          0
> > `-nvme2n1p3 none                0B         0B          0B        0     =
     0          0
> > nvme0n1     none                0B         0B          0B        0     =
     0          0
> > nvme1n1     none                0B         0B          0B        0     =
     0          0
> > nvme0n2     host-managed        2G         4K          4M     1844     =
    14         14
> > nvme1n2     host-managed        2G         4K          4M     1844     =
    14         14
> >=20
> > $ lsblk --help|grep -i zone
> >  -z, --zoned          print zone model
> >         ZONED  zone model
> >     ZONE-SIZE  zone size
> >    ZONE-WGRAN  zone write granularity
> >   ZONE-APPEND  zone append max bytes
> >      ZONES-NR  number of zones
> >    ZONES-OMAX  max open zones
> >    ZONES-AMAX  max active zones
>=20
> It would be nice to have shorter column names, but I do not have any
> sane suggestion (Z-SIZE or Z-APPEND seems strange).

Hmm, considering we already have DISC-{ALN,GRAN,MAX,ZERO}, how about
ZONE-{SZ,GRAN,APP,NR,OMAX,AMAX}?

>   Karel
>=20
> --=20
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> =
