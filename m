Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F60AC433F5
	for <util-linux@archiver.kernel.org>; Fri,  6 May 2022 02:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238954AbiEFDBw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 5 May 2022 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234102AbiEFDBv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 May 2022 23:01:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2047.outbound.protection.outlook.com [40.92.41.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EB5C84A
        for <util-linux@vger.kernel.org>; Thu,  5 May 2022 19:58:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW9O26byKuPm4dgoOjDGdp2Bmxm2Fm3rJI2ZTZxVd1r49BtcemBdUfK4DaTRUXkjIK/0mViR8hUsFLPodGwP5Q/bWiGR3IcFAbfM3QwXuLzpHRoT/U1+YYt6I8ndknue+9+DNDQNuTLzsW6ZFQQ+ooF/6idDHNz+UNsowbxph+wMmGSD7sd/eMzln3TTzFuWKUOfJtG2aXBpWysFQTqv3RKXaI3rTSIbAIw/xvhdO/1NFrIeJqDobo5C6WdVCOn1wL4LJCNivgYMe9jhWTSfKSyjbIMFTrDO/kw5tjCREt7r2LdtHbeEakurx7Zz+1Q5N7Z0/+2V7+Q88yMr1oHvyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxLrU8LBp/B8jexg/dyjRq1OlTCeCE+f9ON8UzYET8I=;
 b=PC5AFq1aeeA3u7IqrU2M+SVmoGuhAJatEtL+/Qp3TdkQCtTpJhCA260TRlD5yfm3E/hcmJ4mfM/UNwnAxsDpRCa8ydTz5H4ba2PelBcN4H3TWHH8zp+k9+PbFcPwrNAa0z2VFcOuVLEt6IyVh42qxZ0WpMVwmzvWraCLY9u4h8FclZRIbFJCVf4Ai4k2yVSG8DS7F5DuzqkEaKPFH3jCox2f7pcrQyn4Oax1AujSlKe/wfnMOcoUF5bzUPsdCR13GI1HjB1NxgFPWzDOC/RBOfs0+Bv0dO1TvKcTEcv38mJhsixoC4ScBH29inaXFoZ0gaa6Fu/aMjpGl79KjVfP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxLrU8LBp/B8jexg/dyjRq1OlTCeCE+f9ON8UzYET8I=;
 b=kzKBxZNLv4BLj13DAGC2XygNeWHI20TIGJ1kFWcRZ+er9X9unXBCFrkVesvB49MCydL9Hz436VzKQsglaYI7LOeXxDCyc2azzYDV3DOex7g157RtqBgmz8KROHHh5QvkxwWWuVdQi7KEzxumVaWkldLhu1Tpf9H8RYd+Fo0JAFoYXDQxn3JBOtDQqtPUDv7uVWlRh5FA3TaQ0ocahyrQoYvC3qKUPQ77sAE9IjiuKIULF+BBYUiIXKUGmCTc1KMjAh3FE0YStjHq3+72lEOce5jI6v9EblxiH9fqXLmtGozo+F3KVLpm0pH1lOemu3izeaB+zip+XD9NP1wioUZi9A==
Received: from SN6PR04MB3983.namprd04.prod.outlook.com (2603:10b6:805:4c::19)
 by SJ0PR04MB7551.namprd04.prod.outlook.com (2603:10b6:a03:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Fri, 6 May
 2022 02:58:07 +0000
Received: from SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::252a:967b:ebf:733a]) by SN6PR04MB3983.namprd04.prod.outlook.com
 ([fe80::252a:967b:ebf:733a%4]) with mapi id 15.20.5186.028; Fri, 6 May 2022
 02:58:07 +0000
From:   Nathan Sharp <nwsharp@live.com>
To:     Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: [PATCH RFC 1/4] misc-utils: add the pipesz utility
Thread-Topic: [PATCH RFC 1/4] misc-utils: add the pipesz utility
Thread-Index: AQHYTioho9SQQuzzfEeMH5YyyfBB1a0OrTYAgAKd+po=
Date:   Fri, 6 May 2022 02:58:07 +0000
Message-ID: <SN6PR04MB3983208E1DE062616C7DCB44C2C59@SN6PR04MB3983.namprd04.prod.outlook.com>
References: <20220412045930.236051-1-nwsharp@live.com>
 <SN6PR04MB3983957C75B4FF779E3D611CC2ED9@SN6PR04MB3983.namprd04.prod.outlook.com>
 <20220504105030.tqswjfqezivnodgb@ws.net.home>
