Return-Path: dave@gnu.org
Date: Fri, 27 Apr 2012 13:23:47 +0200
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH 2/4] fdisk: remove listing variable
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1335525827.11068.5.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

useless global variable.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 886f011..f49efd0 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -216,7 +216,6 @@ char	*disk_device,			/* must be specified */
 
 int	fd,				/* the disk */
 	ext_index,			/* the prime extended partition */
-	listing = 0,			/* no aborts for fdisk -l */
 	nowarn = 0,			/* no warnings for fdisk -l/-s */
 	dos_compatible_flag = 0,	/* disabled by default */
 	dos_changed = 0,
@@ -2940,7 +2939,6 @@ main(int argc, char **argv) {
 		nowarn = 1;
 		if (argc > optind) {
 			int k;
-			listing = 1;
 			for (k = optind; k < argc; k++)
 				print_partition_table_from_option(argv[k]);
 		} else
-- 
1.7.4.1
