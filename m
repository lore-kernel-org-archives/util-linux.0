Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40832C43331
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 04:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83BD20787
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 04:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="diNQFF+T";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="soOe5j0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgDAEos (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:44:48 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:15153 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgDAEos (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Apr 2020 00:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585716288; x=1617252288;
  h=from:to:cc:subject:date:message-id:references:
   mime-version;
  bh=WTT61D4fZ6SK/pPs+w3CNZXUhBW/0Kc1d4VSNVIAEJA=;
  b=diNQFF+Tw7sKiqQpLKM0aBPYy5/zM9ZMCc0QIuCT6nuVUwvi5lcKTviH
   ncEsskagufsWpznQHP9L/ShrUT06IBlS4FZhHcG/L9D85g7JjmKqgBOyG
   utSMYuQkeVO0FN55t7HMLI0YGS3EnLZPPbI1mNThrdHePU4geaGFlj/HS
   zpZNVO+Am3GV7ePOOu/J3p4Xs90dMXbANRhPmtbjl2/Q8mDAtk2AxTGpU
   EkOAZ0v/rbwSM5AIUC7yoeQ0LncXcTKsdee6BPq9qR0Y1ZKdJjNsP+ebd
   ouozy7jxeUIpR7iw4LQlLNzAjGC6CI8G0/IX8bWPIM2H3g+2r5rL+ipcm
   A==;
IronPort-SDR: s1hMcUULDtiHC1KBvuNVaqWhGsWSZy3ZeNFNiWLzPZDeWDAVWtGmXvTr2cN1SXUy4D+O/NHftZ
 Tu1RURCm71oPx7aM/4S9cfyLbbtTYWb/oXucpo4f6qBIW0jFBG3Sulw2g+XhPyYAYCgiEH16p+
 FLMfjpZ3BV3WTku642UsivUxgauqWgeuk9sSfAR9cZNJbweacJBwWm+N1v/8zReZl1mGDhLKt1
 ekIXkocMscKwXc3YNuWV+a1yj6O6O6ZdLqgq3HHbHyWTCBr33xT0R4jjKsF2D1bnmfmBGowinn
 QU8=
