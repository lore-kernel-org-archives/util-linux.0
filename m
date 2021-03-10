Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C114FC433DB
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9499464F4C
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 15:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCJPMf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:12:35 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:3157 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhCJPMV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Mar 2021 10:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615389141; x=1646925141;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/9aoFS4P8X16k+lfijjbumdSE5J2NagI8cLzWHgLCwE=;
  b=XhYOGySPfNjLS4rzWq+fpjMcjdZQBCZQBrG5dXXJYr7ITtfXWCZ49E/5
   3hfbz7L2pftIA8v1mvcxeslzZkQu+vE2ab/gyGJQG1XRS673wfZG0E9FL
   IS+ywai+/JueVsNwx/QKLJdRS4XcQsAixOtYQtdMZb2T2ZICK8GaeHcsj
   Tg53i813VyMFjUoHCHDSefKl3Ibyr9LmE46EWTNMLB45mZQx9UWv/qeur
   gB7NXPE0Q+i9jGjo4KdT1lOYFOoRHi22Bx43pjtMJ2KKZ1zBAC9dn42wm
   c3QAANPmleY1quqlZc/3tTvq61ZmoLa+G0JDJd1TxnkMZpGK6S1vWx5UJ
   A==;
IronPort-SDR: WP2Sde8XcUhKfSMkI9pmK2NW2VO4bRzmdqo1uwn1WFWUiVEk5V0/xc2ZeYsE4gXdhMDhMGfPsB
 KiMS+xsOlevh2FwGQsbJBdaZ+H1IEX2fJQu6/3/nNSg2RRtBLQTbdnO5uKzzGmo/rgOGxcMTfI
 G/BseaaXtpS5/nf2mD5BFs9IVbZLfruuRVKscMnu3UX0x7O3aqtlIZwxeQyJqQQPgC9CYdU5cW
 ucMo4zJlf23VvSbh/iJIKl6vRcsAKdwTZgWS719florkwCH2J0KdKBHEZ/6qNjs0HFyVMjY+Z2
 dV8=
