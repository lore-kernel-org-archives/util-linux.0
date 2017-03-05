Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33513 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdCEUwp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:45 -0500
Received: by mail-wr0-f195.google.com with SMTP id g10so19462047wrg.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/13] blkid: add messages to translations
Date: Sun,  5 Mar 2017 20:52:25 +0000
Message-Id: <20170305205232.24030-7-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Without obvious reason blkid has managed to be part of this project for
pretty long time without getting translations.  Lets change that.  In same
go use the usual error printing facilities instead of fprintf(stderr, ...);

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c | 131 ++++++++++++++++++++++++++---------------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 7bbb54dfd..4746e09a7 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -43,6 +43,7 @@
 #define CLOSE_EXIT_CODE		BLKID_EXIT_OTHER	/* close_stdout() */
 #include "closestream.h"
 
+#include "nls.h"
 #include "ttyutils.h"
 #include "xalloc.h"
 
@@ -50,7 +51,7 @@ static int raw_chars;
 
 static void print_version(FILE *out)
 {
-	fprintf(out, "%s from %s  (libblkid %s, %s)\n",
+	fprintf(out, _("%s from %s  (libblkid %s, %s)\n"),
 		program_invocation_short_name, PACKAGE_STRING,
 		LIBBLKID_VERSION, LIBBLKID_DATE);
 }
@@ -60,38 +61,38 @@ static void usage(int error)
 	FILE *out = error ? stderr : stdout;
 
 	print_version(out);
-	fprintf(out,
-		"Usage:\n"
-		" %1$s -L <label> | -U <uuid>\n\n"
-		" %1$s [-c <file>] [-ghlLv] [-o <format>] [-s <tag>] \n"
-		"       [-t <token>] [<dev> ...]\n\n"
-		" %1$s -p [-s <tag>] [-O <offset>] [-S <size>] \n"
-		"       [-o <format>] <dev> ...\n\n"
-		" %1$s -i [-s <tag>] [-o <format>] <dev> ...\n\n"
-		"Options:\n"
-		" -c <file>   read from <file> instead of reading from the default\n"
-		"               cache file (-c /dev/null means no cache)\n"
-		" -d          don't encode non-printing characters\n"
-		" -h          print this usage message and exit\n"
-		" -g          garbage collect the blkid cache\n"
-		" -o <format> output format; can be one of:\n"
-		"               value, device, export or full; (default: full)\n"
-		" -k          list all known filesystems/RAIDs and exit\n"
-		" -s <tag>    show specified tag(s) (default show all tags)\n"
-		" -t <token>  find device with a specific token (NAME=value pair)\n"
-		" -l          look up only first device with token specified by -t\n"
-		" -L <label>  convert LABEL to device name\n"
-		" -U <uuid>   convert UUID to device name\n"
-		" -V          print version and exit\n"
-		" <dev>       specify device(s) to probe (default: all devices)\n\n"
-		"Low-level probing options:\n"
-		" -p          low-level superblocks probing (bypass cache)\n"
-		" -i          gather information about I/O limits\n"
-		" -S <size>   overwrite device size\n"
-		" -O <offset> probe at the given offset\n"
-		" -u <list>   filter by \"usage\" (e.g. -u filesystem,raid)\n"
-		" -n <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"
-		"\n", program_invocation_short_name);
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(	" %s -L <label> | -U <uuid>\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s [-c <file>] [-ghlLv] [-o <format>] [-s <tag>] \n"
+			"       [-t <token>] [<dev> ...]\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s -p [-s <tag>] [-O <offset>] [-S <size>] \n"
+			"       [-o <format>] <dev> ...\n\n"), program_invocation_short_name);
+	fprintf(out, _(	" %s -i [-s <tag>] [-o <format>] <dev> ...\n\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(	" -c <file>   read from <file> instead of reading from the default\n"
+			"               cache file (-c /dev/null means no cache)\n"), out);
+	fputs(_(	" -d          don't encode non-printing characters\n"), out);
+	fputs(_(	" -h          print this usage message and exit\n"), out);
+	fputs(_(	" -g          garbage collect the blkid cache\n"), out);
+	fputs(_(	" -o <format> output format; can be one of:\n"
+			"               value, device, export or full; (default: full)\n"), out);
+	fputs(_(	" -k          list all known filesystems/RAIDs and exit\n"), out);
+	fputs(_(	" -s <tag>    show specified tag(s) (default show all tags)\n"), out);
+	fputs(_(	" -t <token>  find device with a specific token (NAME=value pair)\n"), out);
+	fputs(_(	" -l          look up only first device with token specified by -t\n"), out);
+	fputs(_(	" -L <label>  convert LABEL to device name\n"), out);
+	fputs(_(	" -U <uuid>   convert UUID to device name\n"), out);
+	fputs(_(	" -V          print version and exit\n"), out);
+	fputs(_(	" <dev>       specify device(s) to probe (default: all devices)\n"), out);
+	fputs(          "\n", out);
+	fputs(_(	"Low-level probing options:\n"), out);
+	fputs(_(	" -p          low-level superblocks probing (bypass cache)\n"), out);
+	fputs(_(	" -i          gather information about I/O limits\n"), out);
+	fputs(_(	" -S <size>   overwrite device size\n"), out);
+	fputs(_(	" -O <offset> probe at the given offset\n"), out);
+	fputs(_(	" -u <list>   filter by \"usage\" (e.g. -u filesystem,raid)\n"), out);
+	fputs(_(	" -n <list>   filter by filesystem type (e.g. -n vfat,ext3)\n"), out);
+	fputs(		"\n", out);
 
 	exit(error);
 }
