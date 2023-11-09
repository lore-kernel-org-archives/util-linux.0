Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2E9C4332F
	for <util-linux@archiver.kernel.org>; Thu,  9 Nov 2023 15:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjKIPOy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 9 Nov 2023 10:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjKIPOw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Nov 2023 10:14:52 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4787F18B
        for <util-linux@vger.kernel.org>; Thu,  9 Nov 2023 07:14:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh1WR0I/POeUsBpryz88aV5D0ca6dhXWQuKEDUb7HHpiwQcdoIA4d2cxgb8me4ZpXUu4a0+lnrzjxi1mehwSKdmzv4cPOruKFaBY+csJqcqNqde5rrW+cj7qu8m538Ah1dMO+9bqCtfPQCIz4W6Kk8NDavKdlTVayIOpSoC56HNnRl+LeTDS0Lw/dDi/BhOym2TBkrwO+zjFrZHv+KqwAEVG+wq1zKctmg7VvACbuoDoz2M4pO+jVVUSsi69xntlX/wrIueoiABickNs4CuoAM9tSeu0wxI3SsxxJEorKxLqmJWSTQhwGrmASBG3SDj0GDcGd4ItaCx1JXzECO4uJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/QYIvMWhQTdUWsvNpS1tldwUqtk2NW3FgNdvUHScCjI=;
 b=c/twkO+VJgp/09Q7ohwfivJpgqB10VCc+fsWg9o4iwnluj0DVs3r6t1wbgiO6qE24KNI8sWDtjEILtqoxbhDc1ASMht3b5foH67rZNzpf9vHcj5AQVN5SOwvYJwbpoRZYowtdNeW6rYUb3HuULCuCLpYtZInwqCVSlPdklsS4OHYSVVHaYILMWSWyyx2hbnQhECGDTVZma+Fvv1fiBlZo7enf+Pnh/sJVc1f1SXNzb+Si1/o/tDbIakdGYLg/xPYG6upfyhyTSYxzgLokQUbpLOMS/Qh2YcPQzrtSsoCMNGQAkwEUZAz1nxIOq4zfC2yBU/WN9OLVlrQfdJv0w506g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QYIvMWhQTdUWsvNpS1tldwUqtk2NW3FgNdvUHScCjI=;
 b=KtD6Kq1wU8ZQ8WzFbxdRIPF44pZ5YNyqnV3yzPzyTbnAljcDzJj/OozB+IfVBc9FQ0TdwOtUC9ee9fmhuGaT1jjMHuvFrz8/xIWwY8bV12sX+EpsKTH9zUYo024lZXnIGQer71QsyRYTbReZGf2nbYwPzSSjlFKsfA3xCroHdNiWEt74+gcRanUikqAtii9pzTpAVXwtmtz+T0AXxUU8HeTuEyh7ZGK8lne5Apda+ndEusa5kmeRC+nHaNIzlrX+yuAdICQ/FIv+rvOq7qZu1EXyKaFGGfKUNTwtqprGgmTCWe6pBVU0KTstz6KF3buyYnPlYygQnTyJ0ySZZCsiTg==
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com (2603:10a6:20b:585::11)
 by GV1PR02MB10909.eurprd02.prod.outlook.com (2603:10a6:150:16c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 15:14:47 +0000
Received: from AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::3877:e1fc:32e5:9fa1]) by AS4PR02MB8550.eurprd02.prod.outlook.com
 ([fe80::3877:e1fc:32e5:9fa1%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 15:14:47 +0000
From:   "Trapp, Michael" <michael.trapp@sap.com>
To:     Karel Zak <kzak@redhat.com>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH] libuuid: avoid truncate clocks.txt to improve performance
Thread-Topic: [PATCH] libuuid: avoid truncate clocks.txt to improve
 performance
Thread-Index: AQHZ+865qRVpb0wehk6TCWlvzqePHbBu0/QAgANzVoA=
Date:   Thu, 9 Nov 2023 15:14:47 +0000
Message-ID: <3C75FC1E-BC1E-4623-B936-37C00142BAB9@sap.com>
References: <i4fuwkw2hvj6gge3uhuy3jlq5gg4ls7djibygcb5duxhumvllx@cernuqwwl7pi>
 <20231107103302.paeetyxxlu36me57@ws.net.home>
In-Reply-To: <20231107103302.paeetyxxlu36me57@ws.net.home>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8550:EE_|GV1PR02MB10909:EE_
x-ms-office365-filtering-correlation-id: 97dfaf77-0a17-4b98-c064-08dbe1369ca5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tHRzq2nTkkMlqpKg1YIjuQNlxJwZMZ1MGqgrf/R/kmiU/FiDaJ125Y5G7SMFr7lEAY+/w7L0K/Tn5oxa9mR1C7Vv5QkfTjPhyubwoZxd3dRRcYlUG+trF6ojJVk1YAu1wKfOMd8sDTkR6xNis+iKxc28soaK2zq+NwZYgCWJVEgOcwU135C+1vaEDqzYF3buj88/+WOU5NbifmzecMIDFyI6PuBDuv6Jllg2a7xAAJ280apn1eb5UoNBZJzMjmZpU61hEEEY9jyPPBvUsoguKMXHuuRtE8AFrcj47xnhhZBpwoow1v7wPx9obLivqr/+c/LR5NKRrDJjYS2QzqoVfQdmYYdkkO9LCPCCPPXYthVjy8Llpp60TGktGSIVgNMNx7gPMhP38jYWqaUA/Cg5bYJRGSrTRZDaOHqWDxrfhGkH9dxdNomc95tTGB3ZYJVp5KL7sQ7xz3HRItvI7lmgYztzCkztLZKjiLSdCgT9cD4eFem9QthGj77YR2MlJ21y7LRr4Edi+Z9ZqcFY51uCNuK/g5rlfuRDYdh0GYZwryJY89ggdmZWjwQ0qSimsdUSCZkPX2vrFgGjtoLCZAS8DGGwnX1U+PhfVg0G9p1vdZt4bMhZtZDocSdCpcz1j1++QevUkChsWRlJpI4h9DnQdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8550.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4326008)(8676002)(8936002)(86362001)(83380400001)(5660300002)(41300700001)(33656002)(38100700002)(2906002)(82960400001)(6916009)(122000001)(6512007)(2616005)(316002)(91956017)(66946007)(66476007)(38070700009)(76116006)(66446008)(54906003)(64756008)(66556008)(6506007)(55236004)(71200400001)(6486002)(26005)(478600001)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEc3cEV3bVpJaWd1L1hWN3hndXcwOWw0ODZuWlQ3dDkydUZNaEg1TDRaTDRC?=
 =?utf-8?B?YVhqUHpxT2UvaE1tVzdTU1ZveDlTZzVucUVWMlRnQjlJN2djSWdrbGZ0OTJx?=
 =?utf-8?B?bm9ZUkNHVHY3ejRPcFo3VjBkTzZ4MzZiWDN5b3E3TDhkN3pvdGxuejZaMWhI?=
 =?utf-8?B?MFVSNC8zN2E1a1pPSWZndmdTaGpUS25xUWF0NTFrT2NiTFJQY0RId3QvOHUr?=
 =?utf-8?B?dW5JZnBtcjdhdWVZWUwxUW1QOWEzSDh3M3RrQmxsZjJUcDM3UlU4dkdGcEow?=
 =?utf-8?B?NTZsSkdRbnFvTGZUSEVmVklZNEJLaEw4UlQ5SEFCanBZSVFCcDRGVVBUa3ZZ?=
 =?utf-8?B?MFVVaHUzbUN5R3d3cTNESlJiVGN2STBuaDFkZ3VtdTFhdml3cDk4bFlPOXBy?=
 =?utf-8?B?MVhMeDVKTnh5ZzdMcWtDU0N1Z05QYWZUcW5kVUN6VS9FOUFJSmZoN3c2NzdI?=
 =?utf-8?B?bGZ4OHJ1eHJFOGthRVRhQ0RuTklSTkZEZHFtdDZ2L3JZYnlza3VROGhyd29U?=
 =?utf-8?B?MkFJZitMV21Xd0x6VkVzbnJKeUFwZmFERXI0cGdDOWpIQnF5bis2eWdieUhD?=
 =?utf-8?B?WjRpdDhTTSticmp6OXFRRWxMNDhUQTczYU5ZYlVjRmV1eVpyZkk3WStOVE9k?=
 =?utf-8?B?eWd2QWhpQVU1VEszQVY5aE9WZFNmSDFEcEIvMHRnSExMaDFoQS8xWVVlQ2pF?=
 =?utf-8?B?TUhLTmlmZU90dGRyODZpck9TWFV1RzB1b2Rldk5tTHA3MGZCazl0UzlLWTU1?=
 =?utf-8?B?bmpFY1BkKzBacmFOeHpMdm5zdjJRa0tBR0tDUmFZbHVXMyt6Z1FWcDR6QWg0?=
 =?utf-8?B?dHlXZGZKYW9yNUQ1bWNMSjE0eWR5cHRieEJMczJHMk5LWWpGRDUzQXRDQmZF?=
 =?utf-8?B?SGtpaXNqSVVrOHI3T0dCYlQ4UUQ3R2xCK0dzbGRXanhFblg0ZnhhaTVwZDVj?=
 =?utf-8?B?TjczMzhFdGpNVjNlVjdkRHVYbGplcjVNRkFJU2V3WURIcFg3QVBJMlJEb0dl?=
 =?utf-8?B?dGNTbGpZODJHVmJZamhrMGV3RUVydjkrckRaSm0rQ1MrZEl3RmJGd2VFOWFG?=
 =?utf-8?B?ckUwRys4ekxtZHREZSsvdldGRkdnRXMwRTgxaFFrLzlNdkxkYWRKTWw3VWJX?=
 =?utf-8?B?UmdXbWlBaDlEQ2dLa3lHOTVDNTZMOFU0Z0ppbzRKMVFsa0VpekY2TXdjQnhP?=
 =?utf-8?B?cmRpdU95dE9lbHE3SGJ0bmRmMGNOcHdnZlErOEh1UmNEZlYxQTJ6UGlnZktY?=
 =?utf-8?B?NjljNlBESFJIa3dEa1pnSUdyRlZFVmZNeGg1dTBDVXNWNThCQWdtY2ptWFVu?=
 =?utf-8?B?V3lITkkwQkovVUNWdVZ5UFBKNzdobnFJZWxlVWw1bkFqejF1Ri83S1FXakNt?=
 =?utf-8?B?enBLZ0k4RkVkbFd4V0Zkd08wbkFFVUxTSFJZUVovdjFGM3UzT2hsL3FTNnBI?=
 =?utf-8?B?eHg3NjRuUTc2TVVnODNNTTQxZkpyY3RXczN3SG1tUFBUVHIxTjJ5aUVqcjFY?=
 =?utf-8?B?Z3N1RlgraTBBZVc5bm9ucHJZa2ZoakdvMFZRdGMxbS9RNStVcDRuSEFDRTBS?=
 =?utf-8?B?Vkd0TEJ1R1p4NTJTLzJmUk9uZmlJc3ltMGVSZFE4SllsWHUzVEh6bGg5MEVl?=
 =?utf-8?B?N1hvSGFCR1FmSTYwcFZqVDZTcXNHQUJpa2FWZ25TWW5tSk8vYUFNQlRnZUFI?=
 =?utf-8?B?Vm1VV2N6UUQwSDJieDhTUTdIaGhpTzZmTWZucktXRU53aCttdGhZbE5xRFg4?=
 =?utf-8?B?VDZIeU95ejE1cjcwSUJJL1dnQjRuMWZCdWdacUNTSjJ4ME95RW1OLy9KNXQ0?=
 =?utf-8?B?WjZaekI1Umc3bjVLT1I3VGhhNjJYV05TUndBaGVqYVAwRGxYRmFGS282SUpt?=
 =?utf-8?B?aFpyNE1tUDNuMDNoOHIzb3FXM24zbWxzMUc3OEtKdE51MlNDT3paQ2dtN0Vt?=
 =?utf-8?B?WVFTd25acjE1QnJMaklsMnVwUVAwTzcrd0V0Qnk2VnlvYjk5dGNyREcvVXZE?=
 =?utf-8?B?YjRLN0xHTEdqMUFVOGZwMFMvQmVQalgxRFVLeUQ3c3Byelk3NEtENDR4L0lZ?=
 =?utf-8?B?S3JhTENCUE50anhoWml2VG5JQzJMS2luYnc5S3pOajNoQmdMdk5VUFBNTVFX?=
 =?utf-8?B?MTlCMVovRzFEUTF5d1ZmdFZXRW5ONEszaE5YTEhyNW1MUlhBR25YNlpUK3Vp?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC01F321ABDDEE42BB295BDCBD8DB972@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8550.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dfaf77-0a17-4b98-c064-08dbe1369ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 15:14:47.5524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ligmnuuwUBgnz/6fbom/EbWX8wgH/RVN2neu9LcVFmLzjPq95XPFEfn5WJiB8BRh5d77oFbPUO/NdU9ALtEbCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10909
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

