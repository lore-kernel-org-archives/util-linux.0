Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:63169 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbaEYK7z (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 06:59:55 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so6655640wes.41
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 03:59:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/4] uuidgen: use type definitions from uuid.h
Date: Sun, 25 May 2014 11:59:39 +0100
Message-Id: <1401015580-27951-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
References: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no need to re-invent wheel.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidgen.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 450e26a..0c844d2 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -26,9 +26,6 @@ extern int optind;
 #include "c.h"
 #include "closestream.h"
 
-#define DO_TYPE_TIME	1
-#define DO_TYPE_RANDOM	2
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(_("\nUsage:\n"), out);
@@ -68,10 +65,10 @@ main (int argc, char *argv[])
 	while ((c = getopt_long(argc, argv, "rtVh", longopts, NULL)) != -1)
 		switch (c) {
 		case 't':
-			do_type = DO_TYPE_TIME;
+			do_type = UUID_TYPE_DCE_TIME;
 			break;
 		case 'r':
-			do_type = DO_TYPE_RANDOM;
+			do_type = UUID_TYPE_DCE_RANDOM;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -83,10 +80,10 @@ main (int argc, char *argv[])
 		}
 
 	switch (do_type) {
-	case DO_TYPE_TIME:
+	case UUID_TYPE_DCE_TIME:
 		uuid_generate_time(uu);
 		break;
-	case DO_TYPE_RANDOM:
+	case UUID_TYPE_DCE_RANDOM:
 		uuid_generate_random(uu);
 		break;
 	default:
-- 
1.9.3