@@ -219,11 +220,11 @@ static void pretty_print_dev(blkid_dev dev)
 	if (retval == 0) {
 		if (mount_flags & MF_MOUNTED) {
 			if (!mtpt[0])
-				strcpy(mtpt, "(mounted, mtpt unknown)");
+				strcpy(mtpt, _("(mounted, mtpt unknown)"));
 		} else if (mount_flags & MF_BUSY)
-			strcpy(mtpt, "(in use)");
+			strcpy(mtpt, _("(in use)"));
 		else
-			strcpy(mtpt, "(not mounted)");
+			strcpy(mtpt, _("(not mounted)"));
 	}
 
 	pretty_print_line(devname, fs_type, label, mtpt, uuid);
@@ -487,7 +488,7 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 
 	fd = open(devname, O_RDONLY|O_CLOEXEC);
 	if (fd < 0) {
-		fprintf(stderr, "error: %s: %m\n", devname);
+		warn(_("error: %s"), devname);
 		return BLKID_EXIT_NOTFOUND;
 	}
 	if (blkid_probe_set_device(pr, fd, offset, size))
@@ -531,10 +532,9 @@ done:
 		if (output & OUTPUT_UDEV_LIST)
 			print_udev_ambivalent(pr);
 		else
-			fprintf(stderr,
-				"%s: ambivalent result (probably more "
+			warnx(_("%s: ambivalent result (probably more "
 				"filesystems on the device, use wipefs(8) "
-				"to see more details)\n",
+				"to see more details)"),
 				devname);
 	}
 	close(fd);
@@ -578,7 +578,7 @@ static int list_to_usage(const char *list, int *flag)
 	return mask;
 err:
 	*flag = 0;
-	fprintf(stderr, "unknown keyword in -u <list> argument: '%s'\n",
+	warnx(_("unknown keyword in -u <list> argument: '%s'"),
 			word ? word : list);
 	exit(BLKID_EXIT_OTHER);
 }
@@ -595,7 +595,7 @@ static char **list_to_types(const char *list, int *flag)
 		p += 2;
 	}
 	if (!p || !*p) {
-		fprintf(stderr, "error: -u <list> argument is empty\n");
+		warnx(_("error: -u <list> argument is empty"));
 		goto err;
 	}
 	for (i = 1; p && (p = strchr(p, ',')); i++, p++);
