Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37102 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757293AbdIILBx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 9 Sep 2017 07:01:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so3292690wmh.4
        for <util-linux@vger.kernel.org>; Sat, 09 Sep 2017 04:01:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] rfkill: allow use of multiple arguments
Date: Sat,  9 Sep 2017 12:01:49 +0100
Message-Id: <20170909110149.23578-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no reason why multiple arguments could not be supported.

Most common use case is to do multiple control commands in one go without us
of 'all' argument that can cause unnecessary connection breakage.  For
example someone might want to add to a system initialization following
commands.

    rfkill block bluetooth uwb wimax wwan gps fm nfc

That will ensure everything but wifi is turned off with as few commands as
possible, without killing wifi at any point.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.8 | 18 ++++++++------
 sys-utils/rfkill.c | 73 +++++++++++++++++++++++++++++++++---------------------
 2 files changed, 56 insertions(+), 35 deletions(-)

diff --git a/sys-utils/rfkill.8 b/sys-utils/rfkill.8
index f6ecc1e48..ce0aadc31 100644
--- a/sys-utils/rfkill.8
+++ b/sys-utils/rfkill.8
@@ -4,7 +4,7 @@
 rfkill \- tool for enabling and disabling wireless devices
 .SH SYNOPSIS
 .B rfkill
-.RI [ options ] " command" " [" id | type ]
+.RI [ options ] " command" " [" id | type \ ...]
 .SH OPTIONS
 .TP
 \fB\-J\fR, \fB\-\-json\fR
@@ -33,23 +33,25 @@ Display help text and exit.
 .B event
 Listen for rfkill events and display them on stdout.
 .TP
-\fBlist \fR[\fIid\fR|\fItype\fR]
+\fBlist \fR[\fIid\fR|\fItype\fR ...]
 List the current state of all available devices.  The full list has TYPE and
 ID columns that one can use to limit the scope.  It is a good idea to check
 with
 .B list
 command
-.BR id " or " type
+.IR id " or " type
 scope is appropriate before setting
 .BR block " or " unblock .
 Special
-.B all
-type string will match everything.
+.I all
+type string will match everything.  Use of multiple
+.IR id " or " type
+arguments is supported.
 .TP
-\fBblock \fBid\fR|\fBtype\fR
+\fBblock \fBid\fR|\fBtype\fR [...]
 Disable the corresponding device.
 .TP
-\fBunblock \fBid\fR|\fBtype\fR
+\fBunblock \fBid\fR|\fBtype\fR [...]
 Enable the corresponding device.  If the device is hard\-blocked, for example
 via a hardware switch, it will remain unavailable though it is now
 soft\-unblocked.
@@ -59,6 +61,8 @@ rfkill list
 rfkill block all
 .br
 rfkill unblock wlan
+.br
+rfkill block bluetooth uwb wimax wwan gps fm nfc
 .SH AUTHORS
 .B rfkill
 was originally written by
diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 380d29e56..6b586d2ed 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -109,6 +109,7 @@ static int columns[ARRAY_SIZE(infos) * 2];
 static size_t ncolumns;
 
 struct control {
+	struct libscols_table *tb;
 	unsigned int
 		json:1,
 		no_headings:1,
@@ -308,32 +309,35 @@ static void fill_table_row(struct libscols_table *tb, struct rfkill_event *event
 	}
 }
 
