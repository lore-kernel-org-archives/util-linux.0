Return-Path: <SRS0=B8qL=4B=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7ACC2BA83
	for <util-linux@archiver.kernel.org>; Thu, 13 Feb 2020 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7C7218AC
	for <util-linux@archiver.kernel.org>; Thu, 13 Feb 2020 12:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=uq.edu.au header.i=@uq.edu.au header.b="HPYwC4hI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgBMM6o (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:58:44 -0500
Received: from mailhub2.soe.uq.edu.au ([130.102.132.209]:54728 "EHLO
        newmailhub.uq.edu.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMM6o (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 13 Feb 2020 07:58:44 -0500
X-Greylist: delayed 709 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Feb 2020 07:58:40 EST
Received: from smtp1.soe.uq.edu.au (smtp1.soe.uq.edu.au [10.138.113.40])
        by newmailhub.uq.edu.au (8.14.5/8.14.5) with ESMTP id 01DCknSq044326
        for <util-linux@vger.kernel.org>; Thu, 13 Feb 2020 22:46:49 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=uq.edu.au; s=s1;
        t=1581598009; bh=92NSCgE10RpmVdnl71kxin/yq+lxzHaydTxzRoZ5aoM=;
        h=From:To:CC:Subject:Date;
        b=HPYwC4hIafb50blQfmrKGTEeI+Sf972ZhxJX6vZK1mxr4oPD/7eh3MA53nIQ81tRN
         loTTbAfvIxxUXNUgIBlEOHpnc9ivM36wIJe7fwjeouBq03+LzhOafW7STDV1gHHlqv
         ZnKMs/t2XlnrdtGV+9F+ww28GgDfL35Cl+puPP9zCiXAtNNpvMC2s3sBTdrvaIXt12
         h6L4R5i38dcQWmIjMc4L+LOH8SVMzDrkTjS/zfrMTCdAvdIbOEh7PD3hJm5PgGEGMm
         nkcUSrNE3Z7A7MDRGluuP1Mcd6kx3hNeeUNz/k4syoCtUxTQzbKev4eEkmb3z/0Rrx
         8KoduaoAdJVmg==
Received: from uq-excas1.soe.uq.edu.au ([130.102.129.51])
        by smtp1.soe.uq.edu.au (8.14.5/8.14.5) with ESMTP id 01DCknMp023795
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Thu, 13 Feb 2020 22:46:49 +1000
Received: from uq-excas1.soe.uq.edu.au (130.102.129.51) by
 uq-exmbx2.soe.uq.edu.au (10.138.112.4) with Microsoft SMTP Server (TLS) id
 15.0.1320.4; Thu, 13 Feb 2020 22:46:49 +1000
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.57)
 by uq-excas1.soe.uq.edu.au (130.102.129.51) with Microsoft SMTP Server (TLS)
 id 15.0.1320.4 via Frontend Transport; Thu, 13 Feb 2020 22:46:48 +1000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHIDwIHm1HtMjK7EotH3JVFTybECcBBn6KEXe29J2yoCCLAeEgaR/SqRXj/VmkSRSXjL9Ya8xNl+t7YbhlCu4Y1IauYB9pL3WXDVpMknaB8xFYB63rXelNuBqmqFrAxk4OUYHV8nIlgCqQIKv5MDpGrU6CSRMXkAe0Ugc7Kt5F32+PPba9zmD9VOX60q/OkNCxpcbvDhMFYrmtljL52kRlhUp/MtkCu/w84xGyRdzx3njNFg2CAhsRbL3WQh4rcmaS6ECV6isseGfhK+rfLefHgWTvRQVoz2G1mFyEnx3cEeo4gxpflPFqEFvKNednOCoYQtSnGAiB9vyS1NPSTaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92NSCgE10RpmVdnl71kxin/yq+lxzHaydTxzRoZ5aoM=;
 b=L4uEqgkVDQ5kJ+3rdYevbbFIcIc/XJusBBOSA7+S2VPcowicGaBzhLho5Kbh1xCRgPDBHtiwZlJj7E7llMODuVgVRpEhft+GFEPH690QeQ0L0EnGpNFJcqVJBLsMuRVZd19ccEKKcRPSEnLmmjRwDhSkfjYpGYF58uHcQnkgUc/8sOuwz6+rZ1WHFvOHhaAowZXa/Zw7IRHbKmvyIPLzZhGMMw3kFqfPy5El+8hSyXovlhlGQFLOdNfJIELWHmV4Rzaw/V2D4XoW1+rsmNTo4sh4TZ2JOWrfxcsyjgbBuaKxZOgysJr0elgGO1Sf0uck0tGYc+FmtC1J+vJZz5Ubxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uq.edu.au; dmarc=pass action=none header.from=uq.edu.au;
 dkim=pass header.d=uq.edu.au; arc=none
Received: from ME3P282MB1394.AUSP282.PROD.OUTLOOK.COM (20.180.49.201) by
 ME3P282MB1201.AUSP282.PROD.OUTLOOK.COM (20.180.50.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 12:46:47 +0000
Received: from ME3P282MB1394.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f89f:abc7:9b00:8faa]) by ME3P282MB1394.AUSP282.PROD.OUTLOOK.COM
 ([fe80::f89f:abc7:9b00:8faa%3]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 12:46:47 +0000
Received: from localhost.localdomain (101.165.169.188) by SYBPR01CA0157.ausprd01.prod.outlook.com (2603:10c6:10:d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 12:46:46 +0000
From:   Zane Van Iperen <z.vaniperen@uq.edu.au>
To:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC:     Zane Van Iperen <z.vaniperen@uq.edu.au>
Subject: [PATCH] libuuid: add uuid_parse_range()
Thread-Topic: [PATCH] libuuid: add uuid_parse_range()
Thread-Index: AQHV4munxWU3ouSMEk6QmGnqXP+RgA==
Date:   Thu, 13 Feb 2020 12:46:47 +0000
Message-ID: <20200213124615.31804-1-z.vaniperen@uq.edu.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0157.ausprd01.prod.outlook.com
 (2603:10c6:10:d::25) To ME3P282MB1394.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:88::9)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=z.vaniperen@uq.edu.au; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [101.165.169.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03dcb5dd-177f-42a6-4c84-08d7b082c981
x-ms-traffictypediagnostic: ME3P282MB1201:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <ME3P282MB1201323C33ADA262119FD053B61A0@ME3P282MB1201.AUSP282.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(346002)(396003)(376002)(189003)(199004)(4326008)(8676002)(26005)(16526019)(86362001)(2906002)(2616005)(956004)(8936002)(81156014)(186003)(81166006)(66946007)(66476007)(1076003)(6486002)(66556008)(52116002)(36756003)(6506007)(69590400006)(64756008)(478600001)(6916009)(71200400001)(66446008)(316002)(786003)(6512007)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:ME3P282MB1201;H:ME3P282MB1394.AUSP282.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: uq.edu.au does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: APOQvBu0ysXC+1SAneN13g7LAPr00dk1w6XZ6BgLv1tX/sBwmwW40LhbDBXmtUX4AubHswiFXf2fNnNpkEc9m3l/b92O/C0kyYTdds/m2oxgzUxoCi+pX/seGTDAuPnS7HFr3Qoi5GKsleNFF3b0fgLqB24pmubQDaNyQ4kksPJQaexmdcBZYajmeB7NYGVmMl5jeCqmE0kDY3PSkZBEZcA2zMwT7U7GS+dGrVBmcOzS10CpcMhDJoh2HH5iU7Tvjinrw9P2Z8e1qqX9Ffk4+FRbcF2HJz5Wn1+5iuduZSAzZ2K0RNREjymP32awUKB6TWcp541Bt9N36FBxIET0aWfleQIsJexUZisP+awtjFTheBQ5e6Cy4M8gj0xPLk22OuGVGrZ2+9zBMHv5+8ugssM4GebkGWnR0CAl52AG6KEj1pS46mgyWt2CmMkqph4gUkeqNDm5dMXhhgeMEIlt3wkh6Qd8ESzB7urQpx4q5KYxtYNz+Z5SzPjemGIYtzaDD4aQddVbD8n5cFzGpj5YWWPLvQ6XsUFkU3XhAH1gXmQ=
x-ms-exchange-antispam-messagedata: GUeMVOTNW6kgqy33ChUj0MsfJq3Tt9Q7YThuXAekDD9u+mkAPOSD5e0KDREA2SKF6KNRBg1ugE+EY8VggJCgW3XiEiEBdSiFo8xyPIrj1w3o1GtevJ/dA5sk1IMKgyRUr008Z9JHLfx6pmjwgFC0dw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dcb5dd-177f-42a6-4c84-08d7b082c981
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 12:46:47.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b6e377cf-9db3-46cb-91a2-fad9605bb15c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: maGB6NIdOnKt8VR8UWYCWPLPD3F0MtwortKJXsj8b3LxIMwa/U346QP5/vqLr7WPMyir1zbYFKrhXWi1jJgYbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3P282MB1201
X-OriginatorOrg: uq.edu.au
X-UQ-FilterTime: 1581598009
X-Scanned-By: MIMEDefang 2.73 on UQ Mailhub
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Rm9yIGNvbXBhdGliaWxpdHkgd2l0aCBDKysncyBzdGQ6OnN0cmluZ192aWV3LCBldCBhbC4NCg0K
U2lnbmVkLW9mZi1ieTogWmFuZSB2YW4gSXBlcmVuIDx6LnZhbmlwZXJlbkB1cS5lZHUuYXU+DQot
LS0NCiBsaWJ1dWlkL3NyYy9wYXJzZS5jIHwgMjMgKysrKysrKysrKysrKysrKy0tLS0tLS0NCiBs
aWJ1dWlkL3NyYy91dWlkLmggIHwgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2xpYnV1aWQvc3JjL3BhcnNlLmMg
Yi9saWJ1dWlkL3NyYy9wYXJzZS5jDQppbmRleCAwNzQzODNlZmEuLmU0ZWM0NGFiMyAxMDA2NDQN
Ci0tLSBhL2xpYnV1aWQvc3JjL3BhcnNlLmMNCisrKyBiL2xpYnV1aWQvc3JjL3BhcnNlLmMNCkBA
IC00MCwxNSArNDAsMjQgQEANCiAjaW5jbHVkZSAidXVpZFAuaCINCiANCiBpbnQgdXVpZF9wYXJz
ZShjb25zdCBjaGFyICppbiwgdXVpZF90IHV1KQ0KK3sNCisJc2l6ZV90IGxlbiA9IHN0cmxlbihp
bik7DQorCWlmIChsZW4gIT0gMzYpDQorCQlyZXR1cm4gLTE7DQorDQorCXJldHVybiB1dWlkX3Bh
cnNlX3JhbmdlKGluLCBpbiArIGxlbiwgdXUpOw0KK30NCisNCitpbnQgdXVpZF9wYXJzZV9yYW5n
ZShjb25zdCBjaGFyICppbl9zdGFydCwgY29uc3QgY2hhciAqaW5fZW5kLCB1dWlkX3QgdXUpDQog
ew0KIAlzdHJ1Y3QgdXVpZAl1dWlkOw0KIAlpbnQgCQlpOw0KIAljb25zdCBjaGFyCSpjcDsNCiAJ
Y2hhcgkJYnVmWzNdOw0KIA0KLQlpZiAoc3RybGVuKGluKSAhPSAzNikNCisJaWYgKChpbl9lbmQg
LSBpbl9zdGFydCkgIT0gMzYpDQogCQlyZXR1cm4gLTE7DQotCWZvciAoaT0wLCBjcCA9IGluOyBp
IDw9IDM2OyBpKyssY3ArKykgew0KKwlmb3IgKGk9MCwgY3AgPSBpbl9zdGFydDsgaSA8PSAzNjsg
aSsrLGNwKyspIHsNCiAJCWlmICgoaSA9PSA4KSB8fCAoaSA9PSAxMykgfHwgKGkgPT0gMTgpIHx8
DQogCQkgICAgKGkgPT0gMjMpKSB7DQogCQkJaWYgKCpjcCA9PSAnLScpDQpAQCAtNjIsMTEgKzcx
LDExIEBAIGludCB1dWlkX3BhcnNlKGNvbnN0IGNoYXIgKmluLCB1dWlkX3QgdXUpDQogCQlpZiAo
IWlzeGRpZ2l0KCpjcCkpDQogCQkJcmV0dXJuIC0xOw0KIAl9DQotCXV1aWQudGltZV9sb3cgPSBz
dHJ0b3VsKGluLCBOVUxMLCAxNik7DQotCXV1aWQudGltZV9taWQgPSBzdHJ0b3VsKGluKzksIE5V
TEwsIDE2KTsNCi0JdXVpZC50aW1lX2hpX2FuZF92ZXJzaW9uID0gc3RydG91bChpbisxNCwgTlVM
TCwgMTYpOw0KLQl1dWlkLmNsb2NrX3NlcSA9IHN0cnRvdWwoaW4rMTksIE5VTEwsIDE2KTsNCi0J
Y3AgPSBpbisyNDsNCisJdXVpZC50aW1lX2xvdyA9IHN0cnRvdWwoaW5fc3RhcnQsIE5VTEwsIDE2
KTsNCisJdXVpZC50aW1lX21pZCA9IHN0cnRvdWwoaW5fc3RhcnQrOSwgTlVMTCwgMTYpOw0KKwl1
dWlkLnRpbWVfaGlfYW5kX3ZlcnNpb24gPSBzdHJ0b3VsKGluX3N0YXJ0KzE0LCBOVUxMLCAxNik7
DQorCXV1aWQuY2xvY2tfc2VxID0gc3RydG91bChpbl9zdGFydCsxOSwgTlVMTCwgMTYpOw0KKwlj
cCA9IGluX3N0YXJ0KzI0Ow0KIAlidWZbMl0gPSAwOw0KIAlmb3IgKGk9MDsgaSA8IDY7IGkrKykg
ew0KIAkJYnVmWzBdID0gKmNwKys7DQpkaWZmIC0tZ2l0IGEvbGlidXVpZC9zcmMvdXVpZC5oIGIv
bGlidXVpZC9zcmMvdXVpZC5oDQppbmRleCAwM2MyMzJjYWEuLmI5MGM4ODgzNiAxMDA2NDQNCi0t
LSBhL2xpYnV1aWQvc3JjL3V1aWQuaA0KKysrIGIvbGlidXVpZC9zcmMvdXVpZC5oDQpAQCAtMTAw
LDYgKzEwMCw3IEBAIGV4dGVybiBpbnQgdXVpZF9pc19udWxsKGNvbnN0IHV1aWRfdCB1dSk7DQog
DQogLyogcGFyc2UuYyAqLw0KIGV4dGVybiBpbnQgdXVpZF9wYXJzZShjb25zdCBjaGFyICppbiwg
dXVpZF90IHV1KTsNCitleHRlcm4gaW50IHV1aWRfcGFyc2VfcmFuZ2UoY29uc3QgY2hhciAqaW5f
c3RhcnQsIGNvbnN0IGNoYXIgKmluX2VuZCwgdXVpZF90IHV1KTsNCiANCiAvKiB1bnBhcnNlLmMg
Ki8NCiBleHRlcm4gdm9pZCB1dWlkX3VucGFyc2UoY29uc3QgdXVpZF90IHV1LCBjaGFyICpvdXQp
Ow0KLS0gDQoyLjE3LjENCg0K
