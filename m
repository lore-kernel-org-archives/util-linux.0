Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35689 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935219AbdCJJan (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Mar 2017 04:30:43 -0500
Received: by mail-lf0-f66.google.com with SMTP id v2so6420032lfi.2
        for <util-linux@vger.kernel.org>; Fri, 10 Mar 2017 01:29:22 -0800 (PST)
Date: Fri, 10 Mar 2017 09:29:01 +0000 (GMT)
From: Sami Kerola <kerolasa@iki.fi>
To: J William Piggott <elseifthen@gmx.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/13] blkid: define output names only once
In-Reply-To: <1998d830-63b1-a477-d5ae-4219171c0b3c@gmx.com>
Message-ID: <alpine.LNX.2.20.1703100917380.28674@imuri>
References: <20170305205232.24030-1-kerolasa@iki.fi> <20170305205232.24030-8-kerolasa@iki.fi> <c0779c68-d9cf-0eb0-f8e4-91130ee57db9@gmx.com> <1998d830-63b1-a477-d5ae-4219171c0b3c@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 8 Mar 2017, J William Piggott wrote:
> On 03/07/2017 09:37 AM, J William Piggott wrote:
> > On 03/05/2017 03:52 PM, Sami Kerola wrote:
> > 
> >> +				warnx(_("Invalid output format %s. "
> >> +					"Choose from value:"), optarg);
> >> +				fputc('\t', stderr);
> >> +				for (j = 0; j < ARRAY_SIZE(output_names); j++)
> >> +					fprintf(stderr, "%s%s", j == 0 ? "" : " ", output_names[j]);
> >> +				fputc('\n', stderr);
> >> +				exit(BLKID_EXIT_OTHER);
> > 
> > 
> > I see, it is saying "Choose a value from:". 'Choose from:" is enough,
> > it's confusing to use 'value' when it is also one of the choices.
> > 
> > I also see, that 2 of the output choices are deprecated. If they are
> > going to be excluded from the 'help' output, shouldn't they be excluded
> > from the error messages as well?
> 
> After replying yesterday something else occurred to me. This seems
> unnecessarily complex for an error message. Isn't "Invalid output format %s. "
> enough? Then let them either use --help or RTM?
> 
> It shouldn't be capitalized and the invalid value should be quoted:
> warnx(_("invalid output format '%s'"

Thank you for feedback JWP,

After reading what you had to say about option argument parsing I end up 
improving messaging, making soft-deprecated arguments to be hidden, and 
rewrote related functions to be something that should be relatively easy 
to make reusable for other utilities.

https://github.com/kerolasa/lelux-utiliteetit/commit/31d790e9f7fb972b34cba37caedf155afe314427

Notably I did not move list of recommended arguments to usage(). To do 
that well will require inu_use_arguments() function, that can be used 
where ever needed. But lets leave this as-is, and do these tidy 
adjustments if there it's seen these option argument functions should be 
generalized.

-- snip
commit 31d790e9f7fb972b34cba37caedf155afe314427
Author: Sami Kerola <kerolasa@iki.fi>
Date:   Tue Feb 28 22:16:58 2017 +0000

blkid: define output names only once
    
Output names are magic strings, and they should be defined only once in one
place to avoid mismatches and/or incompleteness.
    
parse_format_name() is made relatively generic, so that it can be moved to
include/optutils.h if/when needed.
    
Signed-off-by: Sami Kerola <kerolasa@iki.fi>

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 2ec806c23..f6e6f977e 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -19,11 +19,35 @@
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
+enum {
+	opt_in_use = 0,
+	opt_hide,
+	opt_deprecate,
+	opt_removed
+};
+
+struct option_arguments {
+	char *name;
+	int status;
+};
+
+static struct option_arguments output_formats[] = {
+	[OUTPUT_FULL]		= { "full", opt_in_use },
+	[OUTPUT_VALUE_ONLY]	= { "value", opt_in_use },
+	[OUTPUT_DEVICE_ONLY]	= { "device", opt_in_use },
+	[OUTPUT_PRETTY_LIST]	= { "list", opt_hide },		/* to be deprecated */
+	[OUTPUT_UDEV_LIST]	= { "udev", opt_hide },		/* to be deprecated */
+	[OUTPUT_EXPORT_LIST]	= { "export", opt_in_use },
+};
 
 #define LOWPROBE_TOPOLOGY	(1 << 1)
 #define LOWPROBE_SUPERBLOCKS	(1 << 2)
@@ -97,6 +121,36 @@ static void usage(int error)
 	exit(error);
 }
 
+static int parse_format_name(const char *arg)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(output_formats); i++) {
+		if (strcmp(output_formats[i].name, arg) != 0)
+			continue;
+		switch (output_formats[i].status) {
+		case opt_in_use:
+		case opt_hide:
+			return i;
+		case opt_deprecate:
+			warnx(_("'%s' is deprecated"), arg);
+			return i;
+		case opt_removed:
+			warnx(_("'%s' is removed"), arg);
+			return -EINVAL;
+		default:
+			abort();
+		}
+	}
+	warnx(_("invalid argument: '%s'"), arg);
+	fprintf(stderr, _("recommended arguments to use are:"));
+	for (i = 0; i < ARRAY_SIZE(output_formats); i++)
+		if (output_formats[i].status == opt_in_use)
+			fprintf(stderr, " %s", output_formats[i].name);
+	fputc('\n', stderr);
+	return -EINVAL;
+}
+
 /*
  * This function does "safe" printing.  It will convert non-printable
  * ASCII characters using '^' and M- notation.
@@ -288,22 +342,23 @@ static int has_item(char *ary[], const char *item)
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
@@ -324,14 +379,14 @@ static void print_tags(blkid_dev dev, char *show[], int output)
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
@@ -342,7 +397,7 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 			continue;
 
 		if (num == 1 && !first &&
-		    (output & (OUTPUT_UDEV_LIST | OUTPUT_EXPORT_LIST)))
+		    (output == OUTPUT_UDEV_LIST || output == OUTPUT_EXPORT_LIST))
 			/* add extra line between output from more devices */
 			fputc('\n', stdout);
 
