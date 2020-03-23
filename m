Return-Path: <SRS0=nY5j=5I=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF42EC4332B
	for <util-linux@archiver.kernel.org>; Mon, 23 Mar 2020 10:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7525120722
	for <util-linux@archiver.kernel.org>; Mon, 23 Mar 2020 10:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nQ4lelT5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DxR6A2ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCWKih (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 23 Mar 2020 06:38:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3901 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgCWKig (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Mar 2020 06:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1584959917; x=1616495917;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Jv0pc273+fs9uBDDRLgjsN7D0ZDAEo7l90kC1b9mduo=;
  b=nQ4lelT5GuzD1LqBSDIv0fouzEaBTm2c6AX45Mt0A6FsUVJWGkcCpUDM
   avCEwW+KxbKNoepIg1FUv0BDRPnBbqiSSBXUYbkcDZugWW3lW3xCU0yBG
   zTpFrMaL8ZCuUbcxAwAEBimqsAaERn+e3Gj5LsDoSCGgvqRWHFTusyCvu
   1+cNbMyFg2DWtWz+pnccrJshBeA3NUJQcUxnSJRMzRQUrLhRn8YIRaqSf
   VdN0mNoXldDjvvd15WZLkjHQK4RP9hPMdzNZmVLxKq36uRLolRhC4acTK
   M/kilWkppqia2HfYjvoDI8q885TLJCEJBMuSJGjBBBY6avln4smcImbBC
   Q==;
IronPort-SDR: nYxwD2J60hKJ1W8xJLirJCPoNZgf7iynZab0zv53eTocLE8mSQnhxV9jkexksXEupX/0whImyC
 6S6SwTPkZsjYnC/SVx3BH2jF22iY49BlmeFnnBzqVWslf8TG/2Kxybk1biju5Dp38mvKGiLoFK
 i+go/V2C3VPXOJrvWm1LUFANcGqkOYbgR3cj+jCFQDaR8rKuCylQBbekiqy3a+QUCYwMF8xjB8
 xI+fZN8fe2NW9lXRu/wjdNpsR3szqgEE4Q/hkkYH2Vv8Xamr7y1lX8Xl0ASjkjMSIsdRW8NFqH
 WzU=
X-IronPort-AV: E=Sophos;i="5.72,296,1580745600"; 
   d="scan'208";a="133684305"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2020 18:38:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IasJ2ZZbObrx48vyIvfAp8jYnustqs5V94zyLX4QlHpVxdzO6sglYJ6jLPHI9uxVzInU22IgJiRwS2+uApcMoL79tKYxT1in+DKr/iI39P+1KmreMJdQuTloq0LgQRVUxwzvA7c3Pul5UuZqVRwHtmcTWPHqTsAxFNMzMghfLA9/KDObenob/4f8Frqx/rJMrL+TRiPujDdz03YT1ByaVF0H0BYhz0yVg7crV0ialnNeNbNCIA1qLaBJaMfiiZ8ls93AOg6cG2h534+OKvBlaySeT/se2M0JDP9qINFnTOEleMwLeAeRiChehNwP7o6WqMtn8OCmlE9ftenCc7zvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib/axd3WscQteUkqRdCNKAZWzMfzNj0sr3Qegh0amRc=;
 b=ad79haNMXCyjIsqP8lc1YBHGjapa/XhAI0m5XSVwzF/aRXUf6FkHlNcwTTeZPpPTyd/uG0M3mrAKYR3WM0mblCx2QQWAZ5WwvvsMYPO3vihlatjDDxcCc3vYjI3HXPyufOkqsNgtY2UXUCdlhSjdsuNeJnl3uLNXFltNnpvUAycZdSmQfEfB9MmavoUGEfgT0c3m8Gk9PLpqt5OQI6PEaNCq50OP62DPhxPRFtTTV3JgMen2vtZ53RrtX+MFKXZizScNEip+8MejWTdhfV8pVHOvNCpvoZ84wlBx73rj5PII4kcfkyFDfGkciBPEFDt8xf3ImTP/6Yz9PJcgs9k92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib/axd3WscQteUkqRdCNKAZWzMfzNj0sr3Qegh0amRc=;
 b=DxR6A2NDWVSHetFNA3uZ9J5KfT2PtbCBwvNOWXLJejvpLnxu6b83xSfy/Vv7N9T1jHm19GXooiPUKuYCN+AF9J6iwmG+tKg1KRIAdag/gGaf6w5JUsV21LD8h3kX3ncbhiF5UFwhtndjq7fP5WxoTykLCQngLHGc+Fh6svGgKLI=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (10.166.200.137) by
 CO2PR04MB2135.namprd04.prod.outlook.com (10.166.93.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 10:38:35 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 10:38:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>
Subject: Re: [PATCH] libblkid: Add support for zonefs
Thread-Topic: [PATCH] libblkid: Add support for zonefs
Thread-Index: AQHWAP57V5VNJpfXsU65PGkMPbpAKQ==
Date:   Mon, 23 Mar 2020 10:38:35 +0000
Message-ID: <CO2PR04MB2343DF5C09B336B18AAF5F43E7F00@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200320045543.2053382-1-damien.lemoal@wdc.com>
 <20200323103305.uhlc3d7i4famwq5p@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d18c043-18b1-4157-68b4-08d7cf1656fc
x-ms-traffictypediagnostic: CO2PR04MB2135:
x-microsoft-antispam-prvs: <CO2PR04MB2135F29BE932E76EE7056192E7F00@CO2PR04MB2135.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(199004)(9686003)(5660300002)(33656002)(52536014)(66446008)(64756008)(66556008)(66476007)(66946007)(76116006)(91956017)(7696005)(2906002)(6916009)(81166006)(81156014)(8676002)(8936002)(26005)(186003)(55016002)(4326008)(316002)(86362001)(54906003)(478600001)(6506007)(53546011)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR04MB2135;H:CO2PR04MB2343.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aE5vmzj/Ll/Wknp3mlYvthlvUKEQltyXc+d1FI4xujrjA400VKeWRtr4RPBH8J1Tu1yW2hZ73kWrKYsJiNsJGWykg1uyXPgaclh5WunpTQ1nOvAS2Hqp2xaBU5NV+nHWe4Y946INzfifbMnDZW9qTi+X8RkMyBT48mVrw280SPaGXpgIdFwJo9LMjX6lsyvkNIIt1ZhKDBNfF6Kp3UFNgQx0gQUF27xzIhg2MD2OJEkhgrA+mnHTMS8jzxHooQYQJYX9yuoua1BvPmLmxTuyjZWdoyJrDCANBNkKNpHMS0AsxNozxF7k1c140UxPI7fSPTA1KKejbAxO3/EYxvidN3K72c4wHJmjFnS9197tZ3RmgKNFCqLMEeCWNl5KXq5HQ7rLRYizl/1BTybpgEFzN7EHSVL2z5LoEVCRbiV/5XKg7VKl4pXdovYMKrwBPkUl
x-ms-exchange-antispam-messagedata: azdG24EArYVdVAxkYOSHPVcgbV41t8b/biFBNbI/VlN1NmkkrtjEz4RNUuYtxWo4LtFe8ELdrVWZf8WartQTqDcl6nthvVT00yo068ylod6fmger6spRR1k6k0EGwLcX8Csohwn6RfIJOeysW09RRg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d18c043-18b1-4157-68b4-08d7cf1656fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 10:38:35.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4F+Yu9FtUE19a75uh/RBYtuoM4OaS7TMhIxfPggcoxYsAqCzvlzKaCJAxHzi4uOE37kmoQyridoTah98HOqLAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2135
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

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
Overlooked that. With null-blk with zoned=3D1 option set, it is easy to cre=
ate a=0A=
test device without any hardware. Because with an image file, we are not go=
ing=0A=
to get a zoned block device with loopback, which may cause some problems as=
 that=0A=
would not be normal at all to see zonefs on a regular block device.=0A=
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
