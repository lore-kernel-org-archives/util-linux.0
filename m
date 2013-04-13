Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53515 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3DMTzQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:16 -0400
Received: by mail-wi0-f172.google.com with SMTP id hr17so508024wib.5
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/33] utmpdump: add option to write to a file
Date: Sat, 13 Apr 2013 20:54:31 +0100
Message-Id: <1365882901-11429-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/utmpdump |  2 +-
 login-utils/utmpdump.1   |  4 ++-
 login-utils/utmpdump.c   | 92 ++++++++++++++++++++++++++++--------------------
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/bash-completion/utmpdump b/bash-completion/utmpdump
index 3b868ce..48af5bc 100644
--- a/bash-completion/utmpdump
+++ b/bash-completion/utmpdump
@@ -11,7 +11,7 @@ _utmpdump_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--follow --reverse --version --help"
+			OPTS="--follow --reverse --output --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 35565a4..25f361a 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -19,7 +19,7 @@
 .SH NAME
 utmpdump \- dump UTMP and WTMP files in raw format
 .SH SYNOPSIS
-utmpdump [\-frh] [ filename ]
+utmpdump [\-frohV] [ filename ]
 .SH DESCRIPTION
 .B utmpdump
 is a simple program to dump UTMP and WTMP files in raw format, so they
@@ -33,6 +33,8 @@ is passed.
 Output appended data as the file grows.
 .IP "\fB\-r\fR, \fB\-\-reverse\fP
 Undump, write back edited login information into utmp or wtmp files.
+.IP "\fB\-o\fR, \fB\-\-output\fP \fIfile\fR
+Write command output to file instead of standard output.
 .IP "\fB\-h\fR, \fB\-\-help\fP"
 Print a help text and exit.
 .IP "\fB\-V\fR, \fB\-\-version\fP"
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index b015e1b..af3f7c0 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -83,7 +83,7 @@ static void xcleanse(char *s, int len)
 			*s = '?';
 }
 
-static void print_utline(struct utmp ut)
+static void print_utline(struct utmp ut, FILE *out)
 {
 	char *addr_string, *time_string;
 	struct in_addr in;
@@ -97,7 +97,7 @@ static void print_utline(struct utmp ut)
 	cleanse(ut.ut_host);
 
 	/*            pid    id       user     line     host     addr       time */
-	printf("[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15.15s] [%-28.28s]\n",
+	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15.15s] [%-28.28s]\n",
 	       ut.ut_type, ut.ut_pid, ut.ut_id, 8, UT_NAMESIZE, ut.ut_user,
 	       12, UT_LINESIZE, ut.ut_line, 20, UT_HOSTSIZE, ut.ut_host,
 	       addr_string, time_string);
@@ -107,28 +107,28 @@ static void print_utline(struct utmp ut)
 #define EVENTS		(IN_MODIFY|IN_DELETE_SELF|IN_MOVE_SELF|IN_UNMOUNT)
 #define NEVENTS		4
 
