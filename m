Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 08/13] sfdisk: move main function at the end of the file
Date: Tue, 22 Jul 2014 16:44:52 -0700
Message-Id: <1406072697-20912-9-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

By doing so, we can remove do_*() function prototypes.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 476 +++++++++++++++++++++++++---------------------------
 1 file changed, 233 insertions(+), 243 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 7e0b081..a097c6e 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -2457,251 +2457,8 @@ static char *nextproc(FILE *f)
 	return NULL;
 }
 
-static int do_list(char *dev, int silent);
-static void do_size(char *dev, int silent);
-static void do_geom(char *dev, int silent);
-static void do_pt_geom(char *dev, int silent);
-static int do_fdisk(char *dev);
-static void do_reread(char *dev);
-static int do_change_id(char *dev, char *part, char *id);
-static int do_unhide(char **av, int ac, char *arg);
-static int do_activate(char **av, int ac, char *arg);
-
 unsigned long long total_size;
 
-int main(int argc, char **argv)
-{
-	int c, ret = 0;
-	char *dev;
-	int opt_size = 0;
-	int opt_out_geom = 0;
-	int opt_out_pt_geom = 0;
-	int opt_reread = 0;
-	int activate = 0;
-	int do_id = 0;
-	int unhide = 0;
-	char *activatearg = 0;
-	char *unhidearg = 0;
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	if (!strcmp(program_invocation_short_name, "activate"))
-		activate = 1;		/* equivalent to `sfdisk -A' */
-
-	while ((c = getopt_long(argc, argv, "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V",
-				long_opts, NULL)) != -1) {
-		switch (c) {
-		case 'f':
-			force = 1;
-			break;		/* does not imply quiet */
-		case 'g':
-			opt_out_geom = 1;
-			break;
-		case 'G':
-			opt_out_pt_geom = 1;
-			break;
-		case 'i':
-			increment = 1;
-			break;
-		case 'c':
-		case 'c' + PRINT_ID:
-		case 'c' + CHANGE_ID:
-			do_id = c;
-			break;
-		case 'd':
-			dump = 1;		/* fall through */
-		case 'l':
-			opt_list = 1;
-			break;
-		case 'n':
-			no_write = 1;
-			break;
-		case 'q':
-			quiet = 1;
-			break;
-		case 's':
-			opt_size = 1;
-			break;
-		case 'u':
-			set_format(*optarg);
-			break;
-		case 'v':
-			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
-		case 'h':
-			usage(stdout);
-		case 'x':
-			show_extended = 1;
-			break;
-		case 'A':
-			activatearg = optarg;
-			activate = 1;
-			break;
-		case 'C':
-			U.cylinders = strtoul_or_err(optarg, _("invalid cylinders argument"));
-			break;
-		case 'D':
-			DOS = 1;
-			break;
-		case 'E':
-			DOS_extended = 1;
-			break;
-		case 'H':
-			U.heads = strtoul_or_err(optarg, _("invalid heads argument"));
-			break;
-		case 'L':
-			Linux = 1;
-			break;
-		case 'N':
-			one_only = strtol_or_err(optarg, _("invalid number of partitions argument"));
-			break;
-		case 'I':
-			restore_sector_file = optarg;
-			break;
-		case 'O':
-			save_sector_file = optarg;
-			break;
-		case 'R':
-			opt_reread = 1;
-			break;
-		case 'S':
-			U.sectors = strtoul_or_err(optarg, _("invalid sectors argument"));
-			break;
-		case 'T':
-			list_types();
-			return EXIT_SUCCESS;
-		case 'U':
-			unhidearg = optarg;
-			unhide = 1;
-			break;
-		case 'V':
-			verify = 1;
-			break;
-		default:
-			usage(stderr);
-
-			/* dangerous flags */
-		case OPT_IN_ORDER:
-			partitions_in_order = 1;
-			break;
-		case OPT_NOT_IN_ORDER:
-			partitions_in_order = 0;
-			break;
-		case OPT_INSIDE_OUTER:
-			all_logicals_inside_outermost_extended = 1;
-			break;
-		case OPT_NOT_INSIDE_OUTER:
-			all_logicals_inside_outermost_extended = 0;
-			break;
-		case OPT_NESTED:
-			boxes = NESTED;
-			break;
-		case OPT_CHAINED:
-			boxes = CHAINED;
-			break;
-		case OPT_ONESECTOR:
-			boxes = ONESECTOR;
-			break;
-
-			/* more flags */
-		case OPT_NO_REREAD:
-			no_reread = 1;
-			break;
-		case OPT_LEAVE_LAST:
-			leave_last = 1;
-			break;
-		}
-	}
-
-	if (optind == argc &&
-	    (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify)) {
-		FILE *procf;
-
-		/* try all known devices */
-		total_size = 0;
-
-		procf = fopen(_PATH_PROC_PARTITIONS, "r");
-		if (!procf)
-			fprintf(stderr, _("cannot open %s\n"), _PATH_PROC_PARTITIONS);
-		else {
-			while ((dev = nextproc(procf)) != NULL) {
-				if (!is_ide_cdrom_or_tape(dev)) {
-					if (opt_out_geom)
-						do_geom(dev, 1);
-					if (opt_out_pt_geom)
-						do_pt_geom(dev, 1);
-					if (opt_size)
-						do_size(dev, 1);
-					if (opt_list || verify)
-						ret = do_list(dev, 1);
-				}
-				free(dev);
-			}
-			fclose(procf);
-		}
-
-		if (opt_size)
-			printf(_("total: %llu blocks\n"), total_size);
-
-		goto done;
-	}
-
-	if (optind == argc) {
-		if (activate)
-			activate_usage();
-		else
-			usage(stderr);
-	}
-
-	if (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify) {
-		while (optind < argc) {
-			if (opt_out_geom)
-				do_geom(argv[optind], 0);
-			if (opt_out_pt_geom)
-				do_pt_geom(argv[optind], 0);
-			if (opt_size)
-				do_size(argv[optind], 0);
-			if (opt_list || verify)
-				ret = do_list(argv[optind], 0);
-			optind++;
-		}
-		goto done;
-	}
-
-	if (activate) {
-		return do_activate(argv + optind, argc - optind, activatearg);
-	}
-	if (unhide) {
-		return do_unhide(argv + optind, argc - optind, unhidearg);
-	}
-	if (do_id) {
-		if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
-			errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
-		else if ((do_id & CHANGE_ID) != 0 && optind != argc - 3)
-			errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
-		else if (optind != argc - 3 && optind != argc - 2)
-			errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
-		return do_change_id(argv[optind], argv[optind + 1],
-				    (optind == argc - 2) ? 0 : argv[optind + 2]);
-	}
-
-	if (optind != argc - 1)
-		errx(EXIT_FAILURE, _("can specify only one device (except with -l or -s)"));
-	dev = argv[optind];
-
-	if (opt_reread)
-		do_reread(dev);
-	else if (restore_sector_file)
-		restore_sectors(dev);
-	else
-		ret = do_fdisk(dev);
-done:
-	return ret;
-}
-
 /*
  *  H. Listing the current situation
  */
