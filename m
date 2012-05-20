Return-Path: dave@gnu.org
Subject: [PATCH 6/6] fdisk: add debug support
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 May 2012 18:11:39 +0200
Message-ID: <1337530299.2677.17.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Based on libmnt, this patch adds basic debugging support for fdisk. Currently only CONTEXT is debugged, yet keeps exact functionality
as libmnt/libblkid.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    2 ++
 fdisk/fdisk.h |   27 +++++++++++++++++++++++++++
 fdisk/utils.c |   33 ++++++++++++++++++++++++++++++++-
 3 files changed, 61 insertions(+), 1 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 400e682..9b91fa0 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2168,6 +2168,8 @@ int main(int argc, char **argv)
 		}
 	}
 
+	fdisk_init_debug(0);
+
 	if (user_set_sector_size && argc-optind != 1)
 		printf(_("Warning: the -b (set sector size) option should"
 			 " be used with one specified device\n"));
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index c43517c..2471541 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -32,6 +32,33 @@
 #define cround(n)	(display_in_cyl_units ? ((n)/units_per_sector)+1 : (n))
 #define scround(x)	(((x)+units_per_sector-1)/units_per_sector)
 
+/* fdisk debugging flags/options */
+#define FDISK_DEBUG_INIT	(1 << 1)
+#define FDISK_DEBUG_CONTEXT	(1 << 2)
+#define FDISK_DEBUG_ALL		0xFFFF
+
+# define ON_DBG(m, x)	do { \
+				if ((FDISK_DEBUG_ ## m) & fdisk_debug_mask) { \
+					x; \
+				}	   \
+			} while (0)
+
+# define DBG(m, x)	do { \
+				if ((FDISK_DEBUG_ ## m) & fdisk_debug_mask) { \
+					fprintf(stderr, "%d: fdisk: %8s: ", getpid(), # m); \
+					x;				\
+				} \
+			} while (0)
+
+# define DBG_FLUSH	do { \
+				if (fdisk_debug_mask && \
+				    fdisk_debug_mask != FDISK_DEBUG_INIT) \
+					fflush(stderr);			\
+			} while(0)
+
+extern int fdisk_debug_mask;
+extern void fdisk_init_debug(int mask);
+
 struct partition {
 	unsigned char boot_ind;         /* 0x80 - active */
 	unsigned char head;             /* starting head */
diff --git a/fdisk/utils.c b/fdisk/utils.c
index ad83d7f..9f071a6 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -23,6 +23,35 @@
 #include "common.h"
 #include "fdisk.h"
 
+int fdisk_debug_mask;
+
+/**
+ * fdisk_init_debug:
+ * @mask: debug mask (0xffff to enable full debuging)
+ *
+ * If the @mask is not specified then this function reads
+ * FDISK_DEBUG environment variable to get the mask.
+ *
+ * Already initialized debugging stuff cannot be changed. It does not
+ * have effect to call this function twice.
+ */
+void fdisk_init_debug(int mask)
+{
+	if (fdisk_debug_mask & FDISK_DEBUG_INIT)
+		return;
+	if (!mask) {
+		char *str = getenv("FDISK_DEBUG");
+		if (str)
+			fdisk_debug_mask = strtoul(str, 0, 0);
+	} else
+		fdisk_debug_mask = mask;
+
+	if (fdisk_debug_mask)
+		printf("fdisk: debug mask set to 0x%04x.\n",
+		       fdisk_debug_mask);
+	fdisk_debug_mask |= FDISK_DEBUG_INIT;
+}
+
 /**
  * fdisk_new_context:
  *
@@ -37,9 +66,11 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname)
 	 * Attempt to open the device with r-w permissions
 	 * by default, otherwise try read-only.
 	 */
-	if ((fd = open(fname, O_RDWR)) < 0)
+	if ((fd = open(fname, O_RDWR)) < 0) {
 		if ((fd = open(fname, O_RDONLY)) < 0)
 			goto ret;
+		DBG(CONTEXT, printf("opened %s as read-only\n", fname));
+	}
 
 	cxt = calloc(1, sizeof(*cxt));
 	if (!cxt)
-- 
1.7.4.1
