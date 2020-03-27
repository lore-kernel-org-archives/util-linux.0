Return-Path: <SRS0=T2Wt=5M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2CDC43331
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 03:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAC420787
	for <util-linux@archiver.kernel.org>; Fri, 27 Mar 2020 03:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jshC6xS5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RJHsns5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgC0DHJ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:07:09 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17759 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgC0DHJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 Mar 2020 23:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585278429; x=1616814429;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ro3s4b3Zjs9SLO7n5Ym0Bibct8a6Q5/ZJ9b9LPpcyw4=;
  b=jshC6xS53PDm2uTzUsJUM4AhQI3SKefCpNT1V09wZ0zB7oSR4CnLuDhS
   yXkKFptRNgEOpilzpdgJj4ElrSPD3wIzmUq9d4r1eewkxc1vxYtXo+fRJ
   UMCY2UsOCgaZLU6n9nhacBNnuie5kx2QYgclgbgkJbTk6LvWl7d8Fl5uS
   oBZjzsMpZrn/Rz0NSEpUyE4idL0ansTtYoRT3r506kZZb4mIC26PxnW/u
   POc9qDHj5aJBpAPDChJ/qUh7weMFCXhwmDWBtTYwqBEfPhFo9MkwATzPZ
   PI66ns4EiMyYnwVKFcCe2pS0umZcXdtKHtusBUy2aD4tBMrWglYlzh7RF
   g==;
IronPort-SDR: 1uqNhoxbFka9TPXnHOkGX2xqELAXeCe7RYDtBFJonNNlYky1JByvCx1eajB+ZLLDkyODoIZfJc
 IqlFcNVzghxbXiw/66pnx42STpdZe0iSkif36igafegyIBP+qYgAum0S02tMukezHYdNARqWqD
 uSm1TOu2MUDDiDmwP/QOwEiSExYmrfS1X4KNmwtbp1/59hya9tEgM9phmVw/Cqin7vk3EAaVDk
 la9uuKh/OaGw/eoEk3/RdpWWx7ltYvmW+eHXWC/iSEjgafZRDpaJ2/qi8XihPz1Oyam8cBS9dl
 u+o=
X-IronPort-AV: E=Sophos;i="5.72,310,1580745600"; 
   d="scan'208";a="138016153"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 27 Mar 2020 11:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0dzfh9hD+hpZJrlHw5UCDQ2TtxwEC3tN3yNOdFu/iUdkl573gxxcogwTIy4PrHuyWD1zXAVBoUhfVFij10V85jwPD0f1Juuq+e0aZUU337HUNKsL2m7sNqfgQmfVQ3GsOPN9S/XZgs0NPm/by0mFjNiON0eg38Tg5UXa7A1BPc4IiyAH45WZr43pjcf1FQJNaqQ/iM74fY81bEUQKarJ8lf/LVMMM3sbDhK/jL35QnTuN9HhPjo/J3mWbGJEJkE/Vf3kWemNKXZ2oYFd5NBB8HCQ6v7S+akNXLruVEcEka9YgOZLWNKOhY1YkeUB9iMy/bl/Z9bM1UlK0EeQHTlgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACTpgA6brBnqLpW3TME8+n2eMhbaplpb/h5v5Im64Ds=;
 b=AW1YjCI2xE02m3xp6yfn8CUmBaaeRMe9Rw/oTtbmYRwLt2LORzE8kHem8Dx9bua6jpmhFm7b9ZoXoNRicsdPjCDwbly2dQzPVvLPFP4kYNJdCEipN4MBJePxKGC9trHSkgfcH551Sy0Wij6GB5rWwfxawLyEjnG5END4JliUNlxnHwfV62hq/E1SDorbPRD+zagoMLQ7Rip28RB7OJGhloq2wsCz3TrQKCtgn1QMf8zQOze5IJaxzKNJJNaW7FLE9LqdoYmzB54Rq35qsFD7Hq/6PzFsprXTh7yky2Mp/i5MRviX3zS6dDvWwUpYuWLesAqGsgLO5TN6rg5l9QsPUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACTpgA6brBnqLpW3TME8+n2eMhbaplpb/h5v5Im64Ds=;
 b=RJHsns5QW5HNAWbzqdDZka+vwuu59Vb3qegbtfFioMOP0nQATF4G6ZhwYds0PyB1kVJf7aRqu7Jb5a+fNt06UbmNgFKYKF6Y7SLh8hNgwiskGUvbSPUsfRCO0helaEYPuoRPUr/mueZXgcMIGPtZjCDQvruJSzGyAiCfz6HaZmE=
