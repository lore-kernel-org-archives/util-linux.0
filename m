Return-Path: dave@gnu.org
Message-ID: <1349620441.2548.9.camel@offbook>
Subject: [PATCH 4/5] fdisk: fix segfault when printing gpt raw data
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 07 Oct 2012 16:34:01 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/fdisk.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 612bf87..a3ac087 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1390,7 +1390,8 @@ static void print_raw(struct fdisk_context *cxt)
 	int i;
 
 	printf(_("Device: %s\n"), cxt->dev_path);
-	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
+	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL ||
+	    disklabel == GPT_LABEL)
 		print_buffer(cxt, cxt->firstsector);
 	else for (i = 3; i < partitions; i++)
 		     print_buffer(cxt, ptes[i].sectorbuffer);
-- 
1.7.9.5
