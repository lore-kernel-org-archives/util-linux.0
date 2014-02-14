Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60919 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833AbaBNMDG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 14 Feb 2014 07:03:06 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 562ED20C82
	for <util-linux@vger.kernel.org>; Fri, 14 Feb 2014 06:56:02 -0500 (EST)
Message-Id: <1392378962.7365.83374729.31A9DCD2@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_139237896273651";
 charset="utf-8"
Subject: [patch] silence two compiler warnings
Date: Fri, 14 Feb 2014 12:56:02 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_139237896273651
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


Hi,

Attached patch silences for me two compiler warnings
about mismatching print specifiers.

Regards,

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service


--_----------=_139237896273651
Content-Disposition: attachment; filename="0001-libfdisk-avoid-two-compiler-warnings-about-wrong-pri.patch"
Content-Id: <1392378929.7046.c9001d0693389bb52fa585f21fded3d71cc01078.3B26FCCC@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-libfdisk-avoid-two-compiler-warnings-about-wrong-pri.patch"

RnJvbSBiODU0NjQyODM0ZTA4OTc0ZTQzYjNlYjA1ZjRkY2I4NTJmMjliYzk1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogVGh1LCAxMyBG
ZWIgMjAxNCAyMTozNjo0MyArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIGxpYmZk
aXNrOiBhdm9pZCB0d28gY29tcGlsZXIgd2FybmluZ3MgYWJvdXQgd3Jvbmcg
cHJpbnQgZm9ybWF0cwoKU2lnbmVkLW9mZi1ieTogQmVubm8gU2NodWxlbmJl
cmcgPGJlbnNiZXJnQGp1c3RlbWFpbC5uZXQ+Ci0tLQogbGliZmRpc2svc3Jj
L2Rvcy5jIHwgICAgMiArLQogbGliZmRpc2svc3JjL2dwdC5jIHwgICAgMiAr
LQogMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvbGliZmRpc2svc3JjL2Rvcy5jIGIvbGli
ZmRpc2svc3JjL2Rvcy5jCmluZGV4IDZhZjA2MWIuLmRiMDY2NmIgMTAwNjQ0
Ci0tLSBhL2xpYmZkaXNrL3NyYy9kb3MuYworKysgYi9saWJmZGlzay9zcmMv
ZG9zLmMKQEAgLTMwMyw3ICszMDMsNyBAQCBzdGF0aWMgdm9pZCBkb3NfaW5p
dChzdHJ1Y3QgZmRpc2tfY29udGV4dCAqY3h0KQogCQlmZGlza193YXJueChj
eHQsCiAJCV8oIlRoZSBzaXplIG9mIHRoaXMgZGlzayBpcyAlcyAoJWp1IGJ5
dGVzKS4gRE9TICIKIAkJICAicGFydGl0aW9uIHRhYmxlIGZvcm1hdCBjYW4g
bm90IGJlIHVzZWQgb24gZHJpdmVzIGZvciAiCi0JCSAgInZvbHVtZXMgbGFy
Z2VyIHRoYW4gJWp1IGJ5dGVzIGZvciAlbHUtYnl0ZSAiCisJCSAgInZvbHVt
ZXMgbGFyZ2VyIHRoYW4gJWx1IGJ5dGVzIGZvciAlbHUtYnl0ZSAiCiAJCSAg
InNlY3RvcnMuIFVzZSBHVUlEIHBhcnRpdGlvbiB0YWJsZSBmb3JtYXQgKEdQ
VCkuIiksCiAJCQlzenN0ciwgYnl0ZXMsCiAJCQlVSU5UX01BWCAqIGN4dC0+
c2VjdG9yX3NpemUsCmRpZmYgLS1naXQgYS9saWJmZGlzay9zcmMvZ3B0LmMg
Yi9saWJmZGlzay9zcmMvZ3B0LmMKaW5kZXggZGM2ZTZjNy4uZWIxNWQ4YyAx
MDA2NDQKLS0tIGEvbGliZmRpc2svc3JjL2dwdC5jCisrKyBiL2xpYmZkaXNr
L3NyYy9ncHQuYwpAQCAtMTg1MCw3ICsxODUwLDcgQEAgc3RhdGljIGludCBn
cHRfYWRkX3BhcnRpdGlvbigKIAogCWlmIChncHRfY3JlYXRlX25ld19wYXJ0
aXRpb24oY3h0LCBwYXJ0bnVtLAogCQkJCSAgICAgdXNlcl9mLCB1c2VyX2ws
ICZ0eXBlaWQsIGVudHMpICE9IDApCi0JCWZkaXNrX3dhcm54KGN4dCwgXygi
Q291bGQgbm90IGNyZWF0ZSBwYXJ0aXRpb24gJWp1IiksIHBhcnRudW0gKyAx
KTsKKwkJZmRpc2tfd2FybngoY3h0LCBfKCJDb3VsZCBub3QgY3JlYXRlIHBh
cnRpdGlvbiAlenUiKSwgcGFydG51bSArIDEpOwogCWVsc2UgewogCQlzdHJ1
Y3QgZmRpc2tfcGFydHR5cGUgKnQ7CiAKLS0gCjEuNy4wLjQKCg==

--_----------=_139237896273651--

