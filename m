Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54259 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728Ab2APFgR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Jan 2012 00:36:17 -0500
Received: by eekc14 with SMTP id c14so17692eek.19
        for <util-linux@vger.kernel.org>; Sun, 15 Jan 2012 21:36:16 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 1/2] fdisk: rename read_int_sx() and some related variables
Date: Mon, 16 Jan 2012 06:36:12 +0100
Message-Id: <1326692173-11791-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 8c143c3..764798d 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1298,10 +1298,10 @@ read_hex(struct systypes *sys)
 }
 
 static unsigned int
-read_int_sx(unsigned int low, unsigned int dflt, unsigned int high,
-	 unsigned int base, char *mesg, int *suffix)
+read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
+	 unsigned int base, char *mesg, int *is_suffix_used)
 {
-	unsigned int i;
+	unsigned int res;
 	int default_ok = 1;
 	static char *ms = NULL;
 	static size_t mslen = 0;
@@ -1334,7 +1334,7 @@ read_int_sx(unsigned int low, unsigned int dflt, unsigned int high,
 			int absolute = 0;
 			int suflen;
 
-			i = atoi(line_ptr+1);
+			res = atoi(line_ptr + 1);
 
 			while (isdigit(*++line_ptr))
 				use_default = 0;
@@ -1353,7 +1353,7 @@ read_int_sx(unsigned int low, unsigned int dflt, unsigned int high,
 				 * Cylinders
 				 */
 				if (!display_in_cyl_units)
-					i *= heads * sectors;
+					res *= heads * sectors;
 			} else if (*line_ptr &&
 				   *(line_ptr + 1) == 'B' &&
 				   *(line_ptr + 2) == '\0') {
@@ -1391,36 +1391,36 @@ read_int_sx(unsigned int low, unsigned int dflt, unsigned int high,
 				continue;
 			}
 
-			if (absolute && i) {
+			if (absolute && res) {
 				unsigned long long bytes;
 				unsigned long unit;
 
-				bytes = (unsigned long long) i * absolute;
+				bytes = (unsigned long long) res * absolute;
 				unit = sector_size * units_per_sector;
 				bytes += unit/2;	/* round */
 				bytes /= unit;
-				i = bytes;
-				if (suffix)
-					*suffix = absolute;
+				res = bytes;
+				if (is_suffix_used)
+					*is_suffix_used = absolute;
 			}
 			if (minus)
-				i = -i;
-			i += base;
+				res = -res;
+			res += base;
 		} else {
-			i = atoi(line_ptr);
+			res = atoi(line_ptr);
 			while (isdigit(*line_ptr)) {
 				line_ptr++;
 				use_default = 0;
 			}
 		}
 		if (use_default)
-			printf(_("Using default value %u\n"), i = dflt);
-		if (i >= low && i <= high)
+			printf(_("Using default value %u\n"), res = dflt);
+		if (res >= low && res <= high)
 			break;
 		else
 			printf(_("Value out of range.\n"));
 	}
-	return i;
+	return res;
 }
 
 /*
@@ -1434,7 +1434,7 @@ unsigned int
 read_int(unsigned int low, unsigned int dflt, unsigned int high,
 	 unsigned int base, char *mesg)
 {
-	return read_int_sx(low, dflt, high, base, mesg, NULL);
+	return read_int_with_suffix(low, dflt, high, base, mesg, NULL);
 }
 
 
@@ -2336,21 +2336,21 @@ add_partition(int n, int sys) {
 	if (cround(start) == cround(limit)) {
 		stop = limit;
 	} else {
-		int sx = 0;
+		int is_suffix_used = 0;
 
 		snprintf(mesg, sizeof(mesg),
 			_("Last %1$s, +%2$s or +size{K,M,G}"),
 			 str_units(SINGULAR), str_units(PLURAL));
 
-		stop = read_int_sx(cround(start), cround(limit), cround(limit),
-				cround(start), mesg, &sx);
+		stop = read_int_with_suffix(cround(start), cround(limit), cround(limit),
+				cround(start), mesg, &is_suffix_used);
 		if (display_in_cyl_units) {
 			stop = stop * units_per_sector - 1;
 			if (stop >limit)
 				stop = limit;
 		}
 
-		if (sx && alignment_required) {
+		if (is_suffix_used && alignment_required) {
 			/* the last sector has not been exactly requested (but
 			 * defined by +size{K,M,G} convention), so be smart
 			 * and align the end of the partition. The next
-- 
1.7.7

