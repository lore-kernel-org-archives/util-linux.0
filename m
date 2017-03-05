Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33874 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdCEUwq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:46 -0500
Received: by mail-wr0-f193.google.com with SMTP id u48so19504549wrc.1
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/13] blkid: define output names only once
Date: Sun,  5 Mar 2017 20:52:26 +0000
Message-Id: <20170305205232.24030-8-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Output names are magic strings, and they should be defined only once in one
place to avoid mismatches and/or incompleteness.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 104 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 63 insertions(+), 41 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 4746e09a7..887a80083 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -19,11 +19,23 @@
 #include <errno.h>
 #include <getopt.h>
 
-#define OUTPUT_VALUE_ONLY	(1 << 1)
-#define OUTPUT_DEVICE_ONLY	(1 << 2)
-#define OUTPUT_PRETTY_LIST	(1 << 3)		/* deprecated */
-#define OUTPUT_UDEV_LIST	(1 << 4)		/* deprecated */
-#define OUTPUT_EXPORT_LIST	(1 << 5)
+enum {
+	OUTPUT_FULL = 0,
+	OUTPUT_VALUE_ONLY,
+	OUTPUT_DEVICE_ONLY,
+	OUTPUT_PRETTY_LIST,
+	OUTPUT_UDEV_LIST,
+	OUTPUT_EXPORT_LIST
+};
+
+static const char *output_names[] = {
+	[OUTPUT_FULL]		= "full",
+	[OUTPUT_VALUE_ONLY]	= "value",
+	[OUTPUT_DEVICE_ONLY]	= "device",
+	[OUTPUT_PRETTY_LIST]	= "list",	/* deprecated */
+	[OUTPUT_UDEV_LIST]	= "udev",	/* deprecated */
+	[OUTPUT_EXPORT_LIST]	= "export"
+};
 
 #define LOWPROBE_TOPOLOGY	(1 << 1)
 #define LOWPROBE_SUPERBLOCKS	(1 << 2)
@@ -97,6 +109,17 @@ static void usage(int error)
 	exit(error);
 }
 
+static int parse_output_name(const char *arg)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(output_names); i++) {
+		if (strcmp(output_names[i], arg) == 0)
+			return i;
+	}
+	return -EINVAL;
+}
+
 /*
  * This function does "safe" printing.  It will convert non-printable
  * ASCII characters using '^' and M- notation.
@@ -288,22 +311,23 @@ static int has_item(char *ary[], const char *item)
 static void print_value(int output, int num, const char *devname,
 			const char *value, const char *name, size_t valsz)
 {
-	if (output & OUTPUT_VALUE_ONLY) {
+	switch (output) {
+	case OUTPUT_VALUE_ONLY:
 		fputs(value, stdout);
 		fputc('\n', stdout);
-
-	} else if (output & OUTPUT_UDEV_LIST) {
+		break;
+	case OUTPUT_UDEV_LIST:
 		print_udev_format(name, value);
-
-	} else if (output & OUTPUT_EXPORT_LIST) {
+		break;
+	case OUTPUT_EXPORT_LIST:
 		if (num == 1 && devname)
 			printf("DEVNAME=%s\n", devname);
 		fputs(name, stdout);
 		fputs("=", stdout);
 		safe_print(value, valsz, " \\\"'$`<>");
 		fputs("\n", stdout);
-
-	} else {
+		break;
+	default:
 		if (num == 1 && devname)
 			printf("%s:", devname);
 		fputs(" ", stdout);
@@ -324,14 +348,14 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 	if (!dev)
 		return;
 
-	if (output & OUTPUT_PRETTY_LIST) {
+	if (output == OUTPUT_PRETTY_LIST) {
 		pretty_print_dev(dev);
 		return;
 	}
 
 	devname = blkid_dev_devname(dev);
 
-	if (output & OUTPUT_DEVICE_ONLY) {
+	if (output == OUTPUT_DEVICE_ONLY) {
 		printf("%s\n", devname);
 		return;
 	}
@@ -342,7 +366,7 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 			continue;
 
 		if (num == 1 && !first &&
-		    (output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
+		    (output == OUTPUT_UDEV_LIST || output == OUTPUT_EXPORT_LIST))
 			/* add extra line between output from more devices */
 			fputc('\n', stdout);
 
