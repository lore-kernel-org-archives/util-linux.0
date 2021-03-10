Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76747C43381
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 10:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D02064FF3
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 10:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhCJKro (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Mar 2021 05:47:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:10478 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhCJKri (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 10 Mar 2021 05:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615373258; x=1646909258;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ix03Vpbq1+VkdYNq+Sxwc+627MhyaAkZwbb9l5D/PxY=;
  b=V0Mdp8dXhGdJV0RBnfXExQmdCYhmxqgGIXg3eb1bTZbuOfXpCjBYnwk1
   2JYZpZJppONMb7xYpgFaNL7lSu18+/fVZFTdXCF/lm1Mph684jTa1Gxyb
   EGCOt1C01i5xc7KcWrPmS9w7VuvCN5Dc6w/ZLVy/KSHslHoJjcx+jnUjC
   KMR8OcZ/zwGc1Q82ow72fbP/q7o+oXF+6tNmrVrOHB/y+ZyLPVnMZS4Rb
   hZad66WChSSi4zBQ6Vg7PMpHb3XxO3RpTqpxRdqXN+EFW8VfkAWxjVbjM
   jEcmJua4pimnOfopNeX7TiATQuzt1ShJZD8qDtkJ8pAK5ezuFzSlD658Z
   g==;
IronPort-SDR: OysYBtng/RcSl6uHu9l7DND/KFI7CZKUdGnFytk+/mc/ckIwp8gHUd9Oh4/VCHkOH4Mv1o8wPJ
 bq+SPknTzD9hAY1QkAwAeinh80Y+1UO3KQiti9/WuM/J2x7OB/2HBh6cxEJjW9Z2IdXkIqQSTj
 31JDw0t5DtIjQQIsSoU0zQOw8KX7vMf1dLp7NtPKfj1xiyLBW+knHvFu3TS9L9Mgscyd1DgElc
 YTncNqDDn1rh537mM10T/BX8t5x1Mn4TWKTE+mxoRMCiEWcAz9hydkIaujDPe+fs1KYOYkfrkB
 JEs=
X-IronPort-AV: E=Sophos;i="5.81,237,1610380800"; 
   d="scan'208";a="161802485"
Received: from mail-dm6nam11lp2175.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.175])
  by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 18:47:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9Df3GcCdlGBw4Ng7jGseCj4+ihzGpDJoXmvyyAO+7rkuWBNocbeqjzUP0E7rjH4ags9dBWcOWedL+DkBwsXt/YkFTkDWG55FPbI54rlkFlXpMOV54kxDGlMc8832SiYpLR2rnNLe/r8hr6TK/KVJFemf7GMu7rZwjhDNiAwub7e4PAT/Z9P4LJeeXRQYDoEgVvBZO/NE+3sSZwEpxO22z36AsqSj0D4A8vSBig2Ttn1Wyling4ntSSgiIx2FQxMWkEsX+vlqqxZQHxxwGgyUyRwjG/TXXDCPYyvI+4AYc5d4MtSXTM08oFI/2vVbKQJizREuNKtW8ZGlPTHVlY2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwOZ9rkQ7bZ5YTPiviNTUouOXxNXOzAnlNkz/F2t7xc=;
 b=iM7sHRmsZgZ8ll5kxHgrpvSrh9WlD1LXH3kWl06R29/NzrRPKyvIR/03y+a6Y1IYd5a4wHnFwrU9O0g5tVqM7QN9jWLZ6yc+jmU6U6qq2SP1wCG42oL6sQahh3M636Kd4IJs+qpuwuWFCecw8hovuLt4C0SxMQXFDyeoQC6smWhyWOPS32hf+zcMKFSeljJvHKLP1qUH3ryH1mi8NZJGseL1gYqdXcz8cUFpABrA7yyyNDMA7/vJepZK8YfPEqw390idk2l9x+Tnk8VYYnVxdxHPfPiAs7vrEljFymVHDTKHvq56aJ7cQ4WijlNrfRlS9H7OYp6W2YQDOL3hXC09LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwOZ9rkQ7bZ5YTPiviNTUouOXxNXOzAnlNkz/F2t7xc=;
 b=tQqH84/vNy5GWa28NoZctK2j72wwdQBvaHzhPd11URA6W1E5jdRjSqtVPiPV7A1FKL+jA0GIPAO9lAoulbkzffyg5xoOOyOftmyO/Le+F/3yYRFzLGiALwsnn2FBLnlCBMOCzM8iY4nMAwG9H6gnJMVaXXJca5mPa04B6UIpARw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7159.namprd04.prod.outlook.com (2603:10b6:510:1e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Wed, 10 Mar
 2021 10:47:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 10:47:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Please include blkzone: add capacity field to zone report in next dot
 release
Thread-Topic: Please include blkzone: add capacity field to zone report in
 next dot release
Thread-Index: AQHXFZrIgAZkcouBmU29qkHOfMVYVA==
Date:   Wed, 10 Mar 2021 10:47:36 +0000
Message-ID: <PH0PR04MB741640EEABC8A25E6EE248399B919@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:d87b:bccb:ca15:1ed8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40d161a7-1d77-4545-072e-08d8e3b1eae1
x-ms-traffictypediagnostic: PH0PR04MB7159:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB71591940ECEC76D5BE2A0C9C9B919@PH0PR04MB7159.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7d1HpnSx+fr/9bJCbEYViWFcHHsxRWzowAjWPZvJm5SGM0GY0ZslrlI6JSx42h1ClivX1WzlxSyhSjeP5VRpoCq6zvS9eRd/EOCUASUP3M2dO7YSbSDuC4D8ENZs6+OUTzc/VKjGzexZOsK/v8kY+YEA5XM04FDX4PbfavtS0qqU4ZmPsd823Io0n/zLbhghjLsWw0m5dftmg7ZXsI67CW5bdqTUdZ2d1XjPzmAJp38Ak/Pf5DJNBx4gHqL1cY6K05KWFLDGzG3+bD5U1aJp6ncTHI2FSXych7vz/Al12/+RpFrd7QdA6VQL0N9zcwDDxyUyKmCuFT+URGmjfyY3Y4UzTlBRp88xy888YMuogJFSnZcn88bDxm//5MAIqAKdM+mxec4IJeeMjnmV513V/UrLKGYhW1CwC6JkzfGQtUUjV4ePyg+hWTkhc+WEnvSxExyQM1OvlRy+sKqSqY67kNgcdNZ4BUU2kjOSLw03cqbY9gTNPxkgJnHnJHUMH0dsi9fn1xFs+cyw5k42we9WbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(2906002)(186003)(52536014)(66946007)(64756008)(66476007)(66556008)(66446008)(86362001)(76116006)(54906003)(33656002)(4326008)(478600001)(316002)(8936002)(55016002)(9686003)(6916009)(7696005)(71200400001)(4744005)(5660300002)(8676002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CWTLEsMHPbMdiqbmwaNGV+S1eqKB8n3Chyr7SA/iwnNBiZWyTC2iOpqqvhxL?=
 =?us-ascii?Q?rmLQII7fceVapEnUU2hGxFgFYQOsKBwknkUHADhPH4SaDT2DDBXiGiM1tLXI?=
 =?us-ascii?Q?rmhqhxnT0QevXJbiLdiAAltFXS9+hmF000TjZZGgMIqfqqFdILyl01TFBKit?=
 =?us-ascii?Q?k0nmoMRJa+Tr/G2yiSEEBE+hNbxi5Uf6wf+vHoFTt5Z9qE+GX+36q/KyJJa+?=
 =?us-ascii?Q?wpsC21uuw/MW7eelhKAo/VJYbLXPv23fDcnB/onlLrkCLMoTefYKs444wl9G?=
 =?us-ascii?Q?LJ/2F6N/bbyLJknBJcevhcGiBhoPgtm2HoU93uRF7Wx3WsKeFr+nncmQwqE2?=
 =?us-ascii?Q?Wee44G9jM6XT3N5YKF1B6SCWti5bJsnQr2SdgYOsh+es9TYCWKedjzRpnTTn?=
 =?us-ascii?Q?nouvLBZ+lk9RcY3xUh1HoDXRA0hU/9sVV3AGPh2a+R/gkIIIwXzpJe+42LKY?=
 =?us-ascii?Q?JN9Jdy0VPUPb+IYxRYdn5Sog2aQY5C/7f4vEhjXrzBbMD+3CXVoiWrBIcPHP?=
 =?us-ascii?Q?DiFt2nbvbrcUIxJkwkufrRVwd1kkVkASkBN9OS8hDXOCOKbEeec7a0zm8r0k?=
 =?us-ascii?Q?oI7z4yt7jKQoW55cqj/fzhsnxUr/KRZuHxE6k8+AUv8ix1KLI2jDmB2dmmqc?=
 =?us-ascii?Q?8FWYRTm3OVnavpDIwGOlUm1ztUsLDRNjzpdfEz6Sm5ifO3I5DKirF5b+JXMd?=
 =?us-ascii?Q?6WXGQLqbR5s5MbY2SeyabzcLn4OoBS/S/Zvjsyx1YJigWgxvSSTkIBHF7URH?=
 =?us-ascii?Q?bR2ZnTZF142d0kkekoK5vWG7Vy5vLnY23zOFbqPyaxqPsVAeGVbICI2IkdJC?=
 =?us-ascii?Q?iGY4EEhmQnhS1jUT3op87o4uirPrgoE7Y7VmrdHTM9THlwr8CRGVcnuyLGVE?=
 =?us-ascii?Q?xBlvDUxIhMOPnVDWb86CyiApHf0+jxNCbjArLVgg/d+my6rc6uT35cEYhtGr?=
 =?us-ascii?Q?Iv3w35t2t7vQum9lRYBuREzN33rtQUNCt0usjxdOoc+7bK0F1H27NLsLJbQg?=
 =?us-ascii?Q?aBrqAR8NkgJYS8BaKnmA5+0bfTeKREkOZluSrTVZFdnWhjIdm40DytYdcF4X?=
 =?us-ascii?Q?Kz7L6NHBiMnozgpvnmVmFcXDMkLveXVNoDg6lOgwPpZ9mXq01U52llUWpHvu?=
 =?us-ascii?Q?fEqI6vixgk5gj2o7Y9VqA+T8wrM7h3OCdCpTtgdYwM4ZJ5Kpp2Uxldy1n/Es?=
 =?us-ascii?Q?MRSnOJ0zIqmohx507Ch9bIblPzeCYe7Tp5BH1RXljZE3XKh5Q+SquGb8Gc3g?=
 =?us-ascii?Q?Uyg3HLnTWoeETPPL84cx4l9qD4JREi0wyz59KY636rZNuHXC6ipnqhDpExH8?=
 =?us-ascii?Q?w60H1aylusSQk5TYTqJdzQuDYPizJVRUB8sGTsjweNrYE/x9ID5suyl4FdGC?=
 =?us-ascii?Q?alEoaeV1O6plh8g6rrPToq2rqTSi/I7xC7w7TulYuDdbThQJAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d161a7-1d77-4545-072e-08d8e3b1eae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 10:47:36.0933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5gzz+orLPUmFfixMwW8STLtEd7iwe6x+WT31gz7K8w08gHeNgVFTzz2tJeIrXOi0kNb2d7CT+UWuGoyVzu+Hy8+h0IItfk2cPJAI0SxISIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7159
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Karel,=0A=
=0A=
I just saw you tagged 2.36.2 last month, but it doesn't include the commit=
=0A=
e5ad3a6ad0b4 ("blkzone: add capacity field to zone report").=0A=
=0A=
Would it be possible to include it in the next dot release? The zonefs-tool=
s=0A=
test suite depends on this commit and it will be easier for downstreams to=
=0A=
test zonefs and/or the kernel's zone append implementations with this patch=
.=0A=
=0A=
Thanks a lot,=0A=
	Johannes=0A=