@@ -656,6 +656,9 @@ int main(int argc, char **argv)
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
 	show[0] = NULL;
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
 	atexit(close_stdout);
 
 	while ((c = getopt (argc, argv,
@@ -721,39 +724,38 @@ int main(int argc, char **argv)
 			else if (!strcmp(optarg, "full"))
 				output_format = 0;
 			else {
-				fprintf(stderr, "Invalid output format %s. "
+				errx(BLKID_EXIT_OTHER, _("Invalid output format %s. "
 					"Choose from value,\n\t"
-					"device, list, udev or full\n", optarg);
-				exit(BLKID_EXIT_OTHER);
+					"value, device, list, udev, export, or full"), optarg);
 			}
 			break;
 		case 'O':
-			offset = strtosize_or_err(optarg, "invalid offset argument");
+			offset = strtosize_or_err(optarg, _("invalid offset argument"));
 			break;
 		case 'p':
 			lowprobe |= LOWPROBE_SUPERBLOCKS;
 			break;
 		case 's':
 			if (numtag + 1 >= sizeof(show) / sizeof(*show)) {
-				fprintf(stderr, "Too many tags specified\n");
+				warnx(_("Too many tags specified"));
 				usage(err);
 			}
 			show[numtag++] = optarg;
 			show[numtag] = NULL;
 			break;
 		case 'S':
-			size = strtosize_or_err(optarg, "invalid size argument");
+			size = strtosize_or_err(optarg, _("invalid size argument"));
 			break;
 		case 't':
 			if (search_type) {
-				fprintf(stderr, "Can only search for "
-						"one NAME=value pair\n");
+				warnx(_("Can only search for "
+					"one NAME=value pair"));
 				usage(err);
 			}
 			if (blkid_parse_tag_string(optarg,
 						   &search_type,
 						   &search_value)) {
-				fprintf(stderr, "-t needs NAME=value pair\n");
+				warnx(_("-t needs NAME=value pair"));
 				usage(err);
 			}
 			break;
@@ -803,11 +805,10 @@ int main(int argc, char **argv)
 	err = BLKID_EXIT_NOTFOUND;
 
 	if (eval == 0 && (output_format & OUTPUT_PRETTY_LIST)) {
-		if (lowprobe) {
-			fprintf(stderr, "The low-level probing mode does not "
-					"support 'list' output format\n");
-			exit(BLKID_EXIT_OTHER);
-		}
+		if (lowprobe)
+			errx(BLKID_EXIT_OTHER,
+			     _("The low-level probing mode does not "
+			       "support 'list' output format"));
 		pretty_print_dev(NULL);
 	}
 
@@ -817,11 +818,10 @@ int main(int argc, char **argv)
 		 */
 		blkid_probe pr;
 
-		if (!numdev) {
-			fprintf(stderr, "The low-level probing mode "
-					"requires a device\n");
-			exit(BLKID_EXIT_OTHER);
-		}
+		if (!numdev)
+			errx(BLKID_EXIT_OTHER,
+			     _("The low-level probing mode "
+			       "requires a device"));
 
 		/* automatically enable 'export' format for I/O Limits */
 		if (!output_format  && (lowprobe & LOWPROBE_TOPOLOGY))
@@ -870,11 +870,10 @@ int main(int argc, char **argv)
 		 */
 		blkid_dev dev;
 
-		if (!search_type) {
-			fprintf(stderr, "The lookup option requires a "
-				"search type specified using -t\n");
-			exit(BLKID_EXIT_OTHER);
-		}
+		if (!search_type)
+			errx(BLKID_EXIT_OTHER,
+			     _("The lookup option requires a "
+			       "search type specified using -t"));
 		/* Load any additional devices not in the cache */
 		for (i = 0; i < numdev; i++)
 			blkid_get_dev(cache, devices[i], BLKID_DEV_NORMAL);
-- 
2.12.0

