Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:51145 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbcBURzS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:18 -0500
Received: from assos.lan ([84.185.150.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M9b03-1afUBn1S7L-00CxRQ for
 <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 18:55:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] lib/strutils: add more ERANGE messages
Date: Sun, 21 Feb 2016 18:55:12 +0100
Message-Id: <1456077314-17910-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
References: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/strutils.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index 4e0f9cd..03a367b9 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -257,9 +257,10 @@ int16_t strtos16_or_err(const char *str, const char *errmesg)
 {
 	int32_t num = strtos32_or_err(str, errmesg);
 
-	if (num < INT16_MIN || num > INT16_MAX)
-		errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
-
+	if (num < INT16_MIN || num > INT16_MAX) {
+		errno = ERANGE;
+		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
+	}
 	return num;
 }
 
@@ -267,9 +268,10 @@ uint16_t strtou16_or_err(const char *str, const char *errmesg)
 {
 	uint32_t num = strtou32_or_err(str, errmesg);
 
-	if (num > UINT16_MAX)
-		errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
-
+	if (num > UINT16_MAX) {
+		errno = ERANGE;
+		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
+	}
 	return num;
 }
 
@@ -277,9 +279,10 @@ int32_t strtos32_or_err(const char *str, const char *errmesg)
 {
 	int64_t num = strtos64_or_err(str, errmesg);
 
-	if (num < INT32_MIN || num > INT32_MAX)
-		errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
-
+	if (num < INT32_MIN || num > INT32_MAX) {
+		errno = ERANGE;
+		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
+	}
 	return num;
 }
 
@@ -287,9 +290,10 @@ uint32_t strtou32_or_err(const char *str, const char *errmesg)
 {
 	uint64_t num = strtou64_or_err(str, errmesg);
 
-	if (num > UINT32_MAX)
-		errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
-
+	if (num > UINT32_MAX) {
+		errno = ERANGE;
+		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
+	}
 	return num;
 }
 
-- 
1.9.1

