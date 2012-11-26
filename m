Return-Path: dave@gnu.org
Message-ID: <1353904152.2945.17.camel@offbook>
Subject: [PATCH 2/3] fdisk: remove dead code
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 25 Nov 2012 20:29:12 -0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 5683307..d9e4f62 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -352,15 +352,6 @@ sector_t align_lba(struct fdisk_context *cxt, sector_t lba, int direction)
 		}
 	}
 
-	/***
-	 fprintf(stderr, "LBA %llu (%s) --align-(%s)--> %llu (%s)\n",
-				lba,
-				lba_is_aligned(lba) ? "OK" : "FALSE",
-				direction == ALIGN_UP ?   "UP     " :
-				direction == ALIGN_DOWN ? "DOWN   " : "NEAREST",
-				res,
-				lba_is_aligned(res) ? "OK" : "FALSE");
-	***/
 	return res;
 }
 
-- 
1.7.9.5
