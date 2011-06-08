Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1FHWxh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:37 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so829962iwn.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:37 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 1/6] fdisk, display, hexdump.h: Use standard C types instead of u_int, u_char, u_long, etc.
Date: Wed,  8 Jun 2011 16:52:43 -0600
Message-Id: <1307573568-23643-2-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 fdisk/fdiskbsdlabel.c |   34 +++++++++++++++++-----------------
 text-utils/display.c  |   32 ++++++++++++++++----------------
 text-utils/hexdump.h  |    4 ++--
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index 0c3810d..d379b70 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -71,7 +71,7 @@ static void xbsd_change_fstype (void);
 static int xbsd_get_part_index (int max);
 static int xbsd_check_new_partition (int *i);
 static void xbsd_list_types (void);
-static u_short xbsd_dkcksum (struct xbsd_disklabel *lp);
+static unsigned short xbsd_dkcksum (struct xbsd_disklabel *lp);
 static int xbsd_initlabel  (struct partition *p, struct xbsd_disklabel *d,
 			    int pindex);
 static int xbsd_readlabel  (struct partition *p, struct xbsd_disklabel *d);
@@ -463,28 +463,28 @@ xbsd_edit_disklabel (void)
   d = &xbsd_dlabel;
 
 #if defined (__alpha__) || defined (__ia64__)
-  d -> d_secsize    = (u_long) edit_int ((u_long) d -> d_secsize     ,_("bytes/sector"));
-  d -> d_nsectors   = (u_long) edit_int ((u_long) d -> d_nsectors    ,_("sectors/track"));
-  d -> d_ntracks    = (u_long) edit_int ((u_long) d -> d_ntracks     ,_("tracks/cylinder"));
-  d -> d_ncylinders = (u_long) edit_int ((u_long) d -> d_ncylinders  ,_("cylinders"));
+  d -> d_secsize    = (unsigned long) edit_int ((unsigned long) d -> d_secsize     ,_("bytes/sector"));
+  d -> d_nsectors   = (unsigned long) edit_int ((unsigned long) d -> d_nsectors    ,_("sectors/track"));
+  d -> d_ntracks    = (unsigned long) edit_int ((unsigned long) d -> d_ntracks     ,_("tracks/cylinder"));
+  d -> d_ncylinders = (unsigned long) edit_int ((unsigned long) d -> d_ncylinders  ,_("cylinders"));
 #endif
 
   /* d -> d_secpercyl can be != d -> d_nsectors * d -> d_ntracks */
   while (1)
   {
-    d -> d_secpercyl = (u_long) edit_int ((u_long) d -> d_nsectors * d -> d_ntracks,
+    d -> d_secpercyl = (unsigned long) edit_int ((unsigned long) d -> d_nsectors * d -> d_ntracks,
 					  _("sectors/cylinder"));
     if (d -> d_secpercyl <= d -> d_nsectors * d -> d_ntracks)
       break;
 
     printf (_("Must be <= sectors/track * tracks/cylinder (default).\n"));
   }
-  d -> d_rpm        = (u_short) edit_int ((u_short) d -> d_rpm       ,_("rpm"));
-  d -> d_interleave = (u_short) edit_int ((u_short) d -> d_interleave,_("interleave"));
-  d -> d_trackskew  = (u_short) edit_int ((u_short) d -> d_trackskew ,_("trackskew"));
-  d -> d_cylskew    = (u_short) edit_int ((u_short) d -> d_cylskew   ,_("cylinderskew"));
-  d -> d_headswitch = (u_long) edit_int ((u_long) d -> d_headswitch  ,_("headswitch"));
-  d -> d_trkseek    = (u_long) edit_int ((u_long) d -> d_trkseek     ,_("track-to-track seek"));
+  d -> d_rpm        = (unsigned short) edit_int ((unsigned short) d -> d_rpm       ,_("rpm"));
+  d -> d_interleave = (unsigned short) edit_int ((unsigned short) d -> d_interleave,_("interleave"));
+  d -> d_trackskew  = (unsigned short) edit_int ((unsigned short) d -> d_trackskew ,_("trackskew"));
+  d -> d_cylskew    = (unsigned short) edit_int ((unsigned short) d -> d_cylskew   ,_("cylinderskew"));
+  d -> d_headswitch = (unsigned long) edit_int ((unsigned long) d -> d_headswitch  ,_("headswitch"));
+  d -> d_trkseek    = (unsigned long) edit_int ((unsigned long) d -> d_trkseek     ,_("track-to-track seek"));
 
   d -> d_secperunit = d -> d_secpercyl * d -> d_ncylinders;
 }
@@ -638,13 +638,13 @@ xbsd_list_types (void) {
 	list_types (xbsd_fstypes);
 }
 
