Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52825 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753519Ab3LURXG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 21 Dec 2013 12:23:06 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2A5DC20BA9
	for <util-linux@vger.kernel.org>; Sat, 21 Dec 2013 12:23:05 -0500 (EST)
Message-Id: <1387646585.6225.62363057.526D760E@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_138764658562253";
 charset="utf-8"
Subject: [patch] the first Sunday of the week...
Date: Sat, 21 Dec 2013 18:23:05 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_138764658562253
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


Hi,

The man page of cal speaks of "first Sunday of the week"
instead of of "first Sunday of the year".  Attached patch
fixes this, and tries to further improve the clarity of the
paragraph.

Benno

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow


--_----------=_138764658562253
Content-Disposition: attachment; filename="0001-docs-in-cal-s-man-page-admit-that-any-week-has-just-.patch"
Content-Id: <1387646507.5925.4015b69de478cded7d2181c36d0f5da82fd33cc6.34ED6E19@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-docs-in-cal-s-man-page-admit-that-any-week-has-just-.patch"

RnJvbSA2MzQ3NTY1ZjU3MTIxZjI4Y2E2NmViZGM3MTU4MzBlMGRmZTAzZjIy
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogU2F0LCAyMSBE
ZWMgMjAxMyAxODoxNToxNCArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGRvY3M6
IGluIGNhbCdzIG1hbiBwYWdlIGFkbWl0IHRoYXQgYW55IHdlZWsgaGFzIGp1
c3Qgb25lIFN1bmRheQoKU2lnbmVkLW9mZi1ieTogQmVubm8gU2NodWxlbmJl
cmcgPGJlbnNiZXJnQGp1c3RlbWFpbC5uZXQ+Ci0tLQogbWlzYy11dGlscy9j
YWwuMSB8ICAgMTAgKysrKystLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbWlz
Yy11dGlscy9jYWwuMSBiL21pc2MtdXRpbHMvY2FsLjEKaW5kZXggZmE3OWY5
MS4uODYwZjcwOCAxMDA2NDQKLS0tIGEvbWlzYy11dGlscy9jYWwuMQorKysg
Yi9taXNjLXV0aWxzL2NhbC4xCkBAIC0xMDgsMTEgKzEwOCwxMSBAQCBTZXB0
ZW1iZXIuIEJ5IHRoaXMgdGltZSwgbW9zdCBjb3VudHJpZXMgaGFkIHJlY29n
bml6ZWQgdGhlIHJlZm9ybWF0aW9uCiBmb2xsb3dpbmcgdGhhdCBkYXRlIHdl
cmUgZWxpbWluYXRlZCBieSB0aGUgcmVmb3JtYXRpb24sIHNvIHRoZSBjYWxl
bmRhciBmb3IKIHRoYXQgbW9udGggaXMgYSBiaXQgdW51c3VhbC4KIC5QUAot
VGhlIHdlZWsgbnVtYmVyaW5nIGRlcGVuZHMgb24gdGhlIGZpcnN0IGRheSBv
ZiB0aGUgd2Vlay4gSWYgU3VuZGF5ICh0aGUKLWRlZmF1bHQpIGlzIHVzZWQg
Zm9yIHRoZSBmaXJzdCBkYXkgb2YgdGhlIHdlZWssIHRoZW4gdGhlIGN1c3Rv
bWFyeSBOb3J0aAotQW1lcmljYW4gbnVtYmVyaW5nIHdpbGwgYmUgdXNlZCwg
aS5lLiBmaXJzdCBTdW5kYXkgb2YgdGhlIHdlZWsgc3RhcnRzIHRoZQotZmly
c3Qgd2Vlay4gSWYgTW9uZGF5IGlzIHNlbGVjdGVkLCB0aGVuIHRoZSBJU08t
ODYwMSBzdGFuZGFyZCB3ZWVrIG51bWJlcmluZwotaXMgdXNlZCwgd2hlcmUg
dGhlIGZpcnN0IFRodXJzZGF5IGlzIGluIHdlZWsgbnVtYmVyIDEuCitUaGUg
d2VlayBudW1iZXJpbmcgZGVwZW5kcyBvbiB0aGUgY2hvaWNlIG9mIHRoZSBm
aXJzdCBkYXkgb2YgdGhlIHdlZWsuICBJZiBTdW5kYXkKKyh0aGUgZGVmYXVs
dCkgaXMgdXNlZCBmb3IgdGhlIGZpcnN0IGRheSBvZiB0aGUgd2VlaywgdGhl
biB0aGUgY3VzdG9tYXJ5IE5vcnRoCitBbWVyaWNhbiBudW1iZXJpbmcgd2ls
bCBiZSB1c2VkLCBpLmUuIHRoZSBmaXJzdCBTdW5kYXkgb2YgdGhlIHllYXIg
c3RhcnRzIHRoZQorZmlyc3Qgd2Vlay4gIElmIE1vbmRheSBpcyBzZWxlY3Rl
ZCwgdGhlbiB0aGUgSVNPLTg2MDEgc3RhbmRhcmQgd2VlayBudW1iZXJpbmcK
K2lzIHVzZWQsIHdoZXJlIHRoZSBmaXJzdCBUaHVyc2RheSBvZiB0aGUgeWVh
ciBpcyBpbiB3ZWVrIG51bWJlciAxLgogLlNIIEhJU1RPUlkKIEEgY2FsIGNv
bW1hbmQgYXBwZWFyZWQgaW4gVmVyc2lvbiA2IEFUJlQgVU5JWC4KIC5TSCBB
VkFJTEFCSUxJVFkKLS0gCjEuNy4wLjQKCg==

--_----------=_138764658562253--

