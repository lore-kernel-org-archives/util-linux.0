Return-Path: util-linux-owner@vger.kernel.org
Received: from canardo.mork.no ([148.122.252.1]:45455 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753936Ab2JAXyx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Oct 2012 19:54:53 -0400
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] dmesg: fix console-level off-by-one
Date: Tue,  2 Oct 2012 01:54:49 +0200
Message-Id: <1349135689-13948-1-git-send-email-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  commit f06ec64f dmesg; support level names (e.g. --console-level=alert)

introduced an off-by-one error.  The kernel will print messages with
a *higher* level than the console-level. The bug made it impossible to
set the level for debugging, like it is documented in e.g
Documentation/networking/netconsole.txt :

 nemi:/tmp# dmesg -n 8
 dmesg: unknown level '8'

And attempting to set the "emerg" level would result in an invalid 0 value:

 nemi:/tmp# dmesg -n emerg
 dmesg: klogctl failed: Invalid argument

Restoring the old behaviour for numeric levels, and mapping the level
names so that "dmesg -n debug" behaves as expected: logging everything
at level "debug" and higher.

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 sys-utils/dmesg.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 0ee03ee..fe39256 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -232,19 +232,23 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
  */
 static int parse_level(const char *str, size_t len)
 {
+	int offset = 0;
+
 	if (!str)
 		return -1;
-	if (!len)
+	if (!len) {
 		len = strlen(str);
+		offset = 1;
+	}
 	errno = 0;
 
 	if (isdigit(*str)) {
 		char *end = NULL;
-		long x = strtol(str, &end, 10);
+		long x = strtol(str, &end, 10) - offset;
 
 		if (!errno && end && end > str && (size_t) (end - str) == len &&
 		    x >= 0 && (size_t) x < ARRAY_SIZE(level_names))
-			return x;
+			return x + offset;
 	} else {
 		size_t i;
 
@@ -252,7 +256,7 @@ static int parse_level(const char *str, size_t len)
 			const char *n = level_names[i].name;
 
 			if (strncasecmp(str, n, len) == 0 && *(n + len) == '\0')
-				return i;
+				return i + offset;
 		}
 	}
 
-- 
1.7.10.4

