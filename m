Return-Path: <SRS0=mKqM=Q6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32531C43381
	for <util-linux@archiver.kernel.org>; Sat, 23 Feb 2019 04:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41F4206A3
	for <util-linux@archiver.kernel.org>; Sat, 23 Feb 2019 04:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="f/3QVYZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfBWEKz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:10:55 -0500
Received: from m15-10.126.com ([220.181.15.10]:4458 "EHLO m15-10.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBWEKy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 Feb 2019 23:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=SLuoW
        x9BjVMMkLqHjlB1vgeOpDKY/AYZoMlKNk/W7q8=; b=f/3QVYZ7DTj4qxdNnQXMt
        UJo1u4ycEbBIb99ki+lG7YzKnGku/2SlRm94slJlSwTLTV8uoTcN9Zcc+veBeDWO
        qE1mMPP65TZVTX/KfEhAFfgcNkmrFsen7ARCjnvkXTIUPSDnyut/GW8tvFxtawis
        4R/ogH1XajlbfKNcE+2Qlg=
Received: from ziming_cool$126.com ( [101.20.227.86] ) by
 ajax-webmail-wmsvr10 (Coremail) ; Sat, 23 Feb 2019 12:09:54 +0800 (CST)
X-Originating-IP: [101.20.227.86]
Date:   Sat, 23 Feb 2019 12:09:54 +0800 (CST)
From:   =?GBK?B?sfm/wg==?= <ziming_cool@126.com>
To:     util-linux@vger.kernel.org
Subject: Bug report for libfdisk
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20180927(cd7136b6) Copyright (c) 2002-2019 www.mailtech.cn 126com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <2a76c584.126b.169188b95a6.Coremail.ziming_cool@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CsqowAAHD+OTx3BcYG0VAA--.25747W
X-CM-SenderInfo: p2lpx05jbf00bo6rjloofrz/1tbiEwtkklpD4r85hgABsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

RGVhciBkZXZlbG9wZXIgb3IgbWFpbnRhaW5lciBvZiB1dGlsLWxpbnV4OgogICAgSGkhIEFuZCB0
aGFua3MgZm9yIHlvdXIgYXR0ZW50aW9uIHRvIHRoaXMgZW1haWwuCiAgICBJJ20gd3JpdGluZyB0
aGlzIHRvIHJlcG9ydCBhIGJ1ZyBhYm91dCBsaWJmZGlzay4gSSBoYXBwZW5lZCBub3RpY2UgdGhh
dCBmZGlzayBnYXZlIG1lIGFuIGluY29ycmVjdCB2YWx1ZSB3aGVuIHByb21wdCBmb3IgZmlyc3Qg
c2VjdG9yIG9uIGNyZWF0aW5nIGEgcHJpbWFyeSBkb3MgcGFydGl0aW9uLgogICAgSSBmb3VuZCB0
aGlzIGJ1ZyBvbiB1dGlsLWxpbnV4LTIuMzEuMSwgdGhlbiBJIGRvd25sb2FkZWQgdGhlIG5ld2Vy
IHZlcnNpb24gb2YgMi4zMy4xLCBhbmQgbm90aWNlZCB0aGF0IHRoZSBidWcgaXMgc3RpbGwgbm90
IGZpeGVkLgogICAgVGhlIHNvdXJjZSBjb2RlIG9mIGB1dGlsLWxpbnV4LTIuMzEuMS9saWJmZGlz
ay9zcmMvZG9zLmNgIGRlZmluZXMgYSBmdW5jdGlvbiBgZ2V0X3Bvc3NpYmxlX2xhc3RgLCBpdCdz
IHBhcnRpYWwgY29udGVudCBpcyBzaG93biBiZWxvdzoKCgl9IGVsc2UgewoJCS8qIHByaW1hcnkg
cGFydGl0aW9ucyAqLwoJCWlmIChmZGlza191c2VfY3lsaW5kZXJzKGN4dCkgfHwgIWN4dC0+dG90
YWxfc2VjdG9ycykKCQkJbGltaXQgPSBjeHQtPmdlb20uaGVhZHMgKiBjeHQtPmdlb20uc2VjdG9y
cyAqIGN4dC0+Z2VvbS5jeWxpbmRlcnMgLSAxOwoJCWVsc2UKCQkJbGltaXQgPSBjeHQtPnRvdGFs
X3NlY3RvcnMgLSAxOyAgICAgIC8qIEhFUkUgKi8KCgkJaWYgKGxpbWl0ID4gVUlOVF9NQVgpCgkJ
CWxpbWl0ID0gVUlOVF9NQVg7Cgl9CgogICAgV2hlbiBjcmVhdGluZyBhIHByaW1hcnkgcGFydGl0
aW9uIGFuZCB0aGUgbWVhc3VyZSB1bml0IGlzIGBzZWN0b3JgLCBpdCBzaW1wbHkgcmV0dXJucyB0
aGUgdmFsdWUgYGN4dC0+dG90YWxfc2VjdG9ycyAtIDFgLgogICAgSG93IHRoZSBidWcgJ3dvcmtl
ZCcgKEkgc3RyaXBwZWQgc29tZSB1c2VsZXNzIG91dHB1dHMpOgogICAgICAkIHFlbXUtaW1nIGNy
ZWF0ZSB0ZXN0LmltZyA0RwogICAgICBGb3JtYXR0aW5nICd0ZXN0LmltZycsIGZtdD1yYXcgc2l6
ZT00Mjk0OTY3Mjk2CiAgICAgICQgZmRpc2sgdGVzdC5pbWcKICAgICAgRGV2aWNlIGRvZXMgbm90
IGNvbnRhaW4gYSByZWNvZ25pemVkIHBhcnRpdGlvbiB0YWJsZS4KICAgICAgQ3JlYXRlZCBhIG5l
dyBET1MgZGlza2xhYmVsIHdpdGggZGlzayBpZGVudGlmaWVyIDB4ODczZmQ2ZjQuCiAgICAgIENv
bW1hbmQgKG0gZm9yIGhlbHApOiBuCiAgICAgIFBhcnRpdGlvbiB0eXBlCiAgICAgICAgIHAgICBw
cmltYXJ5ICgwIHByaW1hcnksIDAgZXh0ZW5kZWQsIDQgZnJlZSkKICAgICAgICAgZSAgIGV4dGVu
ZGVkIChjb250YWluZXIgZm9yIGxvZ2ljYWwgcGFydGl0aW9ucykKICAgICAgU2VsZWN0IChkZWZh
dWx0IHApOiAKICAgICAgVXNpbmcgZGVmYXVsdCByZXNwb25zZSBwLgogICAgICBQYXJ0aXRpb24g
bnVtYmVyICgxLTQsIGRlZmF1bHQgMSk6IDIKICAgICAgRmlyc3Qgc2VjdG9yICgyMDQ4LTgzODg2
MDcsIGRlZmF1bHQgMjA0OCk6IDQwMDAwMDAKICAgICAgTGFzdCBzZWN0b3IsICtzZWN0b3JzIG9y
ICtzaXple0ssTSxHLFQsUH0gKDQwMDAwMDAtODM4ODYwNywgZGVmYXVsdCA4Mzg4NjA3KTogCiAg
ICAgIENyZWF0ZWQgYSBuZXcgcGFydGl0aW9uIDIgb2YgdHlwZSAnTGludXgnIGFuZCBvZiBzaXpl
IDIuMSBHaUIuCgogICAgVGlsbCBub3csIEkndmUgY3JlYXRlZCBhIHBhcnRpdGlvbiBhdCB0aGUg
ZW5kIG9mIHRoZSBkaXNrLiBUaGVuIEknbGwgY3JlYXRlIGFub3RoZXIgb25lOgoKICAgICAgQ29t
bWFuZCAobSBmb3IgaGVscCk6IG4KICAgICAgUGFydGl0aW9uIHR5cGUKICAgICAgICAgcCAgIHBy
aW1hcnkgKDEgcHJpbWFyeSwgMCBleHRlbmRlZCwgMyBmcmVlKQogICAgICAgICBlICAgZXh0ZW5k
ZWQgKGNvbnRhaW5lciBmb3IgbG9naWNhbCBwYXJ0aXRpb25zKQogICAgICBTZWxlY3QgKGRlZmF1
bHQgcCk6IAogICAgICBVc2luZyBkZWZhdWx0IHJlc3BvbnNlIHAuCiAgICAgIFBhcnRpdGlvbiBu
dW1iZXIgKDEsMyw0LCBkZWZhdWx0IDEpOiAKICAgICAgRmlyc3Qgc2VjdG9yICgyMDQ4LTgzODg2
MDcsIGRlZmF1bHQgMjA0OCk6CgogICAgWW91IGNhbiBzZWUgaXQgc3RpbGwgcHJvbXB0cyBmb3Ig
YEZpcnN0IHNlY3RvcmAgd2l0aCB0aGUgc2FtZSByYW5nZSAyMDQ4LTgzODg2MDcsIHdoaWxlIGl0
IHNob3VsZCBiZSAyMDQ4LTM5OTk5OTkuIFRoaXMgaXMgcHJvYmFibHkgY2F1c2VkIGJ5IHRoZSBj
b2RlIEkndmUgbGlzdGVkIGFscmVhZHkuCiAgICBJJ3ZlIGFsc28gdHJpZWQgdXNpbmcgY3lsaW5k
ZXJzIGFzIG1lYXN1cmUgdW5pdCwgYW5kIHRoZSBwcm9ibGVtIHJlcGVhdGVkLiBIb3dldmVyLCBp
dCB3b3JrcyBwcm9wZXJseSB3aGVuIGNyZWF0aW5nIGEgR1BUIHBhcnRpdGlvbi4KICAgIEkgZG9u
J3QgdGhpbmsgdGhpcyBpcyBjb3JyZWN0LCB0aG91Z2ggaXQncyBub3QgdmVyeSBpbXBvcnRhbnQu
IFNvLCBob3BlIHRoaXMgYnVnIHdpbGwgYmUgZml4ZWQgc29vbi4KICAgIEFuZCBsYXN0LCB0aGFu
a3MgYWdhaW4gZm9yIHJlYWRpbmcgbXkgZW50aXJlIGVtYWlsLCBhbmQgc29ycnkgZm9yIG15IHBv
b3IgRW5nbGlzaCBza2lsbC4uLgogICAgSGl2ZSBhIG5pY2UgZGF5IQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFlvdXJzIHNpbmNlcmVs
eSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgSWN5Lg==
