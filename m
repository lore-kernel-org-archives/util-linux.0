Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:61932 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab2FFM3V (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 08:29:21 -0400
Message-ID: <4FCF4D1E.5020909@bernhard-voelker.de>
Date: Wed, 06 Jun 2012 14:29:18 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] su: remove unimplemented options -u and -v
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From 3e7fedef769fe0cfb71833ec51c3f897e99b0f7c Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 6 Jun 2012 14:26:59 +0200
Subject: [PATCH] su: remove unimplemented options -u and -v

* longopts: Change the values of "help" and "version" to upper-case - as these options
are special anyway.
* main(): Likewise.
* usage(): Remove unimplemented short options -u and -v and fix alignment.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 login-utils/su.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index 0f535b9..66d5273 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -109,8 +109,8 @@ static struct option const longopts[] =
   {"login", no_argument, NULL, 'l'},
   {"preserve-environment", no_argument, NULL, 'p'},
   {"shell", required_argument, NULL, 's'},
-  {"help", no_argument, 0, 'u'},
-  {"version", no_argument, 0, 'v'},
+  {"help", no_argument, 0, 'H'},
+  {"version", no_argument, 0, 'V'},
   {NULL, 0, NULL, 0}
 };

@@ -661,10 +661,8 @@ Change the effective user id and group id to that of USER.\n\
   -m, --preserve-environment   do not reset environment variables\n\
   -p                           same as -m\n\
   -s, --shell=SHELL            run SHELL if /etc/shells allows it\n\
-"), stdout);
-      fputs (_(" -u, --help     display this help and exit\n"), stdout);
-      fputs (_(" -v, --version  output version information and exit\n"), stdout);
-      fputs (_("\
+      --help     display this help and exit\n\
+      --version  output version information and exit\n\
 \n\
 A mere - implies -l.   If USER not given, assume root.\n\
 "), stdout);
@@ -727,10 +725,10 @@ main (int argc, char **argv)
 	  shell = optarg;
 	  break;

-	case 'u':
+	case 'H':
 	  usage(0);

-	case 'v':
+	case 'V':
 	  printf(UTIL_LINUX_VERSION);
 	  exit(EXIT_SUCCESS);

-- 
1.7.7

