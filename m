Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE8C433E6
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37E264EA3
	for <util-linux@archiver.kernel.org>; Mon,  1 Feb 2021 14:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhBAORd (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 1 Feb 2021 09:17:33 -0500
Received: from mail-eopbgr100136.outbound.protection.outlook.com ([40.107.10.136]:6497
        "EHLO GBR01-LO2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232240AbhBAORb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 1 Feb 2021 09:17:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obK5MpIBu8dI5Zu7lrtdR3MZgkvJ7xmzDAGUqYd4onJxtl0uetUxJfNP9lwvNYE3yGDd6vVDX1Shuju+W5Exvw/JpKZqGBAvvYy7ec7eJTalx4b8++Ue2q3dXq/0AaWs5DQhuLnW/dKOY/HclWlBFJF/YHf6TdZyuhY5Br5LghMFW1Xe8q2kAlOKYR+oFj5bbWgTWqHy8+aFa/TUYUxGvUH1PiuGCpfwZum5Mc4CYMPPSCslPQ7/hKY+PwBl43E3mkkeY5IbbWjKd0glP6Qb2RL91bihOK7Ocqhf76/3xsa/kLBsgYhq7LlUVL1tDJrrHopfXGryHL7o72oF5BbQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e0fo7NoFYhS5TqbQGomQs0dk8w36jeD7MqvfuCgNpE=;
 b=krEYHVgpoyq8H+iMRKIRB1be7bVplH8l7iljktTCDdQe67QK87K1p2WRb1QX7R2Pf3mBXM13kZ+82FpKPvfyfAymm6U7wWGxlFY3q9r5YymqzG92kbT6kWnp7/agy35U3MIM1K3j9I6yu0X+vE6QMEllgVj7+0cqUIo0E5QhZNE+9TBadc1Sf8jXgHdS563DUxPFbsbeZgbqy/fDki+CHitK5qp7mJ/XPck03EIZTDUMNdon1hKUtbJ6VdS10/7xFRDRQHBOaMKoW50Y3WT60jZjYOfbcs50GBzihxYHPNDreEoCpkRUjmjzmvpsfOyeJuveJ8CXbjhQchgqI5nTfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synamedia.com; dmarc=pass action=none
 header.from=synamedia.com; dkim=pass header.d=synamedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synamedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8e0fo7NoFYhS5TqbQGomQs0dk8w36jeD7MqvfuCgNpE=;
 b=Ws3t9Jg5JE39rMafzRyHJYp/gA4UpYvB58cqunL9snEFm79qer6s2QTRh18Yr8mkyOXvbEkyGJFZ4sPhgXENBs4Hd0qM8GJSKcb1j0E8WdKSqX3QC0u01nFNBt5Y8WBy6qE/MBsrg3gUENIkmHDf1kfxm4mn8yrNXfBgRo+uhhqR3lIQkaPUlooptbxSio+EQrWRtDJ0VfatlrY8jQcjxm5HvW7OamMsO0ZlvO8YK/F3P8pAgWyneMfD1jmP16zVBQSQN3uaAxaenDOivJLJ7iFj4YBYvw54yw7nW+T09q0KMMDq2eTB25N5S6buJu5Tl+IXhC34TjNR13oXfTBlFQ==
Received: from CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:4a::17)
 by CWLP265MB0962.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:2d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Mon, 1 Feb
 2021 14:16:42 +0000
Received: from CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM
 ([fe80::bca2:24cc:69ba:823a]) by CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM
 ([fe80::bca2:24cc:69ba:823a%6]) with mapi id 15.20.3805.022; Mon, 1 Feb 2021
 14:16:42 +0000
From:   Howard Lum <hlum@synamedia.com>
To:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: lscpu and Intel Turbo Boost
Thread-Topic: lscpu and Intel Turbo Boost
Thread-Index: Adb0Bwv/zLNNX5tqTvuClaQ6TCGRQwEnW9pQ
Date:   Mon, 1 Feb 2021 14:16:41 +0000
Message-ID: <CWXP265MB17020C63B570E7B6BA256F6EC8B69@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB17024AF7959F3132E333F6DAC8BC0@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB17024AF7959F3132E333F6DAC8BC0@CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_ActionId=fc9aff26-a029-4e53-a5ab-5e60c978fab5;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_ContentBits=0;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_Enabled=true;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_Method=Standard;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_Name=e305dca8-daac-40b2-85cb-c39a1eaa36df;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_SetDate=2021-01-26T17:14:22Z;MSIP_Label_e305dca8-daac-40b2-85cb-c39a1eaa36df_SiteId=ecdd899a-33be-4c33-91e4-1f1144fc2f56;
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=synamedia.com;
x-originating-ip: [208.116.159.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 600e4dea-cce9-4bb7-ac7f-08d8c6bbffed
x-ms-traffictypediagnostic: CWLP265MB0962:
x-microsoft-antispam-prvs: <CWLP265MB0962EAEFE0237E2C22641AD5C8B69@CWLP265MB0962.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: duOqIlmWkSRZe4l5bHqhsq1ImTrG0WoGFOZtU0+8c0BiG8WqACv7pAYu4BJdGSsXwOJ0wfVpj171aIDN5FMP53ll5SLaPYdDSzcR0aeRw7Z9TWcBNWQH5SlN9QSxymYDp9nmR1r+ZOS+WpEmLVrixhz/aF5fxFL+MOKao24RckX0/hyAggbpPTpDnHBnCiGMbs1mozppfUhrIBGHZQsmxXlsbl2wisazq91FD9vdE7teitEYB83bkIQFyadpB+FXfl6OXiDLyoN9TbQxUL71nz/fSA5mMc6jnhnLHhcqs2mmU2sR+oFDPul94bF3GAIeE1NLsyfgJQWJJKa96tk8NRv/Kw3YBAQMyIQNEkPqMbq5rJXQjQ76S+PIdbbmRuZ/BflWQ3POxfsM66CpP6Fs+j3jgFe+ofkG+jGwlgdYoPG/mVi4oEHTPPdeM1lK0EJArdpFieZLCRFksO1uQRGYnfGipdJiNVKlAi1wCFH7t8MGP1UFrdF89cVfgujvW1FaXRRrAvP3ha0d1rvKE6S8ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(55016002)(8936002)(76116006)(64756008)(5660300002)(66946007)(66476007)(4744005)(2906002)(66446008)(26005)(6916009)(33656002)(83380400001)(66556008)(71200400001)(478600001)(86362001)(7696005)(6506007)(186003)(9686003)(316002)(8676002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Vy3OCYVN7NRgRborkDcupF+oT6mL2YQHjzK9unMMNBfndpnLtISR+Z3cq1zI?=
 =?us-ascii?Q?obIBq8wRJiL7b6OXAkgv7yMGdJHxkwgywX+gCxOiD1TQsN1YWj35XPSYQDlH?=
 =?us-ascii?Q?/d45nrGWHrxdUUHY3bP+1VP3ryU9/Vjd6D3Z745bb7IUyx3DL8HWZjdGGTbi?=
 =?us-ascii?Q?14/fAW89s9Qmj0SxU1NHehE89SVe6zpSNLoAgce9t2exui17JjfGaaMCCJiQ?=
 =?us-ascii?Q?sarKmBPPDYIz0CsqGohRK4kziMlFzlqltNfIV2Gc/w6MM1P8e30k87q6F9aN?=
 =?us-ascii?Q?JPLPPARZ8j9GGbPueV2gfZgWNyimPolzmDFBQcDXExB/P9h7c2d1KKUenMjC?=
 =?us-ascii?Q?Tte789VDsDHz9Ki7cuHnayyH+YroH4ByNxLcafhDPpNJ4WqgWDPM95A53Zx7?=
 =?us-ascii?Q?gKGf07woRO0yxCCejBCpAG1QEMvZvd6UVBeKOSNSWKBGXJEL+m+jrSj7nWpz?=
 =?us-ascii?Q?tJtbg0Z7J8kWTL29yDV90VNMljCIta7cXp7ZfrOkIAr6C0pYBoiXtFBV/x2o?=
 =?us-ascii?Q?jN1TNSZDAg67N1TKYsot0mG8DhskOS3yont2qxZxLRd5/BeJgXSBiDnW6bZ0?=
 =?us-ascii?Q?aBYd5dtAqptNg/uxUf2XIS9V2e+ZmhEd2HEWrNcGyg6BFsLL/vV8zZ8OuhYR?=
 =?us-ascii?Q?vVwTYda4cyJyZx4BRP548PZrNoYUfvoDuAIoJTd3wszMXW3WdYbEe+Kyul6r?=
 =?us-ascii?Q?5vMBSYcwsu7NUxAflg0CmPdll6CLeisFPvW09NrentX/z/baa/mWXw28YuUc?=
 =?us-ascii?Q?oXcdr97cML50VK2B4ztnb9k95FuP8S6E/gxPdDvE8r//8UVmDSWusJGyJ8VJ?=
 =?us-ascii?Q?QmG83QNpzK+Q7NaEHmqTLXO5uE7ge7MmOVKWJmP4GJw+NEHcureZiGK190WW?=
 =?us-ascii?Q?27bALDuXtESqR3sM/x1nJWfvioPDlZD79dwdx3zXoFceLv6VQtSHS3DNJvoR?=
 =?us-ascii?Q?c/W58/UbhVfZOyL6dXwElZzAFUBFmNkD7Lamzo2fvBVs+gqXEHkH+cIDx3Oa?=
 =?us-ascii?Q?8I/YkhTosNBrcukaMu3/cY80m7wQtQ1a4MqAXExVw6GKTpgZRYO8egOgWyDr?=
 =?us-ascii?Q?rXafzSDK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: synamedia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB1702.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 600e4dea-cce9-4bb7-ac7f-08d8c6bbffed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 14:16:42.7335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ecdd899a-33be-4c33-91e4-1f1144fc2f56
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smeyeIIyHLC7Y6hBViY4/NzuG73lJMPW4ywS3mUbnnoUFXs6qz2Sz05/3aMx0er8fKkzrE5hjkxc1xp/MWWJQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB0962
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I have a server with a Power Regulator control. When this is set for "OS Co=
ntrol Mode", the lscpu output reports CPU max MHz and CPU min MHz info. Whe=
n the control is set to "Static High Performance", the lscpu output only re=
ports "CPU MHz" and the value is the same as the CPU base frequency. Does t=
his mean that the CPU is operating at the base frequency and is not using I=
ntel Turbo Boost?

Howard Lum
Synamedia


This message and any attachment are confidential and may be privileged or o=
therwise protected from disclosure. If you are not the intended recipient, =
please notify the sender immediately and delete this message and any attach=
ment from your system. Do not copy them or disclose the contents to any oth=
er person.
