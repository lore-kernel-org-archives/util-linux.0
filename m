Return-Path: <SRS0=5EDY=N6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E163C43441
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3452145D
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+U+KcSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3452145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389944AbeKTEFD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:05:03 -0500
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:48093
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388650AbeKTDNa (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsRkgtxcrlxaLCLxt4m0xE7EJgk2SS2dlcUzQwXmCb0=;
 b=d+U+KcScayFBThjH/9kVLwKgOHfs3jRdxQaKJBj0VUbnp0wflsoqpvM+J9w6odtDPxaQS8lTl1De49mITxh04rEXUhz+xkK+doOkewrhb2tHO4+IQlE2Qg+LrCi39NFMduyHulgL6N8H7S1viIZy3dPWZVw3ATaDjCYHtbZ0fJg=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB3985.eurprd04.prod.outlook.com (52.134.90.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Mon, 19 Nov 2018 16:48:34 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810%5]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 16:48:34 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>,
        "steve@theinkpens.com" <steve@theinkpens.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: edac driver initialization, interrupt, & debug
Thread-Topic: edac driver initialization, interrupt, & debug
Thread-Index: AQHUftrJh0wfhXfffECLCCglLVqjYA==
Date:   Mon, 19 Nov 2018 16:48:34 +0000
Message-ID: <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic>
 <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB3985;6:V6ZmwugsKZtUmnUn/YL+Wi3QeQzo7H3cU1I2Wsq0BhnmTunjI1T6dTVktlFLkpg50Z5KkAuKzASwq7tKG6Mdc7s+/n8GjZ4WtAOD/uKfJHj+VIe3Cm/vMcXNWdwUtIwindzZAm6q6Qq7lMVlG56XZPkKuPGXOfOezYG2scMsu9/+sEOQ3rDYpOB5EL7SzP9DhME3xDontsSuj6JT0ryoTr8rC1hAVx962Ccm5NmO+G2vXng+2HQvDalstOxLeTaFJiPq2yK+L8kvMDuPLxAWqz72cjspojR2pB0VXXXb/06RGNYMgqHMqsLqA4j1oGFyxdkWNM/VRqutP+oGBS/Wb7O33FPH0FTecDCdeVdxC5+Bu/Na41qn983XkscdkUE3MdByuJp/IQjobuNtDUkoYTswxtzMBePhqkFqj6yM3vmTGhtYVhgFCyCey6BmUs9QochZiwxXa/HvqIIZhyfpVg==;5:DuwN/JeDGej4nlU1kLuI1wdwMW98M+4ZCis5SSVC1FvjG51zVcB1f+hpJikioKnpdfcSjN2JGSMzOW23bCRcKJefMYVASh/+NN+C0SEmkaYgEkdBQRimHxGehBkWbpqpPTnvXqEU/EKP3eQ0u8QEq7Od1CORnWaue9VVVzzp5xY=;7:yO9wuhqEZj+y9SMW8bNZOR8L6BK0M3PhYnNlxmc8fW9sBq4H3cf2uMfvsMuHu3sO945I/BKgRlJ7Hu3bKDEs84EwkSzj7xoRb0YA8G84riKk9jVJO7iCA8+uXJT2LZAc/4Jf+EUXYDMJm0vC7K6f2Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 99206161-1453-4cb6-ad2a-08d64e3ed8a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB3985;
x-ms-traffictypediagnostic: AM0PR04MB3985:
x-microsoft-antispam-prvs: <AM0PR04MB3985AE470788175A960EE70E9AD80@AM0PR04MB3985.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231415)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB3985;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB3985;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(366004)(136003)(376002)(199004)(189003)(81156014)(8676002)(8936002)(99286004)(68736007)(6246003)(102836004)(33656002)(55016002)(54906003)(2900100001)(6436002)(2501003)(305945005)(53936002)(7736002)(6506007)(9686003)(7696005)(93886005)(53546011)(76176011)(110136005)(316002)(66066001)(86362001)(81166006)(229853002)(5660300001)(26005)(4326008)(14454004)(39060400002)(71200400001)(105586002)(44832011)(25786009)(486006)(71190400001)(6116002)(446003)(256004)(3846002)(476003)(478600001)(106356001)(186003)(97736004)(74316002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB3985;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7q4/biBJEJNlWGZuk2RGsWxOtpsWLlPohpZiRuNdTJsxfmpa/kRDwdC4OqdtyGPvCwk41z9YdcrldYbsJl5ihJLGwTjJLTM776Biu/J110ZEEbNy5gDxOx8/zEhbmCpm3sfbsiWsYqXODC97793sdO5bhqd59v8HHEchKVWCtYnO8Vun8FLro3lmqZvpkCXSu7CrcQDzDnxx+odedrOXKthZ8E2SIqf4s/uAHI3kS3spTwbbd1e++fGyNiWa8MPpgZXzkw6l/N7UeXBLaeHtDy2tkj867vxzyvj3JrGfjE9gffc+su164TRJuJ4CMzeVyZkVGXJ9Knefhct9MFVMMA87QGBRhyFBHizv5ij4TF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99206161-1453-4cb6-ad2a-08d64e3ed8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 16:48:34.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3985
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/19/18 8:38 AM, Tracy Smith wrote:=0A=
> Steve, you were correct, there wasn't a device tree entry for the=0A=
> qoriq memory controller in=0A=
> arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi.  I added it making it=0A=
> identical to the fsl-ls1046s.dtsi, which should have the same memory=0A=
> controller and entry as the ls1043a.  I added this but it didn't make=0A=
> a difference as far as being able to call the probe function. I'm now=0A=
> checking the mpc85xx_edac.c dtsi entry for comparison since York used=0A=
> the mpc85xx as the basis for the layerscape, but there is something=0A=
> else missing preventing the probe function from being called.=0A=
> =0A=
> @York=0A=
> What is your entry for=0A=
> /proc/device-tree/soc/ifc@1530000/board-control@1,0/compatible=0A=
=0A=
EDAC driver doesn't check IFC. Are you debugging EDAC for memory controller=
?=0A=
=0A=
> =0A=
> @York=0A=
> cat /proc/device-tree/compatible entry is this, is this correct?=0A=
> fsl,ls1043a-rdbfsl,ls1043a=0A=
=0A=
Once again, you are using your modified code on your own board. So it is=0A=
not ls1043ardb. This compatible has nothing to do with EDAC driver.=0A=
=0A=
I cannot help you with ls1043ardb because the real ls1043ardb board=0A=
doesn't support ECC. The closest board I have is ls1046ardb.=0A=
=0A=
> =0A=
>                 ddr: memory-controller@1080000 {=0A=
>                          compatible =3D "fsl,qoriq-memory-controller";=0A=
>                          reg =3D <0x0 0x1080000 0x0 0x1000>;=0A=
>                          interrupts =3D <0 144 0x4>;=0A=
>                          big-endian;=0A=
>                  };=0A=
=0A=
This is your source code, not your final device tree. Please learn to=0A=
use "fdt" command under U-Boot to dump your device tree before booting=0A=
Linux, or check after Linux is up. For your reference, on my ls1046ardb,=0A=
I have=0A=
=0A=
# cat /proc/device-tree/soc/memory-controller@1080000/compatible=0A=
fsl,qoriq-memory-controller=0A=
=0A=
York=0A=