Received: from CO2PR04MB2343.namprd04.prod.outlook.com (2603:10b6:102:12::9)
 by CO2PR04MB2165.namprd04.prod.outlook.com (2603:10b6:102:16::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Fri, 27 Mar
 2020 03:07:05 +0000
Received: from CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b]) by CO2PR04MB2343.namprd04.prod.outlook.com
 ([fe80::c1a:6c0f:8207:580b%7]) with mapi id 15.20.2835.023; Fri, 27 Mar 2020
 03:07:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Benno Schulenberg <bensberg@justemail.net>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Hans Holmberg <Hans.Holmberg@wdc.com>
Subject: Re: [PATCH v3] blkzone: add open/close/finish commands
Thread-Topic: [PATCH v3] blkzone: add open/close/finish commands
Thread-Index: AQHWA1pGkB7B+lSANEuuEqQKbxDGhw==
Date:   Fri, 27 Mar 2020 03:07:05 +0000
Message-ID: <CO2PR04MB2343937150CA07F3A888DB39E7CC0@CO2PR04MB2343.namprd04.prod.outlook.com>
References: <20200325150952.326707-1-damien.lemoal@wdc.com>
 <20200326103518.w2wi3f5uetlk5amx@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b7009139-1ec0-44b7-ec83-08d7d1fbedfa
x-ms-traffictypediagnostic: CO2PR04MB2165:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO2PR04MB21653525AB589C3F91866F58E7CC0@CO2PR04MB2165.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:130;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO2PR04MB2343.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(71200400001)(26005)(52536014)(316002)(478600001)(6506007)(53546011)(2906002)(54906003)(966005)(7696005)(33656002)(86362001)(81166006)(81156014)(66446008)(8676002)(5660300002)(55016002)(66476007)(91956017)(9686003)(66556008)(6916009)(8936002)(186003)(76116006)(66946007)(4326008)(4744005)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I2TK8NtAJ6Nrb7Wv68Z61IycDtcQeq2+p3lzljfWF3ReeDm2SsO+k8o+ficLGqTXQjDf52yZyRe0wGXSVJdwhf0s+IkQ5mOzDbbOtvo/AfMx7RMlFyh2ahZvpTI9JocUZDwCQgAzEuJXqMomE4r2BBJK5g7iPsqjIUs52Ucg8SAw8d8z5iE18Ep4UBMkGIt/LHUYKJv/kPLBc5JMVJMdic882a6dj87CsZrXk2geY+Quw+k66111jxj0JQfxz9b591sx1jfhCV74EOFURSR/059woPf4HOsHYD+wN6Z+6zGDwbJxmOmJkhouWK6lLkxOXbcynr9qKJ5lNOumt6RqC/70VwoEt8lyaUTXq5pYnDGeJhKn3+FuWC9J3YqwejqnCLPKG+YD7qmyvXpdkMhHRC5RbWH/eetxXe2H8ii8388jK17wlwVXTIGn/eOqeqLjiUSJ87WQu4RSk2j/FYHAksNgp3OKhRiWWjW6kRwraH2w44xX9UXamDgcSQgECCOmN+gYPZ3ELsoskOoMTnfB8w==
x-ms-exchange-antispam-messagedata: k7L7nKXd8E8XWhLz1yO/RkDXHv5pW6FJFHzYdv+eZqGDHQMsGQzS4wxDOv928SUqD6rnv91t2XItPjZPkCmxTc/LB6QZCNTURSS+lGjwMsr87rrWo7gDjUtJ5WIca/F2ahSLY4RNdleqLDcGZd0sWw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7009139-1ec0-44b7-ec83-08d7d1fbedfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 03:07:05.5006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3tm/b8n3qZ6ZPa5ckkxvqJfTPGtDhxkB3x/pt45g1DZjMpzj7DQJsEsl+ndxLKAhTmdQzmySoFxeuRK7yWJVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR04MB2165
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 2020/03/26 19:35, Karel Zak wrote:=0A=
> On Thu, Mar 26, 2020 at 12:09:52AM +0900, Damien Le Moal wrote:=0A=
>>  sys-utils/blkzone.8 | 27 +++++++++++++++++---=0A=
>>  sys-utils/blkzone.c | 61 +++++++++++++++++++++++++++++++++++++++------=
=0A=
>>  2 files changed, 77 insertions(+), 11 deletions(-)=0A=
> =0A=
> Applied as a diff, thanks.=0A=
> https://github.com/karelzak/util-linux/commit/46cf662532ef4e924a3478f2e47=
4b619caf141df=0A=
> =0A=
>     Karel=0A=
=0A=
Thanks !=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
