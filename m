Return-Path: <SRS0=WsHy=7S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAF5C433E0
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 08:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790C7207D5
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HSN8WMqc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZGGuQGku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFEIQT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:16:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29672 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFEIQS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Jun 2020 04:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591344978; x=1622880978;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MIkkHWSSRaipkM859uNHpCjzHD5cSl8XSY8FuH6uW4U=;
  b=HSN8WMqcGHE2T3PgqZ/4eShBjbOYnvxovVfoDwA2B0f935nZ5/KuVG1O
   1uFErzc5tyleSgCdpVfE+0oZIpP8IoQqdMkoVoYWxQDQhxw+hnOwCwjx1
   Q1esZxIJMmvN3rs1aFh7saVQCqqOAXx1OyGSftxpQ+yGCUmrR8HrpppFW
   HBuNBusI712jaoM+yXBmT9HtDJWTjrewA7LKN8TXxDrYJePyn96WeR+eq
   /xBCx/FHMCQFOVpd7UoBgbQqJsCwDNS3ieP+dK0xRRtNRFiSCKIbto56X
   aKQqpq7lg42KnDPto9AKj4DPWfNgmTzBszVAnmEBVT/JSWbxik5AlhCsX
   A==;
IronPort-SDR: jAr4GWXbHWhp0T+Gwkq+6eEyNCwa9bYFysPZ+IXiiBm1u05ErzAmXooNlMFe70llLvabiB50D/
 Q0fFUFIZW0hdT2f++kBUm5X3UUOrtnseva2KTr2fe/OdnjXq2hW/U3P0sXV7EiKBsvVbh+xUYt
 acg0Tf6hwqh/QAuf7vRnn/Cp4MT3YuaUjGqqPQBtiUK6oxNOT17aTuSP9a+h7y8OZZLUcA5ON3
 TUpTT5QPA/7rAIfUn02FunTNGsxs36ueosf295dkJusUv8j9aGUmOc6bxCoaJ1DwFUoK3yvR7i
 eWg=
