Return-Path: <SRS0=5EDY=N6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7B0C04EBA
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE88520831
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 16:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s1oaTB7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE88520831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeKTCsh (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:48:37 -0500
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:11527
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729912AbeKTCsh (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Nov 2018 21:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3cGLXHxVV19EuYBK7jWVBLtLNp9muxjkOU+JsVd9ck=;
 b=s1oaTB7iHOa5qYN+0ofMM/WfGBRWQgZzmWa7R6b/xycVief15t5Vh9q8WNFL8LSE7AhbNhuhn4jTGw2TSAlntHh6FKR+HkQ6E348RyH+UWQnBbk0FCn22TvyJ15EygTl99xuHYabjK3yuDXlqYTwtTz5adbAHHVGNV/ZBlW1hNY=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB4260.eurprd04.prod.outlook.com (52.134.126.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.23; Mon, 19 Nov 2018 16:24:28 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810%5]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 16:24:28 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>, "bp@alien8.de" <bp@alien8.de>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: FW: edac driver initialization, interrupt, & debug
Thread-Topic: FW: edac driver initialization, interrupt, & debug
Thread-Index: AQHUfn6VaCPcy6NdWkCW/eURxj7L2Q==
Date:   Mon, 19 Nov 2018 16:24:28 +0000
Message-ID: <AM0PR04MB397127BBA9AB44D0453B90E79AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic>
 <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4260;6:U9ZyVpo7u2tp/4ANKdWj4TypzKT6ZOfhsJTCwWZXxoR6kCX6zSLPtbu6BCXVnK6d7bUDDfIxrKKOOo6GcfIoKLKPYFG4OkZYpYFsrQ8gGVKXITk3Tgn2f+v5MYwr0T/TgmN2ZVdxFORPx5emmxYYnC5OeigsCnBMpvjacOEiRN9uF5DMYBpIfeCzBsJQpJVQfr0LJJGHjoCH67L6wnWySfZL9rrY+VGUgTGRWzWqEIohFsCeSGNU6fdOeA83tCh9nISeioqkDCkaYNxINBe2/itSoeEpzCo0Qv/7/CmADukke9Ta3SdpwDy9MCXFfkSo6dx03WMEFBm7+4a4p6UDYJl0PZHpZk98SzlY2OPeEDG67ebgwUPhXn/q/86bIRsW3Op9jXUQ+h2kR1hskiHFXoahlxXMoED1CWa5tySVAac05X7PPxdZM00axYPNbPOaq9sPwIlwf4PGmK0OO9d2dQ==;5:XqZDMdRPI5BhHrnjMVeDUn95sg8FeI2rv5EW1htc0bacf9MVRgft1pKdD6L8GV36jDQ6fpcVUdwrqddO6HgVTTBgQSLDzD7T9v/s2MdGdhi+nfog0etA2LbAf4epfAU8ftLWtrcsaCweqbdFQjOi2UxvDLG2Li0jd4CrtvHIGgs=;7:IbVuJw4ml6dTKdIJStUIyiOyb5MH++Qn9E2OFcz7Ym00EHZi9ZJD+2Y2gAnleCXgt9dQ10yzT7AQ4dORZZkDcQVaIIHCAkU3Kn+knNvp985EWCfSJjYAX5yj23LX/DRiFQ8fkBNxdWu00EUGe9L8Tw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: f0750e66-467e-469b-421c-08d64e3b7a99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4260;
x-ms-traffictypediagnostic: AM0PR04MB4260:
x-microsoft-antispam-prvs: <AM0PR04MB426046CAAAC85D8D709FF5849AD80@AM0PR04MB4260.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4260;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4260;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(346002)(39860400002)(366004)(199004)(189003)(2501003)(6506007)(53546011)(76176011)(105586002)(7696005)(2900100001)(66066001)(6116002)(102836004)(54906003)(3846002)(26005)(186003)(39060400002)(6246003)(110136005)(74316002)(7736002)(229853002)(6436002)(305945005)(5660300001)(68736007)(106356001)(316002)(97736004)(33656002)(478600001)(4326008)(2906002)(446003)(14454004)(25786009)(55016002)(81166006)(8676002)(81156014)(486006)(476003)(44832011)(71190400001)(86362001)(8936002)(9686003)(256004)(53936002)(99286004)(71200400001)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4260;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: n56eBYM2gKjAbUvL462xqAMAwJ0doB/NSrX0VJemKQAfzgYF9GJDXpiWQ8uDLNmxam9nilMO1F8rFJIsBem6MpAm//0haT5AsGQwWRjx7GgwwojyspDvRMSxl0doKJNlvqRlTbTZsQ3Il8lhveVRgRNr6jgQL1EsAD6L9sPwae4+s97HsuabMz0Ud0Iypat0NJzvWC1hK10fAvAfkL8nWHnNcHt7esB6MfzRSPa129d0KPttsV3ZUzfo/5+sbbEp5uihOBP2gt2V31R4FajKrDSEKqE2jdwX/B+TNNoFEwfntRVh24tyl2yA5DHTFlKH2HAoOyugkhiTAnSzEPIoiu0kveaDgQoUWRNn03J0IOc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0750e66-467e-469b-421c-08d64e3b7a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 16:24:28.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4260
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/17/18 3:22 PM, Tracy Smith wrote:=0A=
> Thank you Boris for the information.  It is helpful.=0A=
> =0A=
>>> 2. The default EDAC_OPSTATE_INT in fsl_ddr_mc_init() and the=0A=
>>> platform_driver_register() is successful. But I don=92t see any printk(=
)=0A=
>>> messages in fsl_mc_err_probe() within fsl_ddr_edac.c. No errors appear=
=0A=
>>> in any /var/log/*.=0A=
> =0A=
>> Yeah, see if it even gets called at all:=0A=
> =0A=
> I did a grep on /var/log/* and don't see any printk's from=0A=
> fsl_mc_err_probe(). So, it's not being called.=0A=
> =0A=
> 1) What would cause the probe function not to be called?=0A=
> =0A=
> 2) Were changes made in how .probe functions were called between=0A=
> different kernel releases of the edac?=0A=
> =0A=
> 3) How should I go about root causing the reason for the .probe to=0A=
> fail since I may have to backport any changes made?=0A=
> =0A=
> 4) Possibly a patch exists for .probe changes after 4.1.35-rt41?=0A=
> =0A=
> static struct platform_driver fsl_ddr_mc_err_driver =3D {=0A=
> =0A=
> .probe =3D fsl_mc_err_probe,=0A=
> .remove =3D fsl_mc_err_remove,=0A=
> .driver =3D {=0A=
>               .name =3D "fsl_ddr_mc_err",=0A=
>               .of_match_table =3D fsl_ddr_mc_err_of_match,=0A=
>     },=0A=
> }l;=0A=
> =0A=
> int fsl_mc_err_probe(struct platform_device *op)=0A=
> =0A=
> {=0A=
>  struct mem_ctl_info *mci;=0A=
>  struct edac_mc_layer layers[2];=0A=
>  struct fsl_mc_pdata *pdata;=0A=
>  struct resource r;=0A=
>  u32 sdram_ctl;=0A=
>  int res;=0A=
> =0A=
> pr_err("%s: entry\n", __func__);=0A=
> printk("entered fsl_mc_err_probe!\n");=0A=
> =0A=
> Any assistance greatly appreciated.=0A=
> =0A=
> =0A=
> On Sat, Nov 17, 2018 at 8:05 AM Borislav Petkov <bp@alien8.de> wrote:=0A=
>>=0A=
>> + York.=0A=
>>=0A=
>> On Fri, Nov 16, 2018 at 11:07:50AM -0600, Tracy Smith wrote:=0A=
>>> I=92m attempting to insmod/modprobe the layerscape_edac_mod.ko driver.=
=0A=
>>> It seems the driver enters layerscape_edac.c fsl_ddr_mc_init() and=0A=
>>> completes successfully. But there is no EDAC boot messages and no=0A=
>>> /proc/interrupts entry for the EDAC. I=92m backporting the EDAC from th=
e=0A=
>>> LSDK to the SDK 2.0.=0A=
=0A=
Tracy,=0A=
=0A=
You said you were backporting to an older release. Please double check=0A=
your device tree _after_ Linux reaches prompt. You can find it at=0A=
/proc/device-tree. You can also check the device tree in U-Boot using=0A=
bootm command step-by-step, after the fixup.=0A=
=0A=
As long as you have correct "compatible", the probe function should be=0A=
called. It may quit if ECC is not detected, or not register interrupt if=0A=
not found in device tree.=0A=
=0A=
York=0A=
