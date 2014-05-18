Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38177 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:11 -0400
Received: by mail-wi0-f173.google.com with SMTP id bs8so2951988wib.0
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/17] setterm: clean up screendump()
Date: Sun, 18 May 2014 15:05:32 +0100
Message-Id: <1400421941-14244-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 92 +++++++++++++++++++++++++++-------------------------
 1 file changed, 47 insertions(+), 45 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 05ea387..d889db4 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -144,7 +144,7 @@ enum {
 #define	TABS_MAX	160
 #define BLENGTH_MAX	2000
 
-/* Option controls. */
+/* Command controls. */
 struct setterm_control {
 	char *opt_te_terminal_name;	/* terminal name */
 	int opt_bl_min;		/* blank screen */
@@ -152,6 +152,7 @@ struct setterm_control {
 	int opt_bfreq_f;	/* bell frequency in Hz */
 	int opt_sn_num;		/* console number to be snapshoted */
 	char *opt_sn_name;	/* path to write snap */
+	char *in_device;	/* device to snapshot */
 	int opt_msglevel_num;	/* printk() loging level */
 	int opt_ps_mode;	/* powersave mode */
 	int opt_pd_min;		/* powerdown time */
@@ -721,15 +722,18 @@ static void show_tabs(void)
 	}
 }
 
-static void screendump(struct setterm_control *ctl, FILE *F)
+static void __attribute__((__noreturn__)) read_error(struct setterm_control *ctl)
+{
+	if (ctl->opt_sn_num != 0)
+		errx(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
+	else
+		errx(EXIT_DUMPFILE, _("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
+}
+
+static int open_snapshot_device(struct setterm_control *ctl)
 {
 	char infile[MAXPATHLEN];
-	unsigned char header[4];
-	unsigned int rows, cols;
 	int fd;
-	size_t i, j;
-	ssize_t rc;
-	char *inbuf = NULL, *outbuf = NULL, *p, *q;
 
 	sprintf(infile, "/dev/vcsa%d", ctl->opt_sn_num);
 	fd = open(infile, O_RDONLY);
@@ -744,25 +748,47 @@ static void screendump(struct setterm_control *ctl, FILE *F)
 		sprintf(infile, "/dev/vcc/a%.0u", ctl->opt_sn_num);
 		fd = open(infile, O_RDONLY);
 	}
-	if (fd < 0) {
-		sprintf(infile, "/dev/vcsa%d", ctl->opt_sn_num);
-		goto read_error;
-	}
+	ctl->in_device = infile;
+	if (fd < 0)
+		read_error(ctl);
+	return fd;
+}
+
+static void screendump(struct setterm_control *ctl)
+{
+	unsigned char header[4];
+	unsigned int rows, cols;
+	int fd;
+	FILE *out;
+	size_t i, j;
+	ssize_t rc;
+	char *inbuf, *outbuf, *p, *q;
+	char dump_default[] = "screen.dump";
+
+	/* open source and destination files */
+	fd = open_snapshot_device(ctl);
+	if (!ctl->opt_sn_name)
+		ctl->opt_sn_name = dump_default;
+	out = fopen(ctl->opt_sn_name, ctl->opt_snap ? "w" : "a");
+	if (!out)
+		err(EXIT_DUMPFILE, _("can not open dump file %s for output"), ctl->opt_sn_name);
+	/* determine snapshot size */
 	if (read(fd, header, 4) != 4)
-		goto read_error;
+		read_error(ctl);
 	rows = header[0];
 	cols = header[1];
 	if (rows * cols == 0)
-		goto read_error;
-
+		read_error(ctl);
+	/* allocate buffers */
 	inbuf = xmalloc(rows * cols * 2);
 	outbuf = xmalloc(rows * (cols + 1));
-
+	/* read input */
 	rc = read(fd, inbuf, rows * cols * 2);
 	if (rc < 0 || (size_t)rc != rows * cols * 2)
-		goto read_error;
+		read_error(ctl);
 	p = inbuf;
 	q = outbuf;
+	/* copy inbuf to outbuf */
 	for (i = 0; i < rows; i++) {
 		for (j = 0; j < cols; j++) {
 			*q++ = *p;
@@ -772,27 +798,14 @@ static void screendump(struct setterm_control *ctl, FILE *F)
 			q--;
 		*q++ = '\n';
 	}
-	if (fwrite(outbuf, 1, q - outbuf, F) != (size_t)(q - outbuf)) {
-		warnx(_("Error writing screendump"));
-		goto error;
-	}
+	fwrite(outbuf, 1, q - outbuf, out);
+	/* clean up allocations */
 	close(fd);
 	free(inbuf);
 	free(outbuf);
+	if (close_stream(out) != 0)
+		errx(EXIT_FAILURE, _("write error"));
 	return;
-
- read_error:
-	if (ctl->opt_sn_num != 0)
-		warnx(_("Couldn't read %s"), infile);
-	else
-		warnx(_("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
-
- error:
-	if (fd >= 0)
-		close(fd);
-	free(inbuf);
-	free(outbuf);
-	exit(EXIT_FAILURE);
 }
 
 static void perform_sequence(struct setterm_control *ctl)
@@ -1013,18 +1026,7 @@ static void perform_sequence(struct setterm_control *ctl)
 
 	/* -snap [1-NR_CONS]. */
 	if (ctl->opt_snap || ctl->opt_append) {
-		FILE *F;
-		char dump_default[] = "screen.dump";
-
-		if (!ctl->opt_sn_name)
-			ctl->opt_sn_name = dump_default;
-		F = fopen(ctl->opt_sn_name, ctl->opt_snap ? "w" : "a");
-		if (!F)
-			err(EXIT_DUMPFILE, _("can not open dump file %s for output"),
-				ctl->opt_sn_name);
-		screendump(ctl, F);
-		if (close_stream(F) != 0)
-			errx(EXIT_FAILURE, _("write error"));
+		screendump(ctl);
 	}
 
 	/* -msg [on|off]. */
-- 
1.9.2

