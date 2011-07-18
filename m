Return-Path: util-linux-owner@vger.kernel.org
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50275 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370Ab1GRRhr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Jul 2011 13:37:47 -0400
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 69042A807F
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 19:37:46 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id dWErFg8Z+j3f for <util-linux@vger.kernel.org>;
	Mon, 18 Jul 2011 19:37:44 +0200 (CEST)
Received: from mail-pv0-f174.google.com (mail-pv0-f174.google.com [74.125.83.174])
	(Authenticated sender: sendmail@perennou.com)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1425FA807C
	for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 19:37:43 +0200 (CEST)
Received: by pvg12 with SMTP id 12so3173597pvg.19
        for <util-linux@vger.kernel.org>; Mon, 18 Jul 2011 10:37:42 -0700 (PDT)
MIME-Version: 1.0
From: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
Date: Mon, 18 Jul 2011 19:37:22 +0200
Message-ID: <CACpTwpHENHMCSxkh4a-Z5SHVifa=M7ai2XNtfY1An2TiUPc84A@mail.gmail.com>
Subject: [PATCH v2] dmesg: fix segfault
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

An element declared as size_t cannot be detected as negative (len < 0)
is always false.
This can lead to an infinite loop causing a segmentation fault.
Check if len is equal to -1 or -2 instead

Signed-off-by: Marc-Antoine Perennou <Marc-Antoine@Perennou.com>
---
 sys-utils/dmesg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 867581d..d7cf95b 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -367,7 +367,7 @@ static void safe_fwrite(const char *buf, size_t
size, FILE *out)
 		if (len == 0)				/* L'\0' */
 			return;

-		if (len < 0) {				/* invalid sequence */
+		if (len == (size_t)-1 || len == (size_t)-2) {		/* invalid sequence */
 			memset(&s, 0, sizeof (s));
 			len = hex = 1;

-- 
1.7.6.134.gcf13f6.dirty
