Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757277AbcK3OXy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 30 Nov 2016 09:23:54 -0500
Received: from zappa.ga.local ([87.128.112.108]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKpQ4-1cC5nb14KW-0001K7 for
 <util-linux@vger.kernel.org>; Wed, 30 Nov 2016 15:23:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] misc: fix typos using codespell
Date: Wed, 30 Nov 2016 15:23:50 +0100
Message-Id: <1480515830-1408-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
References: <1480515830-1408-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

 # command used was:
 $ ~/src/codespell/codespell \
   -w -D /home/rudi/src/codespell/build/lib/codespell_lib/data/dictionary.txt \
   $(git ls-files | grep -v "^po/\|\.xz$\|\.gz$\|\.bz2$\|\.img$\|^Documentation/releases/")

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libsmartcols/src/table.c       | 4 ++--
 libsmartcols/src/table_print.c | 2 +-
 misc-utils/cal.c               | 2 +-
 sys-utils/lsmem.1              | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libsmartcols/src/table.c b/libsmartcols/src/table.c
index 5a6318d..68f570d 100644
--- a/libsmartcols/src/table.c
+++ b/libsmartcols/src/table.c
@@ -737,7 +737,7 @@ int scols_table_set_default_symbols(struct libscols_table *tb)
  * draw tree output. If no symbols are used for the table then library creates
  * default temporary symbols to draw output by scols_table_set_default_symbols().
  *
- * If @sy is NULL then remove reference from the currenly uses symbols.
+ * If @sy is NULL then remove reference from the currently used symbols.
  *
  * Returns: 0, a negative value in case of an error.
  */
@@ -749,7 +749,7 @@ int scols_table_set_symbols(struct libscols_table *tb,
 
 	/* remove old */
 	if (tb->symbols) {
-		DBG(TAB, ul_debugobj(tb, "remove symbols %p refrence", tb->symbols));
+		DBG(TAB, ul_debugobj(tb, "remove symbols %p reference", tb->symbols));
 		scols_unref_symbols(tb->symbols);
 		tb->symbols = NULL;
 	}
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index c73154e..8c1c400 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -1471,7 +1471,7 @@ done:
 /**
  * scols_table_print_range_to_string:
  * @tb: table
- * @start: first printed line or NULL to print from the beggin of the table
+ * @start: first printed line or NULL to print from the begin of the table
  * @end: last printed line or NULL to print all from start.
  * @data: pointer to the beginning of a memory area to print to
  *
diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 5e7b356..0e2f0d4 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -206,7 +206,7 @@ struct cal_control {
 	const char *abbr_month[MONTHS_IN_YEAR];	/* abbreviated month names */
 
 	int colormode;			/* day and week number highlight */
-	int num_months;			/* number of requested monts */
+	int num_months;			/* number of requested months */
 	int span_months;		/* span the date */
 	int months_in_row;		/* number of months horizontally in print out */
 	int weekstart;			/* day the week starts, often Sun or Mon */
diff --git a/sys-utils/lsmem.1 b/sys-utils/lsmem.1
index a9e2bfc..dc34847 100644
--- a/sys-utils/lsmem.1
+++ b/sys-utils/lsmem.1
@@ -18,7 +18,7 @@ together with a columns list in environments where a stable output is required.
 Not all columns are supported on all systems.  If an unsupported column is
 specified, \fBlsmem\fP prints the column but does not provide any data for it.
 
-Use the \fB\-\-help\fR option to see the columns desription.
+Use the \fB\-\-help\fR option to see the columns description.
 
 .SH OPTIONS
 .TP
-- 
1.8.5.6

