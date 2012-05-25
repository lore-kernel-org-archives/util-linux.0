Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51962 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758201Ab2EYSQ3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:29 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3t-0007mw-DE from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:29 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 3/7] last, login, write: Provide a fallback for MAXHOSTNAMELEN, as elsewhere.
Date: Fri, 25 May 2012 20:16:14 +0200
Message-Id: <1337969778-3154-3-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 login-utils/last.c  |    8 ++++++++
 login-utils/login.c |    8 ++++++++
 term-utils/write.c  |    8 ++++++++
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 1b1bee1..4d09c4b 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -62,6 +62,14 @@
 #include "xalloc.h"
 #include "c.h"
 
+#ifndef MAXHOSTNAMELEN
+# ifdef HOST_NAME_MAX
+#  define MAXHOSTNAMELEN HOST_NAME_MAX
+# else
+#  define MAXHOSTNAMELEN 64
+# endif
+#endif
+
 #define	SECDAY	(24*60*60)			/* seconds in a day */
 #define	NO	0				/* false/no */
 #define	YES	1				/* true/yes */
diff --git a/login-utils/login.c b/login-utils/login.c
index 7b4f8b5..f459b79 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -71,6 +71,14 @@
 
 #include "logindefs.h"
 
+#ifndef MAXHOSTNAMELEN
+# ifdef HOST_NAME_MAX
+#  define MAXHOSTNAMELEN HOST_NAME_MAX
+# else
+#  define MAXHOSTNAMELEN 64
+# endif
+#endif
+
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
 #define LOGIN_MAX_TRIES        3
diff --git a/term-utils/write.c b/term-utils/write.c
index 2a94792..c8aca7e 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -65,6 +65,14 @@
 #include "closestream.h"
 #include "nls.h"
 
+#ifndef MAXHOSTNAMELEN
+# ifdef HOST_NAME_MAX
+#  define MAXHOSTNAMELEN HOST_NAME_MAX
+# else
+#  define MAXHOSTNAMELEN 64
+# endif
+#endif
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out);
 void search_utmp(char *, char *, char *, uid_t);
 void do_write(char *, char *, uid_t);
-- 
1.7.9

