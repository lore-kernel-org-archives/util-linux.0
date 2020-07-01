Return-Path: <SRS0=4DiG=AM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A20C433E0
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC81420760
	for <util-linux@archiver.kernel.org>; Wed,  1 Jul 2020 11:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pQembLTd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nrpoIQNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgGALcs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:32:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:10796 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgGALcs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Jul 2020 07:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593603168; x=1625139168;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TZ5qo+cmreLSkGFdLXqgeuU6Nx6FDQCpMMeTKmvRQ6w=;
  b=pQembLTd374P1sq2ddWRHpDhztNezVPhuGwmKJyl0HHKYRATPMjqTQWR
   35PgrNIy0pHuAvn3/K+63IMPNqiLKcm/QFdAYknrnpxYkOOiCEo+I5vUM
   nBXGEAJQAhIhRIapcHxHhxncCdX4GL2M7zrma4jS2kw4L0P/q6lC9ENUx
   AKeNJZHOLiLbg/lzGSv49POriePiLoEczV+a08weFg8fMljCudcvyEv1T
   Kq04TCXxUXjUKPou6nLDRYrXD9WQpQ73J2XA0zHwI1FjjdoYL3MAwSgm0
   gEnpi+iW0JoReoANac2ziOE1aE58ruHIvia789GCAevWXisv38yXL6RWv
   Q==;
IronPort-SDR: FwBGrcDtI5YVVDmPm/RlxiClsqo+RPnv9QzzCu57nENsU0gSbERLyegUeumuc8sSZGEcKoIT6u
 t238KwnQRWrVjgjhwGob9UNvRuTp8x2SdkgE676whEg0Wo520+0KESm5ECotvtWtuUIt2ZfbZH
 6JOCfughLO0fXGBQh95/JTr2ib2ou1jCEUCJrkYRuZE6Oolk3GHM5EIPObzamXVuTW3sa3oK0d
 NNLlT7Q0IWfQ5tazogvr4ne8kKWrDgN87OGx4wijIXj+1dv/HGPz/MzR4PnVt75B1YAbYtfDPT
 QT8=
X-IronPort-AV: E=Sophos;i="5.75,300,1589212800"; 
   d="scan'208";a="145697175"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 19:32:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VsK4s7VYsEW8z6UtgUzuGXsNw8Tei0LnPVXc4tP+W8KOx5kEzXayNLAfhnCwn4lLqZiBsjGZx2Q1wZDHqbgc6anReGScfNMLgVOYCfeBnUdTQA+sU2yEu5IbkBHrmKT0ST+v/Q+s9lzMPs78aUMwUP4UPl5qWxzAVEBd6Rnrj1x6yulkncoFPEOdEeMg6E5pudxK5IZ+YhX2HzJ4OgToZ1FhjABXYPROoD78XbCEE80ifKXEl0CXArj94pZsNySUxVxNIVGtWTXjQdhVi4aOluzDxdCt3UIWDcTq5vJQb02ObP9gHW58fK2smFkm1hNrm8s+KYxJ50NS6VekOAzG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GYOLyGlGq7MD6StzFhITKJFRA5r+qSQGcyJ0O9vxwA=;
 b=WIe0P8hyZYMCN0jpLBh37l2Ym/d6cGptTSTtppReteGZFneLkP5KGF7tFjvAunasS6rJJ4pimZfU5p0v3ocug5PMEEPipOjuGCaqamRvEMTmAgC3HM3WjQldmV3BoUf8C2E+b2MtYyfiHVMorvhugO/aPNIzEd0YX5uTHIv5ZUfthi/UC0JC7mQN3pnPB+18ECcyib2fczZkf9BB1Q2JduAa7Bjlj1WutK+YfhUSZm/20cy+r+QvYyiThQe0JMWB5Dl4QakmPuGPWgatTb/bnYnTye6mSwVW+NOCWLGPpF1Ka1Tdu2p5TrjNocJbHl7K3bBlIS7alUNzFP7oiulO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GYOLyGlGq7MD6StzFhITKJFRA5r+qSQGcyJ0O9vxwA=;
 b=nrpoIQNT2XPxgmh4KutskqnlsEBploB6vFcHqoLEi0EmruzxsCUBXDhsEmBH0hoZ2wD1zlkNxJvNMeUzfm9VF2pzyrdR42dlfhHelR11aCZLRK6PnUkDRYfDPUPyo3h/zRB0NR4Polz1tsJggdzhXuWZyFwBWAh1JvTMa6oV90I=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6676.namprd04.prod.outlook.com (2603:10b6:a03:22d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Wed, 1 Jul
 2020 11:32:46 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::7960:45f6:17b2:ecfa]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::7960:45f6:17b2:ecfa%3]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 11:32:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH RFC] blkzone: add capacity field to zone report
