Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2903 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232AbaHZKug (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Aug 2014 06:50:36 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7QAoahP022811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 26 Aug 2014 06:50:36 -0400
Received: from choo.home.annexia.org (vpn-226-39.phx2.redhat.com [10.3.226.39])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7QAoZHh027510
	for <util-linux@vger.kernel.org>; Tue, 26 Aug 2014 06:50:35 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: vary basic dump parsing functions
Date: Tue, 26 Aug 2014 11:50:32 +0100
Message-Id: <1409050232-8090-1-git-send-email-rjones@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Karel Zak <kzak@redhat.com>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 libfdisk/src/dump.c  | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 libfdisk/src/table.c |   1 -
 2 files changed, 303 insertions(+), 5 deletions(-)

diff --git a/libfdisk/src/dump.c b/libfdisk/src/dump.c
index 2c9e753..e1fb003 100644
--- a/libfdisk/src/dump.c
+++ b/libfdisk/src/dump.c
@@ -1,5 +1,6 @@
 
 #include "fdiskP.h"
+#include "strutils.h"
 
 /* dump header (e.g. unit: sectors) */
 struct fdisk_dumpheader {
@@ -16,8 +17,8 @@ struct fdisk_dump {
 	int			refcount;
 
 	/* parser's state */
-	FILE			*file;
-	size_t			line;
+	size_t			nlines;
+	int			fmt;		/* input format */
 };
 
 
@@ -117,6 +118,7 @@ static struct fdisk_dumpheader *fdisk_dump_get_header(struct fdisk_dump *dp,
 	return NULL;
 }
 
+
 /**
  * fdisk_dump_set_header:
  * @dp: dump instance
@@ -204,7 +206,7 @@ struct fdisk_table *fdisk_dump_get_table(struct fdisk_dump *dp)
  * @dp: dump
  * @cxt: context
  *
- * Reads data from the current context (on disk partition table).
+ * Reads data from the current context (on disk partition table) into the dump.
  *
  * Return: 0 on success, <0 on error.
  */
@@ -248,6 +250,15 @@ int fdisk_dump_read_context(struct fdisk_dump *dp, struct fdisk_context *cxt)
 	return rc;
 }
 
+/**
+ * fdisk_dump_write_file:
+ * @dp: dump
+ * @f: output file
+ *
+ * Writes dump @dp to the ile @f.
+ *
+ * Returns: 0 on sucess, <0 on error.
+ */
 int fdisk_dump_write_file(struct fdisk_dump *dp, FILE *f)
 {
 	struct list_head *h;
@@ -278,7 +289,7 @@ int fdisk_dump_write_file(struct fdisk_dump *dp, FILE *f)
 		if (devname)
 			p = fdisk_partname(devname, pa->partno + 1);
 		if (p)
-			fprintf(f, "%s: ", p);
+			fprintf(f, "%s : ", p);
 		else
 			fprintf(f, "%zu :", pa->partno + 1);
 
@@ -308,6 +319,273 @@ int fdisk_dump_write_file(struct fdisk_dump *dp, FILE *f)
 	return 0;
 }
 
+static inline int is_header_line(const char *s)
+{
+	const char *p = strchr(s, ':');
+
+	if (!p || p == s || !*(p + 1) || strchr(s, '='))
+		return 0;
+
+	return 1;
+}
+
+/* parses "<name>: value", note modifies @s*/
+static int parse_header_line(struct fdisk_dump *dp, char *s)
+{
+	int rc = -EINVAL;
+	char *name, *value;
+
+	DBG(DUMP, ul_debug("   parse header '%s'", s));
+
+	if (!s || !*s)
+		return -EINVAL;
+
+	name = s;
+	value = strchr(s, ':');
+	if (!value)
+		goto done;
+	*value = '\0';
+	value++;
+
+	ltrim_whitespace((unsigned char *) name);
+	rtrim_whitespace((unsigned char *) name);
+	ltrim_whitespace((unsigned char *) value);
+	rtrim_whitespace((unsigned char *) value);
+
+	if (*name && *value)
+		rc = fdisk_dump_set_header(dp, name, value);
+done:
+	if (rc)
+		DBG(DUMP, ul_debug("header parse error: [rc=%d]", rc));
+	return rc;
+
+}
+
+static int next_number(char **s, uint64_t *num)
+{
+	char *end = NULL;
+	int rc;
+
+	assert(num);
+	assert(s);
+
+	*s = (char *) skip_blank(*s);
+	if (!**s)
+		return -1;
+
+	end = strchr(*s, ',');
+	if (end)
+		*end = '\0';
+
+	rc = strtosize(*s, (uintmax_t *) num);
+	if (end) {
+		*end = ',';
+		*s = end;
+	} else
+		while (**s) (*s)++;
+
+	return rc;
+}
+
+static int partno_from_devname(char *s)
+{
+	int pno;
+	size_t sz;
+	char *end, *p;
+
+	sz = rtrim_whitespace((unsigned char *)s);
+	p = s + sz - 1;
+
+	while (p > s && isdigit(*(p - 1)))
+		p--;
+
+	errno = 0;
+	pno = strtol(p, &end, 10);
+	if (errno || !end || p == end)
+		return -1;
+	return pno - 1;
+}
+
+static int parse_dump_line(struct fdisk_dump *dp, char *s)
+{
+	char *p;
+	struct fdisk_partition *pa;
+	int rc = 0;
+	uint64_t num;
+	int pno;
+
+	assert(dp);
+	assert(s);
+
+	DBG(DUMP, ul_debug("   parse dump line: '%s'", s));
+
+	pa = fdisk_new_partition();
+	if (!pa)
+		return -ENOMEM;
+
+	p = strchr(s, ':');
+	if (!p)
+		return -EINVAL;
+	*p = '\0';
+	p++;
+
+	pno = partno_from_devname(s);
+	if (pno < 0)
+		fdisk_partition_partno_follow_default(pa, 1);
+	else
+		fdisk_partition_set_partno(pa, pno);
+
+
+	while (rc == 0 && p && *p) {
+		while (isblank(*p)) p++;
+		if (!*p)
+			break;
+
+		if (!strncasecmp(p, "start=", 6)) {
+			p += 6;
+			rc = next_number(&p, &num);
+			if (!rc)
+				fdisk_partition_set_start(pa, num);
+
+		} else if (!strncasecmp(p, "size=", 5)) {
+			p += 5;
+			rc = next_number(&p, &num);
+			if (!rc)
+				fdisk_partition_set_size(pa, num);
+
+		} else if (!strncasecmp(p, "end=", 4)) {
+			p += 4;
+			rc = next_number(&p, &num);
+			if (!rc)
+				fdisk_partition_set_end(pa, num);
+		} else {
+			DBG(DUMP, ul_debug("dump parse error: unknown field '%s'", p));
+			rc = -EINVAL;
+			break;
+		}
+
+		while (isblank(*p)) p++;
+		if (*p == ',')
+			p++;
+	}
+
+	if (!rc)
+		rc = fdisk_table_add_partition(dp->table, pa);
+	if (rc)
+		DBG(DUMP, ul_debug("dump parse error: [rc=%d]", rc));
+
+	fdisk_unref_partition(pa);
+	return 0;
+}
+
+static int parse_commas_line(struct fdisk_dump *dp, const char *s)
+{
+	DBG(DUMP, ul_debug("   commas line parse error"));
+	return -EINVAL;
+}
+
+/* modifies @s ! */
+int fdisk_dump_read_buffer(struct fdisk_dump *dp, char *s)
+{
+	int rc = 0;
+
+	assert(dp);
+	assert(s);
+
+	DBG(DUMP, ul_debug("  parsing buffer"));
+
+	s = (char *) skip_blank(s);
+	if (!s || !*s)
+		return 0;	/* nothing baby, ignore */
+
+	if (!dp->table) {
+		dp->table = fdisk_new_table();
+		if (!dp->table)
+			return -ENOMEM;
+	}
+
+	/* parse header lines only if no partition specified yet */
+	if (fdisk_table_is_empty(dp->table) && is_header_line(s))
+		rc = parse_header_line(dp, s);
+
+	/* parse dump format */
+	else if (strchr(s, '='))
+		rc = parse_dump_line(dp, s);
+
+	/* parse simple <value>, ... format */
+	else
+		rc = parse_commas_line(dp, s);
+
+	if (rc)
+		DBG(DUMP, ul_debugobj(dp, "%zu: parse error [rc=%d]",
+				dp->nlines, rc));
+	return rc;
+}
+
+char fdisk_dump_read_line(struct fdisk_dump *dp, FILE *f)
+{
+	char buf[BUFSIZ];
+	char *s;
+
+	assert(dp);
+	assert(f);
+
+	DBG(DUMP, ul_debug(" parsing line"));
+
+	/* read the next non-blank non-comment line */
+	do {
+		if (fgets(buf, sizeof(buf), f) == NULL)
+			return -EINVAL;
+		dp->nlines++;
+		s = strchr(buf, '\n');
+		if (!s) {
+			/* Missing final newline?  Otherwise an extremely */
+			/* long line - assume file was corrupted */
+			if (feof(f)) {
+				DBG(DUMP, ul_debugobj(dp, "no final newline"));
+				s = strchr(buf, '\0');
+			} else {
+				DBG(DUMP, ul_debugobj(dp,
+					"%zu: missing newline at line", dp->nlines));
+				return -EINVAL;
+			}
+		}
+
+		*s = '\0';
+		if (--s >= buf && *s == '\r')
+			*s = '\0';
+		s = (char *) skip_blank(buf);
+	} while (*s == '\0' || *s == '#');
+
+	return fdisk_dump_read_buffer(dp, s);
+}
+
+
+/**
+ * fdisk_dump_read_file:
+ * @dp: dump
+ * @f input file
+ *
+ * Reads file @f into dump @dp.
+ *
+ * Returns: 0 on success, <0 on error.
+ */
+int fdisk_dump_read_file(struct fdisk_dump *dp, FILE *f)
+{
+	int rc = NULL;
+
+	assert(dp);
+	assert(f);
+
+	DBG(DUMP, ul_debug("parsing file"));
+
+	while (rc == 0 && !feof(f))
+		rc = fdisk_dump_read_line(dp, f);
+
+	return rc;
+}
+
+
 #ifdef TEST_PROGRAM
 int test_dump(struct fdisk_test *ts, int argc, char *argv[])
 {
@@ -330,10 +608,31 @@ int test_dump(struct fdisk_test *ts, int argc, char *argv[])
 	return 0;
 }
 
+int test_read(struct fdisk_test *ts, int argc, char *argv[])
+{
+	char *filename = argv[1];
+	struct fdisk_dump *dp;
+	FILE *f;
+
+	if (!(f = fopen(filename, "r")))
+		err(EXIT_FAILURE, "%s: cannot open", filename);
+
+	dp = fdisk_new_dump();
+
+	fdisk_dump_read_file(dp, f);
+	fclose(f);
+
+	fdisk_dump_write_file(dp, stdout);
+	fdisk_unref_dump(dp);
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	struct fdisk_test tss[] = {
 	{ "--dump",  test_dump,    "<device>   print PT" },
+	{ "--read",  test_read,    "<file>     read PT scrit from file" },
 	{ NULL }
 	};
 
diff --git a/libfdisk/src/table.c b/libfdisk/src/table.c
index 28540b9..8de8a75 100644
--- a/libfdisk/src/table.c
+++ b/libfdisk/src/table.c
@@ -91,7 +91,6 @@ void fdisk_unref_table(struct fdisk_table *tb)
  */
 int fdisk_table_is_empty(struct fdisk_table *tb)
 {
-	assert(tb);
 	return tb == NULL || list_empty(&tb->parts) ? 1 : 0;
 }
 
-- 
2.0.4