@@ -3133,3 +2890,236 @@ static int do_fdisk(char *dev)
 	sync();			/* superstition */
 	return ret;
 }
+
+int main(int argc, char **argv)
+{
+	int c, ret = 0;
+	char *dev;
+	int opt_size = 0;
+	int opt_out_geom = 0;
+	int opt_out_pt_geom = 0;
+	int opt_reread = 0;
+	int activate = 0;
+	int do_id = 0;
+	int unhide = 0;
+	char *activatearg = 0;
+	char *unhidearg = 0;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	if (!strcmp(program_invocation_short_name, "activate"))
+		activate = 1;		/* equivalent to `sfdisk -A' */
+
+	while ((c = getopt_long(argc, argv, "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V",
+				long_opts, NULL)) != -1) {
+		switch (c) {
+		case 'f':
+			force = 1;
+			break;		/* does not imply quiet */
+		case 'g':
+			opt_out_geom = 1;
+			break;
+		case 'G':
+			opt_out_pt_geom = 1;
+			break;
+		case 'i':
+			increment = 1;
+			break;
+		case 'c':
+		case 'c' + PRINT_ID:
+		case 'c' + CHANGE_ID:
+			do_id = c;
+			break;
+		case 'd':
+			dump = 1;		/* fall through */
+		case 'l':
+			opt_list = 1;
+			break;
+		case 'n':
+			no_write = 1;
+			break;
+		case 'q':
+			quiet = 1;
+			break;
+		case 's':
+			opt_size = 1;
+			break;
+		case 'u':
+			set_format(*optarg);
+			break;
+		case 'v':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		case 'x':
+			show_extended = 1;
+			break;
+		case 'A':
+			activatearg = optarg;
+			activate = 1;
+			break;
+		case 'C':
+			U.cylinders = strtoul_or_err(optarg, _("invalid cylinders argument"));
+			break;
+		case 'D':
+			DOS = 1;
+			break;
+		case 'E':
+			DOS_extended = 1;
+			break;
+		case 'H':
+			U.heads = strtoul_or_err(optarg, _("invalid heads argument"));
+			break;
+		case 'L':
+			Linux = 1;
+			break;
+		case 'N':
+			one_only = strtol_or_err(optarg, _("invalid number of partitions argument"));
+			break;
+		case 'I':
+			restore_sector_file = optarg;
+			break;
+		case 'O':
+			save_sector_file = optarg;
+			break;
+		case 'R':
+			opt_reread = 1;
+			break;
+		case 'S':
+			U.sectors = strtoul_or_err(optarg, _("invalid sectors argument"));
+			break;
+		case 'T':
+			list_types();
+			return EXIT_SUCCESS;
+		case 'U':
+			unhidearg = optarg;
+			unhide = 1;
+			break;
+		case 'V':
+			verify = 1;
+			break;
+		default:
+			usage(stderr);
+
+			/* dangerous flags */
+		case OPT_IN_ORDER:
+			partitions_in_order = 1;
+			break;
+		case OPT_NOT_IN_ORDER:
+			partitions_in_order = 0;
+			break;
+		case OPT_INSIDE_OUTER:
+			all_logicals_inside_outermost_extended = 1;
+			break;
+		case OPT_NOT_INSIDE_OUTER:
+			all_logicals_inside_outermost_extended = 0;
+			break;
+		case OPT_NESTED:
+			boxes = NESTED;
+			break;
+		case OPT_CHAINED:
+			boxes = CHAINED;
+			break;
+		case OPT_ONESECTOR:
+			boxes = ONESECTOR;
+			break;
+
+			/* more flags */
+		case OPT_NO_REREAD:
+			no_reread = 1;
+			break;
+		case OPT_LEAVE_LAST:
+			leave_last = 1;
+			break;
+		}
+	}
+
+	if (optind == argc &&
+	    (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify)) {
+		FILE *procf;
+
+		/* try all known devices */
+		total_size = 0;
+
+		procf = fopen(_PATH_PROC_PARTITIONS, "r");
+		if (!procf)
+			fprintf(stderr, _("cannot open %s\n"), _PATH_PROC_PARTITIONS);
+		else {
+			while ((dev = nextproc(procf)) != NULL) {
+				if (!is_ide_cdrom_or_tape(dev)) {
+					if (opt_out_geom)
+						do_geom(dev, 1);
+					if (opt_out_pt_geom)
+						do_pt_geom(dev, 1);
+					if (opt_size)
+						do_size(dev, 1);
+					if (opt_list || verify)
+						ret = do_list(dev, 1);
+				}
+				free(dev);
+			}
+			fclose(procf);
+		}
+
+		if (opt_size)
+			printf(_("total: %llu blocks\n"), total_size);
+
+		goto done;
+	}
+
+	if (optind == argc) {
+		if (activate)
+			activate_usage();
+		else
+			usage(stderr);
+	}
+
+	if (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify) {
+		while (optind < argc) {
+			if (opt_out_geom)
+				do_geom(argv[optind], 0);
+			if (opt_out_pt_geom)
+				do_pt_geom(argv[optind], 0);
+			if (opt_size)
+				do_size(argv[optind], 0);
+			if (opt_list || verify)
+				ret = do_list(argv[optind], 0);
+			optind++;
+		}
+		goto done;
+	}
+
+	if (activate) {
+		return do_activate(argv + optind, argc - optind, activatearg);
+	}
+	if (unhide) {
+		return do_unhide(argv + optind, argc - optind, unhidearg);
+	}
+	if (do_id) {
+		if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
+			errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
+		else if ((do_id & CHANGE_ID) != 0 && optind != argc - 3)
+			errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
+		else if (optind != argc - 3 && optind != argc - 2)
+			errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
+		return do_change_id(argv[optind], argv[optind + 1],
+				    (optind == argc - 2) ? 0 : argv[optind + 2]);
+	}
+
+	if (optind != argc - 1)
+		errx(EXIT_FAILURE, _("can specify only one device (except with -l or -s)"));
+	dev = argv[optind];
+
+	if (opt_reread)
+		do_reread(dev);
+	else if (restore_sector_file)
+		restore_sectors(dev);
+	else
+		ret = do_fdisk(dev);
+done:
+	return ret;
+}
-- 
1.8.1.4
