Return-Path: dave@gnu.org
Subject: [PATCH 09/10] fdisk: API: fix fdisk_label_create
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:45 +0200
Message-ID: <1342976745.2863.19.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

It wasn't actually calling create_label(), silly me!

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/utils.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 62cd6aa..510d641 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -143,11 +143,13 @@ int fdisk_label_create(struct fdisk_context *cxt, const char *name)
 #else
 		errcode = fdisk_label_change(cxt, "dos");
 #endif
-		if (errcode)
-			goto done;
-	}
-	
-	errcode = fdisk_label_change(cxt, name);
+	} else
+		errcode = fdisk_label_change(cxt, name);
+
+	if (errcode)
+		goto done;
+
+	errcode = cxt->label->create_label(cxt);
 done:
 	return errcode;
 }
-- 
1.7.4.1
