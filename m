Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53859 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754452Ab2JNUWq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:46 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1296598wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/13] ipcs: validate numeric user input
Date: Sun, 14 Oct 2012 21:22:24 +0100
Message-Id: <1350246145-10600-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am | 2 +-
 sys-utils/ipcs.c        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index a6e3c07..e20c6fb 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -16,7 +16,7 @@ ipcrm_LDADD = $(LDADD) libcommon.la
 
 usrbin_exec_PROGRAMS += ipcs
 dist_man_MANS += sys-utils/ipcs.1
-ipcs_SOURCES = sys-utils/ipcs.c
+ipcs_SOURCES = sys-utils/ipcs.c lib/strutils.c
 
 usrbin_exec_PROGRAMS += renice
 dist_man_MANS += sys-utils/renice.1
diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index a380718..b5fcd17 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -35,6 +35,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "pathnames.h"
+#include "strutils.h"
 #include "xalloc.h"
 
 /*
@@ -629,7 +630,7 @@ int main (int argc, char **argv)
 	while ((opt = getopt_long(argc, argv, options, longopts, NULL)) != -1) {
 		switch (opt) {
 		case 'i':
-			id = atoi (optarg);
+			id = strtos32_or_err(optarg, _("failed to parse argument"));
 			print = 1;
 			break;
 		case 'a':
-- 
1.7.12.3

