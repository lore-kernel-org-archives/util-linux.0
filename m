Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35638 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753712Ab1FFTHc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2011 15:07:32 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1468665eyx.19
        for <util-linux@vger.kernel.org>; Mon, 06 Jun 2011 12:07:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/6] sfdisk: previously undocumented options to usage
Date: Mon,  6 Jun 2011 21:07:16 +0200
Message-Id: <1307387239-9022-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
References: <1307387239-9022-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisk/sfdisk.c |   71 +++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 1b35f66..d4dbcca 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -2319,26 +2319,43 @@ static void usage(FILE * out)
 	fprintf(out, _("\nOptions:\n"
 		       "  -s, --show-size         list size of a partition\n"
 		       "  -c, --id                change or print partition Id\n"
+		       "      --change-id         change Id\n"
+		       "      --print-id          print Id\n"
 		       "  -l, --list              list partitions of each device\n"
 		       "  -d, --dump              idem, but in a format suitable for later input\n"
 		       "  -i, --increment         number cylinders etc. from 1 instead of from 0\n"
 		       "  -u, --unit=[SBCM]       units in sectors, blocks, cylinders or MB\n"
+		       "  -1, --one-only          reserved option that does nothing currently\n"
 		       "  -T, --list-types        list the known partition types\n"
 		       "  -D, --DOS               for DOS-compatibility: waste a little space\n"
+		       "  -E, --DOS-extended      DOS extended partition compatibility\n"
 		       "  -R, --re-read           make kernel reread partition table\n"
 		       "  -N=NUM                  change only the partition with number NUM\n"
 		       "  -n                      do not actually write to disk\n"
 		       "  -O FILE                 save the sectors that will be overwritten to file\n"
 		       "  -I FILE                 restore sectors from file\n"
+		       "  -V, --verify            check that listed partition is reasonable\n"
 		       "  -v, --version           print version\n"
 		       "  -h, --help              print this message\n"));
 
 	fprintf(out, _("\nDangerous options:\n"
 		       "  -f, --force             disable all consistency checking\n"
 		       "  -g, --show-geometry     print the kernel's idea of the geometry\n"
+		       "  -A, --activate[=device] activate bootable flag\n"
 		       "  -G, --show-pt-geometry  print geometry guessed from the partition table\n"
+		       "  -U, --unhide[=device]   set partition unhidden\n"
+		       "      --no-reread         skip partition re-read at boot\n"
 		       "  -x, --show-extended     also list extended partitions on output\n"
 		       "                          or expect descriptors for them on input\n"
+		       "      --leave-last        do not allocate the last cylinder\n"
+		       "      --IBM               same as --leave-last\n"
+		       "      --in-order          partitions are in order\n"
+		       "      --not-in-order      partitions are not in order\n"
+		       "      --inside-order      all logicals inside outermost extended\n"
+		       "      --not-inside-order  not all logicals inside outermost extended\n"
+		       "      --nested            every partition is disjoint from all others\n"
+		       "      --chained           like nested, but extended partitions may lie outside\n"
+		       "      --onesector         partitions are mutually disjoint\n"
 		       "  -L, --Linux             do not complain about things irrelevant for Linux\n"
 		       "  -q, --quiet             suppress warning messages\n"
 		       "\n  Override the detected geometry using:\n"
@@ -2369,6 +2386,18 @@ static const char short_opts[] = "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V";
 #define PRINT_ID 0400
 #define CHANGE_ID 01000
 
+enum {
+    OPT_NO_REREAD = CHAR_MAX + 1,
+    OPT_LEAVE_LAST,
+    OPT_IN_ORDER,
+    OPT_NOT_IN_ORDER,
+    OPT_INSIDE_OUTER,
+    OPT_NOT_INSIDE_OUTER,
+    OPT_NESTED,
+    OPT_CHAINED,
+    OPT_ONESECTOR
+};
+
 static const struct option long_opts[] = {
     { "change-id",	  no_argument, NULL, 'c' + CHANGE_ID },
     { "print-id",	  no_argument, NULL, 'c' + PRINT_ID },
@@ -2396,17 +2425,17 @@ static const struct option long_opts[] = {
     { "re-read",          no_argument, NULL, 'R' },
     { "list-types",       no_argument, NULL, 'T' },
     { "unhide",     optional_argument, NULL, 'U' },
-    { "no-reread",        no_argument, NULL, 160 },
-    { "IBM",              no_argument, NULL, 161 },
-    { "leave-last",       no_argument, NULL, 161 },
-/* undocumented flags - not all completely implemented */
-    { "in-order",         no_argument, NULL, 128 },
-    { "not-in-order",     no_argument, NULL, 129 },
-    { "inside-outer",     no_argument, NULL, 130 },
-    { "not-inside-outer", no_argument, NULL, 131 },
-    { "nested",           no_argument, NULL, 132 },
-    { "chained",          no_argument, NULL, 133 },
-    { "onesector",        no_argument, NULL, 134 },
+    { "no-reread",        no_argument, NULL, OPT_NO_REREAD },
+    { "IBM",              no_argument, NULL, OPT_LEAVE_LAST },
+    { "leave-last",       no_argument, NULL, OPT_LEAVE_LAST },
+/* dangerous flags - not all completely implemented */
+    { "in-order",         no_argument, NULL, OPT_IN_ORDER },
+    { "not-in-order",     no_argument, NULL, OPT_NOT_IN_ORDER },
+    { "inside-outer",     no_argument, NULL, OPT_INSIDE_OUTER },
+    { "not-inside-outer", no_argument, NULL, OPT_NOT_INSIDE_OUTER },
+    { "nested",           no_argument, NULL, OPT_NESTED },
+    { "chained",          no_argument, NULL, OPT_CHAINED },
+    { "onesector",        no_argument, NULL, OPT_ONESECTOR },
     { NULL, 0, NULL, 0 }
 };
 
@@ -2598,26 +2627,26 @@ main(int argc, char **argv) {
 	  default:
 	    usage(stderr); break;
 
-	  /* undocumented flags */
-	  case 128:
+	  /* dangerous flags */
+	  case OPT_IN_ORDER:
 	    partitions_in_order = 1; break;
-	  case 129:
+	  case OPT_NOT_IN_ORDER:
 	    partitions_in_order = 0; break;
-	  case 130:
+	  case OPT_INSIDE_OUTER:
 	    all_logicals_inside_outermost_extended = 1; break;
-	  case 131:
+	  case OPT_NOT_INSIDE_OUTER:
 	    all_logicals_inside_outermost_extended = 0; break;
-	  case 132:
+	  case OPT_NESTED:
 	    boxes = NESTED; break;
-	  case 133:
+	  case OPT_CHAINED:
 	    boxes = CHAINED; break;
-	  case 134:
+	  case OPT_ONESECTOR:
 	    boxes = ONESECTOR; break;
 
 	  /* more flags */
-	  case 160:
+	  case OPT_NO_REREAD:
 	    no_reread = 1; break;
-	  case 161:
+	  case OPT_LEAVE_LAST:
 	    leave_last = 1; break;
 	}
     }
-- 
1.7.5.2

