Return-Path: <SRS0=5EDY=N6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14B3C43441
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A456620831
	for <util-linux@archiver.kernel.org>; Mon, 19 Nov 2018 15:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gBvEKkPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A456620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbeKTCTs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:19:48 -0500
Received: from mail-eopbgr60080.outbound.protection.outlook.com ([40.107.6.80]:28992
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729762AbeKTCTs (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Nov 2018 21:19:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGR5cZ3tBBXPrij55xAcrD9875RYbUxImLKfVRD8KuM=;
 b=gBvEKkPrVZHAmZ1lVzp0+cZa3zE84Pm0xag/G6gy1A70XfW6dK5U+pGcvGuCOWZNc93oTQiCQIknCEEJmHrtm2LUHtS+/xq65f8JzRUFgXxlr2zRfUXVJRZlhc7Swdy+VCYo5X8FrZLYWzqGjYgFw5XR2TUs2mEiorhCJJUvGhQ=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB5924.eurprd04.prod.outlook.com (20.178.117.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.25; Mon, 19 Nov 2018 15:55:44 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::c5be:84db:a7ee:810%5]) with mapi id 15.20.1294.048; Mon, 19 Nov 2018
 15:55:44 +0000
From:   York Sun <york.sun@nxp.com>
To:     Borislav Petkov <bp@alien8.de>, Tracy Smith <tlsmith3777@gmail.com>
CC:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "backports@vger.kernel.org" <backports@vger.kernel.org>,
        "linux-newbie@vger.kernel.org" <linux-newbie@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: FW: edac driver initialization, interrupt, & debug
Thread-Topic: FW: edac driver initialization, interrupt, & debug
Thread-Index: AQHUfn6VaCPcy6NdWkCW/eURxj7L2Q==
Date:   Mon, 19 Nov 2018 15:55:44 +0000
Message-ID: <AM0PR04MB3971E56F1DA8129F6DAAB7369AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <BYAPR02MB431115EC4735AE5B7E29F2CEF6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <BYAPR02MB43110062F32BFDEA712AB371F6DC0@BYAPR02MB4311.namprd02.prod.outlook.com>
 <CAChUvXMp6S6MBY_LmrfgdPcctQw70FoyxbiHeFqK+5fQx5omCw@mail.gmail.com>
 <CAChUvXP6eu76xqEZNspooUMb+311mmDH8=St=awCL77hJPus9Q@mail.gmail.com>
 <20181117140513.GA4944@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5924;6:yTlNyheFwlAcQfm2dFViryDewMj4AtEvapeq/vPXcddiLMQLJBYwl+VKXiZd0gQsTxtG8erdMRE6GrIIkGtv9RjGgn5o4lw2mdrmm0LhKKLNhEVSsoTjS3PEwc6Fln/QlZd/DncTA2Uh8OvICOxtqzhzib+n0ZstFEo5N1BCptj0h7VVeQ3QRZy52MU7XrTED9DYnPkc3XYfTEOFXNyJxvblyJ8XFcfPs4T9FDCFRWu5P9JG/N3MGGZ4fgZVfAR53M+HxIQSYLH6Hat7VdhkxHbWwCsKfNykvZ2bo6Oa1hDCZNlVxJWTmpgVP1txRvGgLqnnIY2xOqHq4kyXZMWLv4gSTubbBZjUIm6S2QeSWQxKM9CWkrG4YBrJow4wr5vlSPqUbn3tHVVwgKzB6ACo2c1OAI3QPnZqw4AtS/6JoCDzWdXnl4XJOTDUbJDuHAOscUMPAZRNJRWZ8wHrR138Xg==;5:XuukKXM2IYwsAAGPaEI33FLOSYPuBkdyUi2apkr58CJ4GXZsdRcccNrlZjXsVEqOAyXDbQGvy+1Wol2a/XGUf2iUrft4/Q9U+Q+JKo40pIsEDyFANBRgqVFb38sc0u3WR7wRqlueDOxtVL52E2o7Pi5DnCoaRcOL3donrZ5v30Q=;7:mTryPZkah/qraDRkzw562WlPForxkKNEyN/bvt+8Mxal3xfzOW7OopURfQuHzwSN8KDJP1+0fhNZvdsd0CEPAIkaROVtEpWzxqUstWhlw4tzmMIwzaK9kB2CgfMIndK/IE32CPuRsXQPIA/r4qJE/g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a1e38bff-28bf-4bda-3dc9-08d64e37771a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5924;
x-ms-traffictypediagnostic: AM0PR04MB5924:
x-microsoft-antispam-prvs: <AM0PR04MB5924082C419AD4CC379CE9739AD80@AM0PR04MB5924.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231415)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5924;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5924;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(366004)(189003)(199004)(229853002)(93886005)(26005)(55016002)(14454004)(186003)(305945005)(8676002)(6246003)(86362001)(7736002)(39060400002)(105586002)(53936002)(54906003)(99286004)(33656002)(8936002)(256004)(7696005)(9686003)(106356001)(53546011)(558084003)(6506007)(5660300001)(102836004)(76176011)(110136005)(316002)(81156014)(81166006)(478600001)(25786009)(4326008)(2900100001)(446003)(6436002)(68736007)(66066001)(44832011)(486006)(71200400001)(71190400001)(476003)(74316002)(3846002)(97736004)(2906002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5924;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BECAoXVGj+fk4mZFi35ngWqBYfy5knNsiQtOhw3axW8th9Q9kr/U5x+9XCQquAJiUVybbGAhBTho+Sjv+O+rNDr3T3kSzidnAaXe2khk8oC37Wwy5j2HMduJoIy48xyGqmS8kI8bm0mvsvcjDRvRyRfiYRef+5WpCMPc0JJi2Uf+z02HfG++7A0wJi6iYd3O4fUPImPFUVh93dHm08QeGGEBfNcksgrUcLKbTIW3FHn0ZDJwGqb/38DnQU7XnB4NWQDc/TZbV0ZupOko+8HcHmoSuQHIhDzTb0N+xkjjdM9eJd0gulv8MzKyGJH1/xTcqATJjxbOJPdIA4L+yv3y0DO3P7n0IduDaCzhbYrbFkA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e38bff-28bf-4bda-3dc9-08d64e37771a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 15:55:44.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5924
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 11/17/18 6:05 AM, Borislav Petkov wrote:=0A=
> =0A=
> Btw, looking at it, York, this whole injection functionality needs to=0A=
> be behind CONFIG_EDAC_DEBUG because a production driver shouldn't have=0A=
> injection capability.=0A=
=0A=
I can make the change.=0A=
=0A=
York=0A=
