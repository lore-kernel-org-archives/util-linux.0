Return-Path: <SRS0=5bNd=RW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F0BC43381
	for <util-linux@archiver.kernel.org>; Tue, 19 Mar 2019 07:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A820685
	for <util-linux@archiver.kernel.org>; Tue, 19 Mar 2019 07:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfCSHae (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:30:34 -0400
Received: from mailin.dlr.de ([194.94.201.12]:65046 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSHad (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 19 Mar 2019 03:30:33 -0400
IronPort-PHdr: =?us-ascii?q?9a23=3AAhnx3x0cnpafNyJ7smDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMSLvad9pjvdHbS+e9qxAeQG9mCs7Qc0qL/iOPJYSQ4+5GPsXQPItRndi?=
 =?us-ascii?q?QuroEopTEmG9OPEkbhLfTnPGQQFcVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBg?=
 =?us-ascii?q?vwNRZvJuTyB4Xek9m72/q99pHOfwlEniaxba5vJxiqsAvdsdUbj5F/Iagr0B?=
 =?us-ascii?q?vJpXVIe+VSxWx2IF+Yggjx6MSt8pN96ipco/0u+dJOXqX8ZKQ4UKdXDC86PG?=
 =?us-ascii?q?Av5c3krgfMQA2S7XYBSGoWkx5IAw/Y7BHmW5r6ryX3uvZh1CScIMb7S60/Vz?=
 =?us-ascii?q?a/4KdxUBLmiDkJOSMl8G/ZicJwgqBUoBO9qBJwzIHZe52VO+Fkc6/BYd8WWW?=
 =?us-ascii?q?hMU8BMXCJBGIO8aI4PAvIGMOhYtYbyvFoOogG4BQW2Ae3vyyVIhmTq0q06yO?=
 =?us-ascii?q?kuDAXG3BY6E90TrnvZtdP4P7oRX+Ct1KTE0CnPY+lL1Tr+54XEaA0trP+PUL?=
 =?us-ascii?q?5qbMbcx1EjGx7ZglmKtIDoPDyY2v4Qv2WV7OdsT/yjhm4opg1pvzSix8Mhhp?=
 =?us-ascii?q?PXio8VxV3I7yp0zJwrKdGlVEJ2Z8OvHoFKuCGALYR2R9svQ2RvuCkn1LILoY?=
 =?us-ascii?q?W7fC0WyJQ/wB7fduCHf5CI4h39UOaRJi91inxjdryxiBi88UiuxOr/WMezyl?=
 =?us-ascii?q?hGsiRInNbNuX0TzRDT686HSudn/ki7wzqAygTT6vteLU8pi6XXM58hwrgumZ?=
 =?us-ascii?q?oPqUnPAzP6lF/rgKKVeUgo4PWk5urkb7n8u5OROZd4igTkPaQvnsy/D/44Mg?=
 =?us-ascii?q?8LX2WD+eqzzqbs/UzjT7VMlPE4l6jZsIrBJcsHpq60GBJa0oI56xqlEjipzs?=
 =?us-ascii?q?wUnWMbI1JdZBKHk4/pNknNIPH5F/i/gE+hkC11yP/bPr3uGInNImLfn7fmeL?=
 =?us-ascii?q?Z381RcxxYrzdBD+5JUDakMIO/vWk/wsNzUFxs5Mw2yw+b6B9RwzZ0eWW2RDa?=
 =?us-ascii?q?+DKq/SskGH5vgpI+aSYI8ZojH9K+Iq5/T2l382hUcdfbW13ZsQcH23BO9mLF?=
 =?us-ascii?q?6bYXrrmNcBF3wHsRAlTOPxil2CViRTZ3CoU6In+jExEJimApvbRoCxnLyB2z?=
 =?us-ascii?q?+2HodXZm9aCVCBCnDod52aVPcKZiKSJdVhkiAeVbe/UI8hzguitAn+y+kvEu?=
 =?us-ascii?q?2Bri4KvJHLztV55+TP0xo18GowR5CAz2CJCmV1mH4YbyE50bo5okFnzFqHl6?=
 =?us-ascii?q?9ijKoLO8ZU4qYdfA4wNJfaic97Ecv5WirNes3PRFvwEYbuOi04Ut9km4xGWE?=
 =?us-ascii?q?16Adj31h0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E0BwDXmZBc/w2KuApjHQEBBQEHBQG?=
 =?us-ascii?q?BZQKCZoFFhAGVU5othHkCF4RmOQUMAQEDAQEJAQMCAQECgRGCOiKCcAEBAwE?=
 =?us-ascii?q?jEUUFCwIBCBoCJgICAjAVEAIEAQ2FFalhgS+FRoRZIoELJAGNRoERgxKFAR2?=
 =?us-ascii?q?CbYJXA4xgmAcHAoEmkh6BbAGJIIhQiwyVCkmBLnGDPJBKigiBHwEB?=
X-IronPort-AV: E=Sophos;i="5.58,497,1544482800"; 
   d="scan'208";a="15058078"
From:   <Fabian.Kirsch@dlr.de>
To:     <kzak@redhat.com>, <util-linux@vger.kernel.org>
CC:     <asbjorn@asbjorn.st>, <rick@openfortress.nl>
Subject: Re: script(1) plans
Thread-Topic: script(1) plans
Thread-Index: AQHU3YmXu7/7liBEt0uq/1uu3xKSwqYSf9sA
Date:   Tue, 19 Mar 2019 07:30:24 +0000
Message-ID: <1552980724.5643.12.camel@dlr.de>
References: <20190318125322.4obb27vwtxfuwuie@ws.net.home>
In-Reply-To: <20190318125322.4obb27vwtxfuwuie@ws.net.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <87F02561D39BC0479BEDFE048D9EDB41@dlr.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

DQo+IEknZCBsaWtlIHRvIGltcHJvdmUgc2NyaXB0KDEpIHRvIGJlIG1vcmUgZmxleGlibGUgYW5k
IHN1cHBvcnQgbW9yZQ0KDQpIaSwNCg0KSU1ITyBzdHJhY2UoMSkgbmVlZHMgYW4gYWRkaXRpb25h
bCBvdXRwdXQgZm9ybWF0IHdoaWNoIGlzIGRlc2lnbmVkIGZvcg0KZnVydGhlciBwcm9jZXNzaW5n
IGluc3RlYWQgb2YgZXllLWJhbGxzLg0KQW5kIHRoZW4gc2NyaXB0KDEpIGNvdWxkIGJlY29tZSBv
bmUgb2YgdGhlIGZpbHRlcnMgd2hpY2ggY29vayByYXcNCnN0cmFjZS1sb2dzIGludG8gdGhlIGZv
cm1hdCB3aGljaCBmaXRzIGl0cyBwdXJwb3NlLg0KDQpPdGhlcndpc2Ugc2NyaXB0KDEpIHN0YXJ0
cyB3YWxraW5nIHRocm91Z2ggdGhlIGRlc2lnbiBzcGFjZSB0b3dhcmRzDQpzdHJhY2UoMSksIHdp
dGhvdXQgZmFjdG9yaW5nIG91dCB0aGUgY29tbW9uIHBhcnQuDQoNCkdyZWV0aW5ncw0KwqAgRmFi
aWFuDQo=
