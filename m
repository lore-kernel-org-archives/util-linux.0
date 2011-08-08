Return-Path: dave@gnu.org
Subject: [PATCH] correct trivial typo
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 07 Aug 2011 23:16:19 -0400
Message-ID: <1312773379.3050.0.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Should say "failed to find" instead of "failed to found".

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 lib/loopdev.c          |    2 +-
 libmount/src/context.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 0ef7136..fa3ad45 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1063,7 +1063,7 @@ static int test_loop_setup(const char *filename, const char *device)
 		if (!device) {
 			rc = loopcxt_find_unused(&lc);
 			if (rc)
-				err(EXIT_FAILURE, "failed to found unused device");
+				err(EXIT_FAILURE, "failed to find unused device");
 			printf("Trying to use '%s'\n", loopcxt_get_device(&lc));
 		}
 
diff --git a/libmount/src/context.c b/libmount/src/context.c
index d9b3116..2210260 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1549,7 +1549,7 @@ int mnt_context_apply_fstab(struct libmnt_context *cxt)
 			rc = apply_table(cxt, tab, MNT_ITER_BACKWARD);
 	}
 	if (rc)
-		DBG(CXT, mnt_debug_h(cxt, "failed to found entry in fstab/mtab"));
+		DBG(CXT, mnt_debug_h(cxt, "failed to find entry in fstab/mtab"));
 	return rc;
 }
 
-- 
1.7.4.1
