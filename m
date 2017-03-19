Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35391 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdCSKR6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 19 Mar 2017 06:17:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so9796422wmb.2
        for <util-linux@vger.kernel.org>; Sun, 19 Mar 2017 03:17:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/5] blkid: add control struct
Date: Sun, 19 Mar 2017 10:10:45 +0000
Message-Id: <20170319101045.3018-6-kerolasa@iki.fi>
In-Reply-To: <20170319101045.3018-1-kerolasa@iki.fi>
References: <20170319101045.3018-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 171 +++++++++++++++++++++++++++--------------------------
 1 file changed, 88 insertions(+), 83 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index eb2ea0735..2f36fac3a 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -19,15 +19,13 @@
 #include <errno.h>
 #include <getopt.h>
 
+#define OUTPUT_FULL		(1 << 0)
 #define OUTPUT_VALUE_ONLY	(1 << 1)
 #define OUTPUT_DEVICE_ONLY	(1 << 2)
 #define OUTPUT_PRETTY_LIST	(1 << 3)		/* deprecated */
 #define OUTPUT_UDEV_LIST	(1 << 4)		/* deprecated */
 #define OUTPUT_EXPORT_LIST	(1 << 5)
 
-#define LOWPROBE_TOPOLOGY	(1 << 1)
-#define LOWPROBE_SUPERBLOCKS	(1 << 2)
-
 #define BLKID_EXIT_NOTFOUND	2	/* token or device not found */
 #define BLKID_EXIT_OTHER	4	/* bad usage or other error */
 #define BLKID_EXIT_AMBIVAL	8	/* ambivalent low-level probing detected */
@@ -47,7 +45,20 @@
 #include "ttyutils.h"
 #include "xalloc.h"
 