-static void roll_file(const char *filename, off_t *size)
+static void roll_file(const char *filename, off_t *size, FILE *out)
 {
-	FILE *fp;
+	FILE *in;
 	struct stat st;
 	struct utmp ut;
 	off_t pos;
 
-	if (!(fp = fopen(filename, "r")))
+	if (!(in = fopen(filename, "r")))
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
 
-	if (fstat(fileno(fp), &st) == -1)
+	if (fstat(fileno(in), &st) == -1)
 		err(EXIT_FAILURE, _("%s: stat failed"), filename);
 
 	if (st.st_size == *size)
 		goto done;
 
-	if (fseek(fp, *size, SEEK_SET) != (off_t) -1) {
-		while (fread(&ut, sizeof(ut), 1, fp) == 1)
-			print_utline(ut);
+	if (fseek(in, *size, SEEK_SET) != (off_t) -1) {
+		while (fread(&ut, sizeof(ut), 1, in) == 1)
+			print_utline(ut, out);
 	}
 
-	pos = ftello(fp);
+	pos = ftello(in);
 	/* If we've successfully read something, use the file position, this
 	 * avoids data duplication.  If we read nothing or hit an error,
 	 * reset to the reported size, this handles truncated files.
@@ -136,10 +136,10 @@ static void roll_file(const char *filename, off_t *size)
 	*size = (pos != -1 && pos != *size) ? pos : st.st_size;
 
 done:
-	fclose(fp);
+	fclose(in);
 }
 
-static int follow_by_inotify(FILE *fp, const char *filename)
+static int follow_by_inotify(FILE *in, const char *filename, FILE *out)
 {
 	char buf[NEVENTS * sizeof(struct inotify_event)];
 	int fd, wd, event;
@@ -150,8 +150,8 @@ static int follow_by_inotify(FILE *fp, const char *filename)
 	if (fd == -1)
 		return -1;	/* probably reached any limit ... */
 
-	size = ftello(fp);
-	fclose(fp);
+	size = ftello(in);
+	fclose(in);
 
 	wd = inotify_add_watch(fd, filename, EVENTS);
 	if (wd == -1)
@@ -172,7 +172,7 @@ static int follow_by_inotify(FILE *fp, const char *filename)
 				    (struct inotify_event *) &buf[event];
 
 			if (ev->mask & IN_MODIFY)
-				roll_file(filename, &size);
+				roll_file(filename, &size, out);
 			else {
 				close(wd);
 				wd = -1;
@@ -187,33 +187,33 @@ static int follow_by_inotify(FILE *fp, const char *filename)
 }
 #endif /* HAVE_INOTIFY_INIT */
 
-static FILE *dump(FILE *fp, const char *filename, int follow)
+static FILE *dump(FILE *in, const char *filename, int follow, FILE *out)
 {
 	struct utmp ut;
 
 	if (follow)
-		fseek(fp, -10 * sizeof(ut), SEEK_END);
+		fseek(in, -10 * sizeof(ut), SEEK_END);
 
-	while (fread(&ut, sizeof(ut), 1, fp) == 1)
-		print_utline(ut);
+	while (fread(&ut, sizeof(ut), 1, in) == 1)
+		print_utline(ut, out);
 
 	if (!follow)
-		return fp;
+		return in;
 
 #ifdef HAVE_INOTIFY_INIT
-	if (follow_by_inotify(fp, filename) == 0)
+	if (follow_by_inotify(in, filename, out) == 0)
 		return NULL;				/* file already closed */
 	else
 #endif
 		/* fallback for systems without inotify or with non-free
 		 * inotify instances */
 		for (;;) {
-			while (fread(&ut, sizeof(ut), 1, fp) == 1)
-				print_utline(ut);
+			while (fread(&ut, sizeof(ut), 1, in) == 1)
+				print_utline(ut, out);
 			sleep(1);
 		}
 
-	return fp;
+	return in;
 }
 
 
@@ -245,7 +245,7 @@ static int gettok(char *line, char *dest, int size, int eatspace)
 	return eaten + 1;
 }
 
-static void undump(FILE *fp)
+static void undump(FILE *in, FILE *out)
 {
 	struct utmp ut;
 	char s_addr[16], s_time[29], *linestart, *line;
@@ -255,7 +255,7 @@ static void undump(FILE *fp)
 	s_addr[15] = 0;
 	s_time[28] = 0;
 
-	while (fgets(linestart, 1023, fp)) {
+	while (fgets(linestart, 1023, in)) {
 		line = linestart;
 		memset(&ut, '\0', sizeof(ut));
 		sscanf(line, "[%hd] [%d] [%4c] ", &ut.ut_type, &ut.ut_pid, ut.ut_id);
@@ -270,7 +270,7 @@ static void undump(FILE *fp)
 		ut.ut_addr = inet_addr(s_addr);
 		ut.ut_time = strtotime(s_time);
 
-		ignore_result( fwrite(&ut, sizeof(ut), 1, stdout) );
+		ignore_result( fwrite(&ut, sizeof(ut), 1, out) );
 
 		++count;
 	}
@@ -286,8 +286,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 		_(" %s [options] [filename]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -f, --follow   output appended data as the file grows\n"
-		" -r, --reverse  write back dumped data into utmp file\n"), out);
+	fputs(_(" -f, --follow         output appended data as the file grows\n"), out);
+	fputs(_(" -r, --reverse        write back dumped data into utmp file\n"), out);
+	fputs(_(" -o, --output <file>  write to file instead of standard output\n"), out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 
@@ -298,13 +299,14 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char **argv)
 {
 	int c;
-	FILE *fp = NULL;
+	FILE *in = NULL, *out = NULL;
 	int reverse = 0, follow = 0;
 	const char *filename = NULL;
 
 	static const struct option longopts[] = {
 		{ "follow",  0, 0, 'f' },
 		{ "reverse", 0, 0, 'r' },
+		{ "output",  required_argument, 0, 'o' },
 		{ "help",    0, 0, 'h' },
 		{ "version", 0, 0, 'V' },
 		{ NULL, 0, 0, 0 }
@@ -315,7 +317,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "frhV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "fro:hV", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
 			reverse = 1;
@@ -325,6 +327,13 @@ int main(int argc, char **argv)
 			follow = 1;
 			break;
 
+		case 'o':
+			out = fopen(optarg, "w");
+			if (!out)
+				err(EXIT_FAILURE, _("cannot open %s"),
+				    optarg);
+			break;
+
 		case 'h':
 			usage(stdout);
 			break;
@@ -336,28 +345,35 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (!out)
+		out = stdout;
+
 	if (optind < argc) {
 		filename = argv[optind];
-		fp = fopen(filename, "r");
-		if (!fp)
+		in = fopen(filename, "r");
+		if (!in)
 			err(EXIT_FAILURE, _("cannot open %s"), filename);
 	} else {
 		if (follow)
 			errx(EXIT_FAILURE, _("following standard input is unsupported"));
 		filename = "/dev/stdin";
-		fp = stdin;
+		in = stdin;
 	}
 
 	if (reverse) {
 		fprintf(stderr, _("Utmp undump of %s\n"), filename);
-		undump(fp);
+		undump(in, out);
 	} else {
 		fprintf(stderr, _("Utmp dump of %s\n"), filename);
-		fp = dump(fp, filename, follow);
+		in = dump(in, filename, follow, out);
 	}
 
-	if (fp && fp != stdin)
-		fclose(fp);
+	if (out != stdout)
+		if (close_stream(out))
+			err(EXIT_FAILURE, _("write failed"));
+
+	if (in && in != stdin)
+		fclose(in);
 
 	return EXIT_SUCCESS;
 }
-- 
1.8.2.1

