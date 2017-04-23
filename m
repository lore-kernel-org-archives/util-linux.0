Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35634 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046082AbdDWU6n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so252614wrg.2
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/10] libblkid: add blkid_return_known_pttypes()
Date: Sun, 23 Apr 2017 21:58:15 +0100
Message-Id: <20170423205821.7444-5-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This new function will return list partition types names libblkid is aware
of.  First use of this information will be in partx(8) to make bash
completion to work without a magic list.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/docs/libblkid-sections.txt  |  1 +
 libblkid/src/blkid.h.in              |  1 +
 libblkid/src/libblkid.sym            |  1 +
 libblkid/src/partitions/partitions.c | 24 ++++++++++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/libblkid/docs/libblkid-sections.txt b/libblkid/docs/libblkid-sections.txt
index 78db25ec9..3b46910bd 100644
--- a/libblkid/docs/libblkid-sections.txt
+++ b/libblkid/docs/libblkid-sections.txt
@@ -86,6 +86,7 @@ blkid_probe_invert_partitions_filter
 blkid_probe_reset_partitions_filter
 <SUBSECTION>
 blkid_known_pttype
+blkid_return_known_pttypes
 <SUBSECTION>
 blkid_partition_get_name
 blkid_partition_get_flags
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index 06e2c1771..953bed130 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -326,6 +326,7 @@ extern unsigned long blkid_topology_get_physical_sector_size(blkid_topology tp)
  * partitions probing
  */
 extern int blkid_known_pttype(const char *pttype);
+extern char **blkid_return_known_pttypes(void);
 
 extern int blkid_probe_enable_partitions(blkid_probe pr, int enable)
 			__ul_attribute__((nonnull));
diff --git a/libblkid/src/libblkid.sym b/libblkid/src/libblkid.sym
index cd76d6592..b88b2d547 100644
--- a/libblkid/src/libblkid.sym
+++ b/libblkid/src/libblkid.sym
@@ -167,4 +167,5 @@ BLKID_2.25 {
 
 BLKID_2.30 {
 	blkid_probe_set_sectorsize;
+	blkid_return_known_pttypes;
 } BLKID_2.25;
diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index 533209761..c94c63de1 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -887,6 +887,30 @@ int blkid_known_pttype(const char *pttype)
 }
 
 /**
+ * blkid_return_known_pttypes:
+ *
+ * Returns: returns address to char ** list.  It is duty of user to free
+ * list elements and the list after use.
+ */
+char **blkid_return_known_pttypes(void)
+{
+	size_t i;
+	const size_t sz = ARRAY_SIZE(idinfos);
+	char **list;
+
+	list = malloc((sz + 1) * sizeof(char *));
+	if (!list)
+		return NULL;
+
+	for (i = 0; i < sz; i++) {
+		const struct blkid_idinfo *id = idinfos[i];
+		list[i] = strdup(id->name);
+	}
+	list[i] = NULL;
+	return list;
+}
+
+/**
  * blkid_partlist_numof_partitions:
  * @ls: partitions list
  *
-- 
2.12.2

