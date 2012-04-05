Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:45401 "EHLO
	homiemail-a4.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755318Ab2DEVwN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Apr 2012 17:52:13 -0400
Subject: [PATCH 2/3] fdisk: use randutils for mbr signature creation
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Apr 2012 23:52:07 +0200
Message-ID: <1333662727.2696.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/Makefile.am |    1 +
 fdisk/fdisk.c     |   51 +++++----------------------------------------------
 2 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/fdisk/Makefile.am b/fdisk/Makefile.am
index 9fbfc79..f6e9a4b 100644
--- a/fdisk/Makefile.am
+++ b/fdisk/Makefile.am
@@ -10,6 +10,7 @@ fdisk_common = \
 	$(top_srcdir)/lib/blkdev.c \
 	$(top_srcdir)/lib/mbsalign.c \
 	$(top_srcdir)/lib/strutils.c \
+	$(top_srcdir)/lib/randutils.c \
 	$(top_srcdir)/lib/wholedisk.c
 
 if LINUX
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 126efb3..7c14861 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -33,6 +33,7 @@
 #include "pathnames.h"
 #include "canonicalize.h"
 #include "strutils.h"
+#include "randutils.h"
 
 #include "fdisksunlabel.h"
 #include "fdisksgilabel.h"
@@ -186,51 +187,6 @@ get_nr_sects(struct partition *p) {
 	return read4_little_endian(p->size4);
 }
 
-static ssize_t
-xread(int fd, void *buf, size_t count) {
-        char *p = buf;
-        ssize_t out = 0;
-        ssize_t rv;
-
-        while (count) {
-                rv = read(fd, p, count);
-                if (rv == -1) {
-                        if (errno == EINTR || errno == EAGAIN)
-                                continue;
-                        return out ? out : -1; /* Error */
-                } else if (rv == 0) {
-                        return out; /* EOF */
-                }
-
-                p += rv;
-                out += rv;
-                count -= rv;
-        }
-
-        return out;
-}
-
-static unsigned int
-get_random_id(void) {
-	int fd;
-	unsigned int v;
-	ssize_t rv = -1;
-	struct timeval tv;
-
-	fd = open("/dev/urandom", O_RDONLY);
-	if (fd >= 0) {
-	        rv = xread(fd, &v, sizeof v);
-		close(fd);
-	}
-
-	if (rv == sizeof v)
-		return v;
-
-	/* Fallback: sucks, but better than nothing */
-	gettimeofday(&tv, NULL);
-	return (unsigned int)(tv.tv_sec + (tv.tv_usec << 12) + getpid());
-}
-
 /*
  * Raw disk label. For DOS-type partition tables the MBR,
  * with descriptions of the primary partitions.
@@ -876,7 +832,10 @@ static void dos_init(void)
 
 static void
 create_doslabel(void) {
-	unsigned int id = get_random_id();
+	unsigned int id;
+
+	/* random disk signature */
+	random_get_bytes(&id, sizeof(id));
 
 	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
 	sun_nolabel();  /* otherwise always recognised as sun */
-- 
1.7.4.1