-static u_short
+static unsigned short
 xbsd_dkcksum (struct xbsd_disklabel *lp) {
-	u_short *start, *end;
-	u_short sum = 0;
+	unsigned short *start, *end;
+	unsigned short sum = 0;
   
-	start = (u_short *) lp;
-	end = (u_short *) &lp->d_partitions[lp->d_npartitions];
+	start = (unsigned short *) lp;
+	end = (unsigned short *) &lp->d_partitions[lp->d_npartitions];
 	while (start < end)
 		sum ^= *start++;
 	return sum;
diff --git a/text-utils/display.c b/text-utils/display.c
index 01805a2..c700b02 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -55,11 +55,11 @@ static off_t address;			/* address/offset in stream */
 static off_t eaddress;			/* end address */
 
 static inline void
-print(PR *pr, u_char *bp) {
+print(PR *pr, unsigned char *bp) {
 
 	switch(pr->flags) {
 	case F_ADDRESS:
-		(void)printf(pr->fmt, (quad_t)address);
+		(void)printf(pr->fmt, (int64_t)address);
 		break;
 	case F_BPAD:
 		(void)printf(pr->fmt, "");
@@ -90,23 +90,23 @@ print(PR *pr, u_char *bp) {
 	    {
 		short sval;	/* int16_t */
 		int ival;	/* int32_t */
-		long long Lval;	/* int64_t, quad_t */
+		long long Lval;	/* int64_t, int64_t */
 
 		switch(pr->bcnt) {
 		case 1:
-			(void)printf(pr->fmt, (quad_t)*bp);
+			(void)printf(pr->fmt, (int64_t)*bp);
 			break;
 		case 2:
 			memmove(&sval, bp, sizeof(sval));
-			(void)printf(pr->fmt, (quad_t)sval);
+			(void)printf(pr->fmt, (int64_t)sval);
 			break;
 		case 4:
 			memmove(&ival, bp, sizeof(ival));
-			(void)printf(pr->fmt, (quad_t)ival);
+			(void)printf(pr->fmt, (int64_t)ival);
 			break;
 		case 8:
 			memmove(&Lval, bp, sizeof(Lval));
-			(void)printf(pr->fmt, (quad_t)Lval);
+			(void)printf(pr->fmt, (int64_t)Lval);
 			break;
 		}
 		break;
@@ -127,23 +127,23 @@ print(PR *pr, u_char *bp) {
 	    {
 		unsigned short sval;	/* u_int16_t */
 		unsigned int ival;	/* u_int32_t */
-		unsigned long long Lval;/* u_int64_t, u_quad_t */
+		unsigned long long Lval;/* u_int64_t, u_int64_t */
 
 		switch(pr->bcnt) {
 		case 1:
-			(void)printf(pr->fmt, (u_quad_t)*bp);
+			(void)printf(pr->fmt, (uint64_t)*bp);
 			break;
 		case 2:
 			memmove(&sval, bp, sizeof(sval));
-			(void)printf(pr->fmt, (u_quad_t)sval);
+			(void)printf(pr->fmt, (uint64_t)sval);
 			break;
 		case 4:
 			memmove(&ival, bp, sizeof(ival));
-			(void)printf(pr->fmt, (u_quad_t)ival);
+			(void)printf(pr->fmt, (uint64_t)ival);
 			break;
 		case 8:
 			memmove(&Lval, bp, sizeof(Lval));
-			(void)printf(pr->fmt, (u_quad_t)Lval);
+			(void)printf(pr->fmt, (uint64_t)Lval);
 			break;
 		}
 		break;
@@ -174,9 +174,9 @@ void display(void)
 	register FU *fu;
 	register PR *pr;
 	register int cnt;
-	register u_char *bp;
+	register unsigned char *bp;
 	off_t saveaddress;
-	u_char savech = 0, *savebp;
+	unsigned char savech = 0, *savebp;
 
 	while ((bp = get()) != NULL)
 	    for (fs = fshead, savebp = bp, saveaddress = address; fs;
@@ -212,7 +212,7 @@ void display(void)
 		for (pr = endfu->nextpr; pr; pr = pr->nextpr)
 			switch(pr->flags) {
 			case F_ADDRESS:
-				(void)printf(pr->fmt, (quad_t)eaddress);
+				(void)printf(pr->fmt, (int64_t)eaddress);
 				break;
 			case F_TEXT:
 				(void)printf("%s", pr->fmt);
@@ -261,7 +261,7 @@ get(void)
 			eaddress = address + nread;
 			return(curp);
 		}
-		n = fread((char *)curp + nread, sizeof(u_char),
+		n = fread((char *)curp + nread, sizeof(unsigned char),
 		    length == -1 ? need : MIN(length, need), stdin);
 		if (!n) {
 			if (ferror(stdin))
diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
index 3df8629..52a64bf 100644
--- a/text-utils/hexdump.h
+++ b/text-utils/hexdump.h
@@ -46,7 +46,7 @@ typedef struct _pr {
 #define	F_U		0x100		/* %_u */
 #define	F_UINT		0x200		/* %[ouXx] */
 #define	F_TEXT		0x400		/* no conversions */
-	u_int flags;			/* flag values */
+	unsigned int flags;		/* flag values */
 	int bcnt;			/* byte count */
 	char *cchar;			/* conversion character */
 	char *fmt;			/* printf format */
@@ -58,7 +58,7 @@ typedef struct _fu {
 	struct _pr *nextpr;		/* next print unit */
 #define	F_IGNORE	0x01		/* %_A */
 #define	F_SETREP	0x02		/* rep count set, not default */
-	u_int flags;			/* flag values */
+	unsigned int flags;		/* flag values */
 	int reps;			/* repetition count */
 	int bcnt;			/* byte count */
 	char *fmt;			/* format string */
-- 
1.7.5.3