Thread-Topic: [PATCH RFC] blkzone: add capacity field to zone report
Thread-Index: AQHWS7MR41UHjLgwCU2nfpCBgxentajvdNCAgAMqdgA=
Date:   Wed, 1 Jul 2020 11:32:45 +0000
Message-ID: <20200701113244.ye7vl3hzph6xc6ey@shindev.dhcp.fujisawa.hgst.com>
References: <20200626121225.428611-1-shinichiro.kawasaki@wdc.com>
 <20200629111159.rrpml3hnpmldczap@ws.net.home>
In-Reply-To: <20200629111159.rrpml3hnpmldczap@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: efbc2bca-4ee5-472a-5579-08d81db27a0a
x-ms-traffictypediagnostic: BY5PR04MB6676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB667675FE7B3486F0C6E279A0ED6C0@BY5PR04MB6676.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFmneeqz8569d/N7lMQk4a54Pvxk51MEjoloP40r6l+0HiNKh5OcONSkEpRMQMoWKNlLRbdbxGyq54gTYEVQNhNsDTpGvtu5+FP4UDBe6n79c1/VfgmP16ySRrq1HuVK6d7Eigid/nd6YEfekoXRpnbznyiTY6sRPFFQHPwn0nWQJ8MpkWOMcu6H/GNT6SKU/xq/vvOpvu0EyjN6T7WexDo5pfgRQ6sJ356+W/TvOq4cAQuDsVo3CWIbEMJ2aZkX8UfwGReEMWvLl01IpQKQlZqelVX0ePlMKZzu6lHkmdXOSlbkDbqpTupJjyI9YNebs8QWMSSDRwywGE4LEX0X7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(478600001)(316002)(71200400001)(6486002)(4744005)(4326008)(86362001)(54906003)(1076003)(26005)(5660300002)(186003)(44832011)(8676002)(8936002)(6916009)(6512007)(83380400001)(9686003)(66446008)(66476007)(64756008)(91956017)(66556008)(76116006)(2906002)(66946007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: a7XyIXqj8/KXKMWPIWBTb3iuyfv2fgGhXezGdiWjP6fm64+YohppwX1rEWB1pQQ8PUWfMGONBg9q/m0qtETPAdcWMP6AqABmUT7CPUCx/cjninRU1BwZo0QPL89L1SIKnK+lR0Q+y7C/Q6yA1FXnKVvY40J4qMYqfM614ysWOc00GdpeTi08C/1w/U6pxcH6ojvcq7/fZ6RuK/9sF9grTkAUjFswGJL25R0RwSN7fjmH+BJvbFkZt3FuV3j8yR9goXkgV+COaVPl3ArB7diwL/96y63pO0GsGnL1xq4qOOs+q2o4p0RPwRz5DzwBzHmR17jLED3WidM6z5W5DzzdBZTcrwkN+ArZB1F/WWcVLqSqgtS963sB7OHQ2Ht/hUVwWiRlEySV31FFsh+Y5Gu2gWwsyFVe4qTLDoqYu53pLTwjg5m84C8ABhhPxKV9P2n9i2ug2W07pJRb8oxDXGikjTG4F7zP7bPt+KHgstRI5+c=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <99C0568D3C136743928C33D8CE521E76@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc2bca-4ee5-472a-5579-08d81db27a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 11:32:46.0127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btxGXecdxGvBG85WK4N3S68DdeCDI2rQuL23PRsjCINJ/4pCZmGaOFdHOncTV9PVXQqAS4jibya/Zd160CDQOzobBMumm744MfnpevlsuAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6676
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Jun 29, 2020 / 13:11, Karel Zak wrote:
> On Fri, Jun 26, 2020 at 09:12:25PM +0900, Shin'ichiro Kawasaki wrote:
> >  configure.ac        |  4 ++++
> >  sys-utils/blkzone.8 |  1 +
> >  sys-utils/blkzone.c | 20 ++++++++++++++++++--
> >  3 files changed, 23 insertions(+), 2 deletions(-)
>=20
>  Applied to the "next" branch (for v2.36 is too late). Thanks!

Hi Karel, thank you for picking it up.

The kernel side patch was applied to nvme-5.9. With this status, the commit
message of the blkzone RFC patch is rather weird. I will revise the commit
message and resend. Could you replace the patch in the next branch?

--=20
Best Regards,
Shin'ichiro Kawasaki=