@@ -351,8 +406,8 @@ static void print_tags(blkid_dev dev, char *show[], int output)
 	blkid_tag_iterate_end(iter);
 
 	if (num > 1) {
-		if (!(output & (OUTPUT_VALUE_ONLY | OUTPUT_UDEV_LIST |
-						OUTPUT_EXPORT_LIST)))
+		if (!(output == OUTPUT_VALUE_ONLY || output == OUTPUT_UDEV_LIST
+		      || output == OUTPUT_EXPORT_LIST))
 			printf("\n");
 		first = 0;
 	}
@@ -504,11 +559,11 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
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
@@ -524,12 +579,15 @@ static int lowprobe_device(blkid_probe pr, const char *devname,
 
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
@@ -644,7 +702,7 @@ int main(int argc, char **argv)
 	int version = 0;
 	int err = BLKID_EXIT_OTHER;
 	unsigned int i;
-	int output_format = 0;
+	int output_format = OUTPUT_FULL;
 	int lookup = 0, gc = 0, lowprobe = 0, eval = 0;
 	int c;
 	uintmax_t offset = 0, size = 0;
@@ -711,23 +769,9 @@ int main(int argc, char **argv)
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
-					"device, list, udev or full\n", optarg);
-			}
+			output_format = parse_format_name(optarg);
+			if (output_format < 0)
+				exit(BLKID_EXIT_OTHER);
 			break;
 		case 'O':
 			offset = strtosize_or_err(optarg, _("invalid offset argument"));
@@ -804,7 +848,7 @@ int main(int argc, char **argv)
 	}
 	err = BLKID_EXIT_NOTFOUND;
 
-	if (eval == 0 && (output_format & OUTPUT_PRETTY_LIST)) {
+	if (eval == 0 && output_format == OUTPUT_PRETTY_LIST) {
 		if (lowprobe)
 			errx(BLKID_EXIT_OTHER,
 			     _("The low-level probing mode does not "
@@ -824,7 +868,7 @@ int main(int argc, char **argv)
 			       "requires a device"));
 
 		/* automatically enable 'export' format for I/O Limits */
-		if (!output_format  && (lowprobe & LOWPROBE_TOPOLOGY))
+		if (output_format == OUTPUT_FULL && (lowprobe & LOWPROBE_TOPOLOGY))
 			output_format = OUTPUT_EXPORT_LIST;
 
 		pr = blkid_new_probe();
