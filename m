Return-Path: <SRS0=HbcR=QU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E06C282C2
	for <util-linux@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED57222C1
	for <util-linux@archiver.kernel.org>; Wed, 13 Feb 2019 14:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbfBMO4Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:56:24 -0500
Received: from mailin.dlr.de ([194.94.201.12]:50732 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732032AbfBMO4Y (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 13 Feb 2019 09:56:24 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Feb 2019 09:56:18 EST
IronPort-PHdr: =?us-ascii?q?9a23=3AS5unSR+4ODNcsf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B30u8cTK2v8tzYMVDF4r011RmVBdWds6oMotGVmpioYXYH75eFvSJKW713fD?=
 =?us-ascii?q?hBt/8rmRc9CtWOE0zxIa2iRSU7GMNfSA0tpCnjYgBaF8nkelLdvGC54yIMFR?=
 =?us-ascii?q?XjLwp1Ifn+FpLPg8it2O2+557ebx9UiDahfLh/MAi4oQLNu8cMnIBsMLwxyh?=
 =?us-ascii?q?zHontJf+RZ22ZlLk+Nkhj/+8m94odt/zxftPw9+cFAV776f7kjQrxDEDsmKW?=
 =?us-ascii?q?E169b1uhTFUACC+2ETUmQSkhpPHgjF8BT3VYr/vyfmquZw3jSRMMvrRr42RD?=
 =?us-ascii?q?ui9b9mRh/2hikaKz43/mLZis1sg6xUrx2svAB/zJXObY2JKPZyYqHQcNUHTm?=
 =?us-ascii?q?RBRMZRUClBD5u7YoUPFeUOJudYoJP7p1cUqBW+BBOsBPjzxT9InXL5wKk60/?=
 =?us-ascii?q?47HQ7bwgMtBtQDu2naotXyMacdS+G1zK/QwDrZa/NWwTb96I7WfRAloPGMW6?=
 =?us-ascii?q?9wcMXLxUkoDQPFgVOdopHmMTONzukBrnSX4/B9We+shGMrsRx9rzasy8s2l4?=
 =?us-ascii?q?XFmJoZxk3Y+Slj3Yo4JtK1RFRmbdOqE5ZcrT+WOot5T886Xm1luSI3xqcYtZ?=
 =?us-ascii?q?O7cyUG0psqywTCZ/GGcYWF5A/oWvyLLjdinn1lfaqyhxO18Ue91OLxTtK00F?=
 =?us-ascii?q?NWripdldnMq2wN2wTT6seZTvt9+V+s1ziJ2Q7d5e9KIUA6m63YJZAm2LA8io?=
 =?us-ascii?q?Qfv0vCESLogkn2jamWdlk++uey8ejof7HmpoWGO4BplA7yKqUumsqhDuQkKg?=
 =?us-ascii?q?UCQnSX9f6h2LDg8kD1WqhGg/M1n6XDrZzWO9wXpqujDA9U1oYj5Qy/DzCj0N?=
 =?us-ascii?q?kAnXcINklKeBOdgIjvIV3AJfH4De2kg1uwkDdm3O3JPrn7ApnXM3fMjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opJCrEdIfLzXlb9tNjZDh8/Lgy1zP3qCMty1owAQ2KDGK?=
 =?us-ascii?q?yZP73IsV+O+O0vJ/OAZIgPuDbyeLAZ4Ku6kGM4nRoZfK+0zbMJZ32iWPdrOU?=
 =?us-ascii?q?OUZTzrmNhXQkkQuQ9rGMLjglyLV3hwZmypVKIU6jUhTo6rW9SQDruxiaCMiX?=
 =?us-ascii?q?/oVqZdYXpLXwiB?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FLDABELWRc/wyKuApjgheCWhGBKgq?=
 =?us-ascii?q?De5lflE4jgVgyCYQ+GYNlNAkNAQMBAQIBAQIBAQKBBQyCOiIcgQsBAQEBAQE?=
 =?us-ascii?q?BAQFNAg2BDRFXASICJgIEMBUSBIM3AYIQqUmBL4QvAYVZIoELjU+BEYVWglo?=
 =?us-ascii?q?wgjyCVwKjJwcCgR+GG4syilKIHAGJZoYQjhRhgS5xgyEaCYJJiEyFP3IBAQE?=
 =?us-ascii?q?Bjl2BHwEB?=
X-IronPort-AV: E=Sophos;i="5.58,365,1544482800"; 
   d="scan'208";a="13695743"
From:   <Fabian.Kirsch@dlr.de>
To:     <util-linux@vger.kernel.org>
Subject: [PATCH] sanity check, to prevent overlapping partitions from being
 partly reported as free
Thread-Topic: [PATCH] sanity check, to prevent overlapping partitions from
 being partly reported as free
Thread-Index: AQHUw6tHXT5SdgSNDUaVW5HHof7qjQ==
Date:   Wed, 13 Feb 2019 14:49:10 +0000
Message-ID: <1550069424.28515.10.camel@dlr.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <96F96EDFA83075499EDCD6526F0DA207@dlr.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

SGksDQoNCmkgbm90aWNlZCB3cm9uZ2x5IHJlcG9ydGVkIGZyZWUgc3BhY2Ugd2hlbiBsb29raW5n
IHdpdGggY2ZkaXNrIG9uDQphbiBVU0IgZHJpdmUgcHJlcGFyZWQgd2l0aCB0aGUgbGF0ZXN0IGFs
cGluZSAqLmlzb1sxXS4NCg0KRmVlbCBmcmVlIHRvIGFwcGx5IGJlbG93IHBhdGNoLCB3aGljaCBm
aXhlZCB0aGUgaXNzdWUgZm9yIG1lLg0KDQpHcmVldGluZ3MNCiAgRmFiaWFuDQoNClsxXTogaHR0
cDovL2RsLWNkbi5hbHBpbmVsaW51eC5vcmcvYWxwaW5lL3YzLjkvcmVsZWFzZXMveDg2L2FscGlu
ZS1leHRlbmRlZC0zLjkuMC14ODYuaXNvDQoNCi0tLQ0KIGxpYmZkaXNrL3NyYy90YWJsZS5jIHwg
OCArKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9saWJmZGlzay9zcmMvdGFibGUuYyBiL2xpYmZkaXNrL3NyYy90
YWJsZS5jDQppbmRleCA0ODgxZGI2OGUuLjNkMzI2OTVmNCAxMDA2NDQNCi0tLSBhL2xpYmZkaXNr
L3NyYy90YWJsZS5jDQorKysgYi9saWJmZGlzay9zcmMvdGFibGUuYw0KQEAgLTU4Miw3ICs1ODIs
NyBAQCBpbnQgZmRpc2tfZ2V0X2ZyZWVzcGFjZXMoc3RydWN0IGZkaXNrX2NvbnRleHQgKmN4dCwg
c3RydWN0IGZkaXNrX3RhYmxlICoqdGIpDQogew0KIAlpbnQgcmMgPSAwOw0KIAlzaXplX3QgbnBh
cnRzID0gMDsNCi0JZmRpc2tfc2VjdG9yX3QgbGFzdCwgZ3JhaW47DQorCWZkaXNrX3NlY3Rvcl90
IGxhc3QsIGdyYWluLCBwYV9lbmQ7DQogCXN0cnVjdCBmZGlza190YWJsZSAqcGFydHMgPSBOVUxM
Ow0KIAlzdHJ1Y3QgZmRpc2tfcGFydGl0aW9uICpwYTsNCiAJc3RydWN0IGZkaXNrX2l0ZXIgaXRy
Ow0KQEAgLTYzMiw3ICs2MzIsMTEgQEAgaW50IGZkaXNrX2dldF9mcmVlc3BhY2VzKHN0cnVjdCBm
ZGlza19jb250ZXh0ICpjeHQsIHN0cnVjdCBmZGlza190YWJsZSAqKnRiKQ0KIAkJLyogYWRkIGdh
cHMgYmV0d2VlbiBsb2dpY2FsIHBhcnRpdGlvbnMgKi8NCiAJCWlmIChmZGlza19wYXJ0aXRpb25f
aXNfY29udGFpbmVyKHBhKSkNCiAJCQlyYyA9IGNoZWNrX2NvbnRhaW5lcl9mcmVlc3BhY2UoY3h0
LCBwYXJ0cywgKnRiLCBwYSk7DQotCQlsYXN0ID0gZmRpc2tfcGFydGl0aW9uX2dldF9lbmQocGEp
Ow0KKwkJaWYoZmRpc2tfcGFydGl0aW9uX2hhc19lbmQocGEpKSB7DQorCQkJcGFfZW5kID0gZmRp
c2tfcGFydGl0aW9uX2dldF9lbmQocGEpOw0KKwkJCWlmKHBhX2VuZCA+IGxhc3QpDQorCQkJCWxh
c3QgPSBwYV9lbmQ7DQorCQl9DQogCQlucGFydHMrKzsNCiAJfQ0KIA0KLS0gDQoyLjEyLjM=
