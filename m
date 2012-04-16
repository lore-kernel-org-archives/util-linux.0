Return-Path: dave@gnu.org
Subject: [PATCH 1/8] fdisk: make CHS user values more robust
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:33 +0200
Message-ID: <1334569473.2552.10.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/cfdisk.c |    6 +++---
 fdisk/fdisk.c  |    8 ++++----
 fdisk/sfdisk.c |    9 +++++----
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fdisk/cfdisk.c b/fdisk/cfdisk.c
index a6cf01e..33624bb 100644
--- a/fdisk/cfdisk.c
+++ b/fdisk/cfdisk.c
@@ -2776,7 +2776,7 @@ main(int argc, char **argv)
 	    arrow_cursor = TRUE;
 	    break;
 	case 'c':
-	    user_cylinders = cylinders = atoll(optarg);
+		user_cylinders = cylinders = strtoll_or_err(optarg, _("cannot parse amount of cylinders"));
 	    if (cylinders <= 0) {
 		fprintf(stderr, "%s: %s\n", argv[0], _("Illegal cylinders value"));
 		exit(1);
@@ -2786,14 +2786,14 @@ main(int argc, char **argv)
 	    use_partition_table_geometry = TRUE;
 	    break;
 	case 'h':
-	    user_heads = heads = atoi(optarg);
+	    user_heads = heads = strtol_or_err(optarg, _("cannot parse amount of heads"));
 	    if (heads <= 0 || heads > MAX_HEADS) {
 		fprintf(stderr, "%s: %s\n", argv[0], _("Illegal heads value"));
 		exit(1);
 	    }
 	    break;
 	case 's':
-	    user_sectors = sectors = atoi(optarg);
+	    user_sectors = sectors = strtol_or_err(optarg, _("cannot parse amount of sectors"));
 	    if (sectors <= 0 || sectors > MAX_SECTORS) {
 		fprintf(stderr, "%s: %s\n", argv[0], _("Illegal sectors value"));
 		exit(1);
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index cf64fa7..0ccabb7 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2914,7 +2914,7 @@ main(int argc, char **argv) {
 			   so cannot be combined with multiple disks,
 			   and te same goes for the C/H/S options.
 			*/
-			sector_size = atoi(optarg);
+			sector_size = strtol_or_err(optarg, _("cannot parse sector size"));
 			if (sector_size != 512 && sector_size != 1024 &&
 			    sector_size != 2048 && sector_size != 4096)
 				usage(stderr);
@@ -2922,7 +2922,7 @@ main(int argc, char **argv) {
 			user_set_sector_size = 1;
 			break;
 		case 'C':
-			user_cylinders = atoi(optarg);
+			user_cylinders =  strtol_or_err(optarg, _("cannot parse amount of cylinders"));
 			break;
 		case 'c':
 			dos_compatible_flag = 0;	/* default */
@@ -2936,12 +2936,12 @@ main(int argc, char **argv) {
 			usage(stdout);
 			break;
 		case 'H':
-			user_heads = atoi(optarg);
+			user_heads =  strtol_or_err(optarg, _("cannot parse amount of heads"));
 			if (user_heads <= 0 || user_heads > 256)
 				user_heads = 0;
 			break;
 		case 'S':
-			user_sectors = atoi(optarg);
+			user_sectors =  strtol_or_err(optarg, _("cannot parse amount of sectors"));
 			if (user_sectors <= 0 || user_sectors >= 64)
 				user_sectors = 0;
 			break;
diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 95e5828..8bd27da 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -55,6 +55,7 @@
 #include "canonicalize.h"
 #include "rpmatch.h"
 #include "closestream.h"
+#include "strutils.h"
 
 /*
  * Table of contents:
@@ -2643,7 +2644,7 @@ main(int argc, char **argv) {
 	    activate = 1;
 	    break;
 	case 'C':
-	    U.cylinders = atoi(optarg);
+	    U.cylinders = strtoll_or_err(optarg, _("cannot parse amount of cylinders"));
 	    break;
 	case 'D':
 	    DOS = 1;
@@ -2652,13 +2653,13 @@ main(int argc, char **argv) {
 	    DOS_extended = 1;
 	    break;
 	case 'H':
-	    U.heads = atoi(optarg);
+	    U.heads = strtol_or_err(optarg, _("cannot parse amount of heads"));
 	    break;
 	case 'L':
 	    Linux = 1;
 	    break;
 	case 'N':
-	    one_only = atoi(optarg);
+	    one_only = strtol_or_err(optarg, _("cannot parse amount of partitions"));
 	    break;
 	case 'I':
 	    restore_sector_file = optarg;
@@ -2670,7 +2671,7 @@ main(int argc, char **argv) {
 	    opt_reread = 1;
 	    break;
 	case 'S':
-	    U.sectors = atoi(optarg);
+	    U.sectors = strtol_or_err(optarg, _("cannot parse amount of sectors"));
 	    break;
 	case 'T':
 	    list_types();
-- 
1.7.4.1
