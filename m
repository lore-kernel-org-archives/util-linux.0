Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:55779 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMT4B (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:01 -0400
Received: by mail-wi0-f176.google.com with SMTP id hm14so509460wib.3
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/33] resizepart: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:47 +0100
Message-Id: <1365882901-11429-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/resizepart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/disk-utils/resizepart.c b/disk-utils/resizepart.c
index 5517c4f..765e3a4 100644
--- a/disk-utils/resizepart.c
+++ b/disk-utils/resizepart.c
@@ -11,6 +11,7 @@
 #include "partx.h"
 #include "sysfs.h"
 #include "strutils.h"
+#include "closestream.h"
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
@@ -73,6 +74,7 @@ int main(int argc, char **argv)
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
+	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
 		switch (c) {
@@ -102,5 +104,8 @@ int main(int argc, char **argv)
 			strtou64_or_err(argv[3], _("invalid length argument"))))
 		err(EXIT_FAILURE, _("failed to resize partition"));
 
+	if (close_fd(fd) != 0)
+		err(EXIT_FAILURE, _("write failed"));
+
 	return 0;
 }
-- 
1.8.2.1

