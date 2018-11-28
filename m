Return-Path: <SRS0=rELb=OH=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B401C43441
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D09206B6
	for <util-linux@archiver.kernel.org>; Wed, 28 Nov 2018 19:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/pvymWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D09206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeK2G1h (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:27:37 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:56637
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbeK2G1h (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 29 Nov 2018 01:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUQPkGaXo2CVbmKp8wUu5Ny4DIBz5JC7Z+hUP2Zpusw=;
 b=K/pvymWicIzfCxlCC3sqRFwWbr0Rjtx0L6VG6ocnLqRTqzNCChhPq3tNFdFzsU4KEKjhaXrNH3LB3tBdoolc840XBoWPPqluJrsLjYjKDedVW8Svymouzu+VyojLaVEaU4LIUyD/OHOxlrNqk720+5cD6GGvCOBi45nY4NIC5HQ=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB4212.eurprd04.prod.outlook.com (52.134.126.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.19; Wed, 28 Nov 2018 19:24:47 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810%6]) with mapi id 15.20.1361.019; Wed, 28 Nov 2018
 19:24:47 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: edac driver injection of uncorrected errors & utils
Thread-Topic: edac driver injection of uncorrected errors & utils
Thread-Index: AQHUh0sNWF6V8PY2qUSDyCw1nmqn1g==
Date:   Wed, 28 Nov 2018 19:24:47 +0000
Message-ID: <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
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
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4212;6:VrrH1zcIIWY7uZGmTkfQ699z6YQbk+R7JtZcHT53aux/iN44KoaEAtC+Lb/UBsji4GDc8YEVA/jGSjw+uZN1U2hv142v4Fu28HOm2MfKXCqWjaqjx+Iv1Op0PIk0uJi5r06iYaL71L5zt3762iSgq3H7GicuSPuUmD59Sl36XYCDrpeQ+CuWq1Gn0wVjHHi2QRgtA1iSz86RRrKafvAaXq4qZ547bGEWjTIhaRQswFnxVRReiuaGID8PZKtwVwlyuz05qR/cBevV7egggPxuNh1tyXGPkNKI2MkUvjI8Fy06HgtcrTswQBpX51iLTjyG3D4enu17w1JXdq0LkU1LCMyFs9TC3Oyxf5pzCGbkJJMgkxcJ1TbqgQ7quDj+EjagSTVTy8ReKgPHIT1nTByVbQc7FN6QNN7Omu/qKgm1yIjGFNBBRwWW47/QQUnSwnHyo4ujZI6nJhPh5dvgZPVZ4A==;5:k0sPTKeX8Q/o3hmaifmcRemNlBPjQSqrAAss0yDVsjKfWEXZE5YDoAZgQGGZ3PJuqJAtpxptlbz0nzKGY9DXApNWgdJ3Lj0rhmNc7dX/HvvxTGzoPoAP3t8itdmjjTQs42j0at7tqBSmYEGiRV/S6iu+gSn/gFpOFq3vesijWR8=;7:QP1WLXaU6Eplx+D8tVw2UaVrKIsrJcZVp0B2QvBS+TdKHhFS5LSLMPLi38TCprMd7+HPdwI2DrwplwWN7zF3K0fhNfT8vAV1pKM+wd+mk8cIy24jcQwsH5T8l8hnittExqlAVJzgIbb+5QtTp4Incw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b90e79be-238b-48fb-cec9-08d6556728e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4212;
x-ms-traffictypediagnostic: AM0PR04MB4212:
x-microsoft-antispam-prvs: <AM0PR04MB421223DB1D25A6EA7735887C9AD10@AM0PR04MB4212.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231443)(999002)(944501436)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4212;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4212;
x-forefront-prvs: 0870212862
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(366004)(136003)(39860400002)(189003)(199004)(39060400002)(71200400001)(6916009)(6436002)(5024004)(14444005)(71190400001)(256004)(106356001)(316002)(26005)(6346003)(53546011)(229853002)(186003)(102836004)(7736002)(54906003)(7696005)(99286004)(476003)(86362001)(93886005)(575784001)(6506007)(446003)(2906002)(105586002)(44832011)(5660300001)(486006)(1411001)(53936002)(9686003)(55016002)(81166006)(81156014)(33656002)(76176011)(4326008)(478600001)(8676002)(3846002)(25786009)(66066001)(97736004)(68736007)(305945005)(74316002)(6246003)(8936002)(14454004)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4212;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-microsoft-antispam-message-info: vTax229dqLEPNeUe/38kFuiweFboa1WScv7HoXRS21jPZiw8JgpA9DIFCgOs8iUFD+ysvG1aWDJduc/X2i/4vcwLQYF9W7GY+LraooPoKI71sLcCh+oKgnfudxdlzpyknrkfdHpM5meaaG773AfLXPGyQJdYI4EEtfF1PuFfcH/cwoBzUzAdmcSP+EOh3qk9v9fRxczgjU+IMJf+mFUd+QpWAeCjot4p1rb/QieEigDas31UMb3BV7d5BCnv/1HV/BAP+5AplbpbOOuZ70HVdEpeoS1lCEPM6RGY9Hj8BR1iFYSRc6rT9KlOkXsgAfN4YwIQeZVpNJ5W/ijy1EjWPg5yD85iiVGFkPJ00WYQwTk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e79be-238b-48fb-cec9-08d6556728e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2018 19:24:47.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4212
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Tracy,=0A=
=0A=
This DDR controller doesn't have the capability to inject limited=0A=
errors. As soon as you enable the error injection, all memory=0A=
transactions will carry the error. Since multi-bit errors are not=0A=
correctable. I don't expect Linux to work properly with these errors.=0A=
=0A=
York=0A=
=0A=
=0A=
On 11/28/18 1:11 PM, Tracy Smith wrote:=0A=
> Thanks York. Why will injecting multi-bit errors crash linux?  Is this=0A=
> the case only for layerscape?  Is there a way to harden against this?=0A=
> =0A=
> On Wed, Nov 28, 2018 at 1:06 PM York Sun <york.sun@nxp.com> wrote:=0A=
>>=0A=
>> Tracy,=0A=
>>=0A=
>> You can inject multiple-bit errors. You will crash the system for doing=
=0A=
>> that. I can't comment on edac-util.=0A=
>>=0A=
>> York=0A=
>>=0A=
>>=0A=
>> On 11/28/18 12:49 PM, Tracy Smith wrote:=0A=
>>> Can I inject a uncorrected error or only corrected errors using the=0A=
>>> layerscape edac driver injection via sysfs?=0A=
>>>=0A=
>>> Is this the expected output for the edac-util on layerscape when=0A=
>>> injecting errors?=0A=
>>>=0A=
>>> root@ls1043ardb:~# edac-util -v=0A=
>>> mc0: 0 Uncorrected Errors with no DIMM info=0A=
>>> mc0: 0 Corrected Errors with no DIMM info=0A=
>>> mc0: csrow0: 0 Uncorrected Errors=0A=
>>> mc0: csrow0: mc#0csrow#0channel#0: 643 Corrected Errors=0A=
>>>=0A=
>>> root@ls1043ardb:~# edac-util -vs=0A=
>>> edac-util: EDAC drivers are loaded. 1 MC detected:=0A=
>>> mc0:fsl_mc_err=0A=
>>>=0A=
>>> root@ls1043ardb:~# edac-util=0A=
>>> mc0: csrow0: mc#0csrow#0channel#0: 2700 Corrected Errors=0A=
>>>=0A=
>>> Does edac-ctl function on ARM based platforms or only on x86 and why=0A=
>>> might it show 0MB for the memory layout for DDR4 as below?=0A=
>>>=0A=
>>> /run/media/nvme0n1p1/tls/neo_mcu-kernel/drivers/edac-utils# edac-ctl=0A=
>>> --layoutreadline() on closed filehandle IN at /usr/sbin/edac-ctl line=
=0A=
>>> 514.=0A=
>>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line =
533.=0A=
>>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line =
533.=0A=
>>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line =
533.=0A=
>>> Use of uninitialized value $size in sprintf at /usr/sbin/edac-ctl line =
533.=0A=
>>>           +-----------------------------------------------+=0A=
>>>           |                      mc0                      |=0A=
>>>           |  csrow0   |  csrow1   |  csrow2   |  csrow3   |=0A=
>>> ----------+-----------------------------------------------+=0A=
>>> channel0: |     0 MB  |     0 MB  |     0 MB  |     0 MB  |=0A=
>>> ----------+-----------------------------------------------+=0A=
>>>=0A=
>>=0A=
> =0A=
> =0A=
> --=0A=
> Confidentiality notice: This e-mail message, including any=0A=
> attachments, may contain legally privileged and/or confidential=0A=
> information. If you are not the intended recipient(s), please=0A=
> immediately notify the sender and delete this e-mail message.=0A=
> =0A=
=0A=