In-Reply-To: <20220504105030.tqswjfqezivnodgb@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: c3707027-b2fe-7652-37a0-f674d2150e28
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/aBRHQk18nulfyaY9eYNc+j5BCYpx38t]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f06830-5fd4-44bd-3a8c-08da2f0c3f1e
x-ms-traffictypediagnostic: SJ0PR04MB7551:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gvd/k/oB9nElAr/zv6mJ5oMG5ffowmNj4FO8GI9Ve45ZwzpQtJ3xOn1uZ9YaecTWlkopPBKpuGQ7bVXBr+64tYMeGFJSWohuyNlR4pN2OMSYzWdIG/8ksY60OvsHsQ7wVHfy9VyDu4qHJpneBjH5ZOIn1frzsQj7vi/Hqz6AqzX8aYCmQqAkczey3WXNAt8DQhPIr5W3J76/85/IBSFiWpy9iXO5hp3E1ILcRGLuRaYYgGgkLvaGFPF/4Ljy6hxRbzEOHl+n3DnfLWHzgquVKUlTsRt3yFVsjE/nIUlCCBnFaOmNcnN9ybVw5JhfIalTg6kGbjYlrPfTTeQtkI2UqSpAzJdg86UQLnkDqqmAotaRM3rumED0YZuYSGGWzHO0Eo972ZsqvOzYDtu/5Sbie6UUvFNGIpHLFMJ1g8IK3i6AMve06F7J49SlSLehT0Wns+yMwNoeiGC5eKno8bRHw6M0zv+w3/hpizAcddHzL2kvNfgSjkw424EVx/sqtNQ7naX+Vbj4uG0sFU1fkVh9+QiFyfVxM4lKZPTcX5vWzkBAy64DCZ8E9EZweAeBoIF7vYJm5PEc019YgiMLxjnGMdTFpUg+xuMx6hFWeUZF7Se0QQ3HZJsBZPAhcxfFMVaKZZxOe2+zbo9PkGxNJ6gffQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmVDNWxEOEpuVDBaYlU2Tms2SDE4aDgweUJrR3dwemRqYjhwd2tzR2JmWnZP?=
 =?utf-8?B?ekU2d3REaXd0TmdtWWFlb2piNHA1R1M4QStLZVJva0dIU3l6ZmJIUysyTzhi?=
 =?utf-8?B?SUxnWVJFZFN3QXBPNTA0STViTU1oTzlNY0ZuYVh0Q2hGUzQ1V2ZRZTZCY2NN?=
 =?utf-8?B?WTJIVStMNktJcitLcURhRktRYWJKa05xQWpDUVFWa2dwbFAvaHhSSzlnUEkr?=
 =?utf-8?B?QkFNNnR2UWdnNjdQbGtaVko0a3F0ckQ1bHBqTmxabFpRZ3NIUUMwUVdzazFI?=
 =?utf-8?B?VUZseWRveW5lLzZZZDRrYVcwVmNtQTFicGNuSkpIc2dnd1k0OFpNY080RmVn?=
 =?utf-8?B?RzVzTUlhY3BNMHNsclV4RVNLc2QzbHg0RDhhZzhpQ3VYMnBiWStlT2FuNGQ2?=
 =?utf-8?B?cFFjUmF6NVBUempUaHVocGphTWlvZWlGd25ZWlZ4RFNxeUozZFlOWk91OHps?=
 =?utf-8?B?eWVVWDdhYlNoQWNNeXMyN3R1K1NTMnZ0RVcveVc5ZW9DMFdlam1iU0ZwdXBp?=
 =?utf-8?B?QjRGQzU1UmJZTXMwWGhGRDkzYW9nNlMwMmorOFIvQXYySUtIUmZ2NzIwamVL?=
 =?utf-8?B?cjZQZkpVL3h1clVWT2lKaGhIQ3diaDQrZ1FTTE1PZW80MkQ3MGdndWhHZmdS?=
 =?utf-8?B?ekRCRlZEMldZZ0phZmhPVXZBdlVJZlBTMWs4SEpPOGFzTUZLQmlTWUFRVlpU?=
 =?utf-8?B?bnVXSmkzTHo3cTZjVysreldzSjNlVnowdUN4N3IvcXZJYnZBNFVlbHpIRzdK?=
 =?utf-8?B?aC9mNHRZWis2NWNkbU0xQzB4Y0pqLzljUVpKc2g2S29RUVd1YlRKUHJNajFF?=
 =?utf-8?B?TGo5Tmo0cUFCUHAxUXVDS0lHOEhmcW1yRFRZSDdtS1pFU2Z1MDZaRTFUM2lE?=
 =?utf-8?B?S0FDRjBwTHAwUW9xSzdac244ZkdINDhkSFhTaXhwem92RSt5ck5pRHdQU3BF?=
 =?utf-8?B?VkFrRElhRWljUjI0TVJQbUJXcGNIN0pCdGhET3FwcUJwSTdaaFNRejFKUG9u?=
 =?utf-8?B?WjBUajVhNWEwRnIwcjJyWi81ak5kNUxHM1gvQjZtRzRETVdwMWttWXdiN2tG?=
 =?utf-8?B?aG5pR00yL3pVRzBSS3hSUjdubDlRZExhWHorRTdIU2FZOUk2Qjc3cjJSTjEy?=
 =?utf-8?B?Tlp2VGk1cWhvOUVRMjBuLzYxOVd1V05ya1o2STN1aGJET2ZvN1Y0bTB5SS9Q?=
 =?utf-8?B?aWxCa1BEc3FHQ3ZQYlFGL0VzVzBzWlZvR3dTMmRoYkI5VlJyYUJTemI0T2c1?=
 =?utf-8?B?RWNaVmk2dFc1cU5sK0JvL0Z0dGNpa2pUVWtKNmRxdXhuR3hXK2xyaEdpWEox?=
 =?utf-8?B?T1NjWWdMTVZweG5jVDZ4cytYQ3NKSFl0TllNVWFZVEVubDZHU0RxTTdtOGUr?=
 =?utf-8?B?NUJNVSs3Qy9XL00vWXQrL1d3cER4VlhLRDNKV21nd0dLQVVpL2dnOFJIQmtn?=
 =?utf-8?B?c2dtbk50dkYwMWNla2FibytWV0xObHpOVG5WK3ZjSXNpZlhTYy92aktoWlBj?=
 =?utf-8?B?RVZnOTJrM1VGSWZvTGllQTdTcVN5ZlBhWGNxY3JKSjUzaWdodkZQTFhsSzEv?=
 =?utf-8?B?L3o5N0JPSXQrRG9XSG14WFF1a2tBbk9TTjRXUUo0MTE0N2FZNVd4NVJzbExW?=
 =?utf-8?B?SjNIYjFydjR3bVdORFVlY1ZxNUZXdlZ3OEx3TEFOZEEzUDdJbzkrdFFsYUFD?=
 =?utf-8?B?TmNuQ1gxWVdvRHBoV29XOFBxU0R5NTdsdHlOMFJ2bEN0dS9wQ0x6V2gwV2xM?=
 =?utf-8?B?SzVVbmR0anM2bjd3eGp0QzV4clhRaVU3Q2F0dXo2V0prWHBieUtKY1dXS2wz?=
 =?utf-8?B?SVRNQ1JqbGRrRDcwemxrMEJnMDFGN0RoL0hGTjZ5cVJGaWE1R1hpdXRYU3dV?=
 =?utf-8?B?UGZxWlRJVTg5alN6MmxCZDlSd3ZpZHVJM2xidlYwdmVsTlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB3983.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f06830-5fd4-44bd-3a8c-08da2f0c3f1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 02:58:07.0936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7551
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