SGkgS2FyZWwsDQoNCndpdGggYWN0aXZhdGVkIOKAk2NvbnQtY2xvY2sgdGhlIGNsb2NrLnR4dCBp
cyBub3QgdXBkYXRlZCBpbiBtb3N0IGNhc2VzIOKAkyB0aGVyZSBzdGlsbCBjYW4gYmUgYSBmYWxs
YmFjayB0byB0aGUgY2xvY2sudHh0IHVwZGF0ZSAtIGFuZCB0aGUgWEZTIHJlZ3Jlc3Npb24gd291
bGQgbm90IGJlIHJlbGV2YW50LCB0aGF04oCZcyBjb3JyZWN0LiANCkJ1dCBhcyB0aGVyZSBoYXZl
IGJlZW4gZGlzY3Vzc2lvbnMgYW5kIGNvbmNlcm5zIGFib3V0IGF2b2lkaW5nIHRoZSBjbG9jay50
eHQgdXBkYXRlLCBJIHdvdWxkIGJlIGhhcHB5IHRvIGhhdmUgYSBzb2x1dGlvbiBmb3IgdGhpcyBj
b2RlIHNlcXVlbmNlIGFzIHdlbGwuIEl0IHdpbGwgcHJlc2VydmUgdGhlIGF2YWlsYWJsZSBsb2dp
YyB3aXRob3V0IHRoZSBYRlMvZnRydW5jYXRlIHJlZ3Jlc3Npb24gYW5kIGN1c3RvbWVycyBzdGls
bCBoYXZlIHRoZSBvcHRpb24gdG8gc3dpdGNoIGJldHdlZW4gYm90aCB2YXJpYW50cyB3aXRob3V0
IGEgcGVyZm9ybWFuY2UgaW1wYWN0Lg0KDQpDb3VsZCB5b3UgcGxlYXNlIGFwcGx5IHRoaXMgcGF0
Y2ggdG8gdXRpbC1saW51eD8NCiANCg0KTWljaGFlbA0KDQo+IE9uIDcuIE5vdiAyMDIzLCBhdCAx
MDozMywgS2FyZWwgWmFrIDxremFrQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gDQo+IE1pY2hh
ZWwsIGFueSBvYmplY3Rpb24gb3IgY29tbWVudD8NCj4gDQo+IEkgaGF2ZSBzZWVuIHJlcG9ydHMg
d2l0aCBYRlMgcGVyZm9ybWFuY2UgaXNzdWVzIHRvbywgYnV0IEkgZ3Vlc3MgaXQncw0KPiBwb3Nz
aWJsZSB0byBzb2x2ZSB0aGUgcHJvYmxlbSB3aXRoIHV1aWRkIGFuZCAtLWNvbnQtY2xvY2suDQo+
IA0KPiAgICBLYXJlbA0KPiANCj4gT24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMDY6MDg6NTlQTSAt
MDUwMCwgR29sZHd5biBSb2RyaWd1ZXMgd3JvdGU6DQo+PiBJbnN0ZWFkIG9mIGV4cGxpY2l0bHkg
dHJ1bmNhdGluZyBjbG9ja3MudHh0IGZpbGUsIHBhZCB3aXRoDQo+PiB3aGl0ZXNwYWNlcyBpbiB0
aGUgZW5kIG9mIGZpbGUuDQo+PiBUaGlzIGlzIGRvbmUgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZSBv
ZiBsaWJ1dWlkIG9uIHhmcw0KPj4gZmlsZXN5c3RlbXMuIEluc3RlYWQgb2YgdHJ1bmNhdGluZyB0
aGUgZmlsZSwgcGFkIGl0IHdpdGggd2hpdGVzcGFjZXMuDQo+PiBUaGlzIGlzIGFueXdheXMgdXNl
ZCBhcyBhIGZhaWxzYWZlIG1ldGhvZCBpbiBjYXNlIHRydW5jYXRlIGZhaWxzLg0KPj4gDQo+PiBU
aGUgcmVhc29uIHdoeSB0aGlzIHJlZ3Jlc3Npb24gd2FzIGludHJvZHVjZWQgd2FzIGJlY2F1c2Ug
b2Y6DQo+PiA4NjlhZTg1ZGFlNjQgKCJ4ZnM6IGZsdXNoIG5ldyBlb2YgcGFnZSBvbiB0cnVuY2F0
ZSB0byBhdm9pZCBwb3N0LWVvZiBjb3JydXB0aW9uIikNCj4+IA0KPj4gQW4gYXR0ZW1wdCB0byBt
b3ZlIHRoZSBjbG9ja3MudHh0IHRvIC9ydW4gKHRtcGZzKSBoYXMgYmVlbiBhdHRlbXB0ZWQgYmVm
b3JlDQo+PiBbMV0gYW5kIHdpdGggY29tbWl0IGFiMmU3ZGQxNyAoImxpYnV1aWQ6IG1vdmUgY2xv
Y2sgc3RhdGUgZmlsZSBmcm9tDQo+PiAvdmFyL2xpYiB0byAvdmFyL3J1biIpLiBUaGUgbGF0dGVy
IHdhcyByZXZlcnRlZC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogR29sZHd5biBSb2RyaWd1ZXMg
PHJnb2xkd3luQHN1c2UuY29tPg0KPj4gDQo+PiAtLS0NCj4+IGxpYnV1aWQvc3JjL2dlbl91dWlk
LmMgfCA5ICsrLS0tLS0tLQ0KPj4gMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNyBk
ZWxldGlvbnMoLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2xpYnV1aWQvc3JjL2dlbl91dWlkLmMg
Yi9saWJ1dWlkL3NyYy9nZW5fdXVpZC5jDQo+PiBpbmRleCA2MTllZjAxMzEuLjk3ZTJkZWM0ZSAx
MDA2NDQNCj4+IC0tLSBhL2xpYnV1aWQvc3JjL2dlbl91dWlkLmMNCj4+ICsrKyBiL2xpYnV1aWQv
c3JjL2dlbl91dWlkLmMNCj4+IEBAIC0yMjksNyArMjI5LDYgQEAgc3RhdGljIGludCBnZXRfY2xv
Y2sodWludDMyX3QgKmNsb2NrX2hpZ2gsIHVpbnQzMl90ICpjbG9ja19sb3csDQo+PiBzdHJ1Y3Qg
dGltZXZhbCB0djsNCj4+IHVpbnQ2NF90IGNsb2NrX3JlZzsNCj4+IG1vZGVfdCBzYXZlX3VtYXNr
Ow0KPj4gLSBpbnQgbGVuOw0KPj4gaW50IHJldCA9IDA7DQo+PiANCj4+IGlmIChzdGF0ZV9mZCA9
PSAtMSkNCj4+IEBAIC0zMjQsMTQgKzMyMywxMCBAQCB0cnlfYWdhaW46DQo+PiANCj4+IGlmIChz
dGF0ZV9mZCA+PSAwKSB7DQo+PiByZXdpbmQoc3RhdGVfZik7DQo+PiAtIGxlbiA9IGZwcmludGYo
c3RhdGVfZiwNCj4+IC0gICAgICAiY2xvY2s6ICUwNHggdHY6ICUwMTZsZCAlMDhsZCBhZGo6ICUw
OGRcbiIsDQo+PiArIGZwcmludGYoc3RhdGVfZiwNCj4+ICsgICAgICAiY2xvY2s6ICUwNHggdHY6
ICUwMTZsZCAlMDhsZCBhZGo6ICUwOGQgICAgICAgICAgICAgICAgICAgXG4iLA0KPj4gICAgICBj
bG9ja19zZXEsIChsb25nKWxhc3QudHZfc2VjLCAobG9uZylsYXN0LnR2X3VzZWMsIGFkanVzdG1l
bnQpOw0KPj4gZmZsdXNoKHN0YXRlX2YpOw0KPj4gLSBpZiAoZnRydW5jYXRlKHN0YXRlX2ZkLCBs
ZW4pIDwgMCkgew0KPj4gLSBmcHJpbnRmKHN0YXRlX2YsICIgICAgICAgICAgICAgICAgICAgXG4i
KTsNCj4+IC0gZmZsdXNoKHN0YXRlX2YpOw0KPj4gLSB9DQo+PiByZXdpbmQoc3RhdGVfZik7DQo+
PiBmbG9jayhzdGF0ZV9mZCwgTE9DS19VTik7DQo+PiB9DQo+PiAtLSANCj4+IDIuNDIuMA0KPj4g
DQo+PiANCj4+IC0tIA0KPj4gR29sZHd5bg0KPj4gDQo+IA0KPiAtLSANCj4gS2FyZWwgWmFrICA8
a3pha0ByZWRoYXQuY29tPg0KPiANCg0K