X-IronPort-AV: E=Sophos;i="5.72,330,1580745600"; 
   d="xz'?scan'208";a="134559675"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 12:44:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rfp3H1345K7zGNvBU7BEhwEZb7liS+eKQOYZT9nVsBThzNAUmY+0PODh/WVWFmVEDHrdgdhkafPWzB/BIBySSd83c1z59PO8cQejqZH3XlKhv/AiGtl7BS0sSl3zq4Nv7BCgvUpOn1hDVTKwy2UNE0A93T6Ff/ks0pevgeOdWOGelGBJVcrNIOqTS8QdgAIl1YfAL0ncbmF+AhmZbUbafhhalhPvfLhPB/C5oRrzwiiKKcicbPr0nUYQcKG0kysDz6SaLYs8ZVzU3g+BzQyRm9C18c3Wur1zup0/wwcAT54B3fE2CxXuRUFnRJwDFffFXycVaIN7Y2+wvwlOsVB3nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=julAOwT61MvrLK/p1SXv9n9to2khyQwFZOR7OhhSaRU=;
 b=KpmrNVX+wDotL1TmPNCzlefmFK/kF5kbv+OrXwmY0EIGT8EDJHcd8H6Q9nCaDdL9NTBd+KQwSWsBHgM0Fb4phx2Rogr41l4dE/PcSUCvzX3ZdwCVWeUy9IhROr2H/GLsvZMp77BnL4auIBTeapRtKo/8swe1QdKZwRJAuTDjhBbCxgphPpHkhap0sErHwIhyalw8loUPMpmNNRUVLYPJ0u0sJP7iRFsNhz/xzWUQQ6r9sktkhvNZe3dz4urH572QOGWQglpp7mm4vzkIILJJjGT68vPFxfWYt1M4pyFM5RYJQL8ap4MvQaiCoF8yiaLOxgvuAnQ97vWv11cKAzgNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=julAOwT61MvrLK/p1SXv9n9to2khyQwFZOR7OhhSaRU=;
 b=soOe5j0RdFyc6FqHWjt0B7yfEFyKmvSioQdCrjAFKIFtf/lUG1lj1+nK5HEjXn24K9W1iz8rV4W1y9QADFC+l+9TGBhI6qaAJ4HY9MJbWL2kZ2t6iu2ul9QwO2+Rd8PqTgJ9Os70MAF84npxZQsxohcWU8nJvlnu37xW/kLORbE=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2357.namprd04.prod.outlook.com (2603:10b6:102:14::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 04:44:30 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2878.014; Wed, 1 Apr 2020
 04:44:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>
Subject: Re: [PATCH] libblkid: Add support for zonefs
Thread-Topic: [PATCH] libblkid: Add support for zonefs
Thread-Index: AQHWAP57V5VNJpfXsU65PGkMPbpAKQ==
Date:   Wed, 1 Apr 2020 04:44:29 +0000
Message-ID: <CO2PR04MB2343E47B5AFE242DA2307BB0E7C90@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200320045543.2053382-1-damien.lemoal@wdc.com>
 <20200323103305.uhlc3d7i4famwq5p@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a8c4b0c1-f0d8-4d69-3fcd-08d7d5f75d94
x-ms-traffictypediagnostic: CO2PR04MB2357:
x-microsoft-antispam-prvs: <CO2PR04MB2357181F1FE2EF5F222AC1DCE7C90@CO2PR04MB2357.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(478600001)(9686003)(4326008)(86362001)(186003)(6916009)(2906002)(26005)(55016002)(81156014)(81166006)(8936002)(316002)(8676002)(66946007)(66556008)(64756008)(66446008)(91956017)(76116006)(66476007)(66616009)(54906003)(33656002)(52536014)(71200400001)(99936003)(6506007)(53546011)(7696005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ci8u5bbbXl3EcI7dhYJXQslWA2jPqKH0RqO8b9j+ro6PTdQhjjVjYeFCtWSL8PF6ME5AOV70eK/AAZISkyMEz+FV/jvF3HZUaMIC7lUc5AHXEwwmTAoiqnw1xjuMXR4hCtOcnNCuSHZMIrzrMzOyJZauEe5IwZVonTKoadnIBjOsGo1vX7yZBBrWR8kVxclXVErYpii9iSkK7htA1Za5ckvmdjKG5sAUMAHZTaVdQW2Eor9So4HvzbyAhUo4YuHjfHMLGOEtJ6DBJ+5HEv0hl47qBvJEZTb4Mf7KQCylaaAlWYKu4iVb0xFLkXefP9M2S6+st6RxnPFhxFcxm6LqwX313FdGRhsnSC3BzsP0ytsYq0lO1KlKUC1peRZJj/1EkJVsA5MWTbTZ6YwTSt1gIu+4anANjI1k6ASgxiyRKvthGVZ8q2TRqtEdJncw2xr
x-ms-exchange-antispam-messagedata: P8J/MXf4t4TllragBTfK9FXahTquTmqogxC4Jqu6doYqlj2KFHq6FRUbmNJe7hrPdJyieTc/hYX5FoUdUJVbcb38FHnH2bDMrPWuHKljGF8pc7qgZDsoAjm5KiMLOWQB5INjn1kJnNNyBXavo6jNoA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_CO2PR04MB2343E47B5AFE242DA2307BB0E7C90CO2PR04MB2343namp_"
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c4b0c1-f0d8-4d69-3fcd-08d7d5f75d94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 04:44:29.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbnYWb1L2cTrLOK+f23e9X3+W323gjP8yGZWbT5BjJZSAcouwbNpOqZsr+w7PsesWHsVMsLZ+ddrleDjLcUgJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2357
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

--_002_CO2PR04MB2343E47B5AFE242DA2307BB0E7C90CO2PR04MB2343namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 2020/03/23 19:33, Karel Zak wrote:=0A=
> On Fri, Mar 20, 2020 at 01:55:43PM +0900, Damien Le Moal wrote:=0A=
>>  libblkid/src/Makemodule.am             |  1 +=0A=
>>  libblkid/src/superblocks/superblocks.c |  3 +-=0A=
>>  libblkid/src/superblocks/superblocks.h |  1 +=0A=
>>  libblkid/src/superblocks/zonefs.c      | 87 ++++++++++++++++++++++++++=
=0A=
>>  4 files changed, 91 insertions(+), 1 deletion(-)=0A=
>>  create mode 100644 libblkid/src/superblocks/zonefs.c=0A=
> =0A=
> Applied (with a small change), thanks.=0A=
> =0A=
>> +struct zonefs_super {=0A=
>> +=0A=
>> +	/* Magic number */=0A=
>> +	__le32		s_magic;=0A=
> =0A=
> We use standard integer types rather than this kernel-ism ;-) Fixed.=0A=
> =0A=
> It would be nice to have a test image for zonefs, something small what=0A=
> we can add to tests/ts/blkid/images-fs/ ;-)=0A=
=0A=
Hi Karel,=0A=
=0A=
Please find attached the zonefs.img.xz file for a small (4 MB uncompressed)=
=0A=
image of a zonefs file system. I tested it with the blkid run in=0A=
tests/ts/blkid/low-probe and it works. I am not sure if other tests are run=
=0A=
against FS images as I have not dig into the test suite (I should !).=0A=
=0A=
If this is OK, please feel free to add the image to tests/ts/blkid/images-f=
s/.=0A=
=0A=
Best regards.=0A=
=0A=
> =0A=
> =0A=
>     Karel=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=

--_002_CO2PR04MB2343E47B5AFE242DA2307BB0E7C90CO2PR04MB2343namp_
Content-Type: application/octet-stream; name="zonefs.img.xz"
Content-Description: zonefs.img.xz
Content-Disposition: attachment; filename="zonefs.img.xz"; size=784;
	creation-date="Wed, 01 Apr 2020 04:44:27 GMT";
	modification-date="Wed, 01 Apr 2020 04:44:27 GMT"
Content-Transfer-Encoding: base64

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj//8AAZJdACmRhiSQv/59WM6VtiaiWCnk2XPKX/dyhvdI
6Z4QTNJu2Da4TKfMmLl/LGojUZPvN4Q9uSgXdRLn3Zf2NkDxCD66TD4oOUYT+zjKhIUPMpatxzwQ
KI34PTiHwo1BIzIHnxzEhvCNSwJpMr4lTxYIiLyPgqXR8KNC1lyf3qVCy4g/XACP0E6vJiiUcR89
jyThcJ6nI1/sKMuF0ZWYin4qkfIndfcZwAaYTZj92K/VkA/EJVP49ZE2MQWlsO5vwXBNRwzRkRGq
rWAdus6xJxhcWYbpZlJYvul2rFnk5VsFCPnH2q38+1IrdM0eWyBC+d1TPfgpZAk7f7htSLk8D7VH
VO4RzOG6xgyy4tLkRvZU8Ih1LDDbwlBUkSKXBgNfyXA7FMAyN5ilFQGl6KMJKuyq/1omrHIMFpKn
vjmPJOFwnqcjX+woy4XRlZiKfiqR8id19xnABphNmP3Yr9WQD8QlU/j1kTYxBaWw7m/BcE1HDNGR
EaqtYB26zrEnGFxZhulmUli+6XasWeTlWwUI+cfahH73xZ//EAErAOxzU6f9vq58MRqft40xbnCe
pyNf7CjLhdGVmIp+KpHyJ3X3GcAGmE2Y/div1ZAPxCVT+PWRNjEFpbDub8FwTUcM0ZERqq1gHbrO
sScYXFmG6WZSWL7pdqxZ5OVbBQj5x9qt/PtSK3TNHlsgQvndUz34KWQJO4DLKmzftTvwxL0uX6oP
PktmQpATDv8Qk/hxeFn4C83/lShGD6n8fN77mjAuVsCPhfODgcBlxCVT+PWRNjEFpbDub8FwTUcM
0ZERqq1gHbrOsScYXFmG6WZSWL7pdqxZ5OVbBQj5x9qt/PtSK3TNHlsgQvndUz34KWQJO4DLKmzf
tTvwxL0uX6oPPktmQpATDv8Qk/hxeFn4C83/lShGD6n8fN77mjAuVsCPhfODgcBlxCVRDz+ygAHt
AAUAQyH0YQAAAAAiBfJscuCPCQAB6gWAgIAClTeLZbHEZ/sCAAAAAARZWg==

--_002_CO2PR04MB2343E47B5AFE242DA2307BB0E7C90CO2PR04MB2343namp_--
