Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:50074 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTdh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:37 -0400
Received: by mail-wi0-f178.google.com with SMTP id ez12so2935096wid.17
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/14] various: fix variable and function declarations [smatch scan]
Date: Mon,  8 Apr 2013 20:32:49 +0100
Message-Id: <1365449579-13238-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/fsck.minix.c:511:9: warning: mixing declarations and code
fdisks/sfdisk.c:982:5: warning: mixing declarations and code
fdisks/sfdisk.c:1254:5: warning: mixing declarations and code
fdisks/sfdisk.c:1564:5: warning: mixing declarations and code
lib/mbsalign.c:279:7: warning: mixing declarations and code
libblkid/src/devname.c:378:17: warning: mixing declarations and code
libfdisk/src/alignment.c:219:9: warning: mixing declarations and code
term-utils/wall.c:111:9: warning: mixing declarations and code
text-utils/col.c:418:19: warning: non-ANSI function declaration of function 'flush_blanks'
text-utils/col.c:553:12: warning: non-ANSI function declaration of function 'alloc_line'
text-utils/rev.c:105:9: warning: mixing declarations and code
text-utils/tailf.c:245:9: warning: mixing declarations and code

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c  |  3 ++-
 fdisks/sfdisk.c          |  8 ++++----
 lib/mbsalign.c           |  4 ++--
 libblkid/src/devname.c   |  6 +++---
 libfdisk/src/alignment.c |  5 +++--
 term-utils/wall.c        | 10 +++++-----
 text-utils/col.c         |  4 ++--
 text-utils/rev.c         | 12 ++++++------
 text-utils/tailf.c       | 10 +++++-----
 9 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 3482200..89e96fc 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -507,11 +507,12 @@ write_super_block(void) {
 
 static void
 write_tables(void) {
-	write_super_block();
 	unsigned long buffsz = get_inode_buffer_size();
 	unsigned long imaps = get_nimaps();
 	unsigned long zmaps = get_nzmaps();
 
+	write_super_block();
+
 	if (write_all(IN, inode_map, imaps * MINIX_BLOCK_SIZE))
 		die(_("Unable to write inode map"));
 
diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index d98df9a..3206a6b 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -977,10 +977,10 @@ out_roundup_size(int width, unsigned long long n, unsigned long unit) {
 static struct geometry
 get_fdisk_geometry_one(struct part_desc *p) {
     struct geometry G;
-
-    memset(&G, 0, sizeof(struct geometry));
     chs b = p->p.end_chs;
     longchs bb = chs_to_longchs(b);
+
+    memset(&G, 0, sizeof(struct geometry));
     G.heads = bb.h + 1;
     G.sectors = bb.s;
     G.cylindersize = G.heads * G.sectors;
@@ -1167,6 +1167,7 @@ static int
 partitions_ok(int fd, struct disk_desc *z) {
     struct part_desc *partitions = &(z->partitions[0]), *p, *q;
     int partno = z->partno;
+    int sector_size;
 
 #define PNO(p) pnumber(p, z)
 
@@ -1251,7 +1252,6 @@ partitions_ok(int fd, struct disk_desc *z) {
 	    }
     }
 
-    int sector_size;
     if (blkdev_get_sector_size(fd, &sector_size) == -1)
 	sector_size = DEFAULT_SECTOR_SIZE;
 
@@ -1538,6 +1538,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     struct part_desc *partitions = &(z->partitions[0]);
     int pno = z->partno;
     int bsd_later = 1;
+    unsigned short sig, magic;
 #ifdef __linux__
     bsd_later = (get_linux_version() >= KERNEL_VERSION(2, 3, 40));
 #endif
@@ -1561,7 +1562,6 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	return 0;
     }
 
-    unsigned short sig, magic;
     memcpy(&sig, s->data + 2, sizeof(sig));
     if (sig <= 0x1ae) {
 	memcpy(&magic, s->data + sig, sizeof(magic));
diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index 05c4650..e420fea 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -173,7 +173,7 @@ mbsalign (const char *src, char *dest, size_t dest_size,
   const char *str_to_print = src;
   size_t n_cols = src_size - 1;
   size_t n_used_bytes = n_cols; /* Not including NUL */
-  size_t n_spaces = 0;
+  size_t n_spaces = 0, space_left;
   bool conversion = false;
   bool wc_enabled = false;
 
@@ -276,7 +276,7 @@ mbsalign_unibyte:
         }
 
       dest = mbs_align_pad (dest, dest_end, start_spaces);
-      size_t space_left = dest_end - dest;
+      space_left = dest_end - dest;
       dest = mempcpy (dest, str_to_print, min (n_used_bytes, space_left));
       mbs_align_pad (dest, dest_end, end_spaces);
     }
diff --git a/libblkid/src/devname.c b/libblkid/src/devname.c
index 1c1ab07..497deaf 100644
--- a/libblkid/src/devname.c
+++ b/libblkid/src/devname.c
@@ -371,12 +371,12 @@ ubi_probe_all(blkid_cache cache, int only_if_new)
 	const char **dirname;
 
 	for (dirname = dirlist; *dirname; dirname++) {
-		DBG(DEVNAME, blkid_debug("probing UBI volumes under %s",
-					  *dirname));
-
 		DIR		*dir;
 		struct dirent	*iter;
 
+		DBG(DEVNAME, blkid_debug("probing UBI volumes under %s",
+					  *dirname));
+
 		dir = opendir(*dirname);
 		if (dir == NULL)
 			continue ;
diff --git a/libfdisk/src/alignment.c b/libfdisk/src/alignment.c
index 25323d1..ac44e73 100644
--- a/libfdisk/src/alignment.c
+++ b/libfdisk/src/alignment.c
@@ -212,12 +212,13 @@ int fdisk_discover_geometry(struct fdisk_context *cxt)
 
 int fdisk_discover_topology(struct fdisk_context *cxt)
 {
+#ifdef HAVE_LIBBLKID
+	blkid_probe pr;
+#endif
 	assert(cxt);
 	assert(cxt->sector_size == 0);
 
 #ifdef HAVE_LIBBLKID
-	blkid_probe pr;
-
 	DBG(TOPOLOGY, dbgprint("initialize libblkid prober"));
 
 	pr = blkid_new_probe();
diff --git a/term-utils/wall.c b/term-utils/wall.c
index c2ac7ad..4865ac7 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -103,11 +103,6 @@ main(int argc, char **argv) {
 	size_t mbufsize;
 	unsigned timeout = WRITE_TIME_OUT;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
 	static const struct option longopts[] = {
 		{ "nobanner",	no_argument,		0, 'n' },
 		{ "timeout",	required_argument,	0, 't' },
@@ -116,6 +111,11 @@ main(int argc, char **argv) {
 		{ NULL,	0, 0, 0 }
 	};
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
 	while ((ch = getopt_long(argc, argv, "nt:Vh", longopts, NULL)) != -1) {
 		switch (ch) {
 		case 'n':
diff --git a/text-utils/col.c b/text-utils/col.c
index c2b10dc..474b33f 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -415,7 +415,7 @@ void flush_lines(int nflush)
  * is the number of half line feeds, otherwise it is the number of whole line
  * feeds.
  */
-void flush_blanks()
+void flush_blanks(void)
 {
 	int half, i, nb;
 
@@ -550,7 +550,7 @@ void flush_line(LINE *l)
 static LINE *line_freelist;
 
 LINE *
-alloc_line()
+alloc_line(void)
 {
 	LINE *l;
 	int i;
diff --git a/text-utils/rev.c b/text-utils/rev.c
index 00d5196..9554506 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -94,6 +94,12 @@ int main(int argc, char *argv[])
 	FILE *fp = stdin;
 	int ch, rval = EXIT_SUCCESS;
 
+	static const struct option longopts[] = {
+		{ "version",    no_argument,       0, 'V' },
+		{ "help",       no_argument,       0, 'h' },
+		{ NULL,         0, 0, 0 }
+	};
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -102,12 +108,6 @@ int main(int argc, char *argv[])
 	signal(SIGINT, sig_handler);
 	signal(SIGTERM, sig_handler);
 
-	static const struct option longopts[] = {
-		{ "version",    no_argument,       0, 'V' },
-		{ "help",       no_argument,       0, 'h' },
-		{ NULL,         0, 0, 0 }
-	};
-
 	while ((ch = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
 		switch(ch) {
 		case 'V':
diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index a8630fb..2f611a4 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -237,11 +237,6 @@ int main(int argc, char **argv)
 	struct stat st;
 	off_t size = 0;
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
 	static const struct option longopts[] = {
 		{ "lines",   required_argument, 0, 'n' },
 		{ "version", no_argument,	0, 'V' },
@@ -249,6 +244,11 @@ int main(int argc, char **argv)
 		{ NULL,      0, 0, 0 }
 	};
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
 	lines = old_style_option(&argc, argv);
 	if (lines < 0)
 		lines = DEFAULT_LINES;
-- 
1.8.2.1

