Return-Path: util-linux-owner@vger.kernel.org
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47566 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab3LQKCP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Dec 2013 05:02:15 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B3BB920ACC
	for <util-linux@vger.kernel.org>; Tue, 17 Dec 2013 05:02:14 -0500 (EST)
Message-Id: <1387274534.32475.60577705.14EC62A9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1387274534324754";
 charset="utf-8"
Subject: [attempt at patch] adding --no-wrap to msgmerge
Date: Tue, 17 Dec 2013 11:02:14 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1387274534324754
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


Hi,

Attached is a patch that should add the option --no-wrap to the runs
of msgmerge (after a renewal of the POT file) to reduce the number
of spurious differences.

However, I can't get the thing to work here.  When i run autogen.sh
it says "Copying file po/Makefile.in.in", and when I then look in that
file it mentions "# Origin: gettext-0.14".  But the only Makefile.in.in
I have on this testing system is /usr/share/gettext/po/Makefile.in.in
and in that file it says "# Origin: gettext-0.18".  (That version is needed,
otherwise it doesn't know the MSGMERGE_OPTIONS variable.)

So... where does autogen.sh/autopoint take its Makefile.in.in from?

Regards,

Benno

-- 
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again


--_----------=_1387274534324754
Content-Disposition: attachment; filename="0001-po-add-no-wrap-to-msgmerge-to-not-wrap-long-message-.patch"
Content-Id: <1387274516.32511.f8e0a38cb5872c1115b3778d6bce1ba41fb7e144.136F4798@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-po-add-no-wrap-to-msgmerge-to-not-wrap-long-message-.patch"

RnJvbSA0ZDlhNjI5YjJkM2E5ZTE3NjhlYjI2OGFjYWY5ZTczZmIxNjk5Nzhm
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogTW9uLCAxNiBE
ZWMgMjAxMyAyMjo0MTo1NiArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIHBvOiBh
ZGQgJy0tbm8td3JhcCcgdG8gbXNnbWVyZ2UsIHRvIG5vdCB3cmFwIGxvbmcg
bWVzc2FnZSBsaW5lcwoKVGhpcyBhdm9pZHMgdW5uZWVkZWQgY2h1cm4gZHVy
aW5nIFBPVC1maWxlIHJlbmV3YWwgYW5kIFBPLWZpbGUgdXBkYXRlcywKYXMg
dGhlIFBPIGZpbGVzIGF0IHRoZSBUUCBhcmUgbWFkZSB3aXRoICctLW5vLXdy
YXAnLgoKU2lnbmVkLW9mZi1ieTogQmVubm8gU2NodWxlbmJlcmcgPGJlbnNi
ZXJnQGp1c3RlbWFpbC5uZXQ+Ci0tLQogcG8vTWFrZXZhcnMgfCAgICAzICsr
KwogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDAgZGVsZXRp
b25zKC0pCgpkaWZmIC0tZ2l0IGEvcG8vTWFrZXZhcnMgYi9wby9NYWtldmFy
cwppbmRleCA5OTM4ZTQ0Li40ZDU2MjljIDEwMDY0NAotLS0gYS9wby9NYWtl
dmFycworKysgYi9wby9NYWtldmFycwpAQCAtMTAsNiArMTAsOSBAQCB0b3Bf
YnVpbGRkaXIgPSAuLgogIyBUaGVzZSBvcHRpb25zIGdldCBwYXNzZWQgdG8g
eGdldHRleHQuCiBYR0VUVEVYVF9PUFRJT05TID0gLS1rZXl3b3JkPV8gLS1r
ZXl3b3JkPU5fIC0ta2V5d29yZD1QXzoxLDIKIAorIyBUaGlzIG9wdGlvbiBn
ZXRzIHBhc3NlZCB0byBtc2dtZXJnZS4KK01TR01FUkdFX09QVElPTlMgPSAt
LW5vLXdyYXAKKwogIyBUaGlzIGlzIHRoZSBjb3B5cmlnaHQgaG9sZGVyIHRo
YXQgZ2V0cyBpbnNlcnRlZCBpbnRvIHRoZSBoZWFkZXIgb2YgdGhlCiAjICQo
RE9NQUlOKS5wb3QgZmlsZS4gIFNldCB0aGlzIHRvIHRoZSBjb3B5cmlnaHQg
aG9sZGVyIG9mIHRoZSBzdXJyb3VuZGluZwogIyBwYWNrYWdlLiAgKE5vdGUg
dGhhdCB0aGUgbXNnc3RyIHN0cmluZ3MsIGV4dHJhY3RlZCBmcm9tIHRoZSBw
YWNrYWdlJ3MKLS0gCjEuNy4wLjQKCg==

--_----------=_1387274534324754--

