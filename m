Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:49525 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbaEDPub (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:31 -0400
Received: by mail-wg0-f41.google.com with SMTP id z12so1224365wgg.0
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/15] cytune: kernel still does not have send_count in cyclades_monitor structure
Date: Sun,  4 May 2014 16:49:46 +0100
Message-Id: <1399218596-21321-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is unlikely the information about sent data will ever appear to kernel
interface, so stop waiting it.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 34 +---------------------------------
 1 file changed, 1 insertion(+), 33 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index 995a75f..7ca39c7 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -55,26 +55,14 @@
 #include "closestream.h"
 #include "strutils.h"
 
-#if 0
-# ifndef XMIT
-#  include <linux/version.h>
-#  if LINUX_VERSION_CODE > 66056
-#   define XMIT
-#  endif
-# endif
-#endif
-
 #include "xalloc.h"
 #include "nls.h"
-/* Until it gets put in the kernel, toggle by hand. */
-#undef XMIT
 
 struct cyclades_control {
 	struct cyclades_monitor c;
 	int cfile;
 	int maxmax;
 	double maxtran;
-	double maxxmit;
 	unsigned long threshold_value;
 	unsigned long timeout_value;
 };
@@ -159,9 +147,6 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 	int i;
 	double diff;
 	double xfer_rate;
-#ifdef XMIT
-	double xmit_rate;
-#endif
 
 	cmon = xmalloc(sizeof(struct cyclades_control) * numfiles);
 
@@ -214,9 +199,6 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 				    _("cannot get timeout for %s"), argv[i]);
 
 			xfer_rate = cywork.char_count / diff;
-#ifdef XMIT
-			xmit_rate = cywork.send_count / diff;
-#endif
 			if ((*threshold_value) !=
 			    cmon[cmon_index].threshold_value
 			    || (*timeout_value) !=
@@ -232,10 +214,6 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 				/* Don't record this first cycle after change */
 				if (xfer_rate > cmon[cmon_index].maxtran)
 					cmon[cmon_index].maxtran = xfer_rate;
-#ifdef XMIT
-				if (xmit_rate > cmon[cmon_index].maxxmit)
-					cmon[cmon_index].maxxmit = xmit_rate;
-#endif
 				if (cmon[cmon_index].maxmax < 0 ||
 				    cywork.char_max >
 				    (unsigned long)cmon[cmon_index].maxmax)
@@ -243,16 +221,6 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 					    cywork.char_max;
 			}
 
-#ifdef XMIT
-			printf(_("%s: %lu ints, %lu/%lu chars; fifo: %lu thresh, %lu tmout, "
-				 "%lu max, %lu now\n"), argv[i],
-			       cywork.int_count, cywork.char_count,
-			       cywork.send_count, *threshold_value,
-			       *timeout_value, cywork.char_max,
-			       cywork.char_last);
-			printf(_("   %f int/sec; %f rec, %f send (char/sec)\n"),
-			       cywork.int_count / diff, xfer_rate, xmit_rate);
-#else
 			printf(_("%s: %lu ints, %lu chars; fifo: %lu thresh, %lu tmout, "
 				 "%lu max, %lu now\n"), argv[i],
 			       cywork.int_count, cywork.char_count,
@@ -260,7 +228,7 @@ static void query_tty_stats(int argc, char **argv, unsigned int interval, int nu
 			       cywork.char_last);
 			printf(_("   %f int/sec; %f rec (char/sec)\n"),
 			       cywork.int_count / diff, xfer_rate);
-#endif
+
 			memcpy(&cmon[cmon_index].c, &cywork,
 			       sizeof(struct cyclades_monitor));
 		}
-- 
1.9.2

