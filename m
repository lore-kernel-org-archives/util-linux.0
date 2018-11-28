Return-Path: <SRS0=rELb=OH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828A8C4161B
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6402081C
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hkmn8eQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6402081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeK2GJM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:09:12 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:43534
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727055AbeK2GJL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Nov 2018 01:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgfkDTYh26/4egJ5ybH5+647gzrqwbLJhHrlZfK69lA=;
 b=Hkmn8eQ7ZK/9htpkANuV6dsqOyHl+1xLWZ2ToMwlso6Aevi0LnURy8F1mFi4eSrT/KrkogL7s/d1C5dVZLisZj1Y/e+lHfiE6E+L4zNOv9MYget+v7Fv31qaqik9ZjDrgHS59W005ew9yGFw7mafMbSTR8LySyAjOSYwFVMgmMQ=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB5092.eurprd04.prod.outlook.com (20.177.40.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.14; Wed, 28 Nov 2018 19:06:25 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810%6]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:06:25 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: edac driver injection of uncorrected errors & utils
Thread-Topic: edac driver injection of uncorrected errors & utils
Thread-Index: AQHUh0sNWF6V8PY2qUSDyCw1nmqn1g==
Date:   Wed, 28 Nov 2018 19:06:25 +0000
Message-ID: <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic>
 <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5092;6:V8kgAyFEAdVJ0widV40fZM+woWNqqYGVgwBdwmfRv8C0Xwzkn17yS1sQBRN4VH8jdYegzeHqSyOcdd7Udw5vMtxtjNT9WrHLQyIRbS4Ar26mXnR7bHl571gVefGcS5mcot0cVI71CRSQnzj/BHz8LG4pGfi68H5fIlhYoypCzBOMPcIOG6o5rX4KXp5jzF9IRtkVnOAQNrIH0omnIIllrE0HtCu+AZnn3y4VujYMx0t+FQEl8KrMz8MeEzJy8CtElWVsz+2icKoAqMHKtjRV+SrvMDoGrFB9V4rTwk/rw5GMBkMGH8i6uY21Omo7e2tN0S4LDQqZH3ByeLsEeCeieRGCvrhUanjB5olpxIDd9+yOaEy8elpuicvKUltqByT0MB1rb/cfWtP8zbxHTIYobSevXRylQn4TJ/ItdCcrtkEK3+O3cWTCvyG47hSMmPIUIBDvQ/5al/jaDg+OPI48lw==;5:o1aaXFziiIk74ItcmJ/j1lR475FDMWodtZgbSbTVvS3c6kpaEkuz88C1De+97ISPDABP8G8z0USa7kgm087t/3u7b2Hk3+aFn1Pevso3mM+NwxZEyONC+O6RMKLUPMj6uYndeL+2zG4J10lHa7mxaP/SMbbXhSs0nzpfsCi18no=;7:ijlROhZTkjx+ys2AfzOrJg3G6LspHAC1v2dxh8F5f6Et+Nad49V7HDcIs11RnDnrKNQhuQ+yF6WUK+HcQgbBbVKYYSdWgixzAXasNGpb7o7kOGDfYLBCZ9JISiOK7qcOIdjZDt37QV8D0YZinZwlRA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d36a132e-8a70-494e-d36d-08d6556497ce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5092;
x-ms-traffictypediagnostic: AM0PR04MB5092:
x-microsoft-antispam-prvs: <AM0PR04MB50924073096554592CDD9B629AD10@AM0PR04MB5092.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(999002)(944501410)(52105112)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5092;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5092;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(2501003)(25786009)(316002)(93886005)(71200400001)(97736004)(71190400001)(68736007)(110136005)(6116002)(6436002)(486006)(3846002)(66066001)(106356001)(256004)(44832011)(476003)(2906002)(105586002)(446003)(305945005)(99286004)(33656002)(74316002)(81166006)(81156014)(8936002)(7696005)(8676002)(39060400002)(575784001)(186003)(9686003)(7736002)(26005)(6246003)(76176011)(14454004)(86362001)(55016002)(478600001)(229853002)(4326008)(53936002)(102836004)(53546011)(6506007)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5092;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +F+qHA3UwUHzo3aQ6hDexJvjzbpdsa4eHY0E3r2buocF3SNcIyL9rhsOgy6KijyvqbpPpqNI6nNIBG/euXghSX9kLpwQRxA/0pJwt53M6fMlM7rBs7d/mFXQmGFdEkN7Aw8A7c8mHm8aiVduiMP6ZkLuXRsuEU226kf3RoRh6qy0G3Yw6YC+NaZR46bXJiAqYAyEB7+SytJs25AzitG8cXFr/hrYPO1CNJTKw4iEJd58xsVPJp/b4q2+WP4Ck+pfSpoo6ee6aI8a2w+0AbhiF0lu5xLGtDfROcF0c0/MvkbtNBLG6pMn1EondHRNSXT/0TLKhriB4Ek5BTjL0CWQMYnama8iU1tR5kKqSmHnSfU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36a132e-8a70-494e-d36d-08d6556497ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:06:25.0417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5092
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Tracy,=0A=
=0A=
You can inject multiple-bit errors. You will crash the system for doing=0A=
that. I can't comment on edac-util.=0A=
=0A=
York=0A=
=0A=
=0A=
On 11/28/18 12:49 PM, Tracy Smith wrote:=0A=
> Can I inject a uncorrected error or only corrected errors using the=0A=
> layerscape edac driver injection via sysfs?=0A=
> =0A=
> Is this the expected output for the edac-util on layerscape when=0A=
> injecting errors?=0A=
> =0A=
> root@ls1043ardb:~# edac-util -v=0A=
> mc0: 0 Uncorrected Errors with no DIMM info=0A=
> mc0: 0 Corrected Errors with no DIMM info=0A=
> mc0: csrow0: 0 Uncorrected Errors=0A=
> mc0: csrow0: mc#0csrow#0channel#0: 643 Corrected Errors=0A=
> =0A=
> root@ls1043ardb:~# edac-util -vs=0A=
> edac-util: EDAC drivers are loaded. 1 MC detected:=0A=
> mc0:fsl_mc_err=0A=
> =0A=
> root@ls1043ardb:~# edac-util=0A=
> mc0: csrow0: mc#0csrow#0channel#0: 2700 Corrected Errors=0A=
> =0A=
> Does edac-ctl function on ARM based platforms or only on x86 and why=0A=
> might it show 0MB for the memory layout for DDR4 as below?=0A=
> =0A=
> /run/media/nvme0n1p1/tls/neo_mcu-kernel/drivers/edac-utils# edac-ctl=0A=
> --layoutreadline() on closed filehandle IN at /usr/sbin/edac-ctl line=0A=
> 514.=0A=
> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 53=
3.=0A=
> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 53=
3.=0A=
> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 53=
3.=0A=
> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line 53=
3.=0A=
>           +-----------------------------------------------+=0A=
>           |                      mc0                      |=0A=
>           |  csrow0   |  csrow1   |  csrow2   |  csrow3   |=0A=
> ----------+-----------------------------------------------+=0A=
> channel0: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |=0A=
> ----------+-----------------------------------------------+=0A=
> =0A=
=0A=
