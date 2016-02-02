Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33182 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcBBNkR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Feb 2016 08:40:17 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so2485472wmr.0
        for <util-linux@vger.kernel.org>; Tue, 02 Feb 2016 05:40:16 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] swapon: add control struct
Date: Tue,  2 Feb 2016 13:40:08 +0000
Message-Id: <1454420410-654-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
References: <1454420410-654-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 253 +++++++++++++++++++++++++++--------------------------
 1 file changed, 129 insertions(+), 124 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index c4d1544..b677f50 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -65,7 +65,6 @@
 # define swapon(path, flags) syscall(SYS_swapon, path, flags)
 #endif
 
-#define QUIET	1
 #define CANONIC	1
 
 #define MAX_PAGESIZE	(64 * 1024)
@@ -75,15 +74,6 @@ enum {
 	SIG_SWSUSPEND
 };
 
-static int all;
-static int priority = -1;	/* non-prioritized swap by default */
-static int discard;		/* don't send swap discards by default */
-
-/* If true, don't complain if the device/file doesn't exist */
-static int ifexists;
-static int fixpgsz;
-static int verbose;
-
 /* column names */
 struct colinfo {
         const char *name; /* header */
@@ -92,10 +82,6 @@ struct colinfo {
         const char *help;
 };
 
-/* basic output flags */
-static int no_headings;
-static int raw;
-
 enum {
 	COL_PATH,
 	COL_TYPE,
@@ -115,8 +101,25 @@ struct colinfo infos[] = {
 	[COL_LABEL]    = { "LABEL",	0.20, 0, N_("swap label")},
 };
 
-static int columns[ARRAY_SIZE(infos) * 2];
-static int ncolumns;
+/* control struct */
+struct swapon_ctl {
+	char *options;			/* fstab-compatible option string */
+	const char *label;		/* swap label */
+	const char *uuid;		/* unique identifier */
+	int discard;			/* discard policy */
+	int columns[ARRAY_SIZE(infos) * 2];	/* --show columns */
+	int ncolumns;			/* number of columns */
+	int priority;			/* non-prioritized swap by default */
+	unsigned int
+		all:1,			/* turn on all swap devices */
+		bytes:1,		/* display --show in bytes */
+		fix_page_size:1,	/* reinitialize page size */
+		no_fail:1,		/* skip devices that do not exist */
+		no_heading:1,		/* toggle --show headers */
+		raw:1,			/* toggle --show alignment */
+		show:1,			/* display --show information */
+		verbose:1;		/* be chatty */
+};
 
 static int column_name_to_id(const char *name, size_t namesz)
 {
@@ -134,20 +137,20 @@ static int column_name_to_id(const char *name, size_t namesz)
 	return -1;
 }
 
-static inline int get_column_id(int num)
+static inline int get_column_id(const struct swapon_ctl *ctl, int num)
 {
-	assert(num < ncolumns);
-	assert(columns[num] < (int) ARRAY_SIZE(infos));
+	assert(num < ctl->ncolumns);
+	assert(ctl->columns[num] < (int) ARRAY_SIZE(infos));
 
-	return columns[num];
+	return ctl->columns[num];
 }
 
-static inline struct colinfo *get_column_info(unsigned num)
+static inline struct colinfo *get_column_info(const struct swapon_ctl *ctl, unsigned num)
 {
-	return &infos[get_column_id(num)];
+	return &infos[get_column_id(ctl, num)];
 }
 
-static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, int bytes)
+static void add_scols_line(const struct swapon_ctl *ctl, struct libscols_table *table, struct libmnt_fs *fs)
 {
 	int i;
 	struct libscols_line *line;
@@ -163,11 +166,11 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 	data = mnt_fs_get_source(fs);
 	if (access(data, R_OK) == 0)
 		pr = get_swap_prober(data);
-	for (i = 0; i < ncolumns; i++) {
+	for (i = 0; i < ctl->ncolumns; i++) {
 		char *str = NULL;
 		off_t size;
 
-		switch (get_column_id(i)) {
+		switch (get_column_id(ctl, i)) {
 		case COL_PATH:
 			xasprintf(&str, "%s", mnt_fs_get_source(fs));
 			break;
@@ -177,7 +180,7 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 		case COL_SIZE:
 			size = mnt_fs_get_size(fs);
 			size *= 1024;	/* convert to bytes */
-			if (bytes)
+			if (ctl->bytes)
 				xasprintf(&str, "%jd", size);
 			else
 				str = size_to_human_string(SIZE_SUFFIX_1LETTER, size);
@@ -185,7 +188,7 @@ static void add_scols_line(struct libscols_table *table, struct libmnt_fs *fs, i
 		case COL_USED:
 			size = mnt_fs_get_usedsize(fs);
 			size *= 1024;	/* convert to bytes */
-			if (bytes)
+			if (ctl->bytes)
 				xasprintf(&str, "%jd", size);
 			else
 				str = size_to_human_string(SIZE_SUFFIX_1LETTER, size);
@@ -244,7 +247,7 @@ static int display_summary(void)
 	return 0;
 }
 
-static int show_table(int bytes)
+static int show_table(struct swapon_ctl *ctl)
 {
 	struct libmnt_table *st = get_swaps();
 	struct libmnt_iter *itr = NULL;
@@ -265,18 +268,18 @@ static int show_table(int bytes)
 	if (!table)
 		err(EXIT_FAILURE, _("failed to initialize output table"));
 
-	scols_table_enable_raw(table, raw);
-	scols_table_enable_noheadings(table, no_headings);
+	scols_table_enable_raw(table, ctl->raw);
+	scols_table_enable_noheadings(table, ctl->no_heading);
 
-	for (i = 0; i < ncolumns; i++) {
-		struct colinfo *col = get_column_info(i);
+	for (i = 0; i < ctl->ncolumns; i++) {
+		struct colinfo *col = get_column_info(ctl, i);
 
 		if (!scols_table_new_column(table, col->name, col->whint, col->flags))
 			err(EXIT_FAILURE, _("failed to initialize output column"));
 	}
 
 	while (mnt_table_next_fs(st, itr, &fs) == 0)
-		add_scols_line(table, fs, bytes);
+		add_scols_line(ctl, table, fs);
 
 	scols_print_table(table);
 	scols_unref_table(table);
@@ -418,7 +421,8 @@ err:
 }
 
 /* returns real size of swap space */
-static unsigned long long swap_get_size(const char *hdr, const char *devname,
+static unsigned long long swap_get_size(const struct swapon_ctl *ctl,
+					const char *hdr, const char *devname,
 					unsigned int pagesize)
 {
 	unsigned int last_page = 0;
@@ -433,7 +437,7 @@ static unsigned long long swap_get_size(const char *hdr, const char *devname,
 		flip = 1;
 		last_page = swab32(s->last_page);
 	}
-	if (verbose)
+	if (ctl->verbose)
 		warnx(_("%s: found swap signature: version %ud, "
 			"page-size %d, %s byte order"),
 			devname,
@@ -444,14 +448,14 @@ static unsigned long long swap_get_size(const char *hdr, const char *devname,
 	return ((unsigned long long) last_page + 1) * pagesize;
 }
 
-static void swap_get_info(const char *hdr, char **label, char **uuid)
+static void swap_get_info(struct swapon_ctl *ctl, const char *hdr)
 {
 	struct swap_header_v1_2 *s = (struct swap_header_v1_2 *) hdr;
 
-	if (s && *s->volume_name && label)
-		*label = xstrdup(s->volume_name);
+	if (s && *s->volume_name && ctl->label)
+		ctl->label = xstrdup(s->volume_name);
 
-	if (s && *s->uuid && uuid) {
+	if (s && *s->uuid && ctl->uuid) {
 		const unsigned char *u = s->uuid;
 		char str[37];
 
@@ -462,11 +466,11 @@ static void swap_get_info(const char *hdr, char **label, char **uuid)
 			u[0], u[1], u[2], u[3],
 			u[4], u[5], u[6], u[7],
 			u[8], u[9], u[10], u[11], u[12], u[13], u[14], u[15]);
-		*uuid = xstrdup(str);
+		ctl->uuid = xstrdup(str);
 	}
 }
 
-static int swapon_checks(const char *special)
+static int swapon_checks(struct swapon_ctl *ctl, const char *special)
 {
 	struct stat st;
 	int fd = -1, sig;
@@ -519,24 +523,24 @@ static int swapon_checks(const char *special)
 
 	if (sig == SIG_SWAPSPACE && pagesize) {
 		unsigned long long swapsize =
-				swap_get_size(hdr, special, pagesize);
+				swap_get_size(ctl, hdr, special, pagesize);
 		int syspg = getpagesize();
 
-		if (verbose)
+		if (ctl->verbose)
 			warnx(_("%s: pagesize=%d, swapsize=%llu, devsize=%llu"),
 				special, pagesize, swapsize, devsize);
 
 		if (swapsize > devsize) {
-			if (verbose)
+			if (ctl->verbose)
 				warnx(_("%s: last_page 0x%08llx is larger"
 					" than actual size of swapspace"),
 					special, swapsize);
 		} else if (syspg < 0 || (unsigned) syspg != pagesize) {
-			if (fixpgsz) {
+			if (ctl->fix_page_size) {
 				char *label = NULL, *uuid = NULL;
 				int rc;
 
-				swap_get_info(hdr, &label, &uuid);
+				swap_get_info(ctl, hdr);
 
 				warnx(_("%s: swap format pagesize does not match."),
 					special);
@@ -572,14 +576,14 @@ err:
 	return -1;
 }
 
-static int do_swapon(const char *orig_special, int prio,
-		     int fl_discard, int canonic)
+static int do_swapon(struct swapon_ctl *ctl, const char *orig_special,
+		     int canonic)
 {
 	int status;
 	const char *special = orig_special;
 	int flags = 0;
 
-	if (verbose)
+	if (ctl->verbose)
 		printf(_("swapon %s\n"), orig_special);
 
 	if (!canonic) {
@@ -588,15 +592,15 @@ static int do_swapon(const char *orig_special, int prio,
 			return cannot_find(orig_special);
 	}
 
-	if (swapon_checks(special))
+	if (swapon_checks(ctl, special))
 		return -1;
 
 #ifdef SWAP_FLAG_PREFER
-	if (prio >= 0) {
-		if (prio > SWAP_FLAG_PRIO_MASK)
-			prio = SWAP_FLAG_PRIO_MASK;
+	if (ctl->priority >= 0) {
+		if (ctl->priority > SWAP_FLAG_PRIO_MASK)
+			ctl->priority = SWAP_FLAG_PRIO_MASK;
 		flags = SWAP_FLAG_PREFER
-			| ((prio & SWAP_FLAG_PRIO_MASK)
+			| ((ctl->priority & SWAP_FLAG_PRIO_MASK)
 			   << SWAP_FLAG_PRIO_SHIFT);
 	}
 #endif
@@ -604,17 +608,17 @@ static int do_swapon(const char *orig_special, int prio,
 	 * Validate the discard flags passed and set them
 	 * accordingly before calling sys_swapon.
 	 */
-	if (fl_discard && !(fl_discard & ~SWAP_FLAGS_DISCARD_VALID)) {
+	if (ctl->discard && !(ctl->discard & ~SWAP_FLAGS_DISCARD_VALID)) {
 		/*
 		 * If we get here with both discard policy flags set,
 		 * we just need to tell the kernel to enable discards
 		 * and it will do correctly, just as we expect.
 		 */
-		if ((fl_discard & SWAP_FLAG_DISCARD_ONCE) &&
-		    (fl_discard & SWAP_FLAG_DISCARD_PAGES))
+		if ((ctl->discard & SWAP_FLAG_DISCARD_ONCE) &&
+		    (ctl->discard & SWAP_FLAG_DISCARD_PAGES))
 			flags |= SWAP_FLAG_DISCARD;
 		else
-			flags |= fl_discard;
+			flags |= ctl->discard;
 	}
 
 	status = swapon(special, flags);
@@ -624,57 +628,56 @@ static int do_swapon(const char *orig_special, int prio,
 	return status;
 }
 
-static int swapon_by_label(const char *label, int prio, int dsc)
+static int swapon_by_label(struct swapon_ctl *ctl)
 {
-	const char *special = mnt_resolve_tag("LABEL", label, mntcache);
-	return special ? do_swapon(special, prio, dsc, CANONIC) :
-			 cannot_find(label);
+	const char *special = mnt_resolve_tag("LABEL", ctl->label, mntcache);
+	return special ? do_swapon(ctl, special, CANONIC) :
+			 cannot_find(ctl->label);
 }
 
-static int swapon_by_uuid(const char *uuid, int prio, int dsc)
+static int swapon_by_uuid(struct swapon_ctl *ctl)
 {
-	const char *special = mnt_resolve_tag("UUID", uuid, mntcache);
-	return special ? do_swapon(special, prio, dsc, CANONIC) :
-			 cannot_find(uuid);
+	const char *special = mnt_resolve_tag("UUID", ctl->uuid, mntcache);
+	return special ? do_swapon(ctl, special, CANONIC) :
+			 cannot_find(ctl->uuid);
 }
 
 /* -o <options> or fstab */
-static int parse_options(const char *optstr,
-			 int *prio, int *disc, int *nofail)
+static int parse_options(struct swapon_ctl *ctl)
 {
 	char *arg = NULL;
 
-	assert(optstr);
-	assert(prio);
-	assert(disc);
-	assert(nofail);
+	assert(ctl->options);
+	assert(ctl->priority);
+	assert(ctl->discard);
+	assert(ctl->no_fail);
 
-	if (mnt_optstr_get_option(optstr, "nofail", NULL, 0) == 0)
-		*nofail = 1;
+	if (mnt_optstr_get_option(ctl->options, "nofail", NULL, 0) == 0)
+		ctl->no_fail = 1;
 
-	if (mnt_optstr_get_option(optstr, "discard", &arg, NULL) == 0) {
-		*disc |= SWAP_FLAG_DISCARD;
+	if (mnt_optstr_get_option(ctl->options, "discard", &arg, NULL) == 0) {
+		ctl->discard |= SWAP_FLAG_DISCARD;
 
 		if (arg) {
 			/* only single-time discards are wanted */
 			if (strcmp(arg, "once") == 0)
-				*disc |= SWAP_FLAG_DISCARD_ONCE;
+				ctl->discard |= SWAP_FLAG_DISCARD_ONCE;
 
 			/* do discard for every released swap page */
 			if (strcmp(arg, "pages") == 0)
-				*disc |= SWAP_FLAG_DISCARD_PAGES;
+				ctl->discard |= SWAP_FLAG_DISCARD_PAGES;
 			}
 	}
 
 	arg = NULL;
-	if (mnt_optstr_get_option(optstr, "pri", &arg, NULL) == 0 && arg)
-		*prio = atoi(arg);
+	if (mnt_optstr_get_option(ctl->options, "pri", &arg, NULL) == 0 && arg)
+		ctl->priority = atoi(arg);
 
 	return 0;
 }
 
 
-static int swapon_all(void)
+static int swapon_all(struct swapon_ctl *ctl)
 {
 	struct libmnt_table *tb = get_fstab();
 	struct libmnt_iter *itr;
@@ -690,7 +693,6 @@ static int swapon_all(void)
 
 	while (mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
 		/* defaults */
-		int pri = priority, dsc = discard, nofail = ifexists;
 		const char *opts, *src;
 
 		if (mnt_fs_get_option(fs, "noauto", NULL, NULL) == 0)
@@ -698,18 +700,18 @@ static int swapon_all(void)
 
 		opts = mnt_fs_get_options(fs);
 		if (opts)
-			parse_options(opts, &pri, &dsc, &nofail);
+			parse_options(ctl);
 
 		src = mnt_resolve_spec(mnt_fs_get_source(fs), mntcache);
 		if (!src) {
-			if (!nofail)
+			if (!ctl->no_fail)
 				status |= cannot_find(mnt_fs_get_source(fs));
 			continue;
 		}
 
 		if (!is_active_swap(src) &&
-		    (!nofail || !access(src, R_OK)))
-			status |= do_swapon(src, pri, dsc, CANONIC);
+		    (!ctl->no_fail || !access(src, R_OK)))
+			status |= do_swapon(ctl, src, CANONIC);
 	}
 
 	mnt_free_iter(itr);
@@ -769,10 +771,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 
 int main(int argc, char *argv[])
 {
-	char *options = NULL;
 	int status = 0, c;
-	int show = 0;
-	int bytes = 0;
 	size_t i;
 
 	enum {
@@ -809,6 +808,8 @@ int main(int argc, char *argv[])
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
+	struct swapon_ctl ctl = { .priority = -1, 0 };
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -824,16 +825,16 @@ int main(int argc, char *argv[])
 
 		switch (c) {
 		case 'a':		/* all */
-			++all;
+			ctl.all = 1;
 			break;
 		case 'h':		/* help */
 			usage(stdout);
 			break;
 		case 'o':
-			options = optarg;
+			ctl.options = optarg;
 			break;
 		case 'p':		/* priority */
-			priority = strtos16_or_err(optarg,
+			ctl.priority = strtos16_or_err(optarg,
 					   _("failed to parse priority"));
 			break;
 		case 'L':
@@ -843,50 +844,50 @@ int main(int argc, char *argv[])
 			add_uuid(optarg);
 			break;
 		case 'd':
-			discard |= SWAP_FLAG_DISCARD;
+			ctl.discard |= SWAP_FLAG_DISCARD;
 			if (optarg) {
 				if (*optarg == '=')
 					optarg++;
 
 				if (strcmp(optarg, "once") == 0)
-					discard |= SWAP_FLAG_DISCARD_ONCE;
+					ctl.discard |= SWAP_FLAG_DISCARD_ONCE;
 				else if (strcmp(optarg, "pages") == 0)
-					discard |= SWAP_FLAG_DISCARD_PAGES;
+					ctl.discard |= SWAP_FLAG_DISCARD_PAGES;
 				else
 					errx(EXIT_FAILURE, _("unsupported discard policy: %s"), optarg);
 			}
 			break;
 		case 'e':               /* ifexists */
-		        ifexists = 1;
+			ctl.no_fail = 1;
 			break;
 		case 'f':
-			fixpgsz = 1;
+			ctl.fix_page_size = 1;
 			break;
 		case 's':		/* status report */
 			status = display_summary();
 			return status;
 		case 'v':		/* be chatty */
-			++verbose;
+			ctl.verbose = 1;
 			break;
 		case SHOW_OPTION:
 			if (optarg) {
-				ncolumns = string_to_idarray(optarg,
-							     columns,
-							     ARRAY_SIZE(columns),
+				ctl.ncolumns = string_to_idarray(optarg,
+							     ctl.columns,
+							     ARRAY_SIZE(ctl.columns),
 							     column_name_to_id);
-				if (ncolumns < 0)
+				if (ctl.ncolumns < 0)
 					return EXIT_FAILURE;
 			}
-			show = 1;
+			ctl.show = 1;
 			break;
 		case NOHEADINGS_OPTION:
-			no_headings = 1;
+			ctl.no_heading = 1;
 			break;
 		case RAW_OPTION:
-			raw = 1;
+			ctl.raw = 1;
 			break;
 		case BYTES_OPTION:
-			bytes = 1;
+			ctl.bytes = 1;
 			break;
 		case 'V':		/* version */
 			printf(UTIL_LINUX_VERSION);
@@ -900,36 +901,40 @@ int main(int argc, char *argv[])
 	}
 	argv += optind;
 
-	if (show || (!all && !numof_labels() && !numof_uuids() && *argv == NULL)) {
-		if (!ncolumns) {
+	if (ctl.show || (!ctl.all && !numof_labels() && !numof_uuids() && *argv == NULL)) {
+		if (!ctl.ncolumns) {
 			/* default columns */
-			columns[ncolumns++] = COL_PATH;
-			columns[ncolumns++] = COL_TYPE;
-			columns[ncolumns++] = COL_SIZE;
-			columns[ncolumns++] = COL_USED;
-			columns[ncolumns++] = COL_PRIO;
+			ctl.columns[ctl.ncolumns++] = COL_PATH;
+			ctl.columns[ctl.ncolumns++] = COL_TYPE;
+			ctl.columns[ctl.ncolumns++] = COL_SIZE;
+			ctl.columns[ctl.ncolumns++] = COL_USED;
+			ctl.columns[ctl.ncolumns++] = COL_PRIO;
 		}
-		status = show_table(bytes);
+		status = show_table(&ctl);
 		return status;
 	}
 
-	if (ifexists && !all)
+	if (ctl.no_fail && !ctl.all)
 		usage(stderr);
 
-	if (all)
-		status |= swapon_all();
+	if (ctl.all)
+		status |= swapon_all(&ctl);
 
-	if (options)
-		parse_options(options, &priority, &discard, &ifexists);
+	if (ctl.options)
+		parse_options(&ctl);
 
-	for (i = 0; i < numof_labels(); i++)
-		status |= swapon_by_label(get_label(i), priority, discard);
+	for (i = 0; i < numof_labels(); i++) {
+		ctl.label = get_label(i);
+		status |= swapon_by_label(&ctl);
+	}
 
-	for (i = 0; i < numof_uuids(); i++)
-		status |= swapon_by_uuid(get_uuid(i), priority, discard);
+	for (i = 0; i < numof_uuids(); i++) {
+		ctl.uuid = get_uuid(i);
+		status |= swapon_by_uuid(&ctl);
+	}
 
 	while (*argv != NULL)
-		status |= do_swapon(*argv++, priority, discard, !CANONIC);
+		status |= do_swapon(&ctl, *argv++, !CANONIC);
 
 	free_tables();
 	mnt_unref_cache(mntcache);
-- 
2.7.0

