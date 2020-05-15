Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB6CC433DF
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 09:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE2C2074D
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ds+LT0C6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="To7Zcypv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgEOJxt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 05:53:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33356 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgEOJxs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 05:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589536428; x=1621072428;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PPg4PNRougKn4LsVE8BTa41WOqeGbqiMOdx8vuN9b5E=;
  b=Ds+LT0C6wzSDo1pQXQ4F7So73FJCOpdsuDGmo172HWuvtzCsfxwHP8Co
   /vd0SvJxplquJcx5VI6cXFpzBm1Esm3AeFF+wuAvfeh68lSyoUlZNSUm3
   QlDFMkjJ8rN1p4vyBU+Wnlk91N7TkST65KkuyVUhr8a28M4lWJaUyEAXX
   VO6ZY8K46P/ZxeYVQEvu/DvlZ/0x3YI6sTqdF1YdXwpGMl9GF5gYrcMjX
   jXQ3x796Wso3Ck5qhFDwq5hVQy3yMqsyzAOSm/jXoi8g8JTZ76fMwDj31
   F9r9fe4v3y1+eAwwyB2ydqeCRYb6VElZXqdFX3aRgN8XXW3o8YE8Jf/hE
   g==;
IronPort-SDR: jtlsWcCN1mrtFFre8aEL59bz/WA+BMrM1a1EFemkd2she4sqij6rOOzTQ8i+gRZu707Vmrx4gI
 iCYTuL+3TVFRaF3PwV/I0W4twSlmkLGItiJzg0wMV4oBvu0wn/v/Stl2PYDlRN5l0jqD2RcycR
 yfEnx25DFiAXnmNhwuz5sAZW2TEjMU1Of76OcuWpCNFdX2nFXDUp0/iHEAL77eudgUHOuJsdKY
 PEQU9VuXx2FQC7fGRkE++fl58eAo90DhTEtn1vSR9pK9e1SfcjyiVdmRstpY5u/i1bPJ6YoUxb
 zlk=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="139199927"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 17:53:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnhvX5Dens6JfeWJqUGoxexSFOAPWTIXoyyK/15kHkfxim1o94npsK1hxLX7i7agUMsL52gr5q70rHh1yQhtHrFw/ru3v7gB9QnW8kwS72lr95X0dK5PuaW99K4stoogKzlOeikgKlX9Rscv1lYbX4Zujaac+A9hkJRciPGLimGpzGzLuXVHfV7PuAEG4Hv+4Q1ZD9FUfZpK4zOfPS2nMrkdPkIl+VjJ6x6WqQzwp/sdTWzKbHZBFXoO1mP+LfZ1oEvEQ1olvDBJ2FKcTRCNRiCi6pl2n83U+LopVAz4xeZv9UH7AQc4P8tsAbJFTNa9nRtwHzgDCpVNd6zPRzPbHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPg4PNRougKn4LsVE8BTa41WOqeGbqiMOdx8vuN9b5E=;
 b=RYBiwQr1OHA21UTcR/hT8PnIHG+kEpLCLrj7JUlmBWJiJ4gwrOF0uMuoR2xEq2APDhRUVk/Qcag/ZWdRuQiMGuo3ywLYtH72TNIgY7ER+bbNQM0f4DnsFjeSoL9X3+PmuHCiWW07osMI0pL8cbV7egToK87GaJ44mTjrjOUBwNVoTPUOegmC2dbsk33d7TQdd1yniDhEFXzowf2XEn2rMu8kBj6kGRGO4Rtv5IsWOAbb2KpeTZxuWAmavVKnuH/ZMV7iXVg/+dc3dIJED8zDFWvVPDyKvml8FzSeDNiTn7nx7G2FyUYQXC2s9glEasf4Ja8B0PH1Bz8NIJUz3x3BmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPg4PNRougKn4LsVE8BTa41WOqeGbqiMOdx8vuN9b5E=;
 b=To7ZcypvP7AeA0dTxRFXSBjI3Nm2cLL76KfPRtZmGxWxkOkcISpNkg19Muv7shIroQuP4jWAZTciKyc+m6YaUl6YTDxO7md8Zv1BB+NRKKNYHajR0BYtdz+yh6F0/Q6QwfPHNR0J5JxqE49g7JfP5rnGAvck0wLqyGwe5gwpQ1g=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3584.namprd04.prod.outlook.com
 (2603:10b6:803:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 09:53:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 09:53:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chris Hofstaedtler <chris@hofstaedtler.name>
CC:     Karel Zak <kzak@redhat.com>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Coly Li <colyli@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Thread-Topic: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Thread-Index: AQHWKpSvHakiWvEpkU2a6/78A/mYdA==
Date:   Fri, 15 May 2020 09:53:46 +0000
Message-ID: <SN4PR0401MB35982647432681A63CBABCA99BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
 <20200515085013.i5lzw5t2sqpamwhi@zeha.at>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hofstaedtler.name; dkim=none (message not signed)
 header.d=none;hofstaedtler.name; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 945280ac-e120-4159-1e00-08d7f8b5dc1c
x-ms-traffictypediagnostic: SN4PR0401MB3584:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3584BD84CECD5744A4A7D0B99BBD0@SN4PR0401MB3584.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LoQ740/sBMwFsNVteNUcw3/dP/+RTEPpTRDwS0gCSWCuWUjQ8qzPQWY9GsnhgBFth4QXaXH5AX1S9HUKQCq/JLgny0ZocZVhL5BJy0XUtYCiX5w3LLpjiwo8GJsGVc0SmgUcDUtPkyRl1oYi1wzJ+/v5xEV+ctQ04UJitwS7B/SKikidFTBc7VBT+z6W7WgnWd1xAWMjC9qMvQTGUnYtt7/FkGNtSVP53N9GcoLAl2kn18wTYaDBpgedBbA6uakk4jjnsNBSF44fj8SnvIjqaFsVus9iABiDAZ5bHQl1u2if9VBqF/1Xh39WmDBrFJCqlS37Ip22MF5S0LeGiZe2r0UyQDkq4duibCq2m8C3gWII/GTavgqaCGZlWwGI2pRobT/2duf6ymo5osjUVmXgnBmjRsY1lbKuihDoDA14pq2TzoGYy7UidnPOSxL0m9x4qKBPRjJj4Eh+lGuGUo9dkG1aM6nDy68dEpge3kicKYzLWAcDmUz6SGkYZa63rMNKB4QNFfOhgEoRMzdzMZuTAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(86362001)(33656002)(9686003)(55016002)(45080400002)(2906002)(71200400001)(4326008)(53546011)(6916009)(316002)(478600001)(966005)(8936002)(8676002)(5660300002)(66556008)(66476007)(6506007)(52536014)(91956017)(66946007)(54906003)(186003)(26005)(7696005)(76116006)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8KZM9+qHt3Iir79zVYrHFx4HT6qTDc9ftjNXZRX3aRK6QMKDhiQ5spBM5LhjvyJMwG+TDmkD7JCPApRTf3ojWZYHZztJxSKfSJs1ucWbfA6qWEpYmk2y53K6yqdtG9FFfzC+w6OvcuVNzsCy3wcwGG9K/Kcm4NCSIFQECZ4vbtr81zxlwEqtPjm5JUfa0yPfiLxjOKJ0iw50Vyk6RqB3wtbFL/JGvNX8Es5pY4KfGmqCdIGDxKP5BDUm1k+lS5b6Scbf64xEbEK7qApQAm17htzMUb2sTdyxMhhvdSwTnZqWL2TVSHHQwRaAptiHr7q2l1tjASbQahwfT9uHuHCjOIcS7KlKbW8DVIOSCcRB/8SjeuXomwLYp2FdKQ9UUU/OHn4a0L9ILL9E3+Eu18cLXTJ0T78mubn58MQOcGDgR4U21Zjga+aXMlI8g0dzl9h+ANmvBZExq8a/yxQMkRMZLFZ9cYRvkoJzXbfCNZOTj4LR2MHIluApOw+qvlOapXXl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945280ac-e120-4159-1e00-08d7f8b5dc1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 09:53:46.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiVWrja4zZcB8GIVXJ19TU5b/+2FkA8FY3ebpkyjp6PNfn8Cga3ZeiN3ZwPpqPq0atfRK4vfwd1Nx+OWzIG3v3F5ms1eS1iraxrshBmFjxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3584
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 15/05/2020 10:50, Chris Hofstaedtler wrote:=0A=
> * Johannes Thumshirn <johannes.thumshirn@wdc.com> [200515 10:41]:=0A=
>> If a user submits a zone management ioctl from user-space, like a zone=
=0A=
>> reset and a file-system (like zonefs or f2fs) is mounted on the zoned=0A=
>> block device, the zone will get reset and the file-system's cached value=
=0A=
>> of the zone's write-pointer becomes invalid.=0A=
>>=0A=
>> Subsequent writes to this zone from the file-system will result in=0A=
>> unaligned writes and the drive will error out.=0A=
> =0A=
> "error out" meaning what exactly?=0A=
=0A=
The drive will report an Unaligned Write error.=0A=
=0A=
> =0A=
>> Open the block device file in exclusive mode for submitting these ioctls=
.=0A=
>> If a file-system is mounted the kernel will return -EBUSY and we can't=
=0A=
>> continue issuing the ioctl.=0A=
> =0A=
> Isn't this something the kernel should enforce, then?=0A=
=0A=
I did a patch for the kernel yesterday [1] enforcing this limitation, but a=
s=0A=
Damien said it's SYS_CAP_ADMIN and with great power comes great responsibil=
ity.=0A=
We're also allowing other raw block device accesses on block devices.=0A=
=0A=
[1] https://lore.kernel.org/linux-block/BY5PR04MB69006DE86D1050620B5EDAA4E7=
BD0@BY5PR04MB6900.namprd04.prod.outlook.com/=0A=
=0A=
> What's to stop anybody from calling the ioctl from another tool,=0A=
> without using O_EXCL?=0A=
=0A=
Nothing, but still we don't need to make one's life hard by letting blkzone=
 go =0A=
havoc with FS internal caching. If another tool does zone resets, it's up t=
o them=0A=
to check for mounted block devices.=0A=