VGhhbmsgeW91IGZvciB5b3VyIHJldmlldywgS2FyZWwhIEkgYXBwcmVjaWF0ZSBhbGwgb2YgeW91
ciBmZWVkYmFjay4KCj4gV291bGQgYmUgYmV0dGVyIHRvIGJlIHBhcmFub2lkIChhcyBleHBlY3Rl
ZCBieSAtLWNoZWNrKSBieSBkZWZhdWx0IGFuZCBpbXBsZW1lbnQgLS1mb3JjZSBmb3IgY2FzZXMg
d2hlbiB1c2VyIHdhbnRzIHNvbWV0aGluZyBjcmF6eT8KClRoZSBtYW5wYWdlIHRhbGtzIGEgYml0
IGFib3V0IHRoaXMuIHBpcGVzeiBpcyBkZXNpZ25lZCB0byBiZSBvcHBvcnR1bmlzdGljIGJ5IGRl
ZmF1bHQgaW4gb3JkZXIgdG8gYXZvaWQgYW5ub3lpbmcgdXNlcnMgdGhhdCBhcmUgdHJvdWJsZXNo
b290aW5nIHRoZWlyIHBpcGVsaW5lcy4KCkZvciBleGFtcGxlLCB3aGVuIEknbSB3b3JraW5nIG9u
IGEgc2NyaXB0LCBJJ2xsIG9mdGVuIG5lZWQgdG8gY3V0IGl0IHVwIGludG8gcGFydHMgYW5kIGR1
bXAgaW50ZXJtZWRpYXRlIGRhdGEgdG8gdGhlIHRlcm1pbmFsIG9yIHRvIGEgZmlsZS4gU28sIGlm
IEkgc3RhcnQgd2l0aCBhIHNjcmlwdCBsaWtlICJhIHwgcGlwZXN6IGIgfCBjIHwgZCIgYW5kIHJl
YWxpemUgdGhhdCB0aGVyZSdzIHNvbWUgcHJvYmxlbSB3aXRoICJiIiBJIG1pZ2h0IGVuZCB1cCBy
dW5uaW5nICJhIHwgcGlwZXN6IGIiIGF0IG15IHRlcm1pbmFsIG9yIGNvbW1lbnRpbmcgb3V0IHRo
ZSAifCBjIHwgZCIuIElmIHBpcGVzeiB3ZXJlbid0IGxlbmllbnQsIGl0J2Qgc3BpdCBvdXQgYW4g
ZXJyb3IgYmVjYXVzZSBzdGRvdXQgaXMgbm93IGEgdHR5LiBTbyBub3cgSSd2ZSBnb3QgdHdvIGFu
bm95YW5jZXMsICJiIiBpcyBicm9rZW4gKmFuZCrigIsgcGlwZXN6IGlzIHdoaW5pbmcuIEluY2lk
ZW50YWxseSwgdGhpcyBpcyBob3cgcGlwZXN6IHdhcyBvcmlnaW5hbGx5LiBJIGRpZCBub3QgbGlr
ZSBpdC4KClRoZXJlJ3MgYW5vdGhlciBtb3JlIHN1YnRsZSByZWFzb24sIHRvby4gSSBkb24ndCB0
aGluayB0aGF0IGZhaWx1cmUgdG8gcmVzaXplIGEgcGlwZSBpcyBhIHJlYXNvbiB0byBtYWtlIHNj
cmlwdHMgc3VkZGVubHkgc3RvcCB3b3JraW5nLiBJZiB5b3VyIGJveCBpcyBsb3cgb24gbWVtb3J5
IG9yIHlvdSdyZSBuZWFyIHBpcGUtdXNlci1wYWdlcy1zb2Z0LCB5b3UnZCBwcm9iYWJseSB3YW50
IHRvIGlnbm9yZSB0aGUgZmFjdCB5b3UgY2FuJ3QgZ2V0IDEgbWVnIGZvciBhIHBpcGUgcmlnaHQg
bm93IGFuZCBqdXN0IGhhdmUgeW91ciBzY3JpcHQgcnVuLiBJZiB5b3UgcmVhbGx5LCByZWFsbHkg
Y2FyZSB0aGF0IHlvdSd2ZSBnb3QgeW91ciBwaXBlcyBhbmQgdHR5cyBhbmQgZmlsZXMgYW5kIHNv
Y2tldHMgYW5kIHJlc291cmNlIGxpbWl0cyBzdHJhaWdodCwgdGhhdCdzIHdoYXQgLS1jaGVjayBp
cyBmb3IuIEkgdGhpbmsgdGhhdCBmb3JnZXR0aW5nIHRvIHNwZWNpZnkgLS1mb3JjZSBpcyBhIGZv
b3RndW4ganVzdCB3YWl0aW5nIHRvIHRha2UgZG93biBhbiBvdmVybmlnaHQgYmF0Y2ggam9iLgoK
SWYgeW91IGRvbid0IGZpbmQgdGhpcyBhcmd1bWVudCBwZXJzdWFzaXZlLCBJJ2xsIHN3aXRjaCB0
aGUgc2Vuc2Ugb2YgLS1jaGVjay8tYyB0byAtLWlnbm9yZS8tdCAobGlrZSBpb25pY2UsIHNpbmNl
IC1pIGlzIHRha2VuKSwgYXMgcmVxdWVzdGVkLiBJIGZpbmQgLS1mb3JjZSBtaXNsZWFkaW5nLCBi
dXQgSSByZWNvZ25pemUgaXQgaXMgbG9uZy1zdGFuZGluZyBjb252ZW50aW9uIGFuZCB3aWxsIGRv
IHRoaXMgaW5zdGVhZCBvZiAtLWlnbm9yZS8tdCBpZiB5b3UgaW5zaXN0LgoKPiBXaHkgd2UgbmVl
ZCBtdWx0aXBsZSBnZXRvcHRfbG9uZygpIGJsb2Nrcz8KCkkgaGFkIGEgZmVlbGluZyB0aGlzIHdv
dWxkIGNvbWUgdXAuIEkgc2hvdWxkIGhhdmUgdGFsa2VkIGFib3V0IHRoaXMgaW4gdGhlIGNvdmVy
IGxldHRlci4gSSBoYWQgYSBzaW5nbGUgYXJndW1lbnQgcHJvY2Vzc2luZyBsb29wIG9yaWdpbmFs
bHksIGJ1dCBpbiB0aGUgZW5kIEkgZmVsdCB0aGF0IGl0IHdhcyBub3Qgd29ydGggdGhlIHRyYWRl
LW9mZnMgaW52b2x2ZWQuCgpJbiBteSBtaW5kIHRoZXJlIHdlcmUgNSBpbXBsZW1lbnRhdGlvbiBz
dHJhdGVnaWVzIEkgY291bGQgY2hvb3NlOgoKKDEpIFJlcXVpcmUgLWMvLWcvLXEvLXYgdG8gcHJl
Y2VkZSBvdGhlciBhcmd1bWVudHMsIHNvIHdlIGhhdmUgYWxsIHRoZSBpbmZvcm1hdGlvbiB3ZSBu
ZWVkIHRvIHByb2Nlc3MgdGhlIG90aGVyIG9wdGlvbnMgaW1tZWRpYXRlbHkuIFRoaXMgaXMgbm90
IHZpYWJsZSBmb3IgYSBudW1iZXIgb2YgcmVhc29ucyB0aGF0IHNob3VsZCBiZWNvbWUgYXBwYXJl
bnQgcXVpY2tseS4KKDIpIFNxdWlycmVsIGF3YXkgLWYvLW4gYXJndW1lbnRzIGludG8gYSBsaWtl
ZCBsaXN0IG9yIHhyZWFsbG9jJ2luZyBhcnJheXMuIFRoaXMgYWRkcyBtYW51YWwgbWVtb3J5IG1h
bmFnZW1lbnQsIGJvb2trZWVwaW5nIHRvIGtlZXAgdmFsZ3JpbmQgaGFwcHkgb24gZXhpdCgpLCBh
bmQgYW4gT09NIGZhaWx1cmUgY2FzZS4gSSBjaG9zZSBhIGxpc3QsIGFuZCBpdCBlbmRlZCB1cCBi
ZWluZyBhYm91dCAxLzMgb2YgdGhlIHRvdGFsIGNvZGUgdXNpbmcgImxpc3QuaCIgYW5kICJ4YWxs
b2MuaCIuCigzKSBTcXVpcnJlbCBhd2F5IC1mLy1uIGFyZ3VtZW50cyBpbiBmaXhlZC1zaXplZCBh
cnJheXMuIFRoaXMgaW50cm9kdWNlcyBhIHZlcnkgc21hbGwgYW1vdW50IG9mIGJvb2trZWVwaW5n
LCBidXQgYWxzbyBhIGJpemFycmUgZmFpbHVyZSBtb2RlIHNob3VsZCBzb21lb25lIHRyeSB0byBo
YXZlIHRvbyBtdWNoIGZ1biB3aXRoLCBlLmcuLCB4YXJncy4gQWxzbywgaXQgd291bGQgZW5kIHVw
IGNoYW5naW5nIHRoZSBvcmRlciBvZiBvcGVyYXRpb25zIHVubGVzcyBkb25lIGluIGEgbW9yZSBj
b21wbGljYXRlZCB3YXkuCig0KSBPbmx5IGFsbG93IGEgc2luZ2xlIC1mLy1uIGFyZ3VtZW50IChw
ZXJoYXBzIGluIGFkZGl0aW9uIHRvIC1pLy1vLy1lKS4gSSBiZWxpZXZlIHRoaXMgaXMgd2hhdCB5
b3UgcHJvcG9zZWQuIFRoaXMgY291bGQgbGVhZCB0byBzb21lIGFubm95aW5nIHJlcGV0aXRpdmVu
ZXNzIGluIHNvbWUgY2FzZXMuIEFkZGl0aW9uYWxseSwgaXQgd291bGQgY29tcGxpY2F0ZSBkb2N1
bWVudGF0aW9uIGlmIHdlIHBlcm1pdHRlZCBjb21iaW5pbmcgLWYvLW4gd2l0aCAtaS8tby8tZS4g
T3IgbGVhZCB0byBldmVuIG1vcmUgc3R1dHRlcmluZyBpZiB3ZSB3ZW50IGZvciBtYXhpbXVtIHNp
bXBsaWNpdHkgYW5kIHRvb2sgb25seSBvbmUgb2YgLWYvLW4vLWkvLW8vLWUuCig1KSBTY2FuIHRo
ZSBhcmd1bWVudCBsaXN0IG11bHRpcGxlIHRpbWVzLiBUaGUgZG93bnNpZGUgaGVyZSBpcyB0aGF0
J3MgaXRzIHVuY29udmVudGlvbmFsLiBIZXJldGljYWwsIGV2ZW4hCgpZb3UgY2F1Z2h0IG9uIHRv
IHRoaXMsIGJ1dCBvcHRpb25zIDEtNCBhbHNvIGFubm95IHBlb3BsZSBsaWtlIG1lIHdobyByZXNw
b25kIHRvIGludm9jYXRpb24gZXJyb3JzIHdpdGggIlt1cCBhcnJvd10gLS1oZWxwIiBpbnN0ZWFk
IG9mIHVzaW5nIHJlYWRsaW5lIHNob3J0Y3V0cyBvciBzaGVsbCBoaXN0b3J5IGV4cGFuc2lvbi4K
Ck9mIHRoZSBvcHRpb25zIGFib3ZlLCBleGNlcHRpbmcgNSBvZiBjb3Vyc2UsIEkgbGVhbiBoZWF2
aWx5IHRvd2FyZHMgNC4KCj4gVGhlIHJlc3Qgc2VlbXMgZ29vZC4KClRoYW5rIHlvdSEgTGV0IG1l
IGtub3cgd2hhdCBjaGFuZ2VzIHlvdSdkIGxpa2UgdG8gc2VlIGFuZCBJJ2xsIHdoaXAgdXAgYSB2
MiEKCkJlc3Qgd2lzaGVzLAogICAgLSBOYXRoYW4gU2hhcnA=
