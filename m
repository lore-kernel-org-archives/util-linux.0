Return-Path: dave@gnu.org
Subject: [PATCH 4/8] fdisk: remove dead code
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:41 +0200
Message-ID: <1334569481.2552.13.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 1c0d7d8..f4b33d2 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1729,25 +1729,10 @@ static void check_consistency(struct partition *p, int partition) {
 		printf(_("logical=(%d, %d, %d)\n"),lec, leh, les);
 	}
 
-#if 0
-/* Beginning on cylinder boundary? */
-	if (pbh != !pbc || pbs != 1) {
-		printf(_("Partition %i does not start on cylinder "
-			"boundary:\n"), partition + 1);
-		printf(_("     phys=(%d, %d, %d) "), pbc, pbh, pbs);
-		printf(_("should be (%d, %d, 1)\n"), pbc, !pbc);
-	}
-#endif
-
 /* Ending on cylinder boundary? */
 	if (peh != (heads - 1) || pes != sectors) {
 		printf(_("Partition %i does not end on cylinder boundary.\n"),
 			partition + 1);
-#if 0
-		printf(_("     phys=(%d, %d, %d) "), pec, peh, pes);
-		printf(_("should be (%d, %d, %d)\n"),
-		pec, heads - 1, sectors);
-#endif
 	}
 }
 
@@ -2966,14 +2951,9 @@ main(int argc, char **argv) {
 		}
 	}
 
-#if 0
-	printf(_("This kernel finds the sector size itself - "
-		 "-b option ignored\n"));
-#else
 	if (user_set_sector_size && argc-optind != 1)
 		printf(_("Warning: the -b (set sector size) option should"
 			 " be used with one specified device\n"));
-#endif
 
 	init_mbr_buffer();
 
-- 
1.7.4.1
