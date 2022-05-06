Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29BD6C433EF
	for <util-linux@archiver.kernel.org>; Fri,  6 May 2022 14:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbiEFOKC (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 6 May 2022 10:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441992AbiEFOKB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 6 May 2022 10:10:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60061.outbound.protection.outlook.com [40.107.6.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB40B63503
        for <util-linux@vger.kernel.org>; Fri,  6 May 2022 07:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keodC3Zox/pqG/luF9u9Lnu7djevwN1HsCJPX1W7lNsTzAtdISGn/yxUYAIAyR0t5t9ejQuqUxwrnbAe1VCnhQOvzEUwfIyxe8y3+YN8n6nEMK+2cqLQeeUovWX6yYppDjDC1c56aF5EQ2RVkbVI61woopvHdDmOVduwWPNeO/CVYu5hH9+aO14PFBYYl1RpwQEOsiBWXOCP5sf1DkLYjRsHHeJdItdlJDq1j2ax/bCZh91bUzpERX66R/9p+xFCKvKAKrQlm6+fIM1Vf8NfMYvT9F8mq5NEdQShHMXiay/YpnMEsL9b5XZni3Rv0pfTyjDsHP8GI3tavTt7ZDRhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcsHrLBgx1fPcfaf22TlBLG8FiiVZvM8RSHGA/RYZ6A=;
 b=k8Iv0ZxC4A5MIoXc8xSuzJrup01fPoTeqaapj8mqi9xfbleL+tEI0jNC1wawGnM7ktWZ80224AqlXMwhKfe7anx4a8KGvUASv/6/S3I85a8rqUIy5eic+uBO0C80FLhwvJ3l0koFWcV/I8lepQtTKpkv2qQsPoexQxzWe98TnsyTeuVgnCcqxif6Vth0AgLMbfkwDolVfo+HNrw7vlIIKlpu/Aq89g23RADzUbAU29ZBlLYH5PHl3e7ebZCw2nFRTypR2CwuxyPSMjdUeOyou3uxyw/9saALfJiX1mCI4kwtGaMq0I1PQSOcSacWLGYXGF3nC2IjS2CPJwB3wiaJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcsHrLBgx1fPcfaf22TlBLG8FiiVZvM8RSHGA/RYZ6A=;
 b=dNUNkxyOL3rqrFaXn7uPlh91T5YmI1IppDsySC/CAbAOIjY8XjQz5RlSF8wUozQhVGvNk5MA8esSH8UbtJgOcj5OMMwuJR/kosd2j6FKvEV8pIMOr7kD3ob8BfsJklSGTFWLc8G0OGbr29+rY+DHBfgk6XIHi0YC7WloGszkP19SL/zP313ohPIgW5KaTPnzRYbRampgwnY4liSqAUdPV7VOFCaeIBdW+fYxRt2msPTBkkS6RlYOVku99e9zAsOzeUg/qFa+DODoGovv4FYtruEXC1A09CXfDt1r/AlP4yEKsNkZoTs49EcHZhJMW7TpExxmfVwdWmSOkAjv8BdP9w==
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com (2603:10a6:20b:585::11)
 by AM6PR02MB4213.eurprd02.prod.outlook.com (2603:10a6:20b:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Fri, 6 May
 2022 14:06:14 +0000
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::ecfd:1f4f:d467:3b2d]) by AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::ecfd:1f4f:d467:3b2d%4]) with mapi id 15.20.5186.020; Fri, 6 May 2022
 14:06:14 +0000
From:   "Trapp, Michael" <michael.trapp@sap.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: uuidd: Implement continuous clock handling for time based UUIDs
Thread-Topic: uuidd: Implement continuous clock handling for time based UUIDs
Thread-Index: AQHYVjE3grrsrNdB90SCXAplz0G5Ta0G0QqAgAsndoA=
Date:   Fri, 6 May 2022 14:06:14 +0000
Message-ID: <F954A285-6204-4317-8295-1EAE38849E83@sap.com>
References: <20220422100830.32187-1-michael.trapp@sap.com>
 <20220429114607.6ggqozhcir7pp2h2@ws.net.home>
