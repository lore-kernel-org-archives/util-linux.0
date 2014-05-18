Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64481 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:03 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so2952329wiw.2
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:02 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/17] setterm: move show_tabs() and screendump() functions
Date: Sun, 18 May 2014 15:05:28 +0100
Message-Id: <1400421941-14244-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier the function was in the middle of option parsing code segment,
and screendump() required function prototype.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 187 +++++++++++++++++++++++++--------------------------
 1 file changed, 92 insertions(+), 95 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index c4753d0..734d275 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -221,8 +221,6 @@ int opt_ps_mode, opt_pd_min;	/* powersave mode/powerdown time */
 
 char opt_sn_name[PATH_MAX] = "screen.dump";
 
-static void screendump(int vcnum, FILE *F);
-
 /* Command line parsing routines.
  *
  * Note that it is an error for a given option to be invoked more than once.
@@ -451,24 +449,6 @@ static int parse_bfreq(char **argv, char *optarg, int *optind)
 	return strtoint_or_err(arg);
 }
 
-static void
-show_tabs(void) {
-	int i, co = tigetnum("cols");
-
-	if(co > 0) {
-		printf("\r         ");
-		for(i = 10; i < co-2; i+=10)
-			printf("%-10d", i);
-		putchar('\n');
-		for(i = 1; i <= co; i++)
-			putchar(i%10+'0');
-		putchar('\n');
-		for(i = 1; i < co; i++)
-			printf("\tT\b");
-		putchar('\n');
-	}
-}
-
 static void __attribute__ ((__noreturn__))
 usage(FILE *out) {
 /* Print error message about arguments, and the command's syntax. */
@@ -769,6 +749,98 @@ static char *ti_entry(const char *name) {
 	return buf_ptr;
 }
 
+static void show_tabs(void)
+{
+	int i, co = tigetnum("cols");
+
+	if (co > 0) {
+		printf("\r         ");
+		for (i = 10; i < co - 2; i += 10)
+			printf("%-10d", i);
+		putchar('\n');
+		for (i = 1; i <= co; i++)
+			putchar(i % 10 + '0');
+		putchar('\n');
+		for (i = 1; i < co; i++)
+			printf("\tT\b");
+		putchar('\n');
+	}
+}
+
+static void screendump(int vcnum, FILE *F)
+{
+	char infile[MAXPATHLEN];
+	unsigned char header[4];
+	unsigned int rows, cols;
+	int fd;
+	size_t i, j;
+	ssize_t rc;
+	char *inbuf = NULL, *outbuf = NULL, *p, *q;
+
+	sprintf(infile, "/dev/vcsa%d", vcnum);
+	fd = open(infile, O_RDONLY);
+	if (fd < 0 && vcnum == 0) {
+		/* vcsa0 is often called vcsa */
+		sprintf(infile, "/dev/vcsa");
+		fd = open(infile, O_RDONLY);
+	}
+	if (fd < 0) {
+		/* try devfs name - for zero vcnum just /dev/vcc/a */
+		/* some gcc's warn for %.u - add 0 */
+		sprintf(infile, "/dev/vcc/a%.0u", vcnum);
+		fd = open(infile, O_RDONLY);
+	}
+	if (fd < 0) {
+		sprintf(infile, "/dev/vcsa%d", vcnum);
+		goto read_error;
+	}
+	if (read(fd, header, 4) != 4)
+		goto read_error;
+	rows = header[0];
+	cols = header[1];
+	if (rows * cols == 0)
+		goto read_error;
+
+	inbuf = xmalloc(rows * cols * 2);
+	outbuf = xmalloc(rows * (cols + 1));
+
+	rc = read(fd, inbuf, rows * cols * 2);
+	if (rc < 0 || (size_t)rc != rows * cols * 2)
+		goto read_error;
+	p = inbuf;
+	q = outbuf;
+	for (i = 0; i < rows; i++) {
+		for (j = 0; j < cols; j++) {
+			*q++ = *p;
+			p += 2;
+		}
+		while (j-- > 0 && q[-1] == ' ')
+			q--;
+		*q++ = '\n';
+	}
+	if (fwrite(outbuf, 1, q - outbuf, F) != (size_t)(q - outbuf)) {
+		warnx(_("Error writing screendump"));
+		goto error;
+	}
+	close(fd);
+	free(inbuf);
+	free(outbuf);
+	return;
+
+ read_error:
+	if (vcnum != 0)
+		warnx(_("Couldn't read %s"), infile);
+	else
+		warnx(_("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
+
+ error:
+	if (fd >= 0)
+		close(fd);
+	free(inbuf);
+	free(outbuf);
+	exit(EXIT_FAILURE);
+}
+
 static void
 perform_sequence(int vcterm) {
 	/* vcterm: Set if terminal is a virtual console. */
@@ -1033,81 +1105,6 @@ perform_sequence(int vcterm) {
 
 }
 
-static void
-screendump(int vcnum, FILE * F)
-{
-	char infile[MAXPATHLEN];
-	unsigned char header[4];
-	unsigned int rows, cols;
-	int fd;
-	size_t i, j;
-	ssize_t rc;
-	char *inbuf = NULL, *outbuf = NULL, *p, *q;
-
-	sprintf(infile, "/dev/vcsa%d", vcnum);
-	fd = open(infile, O_RDONLY);
-	if (fd < 0 && vcnum == 0) {
-		/* vcsa0 is often called vcsa */
-		sprintf(infile, "/dev/vcsa");
-		fd = open(infile, O_RDONLY);
-	}
-	if (fd < 0) {
-		/* try devfs name - for zero vcnum just /dev/vcc/a */
-		/* some gcc's warn for %.u - add 0 */
-		sprintf(infile, "/dev/vcc/a%.0u", vcnum);
-		fd = open(infile, O_RDONLY);
-	}
-	if (fd < 0) {
-		sprintf(infile, "/dev/vcsa%d", vcnum);
-		goto read_error;
-	}
-	if (read(fd, header, 4) != 4)
-		goto read_error;
-	rows = header[0];
-	cols = header[1];
-	if (rows * cols == 0)
-		goto read_error;
-
-	inbuf = xmalloc(rows * cols * 2);
-	outbuf = xmalloc(rows * (cols + 1));
-
-	rc = read(fd, inbuf, rows * cols * 2);
-	if (rc < 0 || (size_t) rc != rows * cols * 2)
-		goto read_error;
-	p = inbuf;
-	q = outbuf;
-	for (i = 0; i < rows; i++) {
-		for (j = 0; j < cols; j++) {
-			*q++ = *p;
-			p += 2;
-		}
-		while (j-- > 0 && q[-1] == ' ')
-			q--;
-		*q++ = '\n';
-	}
-	if (fwrite(outbuf, 1, q - outbuf, F) != (size_t) (q - outbuf)) {
-		warnx(_("Error writing screendump"));
-		goto error;
-	}
-	close(fd);
-	free(inbuf);
-	free(outbuf);
-	return;
-
-read_error:
-	if (vcnum != 0)
-		warnx(_("Couldn't read %s"), infile);
-	else
-		warnx(_("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
-
-error:
-	if (fd >= 0)
-		close(fd);
-	free(inbuf);
-	free(outbuf);
-	exit(EXIT_FAILURE);
-}
-
 int
 main(int argc, char **argv) {
 	char *term;			/* Terminal type. */
-- 
1.9.2

