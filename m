Return-Path: dave@gnu.org
Subject: [PATCH] partx: use sysfs_deinit
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 18:51:16 -0400
Message-ID: <1311547876.3367.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 24 Jul 2011 11:29:23 -0400


Commit a88268b8cc124b6f721ba17ab01a3f6d5800c749 (get partition number with sysfs lib) recently added the sysfs library to partx without freeing resources once finished.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 partx/partx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/partx/partx.c b/partx/partx.c
index e29e50d..4f827a8 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -137,8 +137,10 @@ static int get_partno_from_device(char *partition, dev_t devno)
 		struct sysfs_cxt cxt;
 
 		sysfs_init(&cxt, devno, NULL);
-		if (sysfs_read_int(&cxt, "partition", &partno) >= 0)
+		if (sysfs_read_int(&cxt, "partition", &partno) >= 0) {
+			sysfs_deinit(&cxt);
 			return partno;
+		}
 	}
 
 	sz = strlen(partition);
-- 
1.7.4.1
