Return-Path: dave@gnu.org
Subject: [PATCH 6/7] fdisk: sgi: use sector_t
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:20 +0200
Message-ID: <1338147860.22474.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisksgilabel.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index 3ef9d69..14e3443 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -691,7 +691,7 @@ create_sgilabel(struct fdisk_context *cxt)
 		int sysid;
 	} old[4];
 	int i=0;
-	unsigned long long llsectors;
+	sector_t llsectors;
 	int res; 		/* the result from the ioctl */
 	int sec_fac; 		/* the sector factor */
 
@@ -712,7 +712,7 @@ create_sgilabel(struct fdisk_context *cxt)
 	sectors = geometry.sectors;
 	if (res == 0) {
 		/* the get device size ioctl was successful */
-		unsigned long long llcyls;
+	        sector_t llcyls;
 		llcyls = llsectors / (heads * sectors * sec_fac);
 		cylinders = llcyls;
 		if (cylinders != llcyls)	/* truncated? */
-- 
1.7.4.1
