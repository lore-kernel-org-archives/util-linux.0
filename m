Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49739 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab1LVP0v (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 22 Dec 2011 10:26:51 -0500
Received: by eaad14 with SMTP id d14so2064761eaa.19
        for <util-linux@vger.kernel.org>; Thu, 22 Dec 2011 07:26:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20111222022443.GA31045@gaara.hadrons.org>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
	<1323975769-21929-4-git-send-email-cosoleto@gmail.com>
	<20111222022443.GA31045@gaara.hadrons.org>
Date: Thu, 22 Dec 2011 16:26:49 +0100
Message-ID: <CAMFXF505q=M2T8jJbsQT6Ljz1K6O1fRCixih4maKwO4sJb1d=Q@mail.gmail.com>
Subject: Re: [PATCH 04/13] fdisk: drop one parameter from try() function
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=001517592c12dead3504b4afed28
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--001517592c12dead3504b4afed28
Content-Type: text/plain; charset=ISO-8859-1

2011/12/22 Guillem Jover <guillem@hadrons.org>:
> The logic on user_specified is inverted so it seems the checks on the
> call sites would need to be swapped?

Correct. Thank you for pointing out this.

Attached a patch to fix this regression.

Francesco

--001517592c12dead3504b4afed28
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-fdisk-fix-incorrect-position-of-is_ide_cdrom_or_tape.patch"
Content-Disposition: attachment;
	filename="0001-fdisk-fix-incorrect-position-of-is_ide_cdrom_or_tape.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gwhxbexq0

RnJvbSAyY2Y1NzhjZDRhYmZiZTA2MDllMWRlOTdkZTc1NGNmY2MxOWE1NThjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGcmFuY2VzY28gQ29zb2xldG8gPGNvc29sZXRvQGdtYWlsLmNv
bT4KRGF0ZTogVGh1LCAyMiBEZWMgMjAxMSAxNTo1MzoyNSArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IGZkaXNrOiBmaXggaW5jb3JyZWN0IHBvc2l0aW9uIG9mIGlzX2lkZV9jZHJvbV9vcl90YXBlKCkg
Y2FsbAoKUmVwb3J0ZWQtYnk6IEd1aWxsZW0gSm92ZXIgPGd1aWxsZW1AaGFkcm9ucy5vcmc+ClNp
Z25lZC1vZmYtYnk6IEZyYW5jZXNjbyBDb3NvbGV0byA8Y29zb2xldG9AZ21haWwuY29tPgotLS0K
IGZkaXNrL2ZkaXNrLmMgfCAgICA2ICsrKy0tLQogMSBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZmRpc2svZmRpc2suYyBiL2ZkaXNr
L2ZkaXNrLmMKaW5kZXggYzQxZGE3YS4uYmRlNjBhOSAxMDA2NDQKLS0tIGEvZmRpc2svZmRpc2su
YworKysgYi9mZGlzay9mZGlzay5jCkBAIC0yODQ4LDcgKzI4NDgsOCBAQCBwcmludF9hbGxfcGFy
dGl0aW9uX3RhYmxlX2Zyb21fb3B0aW9uKHZvaWQpCiAJCWlmIChpc193aG9sZV9kaXNrKGRldm5h
bWUpKSB7CiAJCQljaGFyICpjbiA9IGNhbm9uaWNhbGl6ZV9wYXRoKGRldm5hbWUpOwogCQkJaWYg
KGNuKSB7Ci0JCQkJcHJpbnRfcGFydGl0aW9uX3RhYmxlX2Zyb21fb3B0aW9uKGNuKTsKKwkJCQlp
ZiAoIWlzX2lkZV9jZHJvbV9vcl90YXBlKGNuKSkKKwkJCQkJcHJpbnRfcGFydGl0aW9uX3RhYmxl
X2Zyb21fb3B0aW9uKGNuKTsKIAkJCQlmcmVlKGNuKTsKIAkJCX0KIAkJfQpAQCAtMzA1Nyw4ICsz
MDU4LDcgQEAgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpIHsKIAkJCWR1bW15KCZrKTsKIAkJ
CWxpc3RpbmcgPSAxOwogCQkJZm9yIChrID0gb3B0aW5kOyBrIDwgYXJnYzsgaysrKQotCQkJCWlm
ICghaXNfaWRlX2Nkcm9tX29yX3RhcGUoYXJndltrXSkpCi0JCQkJCXByaW50X3BhcnRpdGlvbl90
YWJsZV9mcm9tX29wdGlvbihhcmd2W2tdKTsKKwkJCQlwcmludF9wYXJ0aXRpb25fdGFibGVfZnJv
bV9vcHRpb24oYXJndltrXSk7CiAJCX0gZWxzZQogCQkJcHJpbnRfYWxsX3BhcnRpdGlvbl90YWJs
ZV9mcm9tX29wdGlvbigpOwogCQlleGl0KDApOwotLSAKMS43LjcKCg==
--001517592c12dead3504b4afed28--
