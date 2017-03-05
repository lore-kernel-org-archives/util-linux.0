Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32970 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdCEUwr (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:47 -0500
Received: by mail-wm0-f66.google.com with SMTP id n11so10897414wma.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/13] blkid: improve coding style
Date: Sun,  5 Mar 2017 20:52:27 +0000
Message-Id: <20170305205232.24030-9-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 887a80083..493251d37 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -186,12 +186,12 @@ static void pretty_print_line(const char *device, const char *fs_type,
 		w = term_width / 10;
 		if (w > 8)
 			w = 8;
-		term_width -= 2*w;
+		term_width -= 2 * w;
 		label_len += w;
 		fs_type_len += w;
-		w = term_width/2;
+		w = term_width / 2;
 		device_len += w;
-		mtpt_len +=w;
+		mtpt_len += w;
 	}
 
 	len = pretty_print_word(device, device_len, 0, 1);
@@ -215,7 +215,7 @@ static void pretty_print_dev(blkid_dev dev)
 	if (dev == NULL) {
 		pretty_print_line("device", "fs_type", "label",
 				  "mount point", "UUID");
-		for (len=get_terminal_width(0)-1; len > 0; len--)
+		for (len = get_terminal_width(0) - 1; len > 0; len--)
 			fputc('-', stdout);
 		fputc('\n', stdout);
 		return;
@@ -265,8 +265,8 @@ static void print_udev_format(const char *name, const char *value)
 		printf("ID_FS_%s=%s\n", name, enc);
 
 	} else if (!strcmp(name, "UUID") ||
-		 !strcmp(name, "LABEL") ||
-		 !strcmp(name, "UUID_SUB")) {
+		   !strcmp(name, "LABEL") ||
+		   !strcmp(name, "UUID_SUB")) {
 
 		blkid_safe_string(value, safe, sizeof(safe));
 		printf("ID_FS_%s=%s\n", name, safe);
@@ -281,7 +281,7 @@ static void print_udev_format(const char *name, const char *value)
 		printf("ID_PART_TABLE_TYPE=%s\n", value);
 
 	} else if (!strcmp(name, "PART_ENTRY_NAME") ||
-		  !strcmp(name, "PART_ENTRY_TYPE")) {
+		   !strcmp(name, "PART_ENTRY_TYPE")) {
 
 		blkid_encode_string(value, enc, sizeof(enc));
 		printf("ID_%s=%s\n", name, enc);
@@ -289,11 +289,11 @@ static void print_udev_format(const char *name, const char *value)
 	} else if (!strncmp(name, "PART_ENTRY_", 11))
 		printf("ID_%s=%s\n", name, value);
 
-	else if (namelen >= 15 && (
-		   !strcmp(name + (namelen - 12), "_SECTOR_SIZE") ||
-		   !strcmp(name + (namelen - 8), "_IO_SIZE") ||
-		   !strcmp(name, "ALIGNMENT_OFFSET")))
-			printf("ID_IOLIMIT_%s=%s\n", name, value);
+	else if (namelen >= 15
+		 && (!strcmp(name + (namelen - 12), "_SECTOR_SIZE")
+		     || !strcmp(name + (namelen - 8), "_IO_SIZE")
+		     || !strcmp(name, "ALIGNMENT_OFFSET")))
+		printf("ID_IOLIMIT_%s=%s\n", name, value);
 	else
 		printf("ID_FS_%s=%s\n", name, value);
 }
@@ -382,7 +382,6 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 	}
 }
 
-
 static int append_str(char **res, size_t *sz, const char *a, const char *b)
 {
 	char *str = *res;
@@ -510,7 +509,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	int rc = 0;
 	static int first = 1;
 
-	fd = open(devname, O_RDONLY|O_CLOEXEC);
+	fd = open(devname, O_RDONLY | O_CLOEXEC);
 	if (fd < 0) {
 		warn(_("error: %s"), devname);
 		return BLKID_EXIT_NOTFOUND;
@@ -586,7 +585,7 @@ static int list_to_usage(const char *list, int *flag)
 	}
 	if (!p || !*p)
 		goto err;
-	while(p) {
+	while (p) {
 		word = p;
 		p = strchr(p, ',');
 		if (p)
@@ -625,14 +624,16 @@ static char **list_to_types(const char *list, int *flag)
 		warnx(_("error: -u <list> argument is empty"));
 		goto err;
 	}
-	for (i = 1; p && (p = strchr(p, ',')); i++, p++);
+	for (i = 1; p && (p = strchr(p, ',')); i++, p++)
+		/* do nothing */ ;
 
 	res = xcalloc(i + 1, sizeof(char *));
 	p = *flag & BLKID_FLTR_NOTIN ? list + 2 : list;
 	i = 0;
 
-	while(p) {
+	while (p) {
 		const char *word = p;
+
 		p = strchr(p, ',');
 		res[i++] = p ? xstrndup(word, p - word) : xstrdup(word);
 		if (p)
@@ -796,7 +797,6 @@ int main(int argc, char **argv)
 		}
 	}
 
-
 	/* The rest of the args are device names */
 	if (optind < argc) {
 		devices = xcalloc(argc - optind, sizeof(char *));
-- 
2.12.0