X-IronPort-AV: E=Sophos;i="5.81,237,1610380800"; 
   d="scan'208";a="161839520"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 23:12:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8NSz0Lg3TdHmS9xmcfWBwIXbmo+EM1MxALvvFVCFXMbp/QUPv60DLYFh5d8mqJ0MrRqjk4YPk+W3qcAco9NZc6XgNSKdvMmfcq/vQkaiI3HFbneXGFgGaas+qzGDCaudk5h1Kvwk/J2DU1J+G4Ede8epvPLvZHsJHteeDDn3JXddUBU9fhz5i8a4qqwVL1xTJczvDNt/JumU/JaF5wKzxehvhxq39OBK2nfojC+43sKAGptme1mLu82JRyebD5Iuiqzkm5PnOTwsVeSEbVgVa3MRBiNTmlQUWC4zdkCkUj/MSy3eAi8wCOQENlqI0m2DUQNXc5Y11GWyH10EEK6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azm52HTgH1l7/q15V1Vs81iWA8dQzI6ZadxTfa+ky00=;
 b=L3Br07LsqnpLGMaFGBGrPSWMXgTN9DTtFhqgUzONdYJ33g4lrAdkG50V/IVNms8R2KXf9sQm4u5/v0nvldd4ZXhxzzlaPrRGBWOHWAxIaID+mGL64PThvhuYy7F0qK3lMn9z66GNHYJ+CZE61k89u8HLXc+y66unT/LvCZuu5YxO+3LDWc/qinJZBrdhBi2imIEDLI7jAIdRA53hhFB4LjbqbFNSruMuaBvYOauVKwAdo+1KAs8qrfpgEeiLEZinAkSxi0oHGgw/ocT4m3daJMtBECzIg0RslsZNU85tPkdFzULsCshxeZfVeKZS/78zNUjNpfK86m09n+z5go/+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azm52HTgH1l7/q15V1Vs81iWA8dQzI6ZadxTfa+ky00=;
 b=yQ5gVKovcNroLGgg1fznwJvoWRSX0EwSplOEFVet1bEWrJPEuEsNFs7fX5uX4RpzIjlMVoenao0gKMm68W8mb0atWRuwPkAuY1ZJOvDy1ouNitmSnns4dU6wrF79e7n8lAQhsaktxY59jVlr4DA6t57imky5fjyuykbSXDVN6Oo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7285.namprd04.prod.outlook.com (2603:10b6:510:1b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Wed, 10 Mar
 2021 15:12:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 15:12:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: Please include blkzone: add capacity field to zone report in next
 dot release
Thread-Topic: Please include blkzone: add capacity field to zone report in
 next dot release
Thread-Index: AQHXFZrIgAZkcouBmU29qkHOfMVYVA==
Date:   Wed, 10 Mar 2021 15:12:18 +0000
Message-ID: <PH0PR04MB7416A2576A0C80857D22953D9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <PH0PR04MB741640EEABC8A25E6EE248399B919@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210310151106.hqilnhitaaan77wi@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8aa8b436-a652-47c9-6189-08d8e3d6e5bb
x-ms-traffictypediagnostic: PH0PR04MB7285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7285B1EB819DFA5489D503179B919@PH0PR04MB7285.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqdRJQVx2FO62EPFBTqzWuKwfHf55WvNIHiJZpXj4+kw2LDreVa7hrFyEjxbz1VLe8YoFJQhgzspNDmQqanS+CFQxugjdo6uP0Ujzf2BtW7BgjbvuM9U+84aXnhY2DrG6609KXxhGjUylcW/swlBBvapeLkrbUyKd3vJtcvH5zujJmMCFICl0S4KQdKaPJteK3pYMIOyc2meOKq+T/JWZOSOm+4BCBIpCC/WyBtRuzBz+4MRqhthL1/VqlZa6qTjV5e+8W0DEBq+8grc1jPE9THL0pU5Dnw3k9hkpHWyfIg8E1hxNmQIOadphabfk/PLN461sos+ARXd03PySnKyS1+Zsyi0ulzdCipQrZWjksxVjLgnsq5ajowpGQIBOUIWvqAbKYiih2DCXzIMq267F4zFi6+3f2Ki9HofHCUKePt27UgNU/kGt6+YM7oH1cEn/oABkiA0kAVlqvMZ1eCC8lRgssAWKd5tnZxtE2U8QRx5NGVKiSociaRUd7ygtGpjty8YuhwvGcDVI60/rdvs7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(9686003)(8676002)(66446008)(4326008)(54906003)(316002)(478600001)(6916009)(186003)(7696005)(2906002)(558084003)(91956017)(66946007)(53546011)(71200400001)(76116006)(6506007)(55016002)(5660300002)(86362001)(52536014)(33656002)(64756008)(66476007)(8936002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9g4rc1D89gJnfgpMdksbKulVv55yDD9NXlyDcvca+hn8gIGaSUSHDgS7ZPCK?=
 =?us-ascii?Q?zrsi6nWkQxxb/c3t0TcVaooeOn1wDBj6Sdyf0w97d/ViRk/obIHft+l4xUQb?=
 =?us-ascii?Q?Uqu0O7v73t/uBkaXdrn846zsLSMhlmoRp68/p62h31DFQkGaPnOva0/MU0uq?=
 =?us-ascii?Q?7GXazknPclPm5wOTPDkCK0TFotsne0yB70Pj1RKgVMyWFMN09akAN9qMafN9?=
 =?us-ascii?Q?U2pEPQpZezumVtkWsPsUI1+V3zM7ugWxjCVK7vfbf4wYgqrPaJNQ4C7v4hly?=
 =?us-ascii?Q?9q4n7Q9D5ETCVtdPDJXkjqSKYiVfb8vEuXYYg7eTbB+2RefXuSUKYMcJ2HBW?=
 =?us-ascii?Q?ejL7V8Hl1hSRh9f0D/uJDeoODfAOkRMcPxun2+JGtK4LxLn7SAh/f488eEl6?=
 =?us-ascii?Q?bX0n3fvVR/Ue/PJgnX5tLjVsxuebuZe4zLtgHBxtYBJIPOPQVzueP7Zmx4Tn?=
 =?us-ascii?Q?wK1bmYSm+lRj+G+NBlBYZCwcIfCKSWd+URVbbumrGptz30GlaaUVr1ProxpL?=
 =?us-ascii?Q?kkJyyru+W1he3VPWCEGXyCRcQXc+LPqAcSUpEv2JAJCKpKOyXcBAGP2A0IkJ?=
 =?us-ascii?Q?sIk1VSZ7I26aKk5L4+WhrI6OfTeWXfV8W5z7rdUS1M8mx16N1zNnXG6TocjN?=
 =?us-ascii?Q?iLMbsoMVT21Wn3AqHa+OB0zJ7q8wJv+BxZdlaidQjbY2434W+O/uyTqwDNMy?=
 =?us-ascii?Q?84F3PyS6AW3LVR+uyrJGpasX8Dhn7/oq7wYm6uVp3oFxGQuCdtHDLCqk4L65?=
 =?us-ascii?Q?vIdiE46T4DrhnXYY5Zd+9dQec4+4MFnQgVKNUUz2Ny9PaLuAJx4t4nA0XPcZ?=
 =?us-ascii?Q?54XFOnVOU5LosuMfMO8S5Kqdqa2K0esVPsPgCRu09G7+HxBBV2Vsl/8CgsgG?=
 =?us-ascii?Q?vxU1QrCbRf1xYzPnun1s8lipJ7LqeqwaUxrZqw1BjUgD83S9Q3w4VP1ACb4I?=
 =?us-ascii?Q?8OqxCpOvsvwH7zBIYPhBSt7+rH69fDbrnwhqsavzl79Rc4r/YM5NudJ3L8kH?=
 =?us-ascii?Q?faG8VOqs3uf6UcqMKudFUiocxbkzRfrsWTbhlIk7FZONPlzdzGv5a1kTBnqN?=
 =?us-ascii?Q?beFKGWjIr7KwVYfnhP9JYez/jlDCRUEhTP4Qjmyq5lyiK5wiVn0Rh2wM7I9J?=
 =?us-ascii?Q?kp55PsyRqKn0oKrDKwPn5tgne6gLQkhwvwuloy/bXB6mmRuWKkv/3i7xyyvy?=
 =?us-ascii?Q?2oaksIsAqqw3hj9w6w3Fh5v5xkIK0/Lh5yj2EyxBHAuOgOtCoTD9f8Z2Kxr1?=
 =?us-ascii?Q?4/GuTYOKW00VbLHH0wTcmAqjr3DZJ+u3GlyFxT2pny+AuCdrh4VzRxYOuJpv?=
 =?us-ascii?Q?K9HdswCavRpW4DiG/sgp8604kH4vh/Q1MbrXJ4mx5zp1/IuE+oyDxSQzTue6?=
 =?us-ascii?Q?WqppGHLQYCFw3+6pR0JqjHecFY7Gio7Fiz3eCkgr3LkUz37K0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa8b436-a652-47c9-6189-08d8e3d6e5bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 15:12:18.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQ37PwntQDJh714/3bKfwvpF/F85cCYwLDaFJ4Q8GRI9ZI4ofAiZXh2qqnTwFB6H1q1E+YJBpCvJUC5ao/sJHJVh+3Rmmh9ZzGr8rwMPpTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7285
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 10/03/2021 16:11, Karel Zak wrote:=0A=
> I'm going to prepare 2.37 in the next days from the master branch=0A=
> where is already the patch.=0A=
=0A=
Thanks a lot=0A=
=0A=
Byte,=0A=
	Johannes=0A=
