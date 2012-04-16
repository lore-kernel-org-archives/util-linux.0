Return-Path: dave@gnu.org
Subject: [PATCH 6/8] fdisk: do not call sgi and sun code when creating a
 new dos label
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 16 Apr 2012 11:44:46 +0200
Message-ID: <1334569487.2552.15.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

When creating a new DOS label, SGI and SUN pt logic have no business being there. Remove sun/sgi_nolabel(), since
the default amount of partitions are previously set to 4 and the sun/sgi magic nums are not used in this context.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index f4b33d2..15fb56c 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -838,8 +838,6 @@ create_doslabel(void) {
 	random_get_bytes(&id, sizeof(id));
 
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
-	sun_nolabel();  /* otherwise always recognised as sun */
-	sgi_nolabel();  /* otherwise always recognised as sgi */
 
 	dos_init();
 	zeroize_mbr_buffer();
-- 
1.7.4.1