-static int rfkill_list(struct control const *const ctrl, const char *param)
+static void rfkill_list_init(struct control *ctrl)
 {
-	struct rfkill_id id = { .result = RFKILL_IS_ALL };
-	struct rfkill_event event;
-	ssize_t len;
-	int fd;
-	struct libscols_table *tb;
-
 	scols_init_debug(0);
-	tb = scols_new_table();
-	if (!tb)
+	ctrl->tb = scols_new_table();
+	if (!ctrl->tb)
 		err(EXIT_FAILURE, _("failed to allocate output table"));
 
-	scols_table_enable_json(tb, ctrl->json);
-	scols_table_enable_noheadings(tb, ctrl->no_headings);
-	scols_table_enable_raw(tb, ctrl->raw);
+	scols_table_enable_json(ctrl->tb, ctrl->json);
+	scols_table_enable_noheadings(ctrl->tb, ctrl->no_headings);
+	scols_table_enable_raw(ctrl->tb, ctrl->raw);
 	{
 		size_t i;
 
 		for (i = 0; i < (size_t)ncolumns; i++) {
 			const struct colinfo *col = get_column_info(i);
 
-			if (!scols_table_new_column(tb, col->name, col->whint, col->flags))
+			if (!scols_table_new_column(ctrl->tb, col->name, col->whint, col->flags))
 				err(EXIT_FAILURE, _("failed to initialize output column"));
 		}
 	}
+}
+
+
+static int rfkill_list_fill(struct control const *ctrl, const char *param)
+{
+	struct rfkill_id id = { .result = RFKILL_IS_ALL };
+	struct rfkill_event event;
+	ssize_t len;
+	int fd;
 
 	if (param) {
 		id = rfkill_id_to_type(param);
@@ -386,14 +390,18 @@ static int rfkill_list(struct control const *const ctrl, const char *param)
 		default:
 			abort();
 		}
-		fill_table_row(tb, &event);
+		fill_table_row(ctrl->tb, &event);
 	}
 	close(fd);
-	scols_print_table(tb);
-	scols_unref_table(tb);
 	return 0;
 }
 
+static void rfkill_list_output(struct control const *ctrl)
+{
+	scols_print_table(ctrl->tb);
+	scols_unref_table(ctrl->tb);
+}
+
 static int rfkill_block(uint8_t block, const char *param)
 {
 	struct rfkill_id id;
@@ -452,7 +460,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	size_t i;
 
 	fputs(USAGE_HEADER, stdout);
-	fprintf(stdout, _(" %s [options] command [identifier]\n"), program_invocation_short_name);
+	fprintf(stdout, _(" %s [options] command [identifier ...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, stdout);
 	fputs(_("Tool for enabling and disabling wireless devices.\n"), stdout);
@@ -507,7 +515,7 @@ int main(int argc, char **argv)
 		{0}
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
-	int ret;
+	int ret = 0;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -553,23 +561,32 @@ int main(int argc, char **argv)
 					     ARRAY_SIZE(columns), &ncolumns,
 					     column_name_to_id) < 0)
 			return EXIT_FAILURE;
-		if (argc) {
-			argc--;
-			argv++;
+		rfkill_list_init(&ctrl);
+		if (argc < 2) {
+			if (*argv && strcmp(*argv, "list") == 0)
+				argv++;
+			ret |= rfkill_list_fill(&ctrl, *argv);
+		} else {
+			while (--argc) {
+				argv++;
+				ret |= rfkill_list_fill(&ctrl, *argv);
+			}
 		}
-		ret = rfkill_list(&ctrl, *argv);
+		rfkill_list_output(&ctrl);
 	} else if (strcmp(*argv, "event") == 0) {
 		ret = rfkill_event();
 	} else if (strcmp(*argv, "help") == 0) {
 		usage();
 	} else if (strcmp(*argv, "block") == 0 && argc > 1) {
-		argc--;
-		argv++;
-		ret = rfkill_block(1, *argv);
+		while (--argc) {
+			argv++;
+			ret |= rfkill_block(1, *argv);
+		}
 	} else if (strcmp(*argv, "unblock") == 0 && argc > 1) {
-		argc--;
-		argv++;
-		ret = rfkill_block(0, *argv);
+		while (--argc) {
+			argv++;
+			ret |= rfkill_block(0, *argv);
+		}
 	} else
 		errtryhelp(EXIT_FAILURE);
 
-- 
2.14.1

