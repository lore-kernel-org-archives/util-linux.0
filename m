Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40727 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988Ab1D2QmV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 29 Apr 2011 12:42:21 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2600659fxm.19
        for <util-linux@vger.kernel.org>; Fri, 29 Apr 2011 09:42:20 -0700 (PDT)
MIME-Version: 1.0
From: Austen Dicken <cvpcsm@gmail.com>
Date: Fri, 29 Apr 2011 11:42:00 -0500
Message-ID: <BANLkTin=y5oaEU0913dOnjWhosiyXe3Zwg@mail.gmail.com>
Subject: [PATCH 1/1] dmesg: adds the ability to "follow" the klog ring buffer
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

adds the "-f" option to dmesg, which allows an underpriviledged
user to "follow" the kernel ring buffer, outputting new messages as they
appear.  this is done non-destructively so that the current buffer remains
after execution.

this also changes the log output to be by-line instead of by-character,
and saves the last line printed on each read of the buffer.  if looping,
it will then read the buffer again, but not output until it finds the last
line that it printed.
---
 sys-utils/dmesg.1 |    4 ++
 sys-utils/dmesg.c |  147 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 117 insertions(+), 34 deletions(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index d7af1da..bbdd462 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -6,6 +6,7 @@ dmesg \- print or control the kernel ring buffer
 .SH SYNOPSIS
 .B dmesg
 .RB [ \-c ]
+.RB [ \-f ]
 .RB [ \-r ]
 .RB [ \-n
 .IR level ]
@@ -28,6 +29,9 @@ file to whoever can debug their problem.
 .B \-c
 Clear the ring buffer contents after printing.
 .TP
+.B \-f
+Output ring buffer contents as they are added.
+.TP
 .B \-r
 Print the raw message buffer, i.e., don't strip the log level prefixes.
 .TP
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index c3e5659..3342b80 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -35,6 +35,8 @@
 #include <stdlib.h>
 #include <sys/klog.h>
 #include <ctype.h>
+#include <signal.h>
+#include <unistd.h>

 #include "c.h"
 #include "nls.h"
@@ -44,34 +46,55 @@
 static void __attribute__ ((noreturn)) usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-c] [-n level] [-r] [-s bufsize]\n"),
+		_("Usage: %s [-c] [-f] [-n level] [-r] [-s bufsize]\n"),
 		program_invocation_short_name);
 	exit(EXIT_FAILURE);

 }

+typedef void (*sighandler_t)(int);
+static int follow_loop = 0;
+static void follow_sighandler(int signum) {
+	switch (signum) {
+	case SIGINT:
+		if(follow_loop) {
+			printf("\n");
+			follow_loop = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	char *buf = NULL;
 	int  sz;
 	int  bufsize = 0;
-	int  i;
+	int  i, j;
 	int  n;
 	int  c;
 	int  level = 0;
-	int  lastc;
 	int  cmd = 3;		/* Read all messages in the ring buffer */
 	int  raw = 0;
+	int  follow = 0;
+	char* last_line = NULL;
+	char* this_line = NULL;
+	sighandler_t prev_sighandler;

 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

-	while ((c = getopt(argc, argv, "crn:s:")) != -1) {
+	while ((c = getopt(argc, argv, "cfrn:s:")) != -1) {
 		switch (c) {
 		case 'c':
 			cmd = 4;	/* Read and clear all messages */
 			break;
+		case 'f':
+			follow = 1;
+			break;
 		case 'n':
 			cmd = 8;	/* Set level of messages */
 			level = strtol_or_err(optarg, _("failed to parse level"));
@@ -103,49 +126,105 @@ int main(int argc, char *argv[])
 		return EXIT_SUCCESS;
 	}

+	if (follow) {
+		cmd = 3; // override command to just print the buffer
+		follow_loop = 1;
+		prev_sighandler = signal(SIGINT, follow_sighandler);
+	}
+
 	if (!bufsize) {
 		n = klogctl(10, NULL, 0);	/* read ringbuffer size */
 		if (n > 0)
 			bufsize = n;
 	}

-	if (bufsize) {
-		sz = bufsize + 8;
-		buf = xmalloc(sz * sizeof(char));
-		n = klogctl(cmd, buf, sz);
-	} else {
-		sz = 16392;
-		while (1) {
+	do {
+		if (bufsize) {
+			sz = bufsize + 8;
 			buf = xmalloc(sz * sizeof(char));
-			n = klogctl(3, buf, sz);	/* read only */
-			if (n != sz || sz > (1 << 28))
-				break;
-			free(buf);
-			sz *= 4;
+			n = klogctl(cmd, buf, sz);
+		} else {
+			sz = 16392;
+			while (1) {
+				buf = xmalloc(sz * sizeof(char));
+				n = klogctl(3, buf, sz);	/* read only */
+				if (n != sz || sz > (1 << 28))
+					break;
+				free(buf);
+				sz *= 4;
+			}
+
+			if (n > 0 && cmd == 4)
+				n = klogctl(cmd, buf, sz);	/* read and clear */
 		}

-		if (n > 0 && cmd == 4)
-			n = klogctl(cmd, buf, sz);	/* read and clear */
-	}
-
-	if (n < 0)
-		err(EXIT_FAILURE, _("klogctl failed"));
+		if (n < 0)
+			err(EXIT_FAILURE, _("klogctl failed"));

-	lastc = '\n';
-	for (i = 0; i < n; i++) {
-		if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
-			i++;
-			while (isdigit(buf[i]))
-				i++;
-			if (buf[i] == '>')
+		this_line = xmalloc(n * sizeof(char));
+		for (i = 0, j = 0; i < n; i++) {
+			if (!raw && (i == 0 || buf[i - 1] == '\n') && buf[i] == '<') {
 				i++;
+				while (isdigit(buf[i]))
+					i++;
+				if (buf[i] == '>')
+					i++;
+			}
+			this_line[j] = buf[i];
+
+			if (this_line[j] == '\n') {
+				this_line[j] = '\0';
+				if (last_line) {
+					if (!strcmp(last_line, this_line)) {
+						free(last_line);
+						last_line = NULL;
+					}
+				} else
+					printf("%s\n", this_line);
+
+				j = 0;
+			} else
+				j++;
+		}
+
+		// if we have stale data to print, then print it!
+		if (j && !last_line) {
+			this_line[j] = '\0';
+			printf("%s\n", this_line);
+		}
+
+		free(buf);
+
+		if (last_line) {
+			/* we traversed the whole log and never found
+			 * the last line, so we didn't output anything.
+			 * we clear last_line now so that next time we
+			 * print the whole log */
+			free(last_line);
+			last_line = NULL;
+
+			/* free this_line as well */
+			free(this_line);
+			this_line = NULL;
+		} else {
+			last_line = this_line;
+			this_line = NULL;
 		}
-		lastc = buf[i];
-		putchar(lastc);
+		usleep(200);
+
+	} while (follow_loop);
+
+	if (follow) {
+		if (last_line) {
+			free(last_line);
+			last_line = NULL;
+		}
+
+		if (prev_sighandler)
+			signal(SIGINT, prev_sighandler);
+		else
+			signal(SIGINT, SIG_DFL);
 	}
-	if (lastc != '\n')
-		putchar('\n');
-	free(buf);

 	return EXIT_SUCCESS;
 }