X-IronPort-AV: E=Sophos;i="5.73,475,1583164800"; 
   d="scan'208";a="248381821"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2020 16:16:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOWnVsqLbCnRycVlJhu+/XUwjY6ft/oszGr7RoAfExcxbDSjsuavp8PrNmzsHbEYSVNcqAi9TxGw3+Sf588xvRARxZqSDcXySEZCCCLT/TsFNeeKcNE7oiemVgonflZcUpDy2IlCYOwtNLYl1bH+ad1mBreaH6od21eKsVz62MZ3TrbfUo1Wpwuiq5y1NKVr0NtvG9xNrC127Er8kGswPZRB0R3MZOl9iFeGv8d9X7uaGxn3lw00vDZmfvMdTaDDHaQPz/W4xJmyQuKC9rWM78DzTLEAi7zecNihdRYS8mLxgK0Iy73w09Mto6U9r70+Cys0LWwKVZ2dbxAOpgT13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3zFOAwVYkDuzl9H7J2sLWURE0mbqboxsSFBLXd15WQ=;
 b=WrNY+iviSOxezN4/sU46JvKzahRzOLLfwtjpTYqozYd4iGFiLv8qSzl/2VKq55dolwwTGBSbHOGlWH2rIGSCLpKcmWf4rOoBdZrC9Ur2OFWkzHt8KX90cweegHFj9uO/FbKQepYUYrWWNeMHmV62NrQj+rUBwTV8p8SS2Sdul5awdGhqvddPuprkfR0KFJGsEKOjosdH3wSSoWdCaUdCyuqX6crWGDwrYHylNSI5eIKsSuKty5VeNZk6IzAh2LzpUMM50mxAjCwuUv21Z49hHcgrz25JceYLjK4sqllx4vfoTkA0+32FombzGtWVy8UgcNaRZ4OPlz4/dFuN4AneeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3zFOAwVYkDuzl9H7J2sLWURE0mbqboxsSFBLXd15WQ=;
 b=ZGGuQGkuxtWjFYckuLEyLSRrGlZYE13nppCsIYEY6Jdy85YyinfOseoJ6SxM7W6JZE2SsuL3Pg+0Xogj1xnAwSBoPzj09gCvl+GSarejMqsuBpgIpY9kI7s6pcnq0OERnVhjrrhWVMDW0CtoTkgVRGEzVr6mw3j6O5T9dXSRoc0=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5285.namprd04.prod.outlook.com (2603:10b6:a03:c9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 08:16:16 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 08:16:16 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: Add --force option
Thread-Topic: [PATCH] blkzone: Add --force option
Thread-Index: AQHWOvcP+rfthYBiMEqUyEy3HVTr1ajJpL+AgAAIfIA=
Date:   Fri, 5 Jun 2020 08:16:16 +0000
Message-ID: <20200605081615.3ce37az6s6sgbldc@shindev.dhcp.fujisawa.hgst.com>
References: <20200605050618.591153-1-shinichiro.kawasaki@wdc.com>
 <20200605074553.bsepxxwzk4zhhh4r@ws.net.home>
In-Reply-To: <20200605074553.bsepxxwzk4zhhh4r@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dcf17419-705d-487f-59b9-08d80928b814
x-ms-traffictypediagnostic: BYAPR04MB5285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5285F4C60EC774D7A5947691ED860@BYAPR04MB5285.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIKyENXq39Fxwlx1BKIhw+8xK34C8/Bt29KSjThj3hrn6cd5n12PuZAU4PGKhOBoYgMZ3mHr0HOxVViU3IvMFt4Ky2R98imukNHUE6ADk1uz9OA5LJWYxxwn4wivgT6PycCnw3WmeoUW3/S5Tl3YfILsoxfxXf/n/4RY92Bn/hdsqDYmiAj76P2Iaxzboo6SME3MGAwyzgcL4tMzGGcr9sWVRASARgkY1uorr57PCKLx82Dmwr0XXdj+TZrqBjsXlvE5XHA3sW+oTdmnD4zSgt+u0zZ2qk+ETZATIqzuZ2HKvehFyk5AtWeKzCo93EtN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6916009)(186003)(66556008)(64756008)(1076003)(6486002)(6506007)(44832011)(86362001)(66946007)(76116006)(91956017)(66446008)(83380400001)(4326008)(478600001)(5660300002)(2906002)(26005)(71200400001)(8936002)(9686003)(6512007)(54906003)(66476007)(8676002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7cC7weZ6+yB65Ivb8lTUFw0kMzXFvYlKjj4qHMuh3qUdYZ/lQTwOaWt+jVhnH+DTxDRAQo2R0HSsUIbBVj+StHFFJ6da2zsBQwZBYHpXDqiN+0NB8CjRnjHHfsFBnCyGRLWul/kgbjSGjfhiCPlG9YCQW9/ZNg86onu3TJn0VEMdQcVCE8A4aj+0VW7v3kNdtu7JCzsYORPsXZMXFIOIGkFHhCZ5jDKgpLZh8oEHcES3m38kgw6Ci8M2QRyZo0p+GTubmQ/55NvXZALuRuTt58QDwWbHCAB270RFYs0aUDT06iX8blQrd0BIRJIiuwpDPdZA9RSWBgJ0uweuuS9YMBBqLokYggtBZfvIVeBVVJCo8+9rKeCVLdVna2gHVgr2aZO+xANf8tbTjOzzievBNOHpEZu2bd5qa08K+qBzghVLAF48xzJnHS3+IW9NAD6qjc2KpcIBIgMR6OWbrZjMx/jPh7NGREoW4DuGv4zZ3Vs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5F4044B2972ED44B9C33322617269CF9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf17419-705d-487f-59b9-08d80928b814
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 08:16:16.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2JgFCn2AH/ayIxT27q3bvnc5nADvt8usQW4VNU1b9Eq/W+/3pKtN2fM6Iv7wa0uroJsIBCiE/hNLPNHfEYXuBjtdaCBsPuy0o/WW9ZDzjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5285
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Jun 05, 2020 / 09:45, Karel Zak wrote:
> On Fri, Jun 05, 2020 at 02:06:18PM +0900, Shin'ichiro Kawasaki wrote:
> > Also fix missing initialization and too many periods in man page of
> > --verbose option.
> =20
> The initialization is not missing :-)
>=20
> > @@ -382,12 +387,15 @@ int main(int argc, char **argv)
> >  		.count =3D 0,
> >  		.length =3D 0
> >  	};
> > +	ctl.force =3D 0;
> > +	ctl.verbose =3D 0;
>=20
> This is unnecessary.
>=20
> According to C standard all subobjects that are not initialized
> explicitly shall be initialized implicitly the same as objects that
> have static storage duration. (C11 standard, 6.7.8 Initialization).
>=20
> For example:=20
>=20
>  struct A {
>     int x, y, z;
>  };
>=20
>  struct A foo =3D { .x =3D 0 };
>=20
> means that foo.y as well as foo.z are zero.
>=20
> You can see this pattern pretty often our code.

Thanks. I misunderstood C language struct initialization. Also I noticed th=
at
you made another commit to reduce confusion. This is helpful :)

>=20
>=20
> Anyway, your patch has been merged (with tiny changes). Thanks!

Thank you!

--=20
Best Regards,
Shin'ichiro Kawasaki=