In-Reply-To: <20220429114607.6ggqozhcir7pp2h2@ws.net.home>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e7be4ef-a483-4257-ea9c-08da2f6994f0
x-ms-traffictypediagnostic: AM6PR02MB4213:EE_
x-microsoft-antispam-prvs: <AM6PR02MB42132D9519F99F90D3C57D69F9C59@AM6PR02MB4213.eurprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vkil5aqtYOzo0CzCQFoZQPiaMJy/nRE9YdCSzEW8piCbjJgd7IbdoZgJOib0iVcdvtorHHqJdIqtD+HlOATGm0IzGe+AVANSlwglVO90JuC/GCSzf0IHlZKnxNUg/3lykt1MJxgcaJPH1AaIOXcQNyJUPMybjyKeiDPv7Hvk0kOynfL7n41/jElSZav6lNCsJq7LNWsyKpulznBtB3WD6mJqcjd7Ejm738xhJZHiwT0euMfJG1/0ngQr2pgNKbUAAOszcCVTY3tkoQy5fiKdAq275WMZM/X0vTXtg/bbVuzI6dROVo8BskqJAlelNVt7ZqybC04h5+oOStdiehY0HUbeO5W3dyTqm531dwaJstwkwPLK4W/IBwbk1tU8e4AYXhq0pAiCLP5Ofw2kGTYQMbAhQxrCAVSbttGB2XRROD8PK+RcXLlt/GBbwYXPaiqYQc+5jvI/2RW+gSibXkbVK2Y0R/X9wZn1vu/aMTSrSxIFoccpmwf21FeewSx7fVbHMJFEHDnCANDhnpFbaWg1+lMsLEv4tmefMTze9gnSc/3QAG5j9RwgVe+6maZVXwhqtqpYJL/G2oHrPLyBDwNJhsqXxaQ2Iowbm3P/mZGIr2UXWFCUIZ4fen49+fWvCcCjqZwQnvzZNZq1Sohwnd/oRf3cwojmsZ18Us2X9h4HJatQj+OOHiIuTkxxcGISyjv85LYMG4FElt9WYFB0UHRTmIb5EsJKeFXvtKowOM7qcsGO9PzOgbskMi2RFp7ieAmG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8550.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(86362001)(38070700005)(6916009)(316002)(71200400001)(83380400001)(8676002)(64756008)(66446008)(4326008)(66476007)(91956017)(66556008)(36756003)(66946007)(76116006)(6486002)(2616005)(6506007)(6512007)(508600001)(186003)(33656002)(8936002)(5660300002)(2906002)(26005)(122000001)(82960400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkNHN3kxeCtCYWdZU0xvNjh2d2wyelRObGUrSG1ENnJ5SkgrbXNQNmVKeHQr?=
 =?utf-8?B?VzR1dEF4cmdrZjNIZGRPV1NQUGJsU25YMmQzMWh1Tlc3cjJHdFZkTXdDcVN2?=
 =?utf-8?B?bjdub0xRdFVkNUFFTU96NUJ4VGdmdzZwaENXWWNUbmlJK2VvV2hMc2VhNTBu?=
 =?utf-8?B?L3lERmlzVGVxVlVYam0weHBoU0ZzWERsclhZU013TkVjOVlUYTUra1pHMHQr?=
 =?utf-8?B?SVEwcWF4RDJiQjFCb1kzN2l2a0NYeGVYNmw1NDJGaFpFZTM4N2lkOGJjbjV0?=
 =?utf-8?B?azNuNlBjeEk4SGQrZmphemx4VEx4b3lDZFFwcnM3aWZ3NmVTOGxUVXRhNERV?=
 =?utf-8?B?SytteWJ0WG9obUNrMXpJVDc0NXFKZEVhMEw2UTE3aUlheWpOTGFUZk9ERjNo?=
 =?utf-8?B?Zm1CaFg1RCtxVUtWRE1MSmlLYkJDVFRmeVZKeWtqdHd5UHhBTUx3NXp2c3My?=
 =?utf-8?B?STVMU0ZROUNiK3RWZ2U1VGpuZjRqUHpCQkozVFhyRnkyV1h3SkNJdmRKVlZU?=
 =?utf-8?B?Nmd0eVV6QW13dExwa0l6OTA0ZlhLYXV2KytNNy9BeFdwc3ZMVjRrSUcvSzAr?=
 =?utf-8?B?NHNJYmYwOXVubVo1bk9yUVFQS0pHRlBaU3d4S3hvSFBVYStjTGNnT2hYK3Q2?=
 =?utf-8?B?bjUvd1czWEZQMUhCbUFaYVBmSWJHeUpCMUgzd3loZWFuWkxLTC9FUmNuL2JK?=
 =?utf-8?B?WjgzbDhpQ1NDYWl1SGs3eU5sZHc5dXRpeitvVSsyR0l1Yk1xOWlkS0ZJQ05F?=
 =?utf-8?B?RDRVVkxoRjhIVWErQUJMUUhCeUIxRkMza1lQajBRaXhNVXBYQ3JNYXVFMVMw?=
 =?utf-8?B?UWZtejlXSmJFTStibk1lam9vTU5RalZxRmVCeVRCdGJhVWNuVHZtZkdCdTI3?=
 =?utf-8?B?djRuczJIeEpBWjBFYUtKYTZVMWg4VllpYWFuVnhRdWo4aW02dEVjd2RMMWRk?=
 =?utf-8?B?ellTYzc1YURVSWFOUmJSc1BFTjFJOVVVTlpZeFZHb1VwSVVNM2lvbmFmbDdi?=
 =?utf-8?B?V2M2ZGtDa2FsU3I1L1YyQVdEMitXZm1tRTBFU0x5Z1pGbzIvb3BoYW90dFho?=
 =?utf-8?B?Qk9uYnFTc1pyNE9iUHFHZlQ5ZzB1Z20vUWRyV3Z1SlE3NFB2cEFNUk54c2or?=
 =?utf-8?B?UCtDSVJjcUp0d0owMWVLVGx4OXBpMEI3a2RjYWt6VmtLQThUTjNDS0dlc3dH?=
 =?utf-8?B?U0FqWnhaZTlxU1d1R29WSHRRNE8vcVZXRXRRMHZaZzJCZTdKeUR5L3JpbjJM?=
 =?utf-8?B?aDJjT0svYU11bXR0dm1ncm9EajExSHAvQUNpN0x2aVBraFlvYldIbWkwSjVv?=
 =?utf-8?B?S2V0SFlyZ2VmNlNHY0lsT2NFemxtNXRlb0pMTWVhNUZROEd1aG1ramdnejVv?=
 =?utf-8?B?c25PSWViU0R0WC96bzdmdmNzS1AyNWxOSlZFdzNIaGhPclhVRkYvSStUM1Qy?=
 =?utf-8?B?V1I1c0dBS3E4VWxSdDEydGdYcHgyRXBIN0xsamFJc3FhNzJEOThyM2JvOFpn?=
 =?utf-8?B?cFp1amdBbTM3bFFkd1NGNm5OeGQ0YjduS243MlRYUUZYSk15YkR5U1V0RGpq?=
 =?utf-8?B?UlFHejdKU2ZhT05TSndJUnpLQlNRY2JvcTllbzN0YzJaNU8wZGgzTTBtNzUw?=
 =?utf-8?B?VnNmZkd3dFU5QVNCYUI1RmIrV09hazdNMGxEVjhMS2xiMlRkRURqMnFyQ3lw?=
 =?utf-8?B?WEt4bVQ3TGFVM2pRTHRGejd0aE1iZ2ZocnZFak8zaE93WlV3ZzVnMTBlZXd2?=
 =?utf-8?B?c1d4cjN3T3NnNE1IMytWenNZNCtUb2ZBYVkwS3RrcjdRb3JaQlh2dE1GU3R5?=
 =?utf-8?B?bkdnLy9oeEE0VXpONnR0YzlsUmhBaUE1MkNxUmFCcHA5QUxuQ2swd2IxbUMv?=
 =?utf-8?B?MEdrYWpteU1rM3lFWTJ0aDdjSGxLS28vYjdJZmp6MlFVMm55L0Z1ZjBDdXhU?=
 =?utf-8?B?a1ljd295VTE5Vkwyc2x0YUh5T3RTVnVVMmlEUGFoVDVpdW8xR1owTjliK0JK?=
 =?utf-8?B?WFk2ZzY5WllvdFBiL0NuRVVkRHd0dXVaMktvOHdHNUdJa09DSFdOalBsZFRD?=
 =?utf-8?B?YThoWm9nWEMyMWhQTHdaWGp3ZGdLcHY1ZkZoYzRpSTEzNjUxTUluRUNJZkx5?=
 =?utf-8?B?bmcySkdPcHVlbUVLUERwVjBRZk9odFowTHFZR01zZFVZYkIxamNXeTlUTm91?=
 =?utf-8?B?Ni9KckcxVzJsdjZVZEdDRGNCbERIOUU0eDRuZEY1R0VqQm9DVnE5SnJmcGFP?=
 =?utf-8?B?VjNsMHl2bGVqTnZmbFNmSVh6QXJnQmdMeXNKSkQxNkluaHF3ZzBFM1JmQlNJ?=
 =?utf-8?B?TXJlU2grc2R2WG5mKzZhMXNHVWlaZjFGQzEyNWl5ZjFWeWxGR0ZUNjh2V2py?=
 =?utf-8?Q?0R5frzGFF+/7chWg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCBD8F7E303A024E95FBCB05A6DEFEEE@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8550.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7be4ef-a483-4257-ea9c-08da2f6994f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 14:06:14.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y/ed9uYW8nCPPvoDAmj4KxnJ1K07dGMBYnU445g39uh0YLVQG52RFPwa1lTQ4YJrw+ctGZWgLyHpziSp64v36w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4213
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

DQoNCj4gT24gMjkuIEFwciAyMDIyLCBhdCAxMzo0NiwgS2FyZWwgWmFrIDxremFrQHJlZGhhdC5j
b20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBBcHIgMjIsIDIwMjIgYXQgMTI6MDg6MzBQTSArMDIw
MCwgTWljaGFlbCBUcmFwcCB3cm90ZToNCj4+ICtzdGF0aWMgaW50IGdldF9jbG9ja19jb250KHVp
bnQzMl90ICpjbG9ja19oaWdoLA0KPj4gKwkJCSAgICB1aW50MzJfdCAqY2xvY2tfbG93LA0KPj4g
KwkJCSAgICBpbnQgbnVtKQ0KPj4gK3sNCj4+ICsJLyogMTAwbnMgYmFzZWQgdGltZSBvZmZzZXQg
YWNjb3JkaW5nIHRvIFJGQyA0MTIyLiA0LjEuNC4gKi8NCj4+ICsJY29uc3QgdWludDY0X3QgcmVn
X29mZnNldCA9ICgoKHVpbnQ2NF90KSAweDAxQjIxREQyKSA8PCAzMikgKyAweDEzODE0MDAwOw0K
Pj4gKwlUSFJFQURfTE9DQUwgdWludDY0X3QgbGFzdF9jbG9ja19yZWcgPSAwOw0KPj4gKwl1aW50
NjRfdCBjbG9ja19yZWc7DQo+PiArDQo+PiArCWlmIChsYXN0X2Nsb2NrX3JlZyA9PSAwKQ0KPj4g
KwkJbGFzdF9jbG9ja19yZWcgPSBnZXRfY2xvY2tfY291bnRlcigpOw0KPj4gKw0KPj4gKwljbG9j
a19yZWcgPSBnZXRfY2xvY2tfY291bnRlcigpOw0KPj4gKwljbG9ja19yZWcgKz0gTUFYX0FESlVT
VE1FTlQ7DQo+PiArDQo+PiArCWlmICgobGFzdF9jbG9ja19yZWcgKyBudW0pID49IGNsb2NrX3Jl
ZykNCj4+ICsJCXJldHVybiAtMTsNCj4gDQo+IA0KPiBJZiBJIHJlYWQgeW91ciBjb2RlIGNvcnJl
Y3RseSwgaXQgaW5pdGlhbGl6ZXMgdGhlIGNsb2NrIGF0IHV1aWRkIHN0YXJ0DQo+IGFuZCB0aGVu
IGNvbnRpbnVlcyAoZm9yZXZlcikuIEVhY2ggc2hvcnQgdGltZSBvZiBpbmFjdGl2aXR5IHdpbGwN
Cj4gaW5jcmVhc2UgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB0aW1lIHN0b3JlZCBpbiBVVUlEcyBh
bmQgcmVhbC10aW1lLg0KPiBGb3IgZXhhbXBsZSwgdGhpcyBkaWZmZXJlbmNlIHdpbGwgYmUgaHVn
ZSBmb3IgZGF0YWJhc2VzIHdoZXJlIHVzZXJzDQo+IGRvbid0IGFsbG9jYXRlIG5ldyBVVUlEcyBh
dCBuaWdodC4NCj4gDQo+IA0KPiBNYXliZSB3ZSBjYW4gaW1wbGVtZW50IHNvbWUgaHlicmlkIG1v
ZGVsIHRoYXQgcmVzZXRzIHRoZSBjb250aW51b3VzDQo+IGNsb2NrIHN0YXJ0IHBvaW50IChsYXN0
X2Nsb2NrX3JlZykgZnJvbSB0aW1lIHRvIHRpbWUsIGZvciBleGFtcGxlLA0KPiBldmVyeSBtaW51
dGUgKGhvdXIsIC4uLikuIEkgZG9uJ3QgdGhpbmsgaXQgd2lsbCBiZSBhIHBlcmZvcm1hbmNlDQo+
IHByb2JsZW0gd2hlbiBpdCBkb2VzIG5vdCB1c2UgTElCVVVJRF9DTE9DS19GSUxFLiBUaGUgcmVz
dWx0IHdpbGwgYmUNCj4gVVVJRHMgdGhhdCBtYXRjaCB3aXRoIHJlYWxpdHkuIERvZXMgaXQgbWFr
ZSBzZW5zZT8NCg0KT2YgY291cnNlLCB3ZSBjYW4gdXNlIGEgPG1heF9vZmZzZXRfdmFsdWU+IGFz
IG9wdGFyZyBmb3IgdGhlIOKAmC1D4oCZIG9wdGlvbiBhbmQgdXBkYXRlIGxhc3RfY2xvY2tfcmVn
IGFjY29yZGluZ2x5Lg0KQSBjdXN0b20gdmFsdWUgY291bGQgYmUgc2V0IHdpdGgg4oCYLUMgPE5V
TT7igJkgYW5kIHRoZSBmZWF0dXJlIGNvdWxkIGFsc28gYmUgZGVhY3RpdmF0ZWQgYnkgb21pdHRp
bmcg4oCYLUPigJkuDQpXaGF0IGRvIHlvdSB0aGluayBhYm91dCB0aGF0Pw0KDQoNCk1pY2hhZWw=