@@ -351,8 +375,8 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 	blkid_tag_iterate_end(iter);
 
 	if (num > 1) {
-		if (!(output & (OUTPUT_VALUE_ONLY | OUTPUT_UDEV_LIST |
-						OUTPUT_EXPORT_LIST)))
+		if (!(output == OUTPUT_VALUE_ONLY || output == OUTPUT_UDEV_LIST
+		      || output == OUTPUT_EXPORT_LIST))
 			printf("\n");
 		first = 0;
 	}
@@ -504,11 +528,11 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	if (!rc)
 		nvals = blkid_probe_numof_values(pr);
 
-	if (nvals && !first && output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST))
+	if (nvals && !first && (output == OUTPUT_UDEV_LIST || output == OUTPUT_EXPORT_LIST))
 		/* add extra line between output from devices */
 		fputc('\n', stdout);
 
-	if (nvals && (output & OUTPUT_DEVICE_ONLY)) {
+	if (nvals && output == OUTPUT_DEVICE_ONLY) {
 		printf("%s\n", devname);
 		goto done;
 	}
@@ -524,12 +548,15 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 
 	if (first)
 		first = 0;
-	if (nvals >= 1 && !(output & (OUTPUT_VALUE_ONLY |
-					OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
+
+	if (nvals >= 1 && !(output == OUTPUT_VALUE_ONLY ||
+			    output == OUTPUT_UDEV_LIST ||
+			    output == OUTPUT_EXPORT_LIST))
 		printf("\n");
+
 done:
 	if (rc == -2) {
-		if (output & OUTPUT_UDEV_LIST)
+		if (output == OUTPUT_UDEV_LIST)
 			print_udev_ambivalent(pr);
 		else
 			warnx(_("%s: ambivalent result (probably more "
@@ -644,7 +671,7 @@ int main(int argc, char **argv)
 	int version = 0;
 	int err = BLKID_EXIT_OTHER;
 	unsigned int i;
-	int output_format = 0;
+	int output_format = OUTPUT_FULL;
 	int lookup = 0, gc = 0, lowprobe = 0, eval = 0;
 	int c;
 	uintmax_t offset = 0, size = 0;
@@ -711,22 +738,17 @@ int main(int argc, char **argv)
 			exit(EXIT_SUCCESS);
 		}
 		case 'o':
-			if (!strcmp(optarg, "value"))
-				output_format = OUTPUT_VALUE_ONLY;
-			else if (!strcmp(optarg, "device"))
-				output_format = OUTPUT_DEVICE_ONLY;
-			else if (!strcmp(optarg, "list"))
-				output_format = OUTPUT_PRETTY_LIST;	/* deprecated */
-			else if (!strcmp(optarg, "udev"))
-				output_format = OUTPUT_UDEV_LIST;
-			else if (!strcmp(optarg, "export"))
-				output_format = OUTPUT_EXPORT_LIST;
-			else if (!strcmp(optarg, "full"))
-				output_format = 0;
-			else {
-				errx(BLKID_EXIT_OTHER, _("Invalid output format %s. "
-					"Choose from value,\n\t"
-					"value, device, list, udev, export, or full"), optarg);
+			output_format = parse_output_name(optarg);
+			if (output_format < 0) {
+				size_t j;
+
+				warnx(_("Invalid output format %s. "
+					"Choose from value:"), optarg);
+				fputc('\t', stderr);
+				for (j = 0; j < ARRAY_SIZE(output_names); j++)
+					fprintf(stderr, "%s%s", j == 0 ? "" : " ", output_names[j]);
+				fputc('\n', stderr);
+				exit(BLKID_EXIT_OTHER);
 			}
 			break;
 		case 'O':
@@ -804,7 +826,7 @@ int main(int argc, char **argv)
 	}
 	err = BLKID_EXIT_NOTFOUND;
 
-	if (eval == 0 && (output_format & OUTPUT_PRETTY_LIST)) {
+	if (eval == 0 && output_format == OUTPUT_PRETTY_LIST) {
 		if (lowprobe)
 			errx(BLKID_EXIT_OTHER,
 			     _("The low-level probing mode does not "
@@ -824,7 +846,7 @@ int main(int argc, char **argv)
 			       "requires a device"));
 
 		/* automatically enable 'export' format for I/O Limits */
-		if (!output_format  && (lowprobe & LOWPROBE_TOPOLOGY))
+		if (output_format == OUTPUT_FULL && (lowprobe & LOWPROBE_TOPOLOGY))
 			output_format = OUTPUT_EXPORT_LIST;
 
 		pr = blkid_new_probe();
-- 
2.12.0

