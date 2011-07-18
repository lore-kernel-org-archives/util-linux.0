Return-Path: util-linux-owner@vger.kernel.org
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:52039 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab1GRQrg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2011 12:47:36 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id E603539727
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 18:46:21 +0200 (CEST)
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id C2ABC172067
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 18:46:17 +0200 (CEST)
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id haKnoaR8d3x3 for <util-linux@vger.kernel.org>;
	Mon, 18 Jul 2011 18:46:16 +0200 (CEST)
Received: from mail-pv0-f174.google.com (mail-pv0-f174.google.com [74.125.83.174])
	(Authenticated sender: sendmail@perennou.com)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C01DF172071
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 18:46:15 +0200 (CEST)
Received: by pvg12 with SMTP id 12so3134315pvg.19
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 09:46:14 -0700 (PDT)
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Date: Mon, 18 Jul 2011 18:45:54 +0200
Message-ID: <CACpTwpGZHf4dY72T6-nNLWCEU9CM2h58OQvCVgDZiKxsOorxVw@mail.gmail.com>
Subject: dmesg: fix segfqult
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

An element declared as size_t cannot be detected as negative (len < 0
is always false).
This can lead to an infinite loop causing a segmentation fault.
Use an int to solve this issue

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 sys-utils/dmesg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 867581d..91855a1 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -362,7 +362,7 @@ static void safe_fwrite(const char *buf, size_t
size, FILE *out)

 #ifdef HAVE_WIDECHAR
 		wchar_t wc;
-		size_t len = mbrtowc(&wc, p, size - i, &s);
+		int len = mbrtowc(&wc, p, size - i, &s);

 		if (len == 0)				/* L'\0' */
 			return;
-- 
1.7.6.134.gcf13f6.dirty
