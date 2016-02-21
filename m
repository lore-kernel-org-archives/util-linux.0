Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:62742 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751452AbcBURzR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:17 -0500
Received: from assos.lan ([84.185.150.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M2Ldk-1ZheYi0prY-00s7A3 for
 <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 18:55:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] lib/strutils: fix errno usage in strtoint functions
Date: Sun, 21 Feb 2016 18:55:11 +0100
Message-Id: <1456077314-17910-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
References: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Don't use undefined errno:
$ ./logger --no-act -t "wtf" --id="" message
logger: failed to parse id: '': No such file or directory

Don't print useless EINVAL message but ERANGE only:
$ ./logger --no-act -t "wtf" --id="XX" message
logger: failed to parse id: 'XX': Invalid argument

Note the ERANGE-only improvement does not change anything on
Linux/c99 as strtoul(3) only set ERANGE there.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/strutils.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/strutils.c b/lib/strutils.c
index ef81ebd..4e0f9cd 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -298,9 +298,9 @@ int64_t strtos64_or_err(const char *str, const char *errmesg)
 	int64_t num;
 	char *end = NULL;
 
+	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	errno = 0;
 	num = strtoimax(str, &end, 10);
 
 	if (errno || str == end || (end && *end))
@@ -308,7 +308,7 @@ int64_t strtos64_or_err(const char *str, const char *errmesg)
 
 	return num;
 err:
-	if (errno)
+	if (errno == ERANGE)
 		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
@@ -319,9 +319,9 @@ uint64_t strtou64_or_err(const char *str, const char *errmesg)
 	uintmax_t num;
 	char *end = NULL;
 
+	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	errno = 0;
 	num = strtoumax(str, &end, 10);
 
 	if (errno || str == end || (end && *end))
@@ -329,7 +329,7 @@ uint64_t strtou64_or_err(const char *str, const char *errmesg)
 
 	return num;
 err:
-	if (errno)
+	if (errno == ERANGE)
 		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
@@ -341,9 +341,9 @@ double strtod_or_err(const char *str, const char *errmesg)
 	double num;
 	char *end = NULL;
 
+	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	errno = 0;
 	num = strtod(str, &end);
 
 	if (errno || str == end || (end && *end))
@@ -351,7 +351,7 @@ double strtod_or_err(const char *str, const char *errmesg)
 
 	return num;
 err:
-	if (errno)
+	if (errno == ERANGE)
 		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
@@ -362,9 +362,9 @@ long strtol_or_err(const char *str, const char *errmesg)
 	long num;
 	char *end = NULL;
 
+	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	errno = 0;
 	num = strtol(str, &end, 10);
 
 	if (errno || str == end || (end && *end))
@@ -372,8 +372,9 @@ long strtol_or_err(const char *str, const char *errmesg)
 
 	return num;
 err:
-	if (errno)
+	if (errno == ERANGE)
 		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
+
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 }
 
@@ -382,9 +383,9 @@ unsigned long strtoul_or_err(const char *str, const char *errmesg)
 	unsigned long num;
 	char *end = NULL;
 
+	errno = 0;
 	if (str == NULL || *str == '\0')
 		goto err;
-	errno = 0;
 	num = strtoul(str, &end, 10);
 
 	if (errno || str == end || (end && *end))
@@ -392,7 +393,7 @@ unsigned long strtoul_or_err(const char *str, const char *errmesg)
 
 	return num;
 err:
-	if (errno)
+	if (errno == ERANGE)
 		err(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
 
 	errx(STRTOXX_EXIT_CODE, "%s: '%s'", errmesg, str);
-- 
1.9.1

