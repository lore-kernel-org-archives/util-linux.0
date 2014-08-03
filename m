Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:39128 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbaHCOR4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Aug 2014 10:17:56 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so6440526wev.13
        for <util-linux@vger.kernel.org>; Sun, 03 Aug 2014 07:17:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/7] zramctl: fail status printout when device does not exist
Date: Sun,  3 Aug 2014 15:17:40 +0100
Message-Id: <1407075463-19586-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
References: <1407075463-19586-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier.

$ zramctl zram313 ; echo $?
0

Now.

$ zramctl zram313 ; echo $?
zramctl: zram313: no such device
1

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/zramctl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index 9a3d5d2..85dc30c 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -229,7 +229,7 @@ static struct zram *find_free_zram(void)
 	return z;
 }
 
-static void fill_table_row(struct libscols_table *tb, struct zram *z)
+static int fill_table_row(struct libscols_table *tb, struct zram *z)
 {
 	static struct libscols_line *ln;
 	struct sysfs_cxt *sysfs;
@@ -243,7 +243,7 @@ static void fill_table_row(struct libscols_table *tb, struct zram *z)
 
 	sysfs = zram_get_sysfs(z);
 	if (!sysfs)
-		return;
+		return 1;
 
 	ln = scols_table_new_line(tb, NULL);
 	if (!ln)
@@ -316,12 +316,14 @@ static void fill_table_row(struct libscols_table *tb, struct zram *z)
 		if (str)
 			scols_line_refer_data(ln, i, str);
 	}
+	return 0;
 }
 
-static void status(struct zram *z)
+static int status(struct zram *z)
 {
 	struct libscols_table *tb;
 	size_t i;
+	int ret = 0;
 
 	scols_init_debug(0);
 
@@ -340,7 +342,7 @@ static void status(struct zram *z)
 	}
 
 	if (z)
-		fill_table_row(tb, z);		/* just one device specified */
+		ret = fill_table_row(tb, z);		/* just one device specified */
 	else {
 		size_t i;			/* list all used devices */
 		z = new_zram(NULL);
@@ -356,6 +358,7 @@ static void status(struct zram *z)
 
 	scols_print_table(tb);
 	scols_unref_table(tb);
+	return ret;
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -513,8 +516,9 @@ int main(int argc, char **argv)
 			columns[ncolumns++] = COL_MOUNTPOINT;
 		}
 		if (optind < argc) {
-			zram = new_zram(argv[optind++]);
-			status(zram);
+			zram = new_zram(argv[optind]);
+			if (status(zram))
+				errx(EXIT_FAILURE, _("%s: no such device"), argv[optind]);
 			free_zram(zram);
 		} else
 			status(NULL);
-- 
2.0.3

