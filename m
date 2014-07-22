Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 03/13] sfdisk: remove dead code
Date: Tue, 22 Jul 2014 16:44:47 -0700
Message-Id: <1406072697-20912-4-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 6db9dfd..88f953d 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -436,18 +436,6 @@ get_cylindersize(char *dev, int fd, int silent) {
 		R.start);
 	exit(EXIT_FAILURE);
     }
-#if 0
-    if (R.heads && B.heads != R.heads)
-	warnx(_("Warning: HDIO_GETGEO says that there are %lu heads"),
-		R.heads);
-    if (R.sectors && B.sectors != R.sectors)
-	warnx(_("Warning: HDIO_GETGEO says that there are %lu sectors"),
-		R.sectors);
-    if (R.cylinders && B.cylinders != R.cylinders
-	&& B.cylinders < 65536 && R.cylinders < 65536)
-	warnx(_("Warning: BLKGETSIZE/HDIO_GETGEO says that there are %lu cylinders"),
-		R.cylinders);
-#endif
 
     if (B.sectors > 63)
 	warnx(_("Warning: unlikely number of sectors (%lu) - usually at most 63\n"
@@ -515,18 +503,6 @@ ulong_to_chs(unsigned long sno, struct geometry G) {
     return longchs_to_chs(ulong_to_longchs(sno, G), G);
 }
 
-#if 0
-static unsigned long
-longchs_to_ulong(longchs aa, struct geometry G) {
-    return (aa.c * G.cylindersize + aa.h * G.sectors + aa.s - 1);
-}
-
-static unsigned long
-chs_to_ulong(chs a, struct geometry G) {
-    return longchs_to_ulong(chs_to_longchs(a), G);
-}
-#endif
-
 static int
 is_equal_chs(chs a, chs b) {
     return (a.h == b.h && a.s == b.s && a.c == b.c);
@@ -1016,10 +992,6 @@ out_partition(char *dev, int format, struct part_desc *p,
 	out_rounddown(10, size, 1, 0);
 	break;
     case F_BLOCK:
-#if 0
-	printf("%8lu,%3lu ",
-	       p->sector / 2, ((p->sector & 1) ? 512 : 0) + p->offset);
-#endif
 	out_rounddown(8, start, 2, increment);
 	out_roundup(8, end, 2, increment);
 	out_rounddown(9, size, 2, 0);
@@ -1849,13 +1821,11 @@ first_free(int pno, int is_extended, struct part_desc *ep, int format,
 	else if (all_logicals_inside_outermost_extended)
 	    pp = outer_extended_partition(ep);
     }
-#if 0
-    ff = pp ? (pp->start + unit - 1) / unit : 0;
-#else
+
     /* rounding up wastes almost an entire cylinder - round down
        and leave it to compute_start_sect() to fix the difference */
     ff = pp ? pp->start / unit : 0;
-#endif
+
     /* MBR and 1st sector of an extended partition are never free */
     if (unit == 1)
 	ff++;
-- 
1.8.1.4
