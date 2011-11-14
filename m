Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:64342 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBsZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:25 -0500
Message-ID: <4EC07367.1080607@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:23 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 07/15] prlimit: fix case when getting missing limit is needed
 and PID is given later
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 07/15] prlimit: fix case when getting missing limit is needed and 
PID is given later

When the PID is given later than a partially given limit, then
prlimit used the current PID for getting the missing part
(hard, soft) of the limit. Example:
$ ps
   PID TTY          TIME CMD
   555 pts/6    00:00:00 bash
   ...
$ prlimit -p555 -n --noheadings
NOFILE   max amount of open files 1024 8192
$ sleep 100000&
[1] 650
$ prlimit -p555 -n:5000
$ prlimit -n4000: -p650
$ prlimit -p650 -n --noheadings
NOFILE   max amount of open files 4000 5000

Factored out the retrieval of the unknown limit from parse_prlim()
to new get_unknown_hardsoft() which is to be called by do_prlimit()
based on the new struct prlimit member 'found' set by add_prlim().

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   57 
++++++++++++++++++++++++++++++--------------------
  1 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 611f3e8..622a318 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -85,6 +85,7 @@ static struct prlimit_desc prlimit_desc[] =

  struct prlimit {
  	struct rlimit rlim;
+	int found;
  	struct prlimit_desc *desc;
  	int modify;
  };
@@ -294,6 +295,26 @@ done:
  	return 0;
  }

+static void get_unknown_hardsoft(struct prlimit *lim)
+{
+	/*
+	 * If one of the limits is unknown (default value for not being
+	 * passed), we need to get the current limit and use it.
+	 * I see no other way other than using prlimit(2).
+	 */
+	if (lim->found != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
+		struct rlimit old;
+
+		if (prlimit(pid, lim->desc->resource, NULL, &old) == -1)
+			errx(EXIT_FAILURE, _("failed to get old %s limit"),
+				lim->desc->resource);
+
+		if (!(lim->found & PRLIMIT_SOFT))
+			lim->rlim.rlim_cur = old.rlim_cur;
+		else if (!(lim->found & PRLIMIT_HARD))
+			lim->rlim.rlim_max = old.rlim_max;
+	}
+}

  static void do_prlimit(struct prlimit lims[], size_t n, int tt_flags)
  {
@@ -305,6 +326,17 @@ static void do_prlimit(struct prlimit lims[], 
size_t n, int tt_flags)
  		if (lims[i].modify) {
  			if (!pid)
  				warnx(_("setting limits of the prlimit process is pointless"));
+
+			get_unknown_hardsoft(&lims[i]);
+
+			/* final soft vs. hard limit check to have a
+			 * better diagnostic than "invalid argument".
+			 */
+			if ((lims[i].rlim.rlim_cur > lims[i].rlim.rlim_max) &&
+				(lims[i].rlim.rlim_cur != RLIM_INFINITY ||
+				 lims[i].rlim.rlim_max != RLIM_INFINITY))
+				errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling 
value"));
+
  			new = &lims[i].rlim;
  		} else {
  			nshows++;
@@ -420,31 +452,10 @@ static int parse_prlim(struct rlimit *lim, char 
*ops, size_t id)
  		errx(EXIT_FAILURE, _("failed to parse %s limit"),
  		     prlimit_desc[id].name);

-	/*
-	 * If one of the limits is unknown (default value for not being 
passed), we need
-	 * to get the current limit and use it.
-	 * I see no other way other than using prlimit(2).
-	 */
-	if (found != (PRLIMIT_HARD | PRLIMIT_SOFT)) {
-		struct rlimit old;
-
-		if (prlimit(pid, prlimit_desc[id].resource, NULL, &old) == -1)
-			errx(EXIT_FAILURE, _("failed to get old %s limit"),
-			     prlimit_desc[id].name);
-
-		if (!(found & PRLIMIT_SOFT))
-			soft = old.rlim_cur;
-		else if (!(found & PRLIMIT_HARD))
-			hard = old.rlim_max;
-	}
-
-	if (soft > hard && (soft != RLIM_INFINITY || hard != RLIM_INFINITY))
-		errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling value"));
-
  	lim->rlim_cur = soft;
  	lim->rlim_max = hard;

-	return 0;
+	return found;
  }

  /*
@@ -456,7 +467,7 @@ static int add_prlim(char *ops, struct prlimit *lim, 
size_t id)

  	if (ops) { /* planning on modifying a limit? */
  		lim->modify = 1;
-		parse_prlim(&lim->rlim, ops, id);
+		lim->found = parse_prlim(&lim->rlim, ops, id);
  	}

  	return 0;
