Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:44413 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab2IPGML (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Sep 2012 02:12:11 -0400
Received: by wibhr14 with SMTP id hr14so1252935wib.1
        for <util-linux@vger.kernel.org>; Sat, 15 Sep 2012 23:12:10 -0700 (PDT)
MIME-Version: 1.0
From: Queen Adam <adam900710@gmail.com>
Date: Sun, 16 Sep 2012 14:11:48 +0800
Message-ID: <CAFy8SQX-F5r+ztpJ9ZnBNwSjcbBqBN=g6-ZiSfV2sW_dBRv+tQ@mail.gmail.com>
Subject: Default wait time in hwclock is not long enough for some ARM devices
To: util-linux@vger.kernel.org
Content-Type: multipart/mixed; boundary=f46d043bd7588b402304c9cb897c
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--f46d043bd7588b402304c9cb897c
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm using Archlinux ARM for my Melo A100 box.
The hwclock always timeout when using select() in rtc.c.

After I change the timeout from 5 to 10, the problem is solved.

In fact the timeout in my ARM box seems only to be a little larger than 5s.

I also attached the patch.

--f46d043bd7588b402304c9cb897c
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h75qypgo0

ZGlmZiAtLWdpdCBhL3N5cy11dGlscy9od2Nsb2NrLXJ0Yy5jIGIvc3lzLXV0aWxzL2h3Y2xvY2st
cnRjLmMKaW5kZXggMzM4MDk0MS4uNjQwZjgyNiAxMDA2NDQKLS0tIGEvc3lzLXV0aWxzL2h3Y2xv
Y2stcnRjLmMKKysrIGIvc3lzLXV0aWxzL2h3Y2xvY2stcnRjLmMKQEAgLTMwOCw3ICszMDgsNyBA
QCBzdGF0aWMgaW50IHN5bmNocm9uaXplX3RvX2Nsb2NrX3RpY2tfcnRjKHZvaWQpCiAgICAgICAg
ICAgICAgICAgICAgICAgICAqLwogICAgICAgICAgICAgICAgICAgICAgICBGRF9aRVJPKCZyZmRz
KTsKICAgICAgICAgICAgICAgICAgICAgICAgRkRfU0VUKHJ0Y19mZCwgJnJmZHMpOwotICAgICAg
ICAgICAgICAgICAgICAgICB0di50dl9zZWMgPSA1OworICAgICAgICAgICAgICAgICAgICAgICB0
di50dl9zZWMgPSAxMDsKICAgICAgICAgICAgICAgICAgICAgICAgdHYudHZfdXNlYyA9IDA7CiAg
ICAgICAgICAgICAgICAgICAgICAgIHJjID0gc2VsZWN0KHJ0Y19mZCArIDEsICZyZmRzLCBOVUxM
LCBOVUxMLCAmdHYpOwogICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAxOwo=
--f46d043bd7588b402304c9cb897c--
