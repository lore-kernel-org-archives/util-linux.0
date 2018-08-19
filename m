Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.asbjorn.biz ([185.38.24.25]:48678 "EHLO mail.asbjorn.biz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeHSUgF (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 19 Aug 2018 16:36:05 -0400
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=
        <asbjorn@asbjorn.st>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?=
        <asbjorn@asbjorn.st>
Subject: [PATCH 2/2] script: add input log feature
Date: Sun, 19 Aug 2018 17:16:58 +0000
Message-Id: <20180819171658.20285-2-asbjorn@asbjorn.st>
In-Reply-To: <20180819171658.20285-1-asbjorn@asbjorn.st>
References: <20180819171658.20285-1-asbjorn@asbjorn.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When script is used to log usage of shell accounts, accessible by
random users (some of whom might be malicious).

This patch adds a new --input-log option, which makes script save
the input data to a file, in an extended timing format also containing
the data, thereby allowing the input to be reconstructed.

Signed-off-by: Asbjørn Sloth Tønnesen <asbjorn@asbjorn.st>
---
 bash-completion/script |  1 +
 term-utils/script.1    | 11 +++++++++-
 term-utils/script.c    | 58 +++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/bash-completion/script b/bash-completion/script
index 57b91a9eb..c670dd5bd 100644
--- a/bash-completion/script
+++ b/bash-completion/script
@@ -25,6 +25,7 @@ _script_module()
 				--flush
 				--force
 				--quiet
+				--input-log
 				--output-limit
 				--timing=
 				--version
diff --git a/term-utils/script.1 b/term-utils/script.1
index 0fb4c4fd7..a55924f68 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -87,8 +87,17 @@ being done using `cat foo'.
 Allow the default output destination, i.e. the typescript file, to be a hard
 or symbolic link.  The command will follow a symbolic link.
 .TP
+\fB\-i, \fB\-\-input-log\fR \fIfile\fR
+Log input data to
+.IR file .
+This data contains three fields, separated by a space.  The first
+field indicates how much time elapsed since the previous input.  The second
+field indicates how many characters were input this time.  The third field is
+the input data. This information can be used to log input data, regardless of
+whether it's echoed back by the shell.  Beware this will log passwords in the input.
+.TP
 \fB\-o\fR, \fB\-\-output-limit\fR \fIsize\fR
-Limit the size of the typescript and timing files to
+Limit the combined size of the output files to
 .I size
 and stop the child process after this size is exceeded.  The calculated
 file size does not include the start and done messages that the
diff --git a/term-utils/script.c b/term-utils/script.c
index dfea87463..4ea6d3ccf 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -101,13 +101,17 @@ UL_DEBUG_DEFINE_MASKNAMES(script) = UL_DEBUG_EMPTY_MASKNAMES;
 struct script_control {
 	char *shell;		/* shell to be executed */
 	char *command;		/* command to be executed */
+	char *inputlogname;	/* input log file path */
+	FILE *inputlogfp;	/* input log file pointer */
 	char *fname;		/* output file path */
 	FILE *typescriptfp;	/* output file pointer */
 	char *tname;		/* timing file path */
 	FILE *timingfp;		/* timing file pointer */
 	uint64_t outsz;         /* current output file size */
 	uint64_t maxsz;		/* maximum output file size */
-	struct timeval oldtime;	/* previous write or command start time */
+	struct timeval
+		last_timing,	/* previous timing/input write or ... */
+		last_inputlog;	/* ... command start time */
 	int master;		/* pseudoterminal master file descriptor */
 	int slave;		/* pseudoterminal slave file descriptor */
 	int poll_timeout;	/* poll() timeout, used in end of execution */
@@ -124,6 +128,7 @@ struct script_control {
 	 flush:1,		/* flush after each write */
 	 quiet:1,		/* suppress most output */
 	 timing:1,		/* include timing file */
+	 inputlog:1,		/* write input log file */
 	 force:1,		/* write output to links */
 	 isterm:1,		/* is child process running as terminal */
 	 die:1;			/* terminate program */
@@ -172,6 +177,7 @@ static void __attribute__((__noreturn__)) usage(void)
 		" -e, --return                  return exit code of the child process\n"
 		" -f, --flush                   run flush after each write\n"
 		"     --force                   use output file even when it is a link\n"
+		" -i, --input-log=<file>        write input log to file\n"
 		" -o, --output-limit <size>     terminate if output files exceed size\n"
 		" -q, --quiet                   be quiet\n"
 		" -t[<file>], --timing[=<file>] output timing data to stderr or to FILE\n"
@@ -295,6 +301,8 @@ static void __attribute__((__noreturn__)) done_log(struct script_control *ctl, c
 		err(EXIT_FAILURE, "write failed: %s", ctl->tname);
 	if (ctl->typescriptfp && close_stream(ctl->typescriptfp) != 0)
 		err(EXIT_FAILURE, "write failed: %s", ctl->fname);
+	if (ctl->inputlogfp && close_stream(ctl->inputlogfp) != 0)
+		err(EXIT_FAILURE, "write failed: %s", ctl->inputlogname);
 
 	exit(ctl->rc_wanted ? childstatus : EXIT_SUCCESS);
 }
@@ -337,12 +345,12 @@ static void write_output(struct script_control *ctl, char *obuf,
 		DBG(IO, ul_debug("  writing timing info"));
 
 		gettime_monotonic(&now);
-		timersub(&now, &ctl->oldtime, &delta);
+		timersub(&now, &ctl->last_timing, &delta);
 		timing_bytes = fprintf(ctl->timingfp, "%ld.%06ld %zd\n",
 		        (long)delta.tv_sec, (long)delta.tv_usec, bytes);
 		if (ctl->flush)
 			fflush(ctl->timingfp);
-		ctl->oldtime = now;
+		ctl->last_timing = now;
 		if (timing_bytes < 0)
 			timing_bytes = 0;
 	}
@@ -373,6 +381,25 @@ static void write_output(struct script_control *ctl, char *obuf,
 static int write_to_shell(struct script_control *ctl,
 			  char *buf, size_t bufsz)
 {
+	if (ctl->inputlog && ctl->inputlogfp) {
+		struct timeval now, delta;
+		int inputlog_bytes = 0;
+		int bytes = bufsz;
+
+		DBG(IO, ul_debug("  writing input log"));
+
+		gettime_monotonic(&now);
+		timersub(&now, &ctl->last_inputlog, &delta);
+		inputlog_bytes = fprintf(ctl->inputlogfp, "%ld.%06ld %zd %.*s\n",
+		        (long)delta.tv_sec, (long)delta.tv_usec, bufsz, bytes, buf);
+		if (ctl->flush)
+			fflush(ctl->inputlogfp);
+		ctl->last_inputlog = now;
+
+		if (ctl->maxsz != 0)
+			ctl->outsz += inputlog_bytes;
+	}
+
 	return write_all(ctl->master, buf, bufsz);
 }
 
@@ -455,6 +482,9 @@ static void handle_io(struct script_control *ctl, int fd, int *eof)
 			warn(_("write failed"));
 			fail(ctl);
 		}
+
+		check_output_limit(ctl);
+
 		/* without sync write_output() will write both input &
 		 * shell output that looks like double echoing */
 		fdatasync(ctl->master);
@@ -520,6 +550,7 @@ static void handle_signal(struct script_control *ctl, int fd)
 static void do_io(struct script_control *ctl)
 {
 	int ret, eof = 0;
+	struct timeval now;
 	time_t tvec = script_time((time_t *)NULL);
 	enum {
 		POLLFD_SIGNAL = 0,
@@ -551,11 +582,23 @@ static void do_io(struct script_control *ctl)
 		}
 	}
 
+	if (ctl->inputlog) {
+		const char *ilname = ctl->inputlogname;
+
+		if (!(ctl->inputlogfp = fopen(ilname, "w" UL_CLOEXECSTR))) {
+			restore_tty(ctl, TCSANOW);
+			warn(_("cannot open %s"), ilname);
+			fail(ctl);
+		}
+	}
+
 
 	if (ctl->typescriptfp)
 		typescript_message_start(ctl, &tvec);
 
-	gettime_monotonic(&ctl->oldtime);
+	gettime_monotonic(&now);
+	ctl->last_timing = now;
+	ctl->last_inputlog = now;
 
 	while (!ctl->die) {
 		size_t i;
@@ -775,6 +818,7 @@ int main(int argc, char **argv)
 		{"return", no_argument, NULL, 'e'},
 		{"flush", no_argument, NULL, 'f'},
 		{"force", no_argument, NULL, FORCE_OPTION,},
+		{"input-log", required_argument, NULL, 'i'},
 		{"output-limit", required_argument, NULL, 'o'},
 		{"quiet", no_argument, NULL, 'q'},
 		{"timing", optional_argument, NULL, 't'},
@@ -798,7 +842,7 @@ int main(int argc, char **argv)
 
 	script_init_debug();
 
-	while ((ch = getopt_long(argc, argv, "ac:efo:qt::Vh", longopts, NULL)) != -1)
+	while ((ch = getopt_long(argc, argv, "ac:efi:o:qt::Vh", longopts, NULL)) != -1)
 		switch (ch) {
 		case 'a':
 			ctl.append = 1;
@@ -815,6 +859,10 @@ int main(int argc, char **argv)
 		case FORCE_OPTION:
 			ctl.force = 1;
 			break;
+		case 'i':
+			ctl.inputlog = 1;
+			ctl.inputlogname = optarg;
+			break;
 		case 'o':
 			ctl.maxsz = strtosize_or_err(optarg, _("failed to parse output limit size"));
 			break;
-- 
2.16.1
