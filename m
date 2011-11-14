Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:55061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab1KNBsj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:39 -0500
Message-ID: <4EC07375.20005@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:37 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 10/15] prlimit: refactor code: separate modify and show clearly
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 10/15] prlimit: refactor code: separate modify and show clearly

Struct prlimit now has a flag whether a limit has to be modified,
and a flag whether the limit has to be shown; names "modify" and
"show". Furthermore, move show_limits() to main().

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   37 +++++++++++++++++++------------------
  1 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 4124faa..fc11a94 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -85,12 +85,12 @@ static struct prlimit_desc prlimit_desc[] =

  struct prlimit {
  	struct rlimit rlim;
-	int found;
  	struct prlimit_desc *desc;
  	int modify;
+	int show;
  };

-#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0 }
+#define PRLIMIT_EMPTY_LIMIT	{{ 0, 0, }, NULL, 0, 0 }

  enum {
  	COL_HELP,
@@ -286,7 +286,7 @@ static int show_limits(struct prlimit lims[], size_t 
n, int tt_flags)
  	}

  	for (i = 0; (size_t) i < n; i++)
-		if (!lims[i].modify) /* only display old limits */
+		if (lims[i].show)
  			add_tt_line(tt, &lims[i]);

  	tt_print_table(tt);
@@ -302,23 +302,23 @@ static void get_unknown_hardsoft(struct prlimit *lim)
  	 * passed), we need to get the current limit and use it.
  	 * I see no other way other than using prlimit(2).
  	 */
-	if (lim->found != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
+	if (lim->modify != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
  		struct rlimit old;

  		if (prlimit(pid, lim->desc->resource, NULL, &old) == -1)
  			errx(EXIT_FAILURE, _("failed to get old %s limit"),
  				lim->desc->resource);

-		if (!(lim->found & PRLIMIT_SOFT))
+		if (!(lim->modify & PRLIMIT_SOFT))
  			lim->rlim.rlim_cur = old.rlim_cur;
-		else if (!(lim->found & PRLIMIT_HARD))
+		else if (!(lim->modify & PRLIMIT_HARD))
  			lim->rlim.rlim_max = old.rlim_max;
  			
  		/* give better diagnostic in cases where the new hard limit
  		 * would be lower than the current soft limit, and the user
  		 * did not give a new soft limit.
  		 */
-		if (!(lim->found & PRLIMIT_SOFT) &&
+		if (!(lim->modify & PRLIMIT_SOFT) &&
  			(lim->rlim.rlim_cur > lim->rlim.rlim_max)) {
  			errx(EXIT_FAILURE,
  				_("current soft limit %s is greater than new hard limit"),
@@ -329,7 +329,7 @@ static void get_unknown_hardsoft(struct prlimit *lim)

  static void do_prlimit(struct prlimit lims[], size_t n, int tt_flags)
  {
-	size_t i, nshows = 0;
+	size_t i;

  	for (i = 0; i < n; i++) {
  		struct rlimit *new = NULL;
@@ -349,8 +349,6 @@ static void do_prlimit(struct prlimit lims[], size_t 
n, int tt_flags)
  				errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling 
value"));

  			new = &lims[i].rlim;
-		} else {
-			nshows++;
  		}

  		if (verbose && new) {
@@ -384,9 +382,6 @@ static void do_prlimit(struct prlimit lims[], size_t 
n, int tt_flags)
  			}
  		}
  	}
-
-	if (nshows)
-		show_limits(lims, n, tt_flags);
  }


@@ -457,16 +452,16 @@ static int get_range(char *str, rlim_t *soft, 
rlim_t *hard, int *found)
  static int parse_prlim(struct rlimit *lim, char *ops, size_t id)
  {
  	rlim_t soft, hard;
-	int found = 0;
+	int modify = 0;

-	if (get_range(ops, &soft, &hard, &found))
+	if (get_range(ops, &soft, &hard, &modify))
  		errx(EXIT_FAILURE, _("failed to parse %s limit"),
  		     prlimit_desc[id].name);

  	lim->rlim_cur = soft;
  	lim->rlim_max = hard;

-	return found;
+	return modify;
  }

  /*
@@ -477,8 +472,13 @@ static int add_prlim(char *ops, struct prlimit 
*lim, size_t id)
  	lim->desc = &prlimit_desc[id];

  	if (ops) { /* planning on modifying a limit? */
-		lim->modify = 1;
-		lim->found = parse_prlim(&lim->rlim, ops, id);
+		int modify = parse_prlim(&lim->rlim, ops, id);
+		if (modify)
+			lim->modify = 1;
+		else
+			lim->show = 1;
+	} else {
+		lim->show = 1;
  	}

  	return 0;
@@ -630,6 +630,7 @@ int main(int argc, char **argv)
  	}

  	do_prlimit(lims, n, tt_flags);
+	show_limits(lims, n, tt_flags);

  	return EXIT_SUCCESS;
  }
