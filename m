Return-Path: dave@gnu.org
Date: Wed, 14 Dec 2011 18:58:26 +0100
From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] wipefs: use xalloc lib
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Message-id: <1323885506.1255.1.camel@offworld>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 14 Dec 2011 18:56:57 +0100

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/wipefs.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index f79fa3c..92f4101 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -132,10 +132,7 @@ add_offset(struct wipe_desc *wp0, loff_t offset, int zap)
 		wp = wp->next;
 	}
 
-	wp = calloc(1, sizeof(struct wipe_desc));
-	if (!wp)
-		err(EXIT_FAILURE, _("calloc failed"));
-
+	wp = xcalloc(1, sizeof(struct wipe_desc));
 	wp->offset = offset;
 	wp->next = wp0;
 	wp->zap = zap;
-- 
1.7.7.3