-static int raw_chars;
+struct blkid_control {
+	int output;
+	uintmax_t offset;
+	uintmax_t size;
+	char *show[128];
+	unsigned int
+		eval:1,
+		gc:1,
+		lookup:1,
+		lowprobe:1,
+		lowprobe_superblocks:1,
+		lowprobe_topology:1,
+		raw_chars:1;
+};
 
 static void print_version(FILE *out)
 {
@@ -102,7 +113,8 @@ static void usage(int error)
  *
  * If 'esc' is defined then escape all chars from esc by \.
  */
-static void safe_print(const char *cp, int len, const char *esc)
+static void safe_print(const struct blkid_control *ctl, const char *cp, int len,
+		       const char *esc)
 {
 	unsigned char	ch;
 
@@ -111,7 +123,7 @@ static void safe_print(const char *cp, int len, const char *esc)
 
 	while (len--) {
 		ch = *cp++;
-		if (!raw_chars) {
+		if (!ctl->raw_chars) {
 			if (ch >= 128) {
 				fputs("M-", stdout);
 				ch -= 128;
@@ -284,22 +296,23 @@ static int has_item(char *ary[], const char *item)
 	return 0;
 }
 
-static void print_value(int output, int num, const char *devname,
-			const char *value, const char *name, size_t valsz)
+static void print_value(const struct blkid_control *ctl, int num,
+			const char *devname, const char *value,
+			const char *name, size_t valsz)
 {
-	if (output & OUTPUT_VALUE_ONLY) {
+	if (ctl->output & OUTPUT_VALUE_ONLY) {
 		fputs(value, stdout);
 		fputc('\n', stdout);
 
-	} else if (output & OUTPUT_UDEV_LIST) {
+	} else if (ctl->output & OUTPUT_UDEV_LIST) {
 		print_udev_format(name, value);
 
-	} else if (output & OUTPUT_EXPORT_LIST) {
+	} else if (ctl->output & OUTPUT_EXPORT_LIST) {
 		if (num == 1 && devname)
 			printf("DEVNAME=%s\n", devname);
 		fputs(name, stdout);
 		fputs("=", stdout);
-		safe_print(value, valsz, " \\\"'$`<>");
+		safe_print(ctl, value, valsz, " \\\"'$`<>");
 		fputs("\n", stdout);
 
 	} else {
@@ -308,12 +321,12 @@ static void print_value(int output, int num, const char *devname,
 		fputs(" ", stdout);
 		fputs(name, stdout);
 		fputs("=\"", stdout);
-		safe_print(value, valsz, "\"\\");
+		safe_print(ctl, value, valsz, "\"\\");
 		fputs("\"", stdout);
 	}
 }
 
-static void print_tags(blkid_dev dev, char *show[], int output)
+static void print_tags(const struct blkid_control *ctl, blkid_dev dev)
 {
 	blkid_tag_iterate	iter;
 	const char		*type, *value, *devname;
@@ -323,34 +336,34 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 	if (!dev)
 		return;
 
-	if (output & OUTPUT_PRETTY_LIST) {
+	if (ctl->output & OUTPUT_PRETTY_LIST) {
 		pretty_print_dev(dev);
 		return;
 	}
 
 	devname = blkid_dev_devname(dev);
 
-	if (output & OUTPUT_DEVICE_ONLY) {
+	if (ctl->output & OUTPUT_DEVICE_ONLY) {
 		printf("%s\n", devname);
 		return;
 	}
 
 	iter = blkid_tag_iterate_begin(dev);
 	while (blkid_tag_next(iter, &type, &value) == 0) {
-		if (show[0] && !has_item(show, type))
+		if (ctl->show[0] && !has_item(ctl->show, type))
 			continue;
 
 		if (num == 1 && !first &&
-		    (output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
+		    (ctl->output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
 			/* add extra line between output from more devices */
 			fputc('\n', stdout);
 
-		print_value(output, num++, devname, value, type, strlen(value));
+		print_value(ctl, num++, devname, value, type, strlen(value));
 	}
 	blkid_tag_iterate_end(iter);
 
 	if (num > 1) {
-		if (!(output & (OUTPUT_VALUE_ONLY | OUTPUT_UDEV_LIST |
+		if (!(ctl->output & (OUTPUT_VALUE_ONLY | OUTPUT_UDEV_LIST |
 						OUTPUT_EXPORT_LIST)))
 			printf("\n");
 		first = 0;
@@ -474,8 +487,7 @@ static int lowprobe_topology(blkid_probe pr)
 }
 
 static int lowprobe_device(blkid_probe pr, const char *devname,
-			int chain, char *show[], int output,
-			uint64_t offset, uint64_t size)
+			   struct blkid_control *ctl)
 {
 	const char *data;
 	const char *name;
@@ -490,12 +502,12 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 		warn(_("error: %s"), devname);
 		return BLKID_EXIT_NOTFOUND;
 	}
-	if (blkid_probe_set_device(pr, fd, offset, size))
+	if (blkid_probe_set_device(pr, fd, ctl->offset, ctl->size))
 		goto done;
 
-	if (chain & LOWPROBE_TOPOLOGY)
+	if (ctl->lowprobe_topology)
 		rc = lowprobe_topology(pr);
-	if (rc >= 0 && (chain & LOWPROBE_SUPERBLOCKS))
+	if (rc >= 0 && ctl->lowprobe_superblocks)
 		rc = lowprobe_superblocks(pr);
 	if (rc < 0)
 		goto done;
@@ -503,11 +515,11 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	if (!rc)
 		nvals = blkid_probe_numof_values(pr);
 
-	if (nvals && !first && output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST))
+	if (nvals && !first && ctl->output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST))
 		/* add extra line between output from devices */
 		fputc('\n', stdout);
 
-	if (nvals && (output & OUTPUT_DEVICE_ONLY)) {
+	if (nvals && (ctl->output & OUTPUT_DEVICE_ONLY)) {
 		printf("%s\n", devname);
 		goto done;
 	}
@@ -515,20 +527,21 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 	for (n = 0; n < nvals; n++) {
 		if (blkid_probe_get_value(pr, n, &name, &data, &len))
 			continue;
-		if (show[0] && !has_item(show, name))
+		if (ctl->show[0] && !has_item(ctl->show, name))
 			continue;
 		len = strnlen((char *) data, len);
-		print_value(output, num++, devname, (char *) data, name, len);
+		print_value(ctl, num++, devname, (char *) data, name, len);
 	}
 
 	if (first)
 		first = 0;
-	if (nvals >= 1 && !(output & (OUTPUT_VALUE_ONLY |
+
+	if (nvals >= 1 && !(ctl->output & (OUTPUT_VALUE_ONLY |
 					OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
 		printf("\n");
 done:
 	if (rc == -2) {
-		if (output & OUTPUT_UDEV_LIST)
+		if (ctl->output & OUTPUT_UDEV_LIST)
 			print_udev_ambivalent(pr);
 		else
 			warnx(_("%s: ambivalent result (probably more "
@@ -631,9 +644,9 @@ static void free_types_list(char *list[])
 
 int main(int argc, char **argv)
 {
+	struct blkid_control ctl = { .output = OUTPUT_FULL, 0 };
 	blkid_cache cache = NULL;
 	char **devices = NULL;
-	char *show[128] = { NULL, };
 	char *search_type = NULL, *search_value = NULL;
 	char *read = NULL;
 	int fltr_usage = 0;
@@ -642,10 +655,7 @@ int main(int argc, char **argv)
 	unsigned int numdev = 0, numtag = 0;
 	int err = BLKID_EXIT_OTHER;
 	unsigned int i;
-	int output_format = 0;
-	int lookup = 0, gc = 0, lowprobe = 0, eval = 0;
 	int c;
-	uintmax_t offset = 0, size = 0;
 
 	static const ul_excl_t excl[] = {       /* rows and cols in ASCII order */
 		{ 'n','u' },
@@ -653,7 +663,6 @@ int main(int argc, char **argv)
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
-	show[0] = NULL;
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -666,16 +675,13 @@ int main(int argc, char **argv)
 
 		switch (c) {
 		case 'c':
-			if (optarg && !*optarg)
-				read = NULL;
-			else
-				read = optarg;
+			read = optarg;
 			break;
 		case 'd':
-			raw_chars = 1;
+			ctl.raw_chars = 1;
 			break;
 		case 'L':
-			eval++;
+			ctl.eval = 1;
 			search_value = xstrdup(optarg);
 			search_type = xstrdup("LABEL");
 			break;
@@ -686,18 +692,18 @@ int main(int argc, char **argv)
 			fltr_usage = list_to_usage(optarg, &fltr_flag);
 			break;
 		case 'U':
-			eval++;
+			ctl.eval = 1;
 			search_value = xstrdup(optarg);
 			search_type = xstrdup("UUID");
 			break;
 		case 'i':
-			lowprobe |= LOWPROBE_TOPOLOGY;
+			ctl.lowprobe_topology = 1;
 			break;
 		case 'l':
-			lookup++;
+			ctl.lookup = 1;
 			break;
 		case 'g':
-			gc = 1;
+			ctl.gc = 1;
 			break;
 		case 'k':
 		{
@@ -710,36 +716,35 @@ int main(int argc, char **argv)
 		}
 		case 'o':
 			if (!strcmp(optarg, "value"))
-				output_format = OUTPUT_VALUE_ONLY;
+				ctl.output = OUTPUT_VALUE_ONLY;
 			else if (!strcmp(optarg, "device"))
-				output_format = OUTPUT_DEVICE_ONLY;
+				ctl.output = OUTPUT_DEVICE_ONLY;
 			else if (!strcmp(optarg, "list"))
-				output_format = OUTPUT_PRETTY_LIST;	/* deprecated */
+				ctl.output = OUTPUT_PRETTY_LIST;	/* deprecated */
 			else if (!strcmp(optarg, "udev"))
-				output_format = OUTPUT_UDEV_LIST;
+				ctl.output = OUTPUT_UDEV_LIST;
 			else if (!strcmp(optarg, "export"))
-				output_format = OUTPUT_EXPORT_LIST;
+				ctl.output = OUTPUT_EXPORT_LIST;
 			else if (!strcmp(optarg, "full"))
-				output_format = 0;
+				ctl.output = 0;
 			else
 				errx(BLKID_EXIT_OTHER, _("unsupported output format %s"), optarg);
 			break;
 		case 'O':
-			offset = strtosize_or_err(optarg, _("invalid offset argument"));
+			ctl.offset = strtosize_or_err(optarg, _("invalid offset argument"));
 			break;
 		case 'p':
-			lowprobe |= LOWPROBE_SUPERBLOCKS;
+			ctl.lowprobe_superblocks = 1;
 			break;
 		case 's':
-			if (numtag + 1 >= sizeof(show) / sizeof(*show)) {
+			if (numtag + 1 >= sizeof(ctl.show) / sizeof(*ctl.show)) {
 				warnx(_("Too many tags specified"));
 				errtryh(err);
 			}
-			show[numtag++] = optarg;
-			show[numtag] = NULL;
+			ctl.show[numtag++] = optarg;
 			break;
 		case 'S':
-			size = strtosize_or_err(optarg, _("invalid size argument"));
+			ctl.size = strtosize_or_err(optarg, _("invalid size argument"));
 			break;
 		case 't':
 			if (search_type) {
@@ -769,6 +774,8 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (ctl.lowprobe_topology || ctl.lowprobe_superblocks)
+		ctl.lowprobe = 1;
 
 	/* The rest of the args are device names */
 	if (optind < argc) {
@@ -778,31 +785,31 @@ int main(int argc, char **argv)
 	}
 
 	/* convert LABEL/UUID lookup to evaluate request */
-	if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
+	if (ctl.lookup && ctl.output == OUTPUT_DEVICE_ONLY && search_type &&
 	    (!strcmp(search_type, "LABEL") || !strcmp(search_type, "UUID"))) {
-		eval++;
-		lookup = 0;
+		ctl.eval = 1;
+		ctl.lookup = 0;
 	}
 
-	if (!lowprobe && !eval && blkid_get_cache(&cache, read) < 0)
+	if (!ctl.lowprobe && !ctl.eval && blkid_get_cache(&cache, read) < 0)
 		goto exit;
 
-	if (gc) {
+	if (ctl.gc) {
 		blkid_gc_cache(cache);
 		err = 0;
 		goto exit;
 	}
 	err = BLKID_EXIT_NOTFOUND;
 
-	if (eval == 0 && (output_format & OUTPUT_PRETTY_LIST)) {
-		if (lowprobe)
+	if (ctl.eval == 0 && (ctl.output & OUTPUT_PRETTY_LIST)) {
+		if (ctl.lowprobe)
 			errx(BLKID_EXIT_OTHER,
 			     _("The low-level probing mode does not "
 			       "support 'list' output format"));
 		pretty_print_dev(NULL);
 	}
 
-	if (lowprobe) {
+	if (ctl.lowprobe) {
 		/*
 		 * Low-level API
 		 */
@@ -814,38 +821,36 @@ int main(int argc, char **argv)
 			       "requires a device"));
 
 		/* automatically enable 'export' format for I/O Limits */
-		if (!output_format  && (lowprobe & LOWPROBE_TOPOLOGY))
-			output_format = OUTPUT_EXPORT_LIST;
+		if (!ctl.output  && ctl.lowprobe_topology)
+			ctl.output = OUTPUT_EXPORT_LIST;
 
 		pr = blkid_new_probe();
 		if (!pr)
 			goto exit;
 
-		if (lowprobe & LOWPROBE_SUPERBLOCKS) {
+		if (ctl.lowprobe_superblocks) {
 			blkid_probe_set_superblocks_flags(pr,
 				BLKID_SUBLKS_LABEL | BLKID_SUBLKS_UUID |
 				BLKID_SUBLKS_TYPE | BLKID_SUBLKS_SECTYPE |
 				BLKID_SUBLKS_USAGE | BLKID_SUBLKS_VERSION);
 
-			if (fltr_usage && blkid_probe_filter_superblocks_usage(
-						pr, fltr_flag, fltr_usage))
+
+			if (fltr_usage &&
+			    blkid_probe_filter_superblocks_usage(pr, fltr_flag, fltr_usage))
 				goto exit;
 
-			else if (fltr_type && blkid_probe_filter_superblocks_type(
-						pr, fltr_flag, fltr_type))
+			else if (fltr_type &&
+				 blkid_probe_filter_superblocks_type(pr, fltr_flag, fltr_type))
 				goto exit;
 		}
 
 		for (i = 0; i < numdev; i++) {
-			err = lowprobe_device(pr, devices[i], lowprobe, show,
-					output_format,
-					(uint64_t) offset,
-					(uint64_t) size);
+			err = lowprobe_device(pr, devices[i], &ctl);
 			if (err)
 				break;
 		}
 		blkid_free_probe(pr);
-	} else if (eval) {
+	} else if (ctl.eval) {
 		/*
 		 * Evaluate API
 		 */
@@ -854,7 +859,7 @@ int main(int argc, char **argv)
 			err = 0;
 			printf("%s\n", res);
 		}
-	} else if (lookup) {
+	} else if (ctl.lookup) {
 		/*
 		 * Classic (cache based) API
 		 */
@@ -870,7 +875,7 @@ int main(int argc, char **argv)
 
 		if ((dev = blkid_find_dev_with_tag(cache, search_type,
 						   search_value))) {
-			print_tags(dev, show, output_format);
+			print_tags(&ctl, dev);
 			err = 0;
 		}
 	/* If we didn't specify a single device, show all available devices */
@@ -886,7 +891,7 @@ int main(int argc, char **argv)
 			dev = blkid_verify(cache, dev);
 			if (!dev)
 				continue;
-			print_tags(dev, show, output_format);
+			print_tags(&ctl, dev);
 			err = 0;
 		}
 		blkid_dev_iterate_end(iter);
@@ -900,7 +905,7 @@ int main(int argc, char **argv)
 			    !blkid_dev_has_tag(dev, search_type,
 					       search_value))
 				continue;
-			print_tags(dev, show, output_format);
+			print_tags(&ctl, dev);
 			err = 0;
 		}
 	}
@@ -909,7 +914,7 @@ exit:
 	free(search_type);
 	free(search_value);
 	free_types_list(fltr_type);
-	if (!lowprobe && !eval)
+	if (!ctl.lowprobe && !ctl.eval)
 		blkid_put_cache(cache);
 	free(devices);
 	return err;
-- 
2.12.0

