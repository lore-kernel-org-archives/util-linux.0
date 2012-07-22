Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54472 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab2GVT7M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Jul 2012 15:59:12 -0400
Received: by wgbdr13 with SMTP id dr13so5183706wgb.1
        for <util-linux@vger.kernel.org>; Sun, 22 Jul 2012 12:59:10 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 22 Jul 2012 21:59:10 +0200
Message-ID: <CAG27Bk1N-6L=LNQ_zBAr0HCsDxGHKoDWSOk=V8x1jdNtXKHK0Q@mail.gmail.com>
Subject: [pull] shadow declarations and no return attributes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

This patch set is so trivial that I where wondering should I even send
these.  Oh well, perhaps cleaning non critical warnings has some value.


The following changes since commit cc924cc086cf0363f49edd6ce14947acae2dad77:

  mkfs.cramfs: fix compiler warning [-Wmissing-prototypes] (2012-07-16
18:57:30 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk29

for you to fetch changes up to 6a3c14f39fb0eba1affd6c5bb27d7b92fb46d619:

  more: add noreturn function attribute (2012-07-17 20:37:06 +0200)

----------------------------------------------------------------
Sami Kerola (19):
      mkswap: fix shadow declaration
      libmount: fix shadow declaration
      sulogin: fix shadow declaration
      blkid: fix shadow declaration
      lslocks: fix shadow declaration
      whereis: fix shadow declaration
      eject: fix shadow declaration
      lscpu: fix shadow declaration
      setterm: fix shadow declaration
      more: fix shadow declaration
      ul: fix shadow declaration
      hexdump: fix shadow declaration
      include: define format to be constant in xasprintf()
      fdisk: add noreturn function attribute
      libblkid: add noreturn function attribute
      libmount: add noreturn function attribute
      vipw: add noreturn function attribute
      script: add noreturn function attributes
      more: add noreturn function attribute

 disk-utils/mkswap.c       |  4 ++--
 fdisks/fdisk.c            |  3 ++-
 include/xalloc.h          |  3 ++-
 libblkid/src/dev.c        |  2 +-
 libblkid/src/tag.c        |  2 +-
 libmount/src/lock.c       |  2 +-
 libmount/src/tab_update.c |  2 +-
 login-utils/sulogin.c     | 20 ++++++++++----------
 login-utils/vipw.c        |  3 ++-
 misc-utils/blkid.c        |  8 ++++----
 misc-utils/lslocks.c      |  4 ++--
 misc-utils/whereis.c      | 18 +++++++++---------
 sys-utils/eject.c         |  1 -
 sys-utils/lscpu.c         | 17 ++++++++---------
 term-utils/script.c       | 10 +++++-----
 term-utils/setterm.c      |  6 +++---
 text-utils/hexdump.c      |  2 +-
 text-utils/hexdump.h      |  2 +-
 text-utils/more.c         |  9 +++++----
 text-utils/parse.c        |  2 +-
 text-utils/ul.c           |  6 +++---
 21 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ca49d0e..34fe687 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -363,7 +363,7 @@ new_prober(int fd)
 #endif

 static void
-wipe_device(int fd, const char *devname, int force, int is_blkdev)
+wipe_device(int fd, const char *devname, int force, int is_blkdevice)
 {
 	char *type = NULL;
 	int whole = 0;
@@ -375,7 +375,7 @@ wipe_device(int fd, const char *devname, int
force, int is_blkdev)
 		if (lseek(fd, 0, SEEK_SET) != 0)
 			errx(EXIT_FAILURE, _("unable to rewind swap-device"));

-		if (is_blkdev && is_whole_disk_fd(fd, devname)) {
+		if (is_blkdevice && is_whole_disk_fd(fd, devname)) {
 			/* don't zap bootbits on whole disk -- we know nothing
 			 * about bootloaders on the device */
 			whole = 1;
diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 32b6de9..7fca5b6 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -159,7 +159,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-void fatal(struct fdisk_context *cxt, enum failure why)
+void __attribute__((__noreturn__))
+fatal(struct fdisk_context *cxt, enum failure why)
 {
 	close(cxt->dev_fd);
 	switch (why) {
diff --git a/include/xalloc.h b/include/xalloc.h
index 8c22ff7..1704259 100644
--- a/include/xalloc.h
+++ b/include/xalloc.h
@@ -63,7 +63,8 @@ static inline char *xstrdup(const char *str)
         return ret;
 }

-static inline int xasprintf(char **strp, char *fmt, ...)
+static inline int __attribute__ ((__format__(printf, 2, 3)))
+    xasprintf(char **strp, const char *fmt, ...)
 {
 	int ret;
 	va_list args;
diff --git a/libblkid/src/dev.c b/libblkid/src/dev.c
index 791a6c1..58ee6f8 100644
--- a/libblkid/src/dev.c
+++ b/libblkid/src/dev.c
@@ -206,7 +206,7 @@ extern char *optarg;
 extern int optind;
 #endif

-void usage(char *prog)
+void __attribute__((__noreturn__)) usage(char *prog)
 {
 	fprintf(stderr, "Usage: %s [-f blkid_file] [-m debug_mask]\n", prog);
 	fprintf(stderr, "\tList all devices and exit\n");
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 0dbe1ff..be4ef35 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -390,7 +390,7 @@ extern char *optarg;
 extern int optind;
 #endif

-void usage(char *prog)
+void __attribute__((__noreturn__)) usage(char *prog)
 {
 	fprintf(stderr, "Usage: %s [-f blkid_file] [-m debug_mask] device "
 		"[type value]\n",
diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index 80ccdee..9f04725 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -589,7 +589,7 @@ void clean_lock(void)
 	mnt_free_lock(lock);
 }

-void sig_handler(int sig)
+void __attribute__((__noreturn__)) sig_handler(int sig)
 {
 	errx(EXIT_FAILURE, "\n%d: catch signal: %s\n", getpid(), strsignal(sig));
 }
diff --git a/libmount/src/tab_update.c b/libmount/src/tab_update.c
index 56e87cf..caabd05 100644
--- a/libmount/src/tab_update.c
+++ b/libmount/src/tab_update.c
@@ -200,7 +200,7 @@ int mnt_update_set_fs(struct libmnt_update *upd,
unsigned long mountflags,

 	} else if (fs) {
 		if (upd->userspace_only && !(mountflags & MS_MOVE)) {
-			int rc = utab_new_entry(upd, fs, mountflags);
+			rc = utab_new_entry(upd, fs, mountflags);
 			if (rc)
 				return rc;
 		} else {
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 7ac493b..d7d44b6 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -334,7 +334,7 @@ static void sushell(struct passwd *pwd)
 	char shell[PATH_MAX];
 	char home[PATH_MAX];
 	char *p;
-	char *sushell;
+	char *su_shell;

 	/*
 	 * Set directory and shell.
@@ -348,17 +348,17 @@ static void sushell(struct passwd *pwd)
 	}

 	if ((p = getenv("SUSHELL")) != NULL)
-		sushell = p;
+		su_shell = p;
 	else if ((p = getenv("sushell")) != NULL)
-		sushell = p;
+		su_shell = p;
 	else {
 		if (pwd->pw_shell[0])
-			sushell = pwd->pw_shell;
+			su_shell = pwd->pw_shell;
 		else
-			sushell = "/bin/sh";
+			su_shell = "/bin/sh";
 	}
-	if ((p = strrchr(sushell, '/')) == NULL)
-		p = sushell;
+	if ((p = strrchr(su_shell, '/')) == NULL)
+		p = su_shell;
 	else
 		p++;

@@ -378,7 +378,7 @@ static void sushell(struct passwd *pwd)
 	/*
 	 * Try to execute a shell.
 	 */
-	setenv("SHELL", sushell, 1);
+	setenv("SHELL", su_shell, 1);
 	unmask_signal(SIGINT, &saved_sigint);
 	unmask_signal(SIGTSTP, &saved_sigtstp);
 	unmask_signal(SIGQUIT, &saved_sigquit);
@@ -399,8 +399,8 @@ static void sushell(struct passwd *pwd)
 		free(level);
 	}
 #endif
-	execl(sushell, shell, NULL);
-	warn(_("%s: exec failed"), sushell);
+	execl(su_shell, shell, NULL);
+	warn(_("%s: exec failed"), su_shell);

 	setenv("SHELL", "/bin/sh", 1);
 	execl("/bin/sh", profile ? "-sh" : "sh", NULL);
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 3377112..ed3f43b 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -236,7 +236,8 @@ static void pw_edit(int notsetuid)
 	free(editor);
 }

-void pw_error(char *name, int err, int eval)
+void __attribute__((__noreturn__))
+pw_error(char *name, int err, int eval)
 {
 	if (err) {
 		if (name)
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 579ad27..920f639 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -399,17 +399,17 @@ static int print_udev_ambivalent(blkid_probe pr)
 	int count = 0, rc = -1;

 	while (!blkid_do_probe(pr)) {
-		const char *usage = NULL, *type = NULL, *version = NULL;
+		const char *usage_txt = NULL, *type = NULL, *version = NULL;
 		char enc[256];

-		blkid_probe_lookup_value(pr, "USAGE", &usage, NULL);
+		blkid_probe_lookup_value(pr, "USAGE", &usage_txt, NULL);
 		blkid_probe_lookup_value(pr, "TYPE", &type, NULL);
 		blkid_probe_lookup_value(pr, "VERSION", &version, NULL);

-		if (!usage || !type)
+		if (!usage_txt || !type)
 			continue;

-		blkid_encode_string(usage, enc, sizeof(enc));
+		blkid_encode_string(usage_txt, enc, sizeof(enc));
 		if (append_str(&val, &valsz, enc, ":"))
 			goto done;

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 094224d..56855f4 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -104,12 +104,12 @@ static void disable_columns_truncate(void)
 /*
  * Return a PID's command name
  */
-static char *get_cmdname(pid_t pid)
+static char *get_cmdname(pid_t qpid)
 {
 	FILE *fp;
 	char path[PATH_MAX], *ret = NULL;

-	sprintf(path, "/proc/%d/comm", pid);
+	sprintf(path, "/proc/%d/comm", qpid);
 	if (!(fp = fopen(path, "r")))
 		return NULL;

diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index 6807b8a..6faf262 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -188,7 +188,7 @@ itsit(char *cp, char *dp)
 static void
 findin(char *dir, char *cp)
 {
-	DIR *dirp;
+	DIR *derp;
 	struct dirent *dp;
 	char *d, *dd;
 	size_t l;
@@ -197,17 +197,17 @@ findin(char *dir, char *cp)

 	dd = strchr(dir, '*');
 	if (!dd) {
-		dirp = opendir(dir);
-		if (dirp == NULL)
+		derp = opendir(dir);
+		if (derp == NULL)
 			return;
-		while ((dp = readdir(dirp)) != NULL) {
+		while ((dp = readdir(derp)) != NULL) {
 			if (itsit(cp, dp->d_name)) {
 				count++;
 				if (print)
 					printf(" %s/%s", dir, dp->d_name);
 			}
 		}
-		closedir(dirp);
+		closedir(derp);
 		return;
 	}

@@ -217,10 +217,10 @@ findin(char *dir, char *cp)
 		strcpy(dirbuf, dir);
 		d = strchr(dirbuf, '*');
 		*d = 0;
-		dirp = opendir(dirbuf);
-		if (dirp == NULL)
+		derp = opendir(dirbuf);
+		if (derp == NULL)
 			return;
-		while ((dp = readdir(dirp)) != NULL) {
+		while ((dp = readdir(derp)) != NULL) {
 			if (!strcmp(dp->d_name, ".") ||
 			    !strcmp(dp->d_name, ".."))
 				continue;
@@ -234,7 +234,7 @@ findin(char *dir, char *cp)
 			strcat(d, dd + 1);
 			findin(dirbuf, cp);
 		}
-		closedir(dirp);
+		closedir(derp);
 	}
 	return;

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index c8bb6a8..08af08e 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -526,7 +526,6 @@ static int read_speed(const char *devname)
 		} else {
 			if (strncmp(line, "drive speed:", 12) == 0) {
 				int i;
-				char *str;

 				str = strtok(&line[12], "\t ");
 				for (i = 1; i < drive_number; i++)
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 3984b2d..7a712de 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1081,7 +1081,7 @@ print_summary(struct lscpu_desc *desc, struct
lscpu_modifier *mod)
 	print_s(_("Architecture:"), desc->arch);

 	if (desc->mode) {
-		char buf[64], *p = buf;
+		char mbuf[64], *p = mbuf;

 		if (desc->mode & MODE_32BIT) {
 			strcpy(p, "32-bit, ");
@@ -1092,7 +1092,7 @@ print_summary(struct lscpu_desc *desc, struct
lscpu_modifier *mod)
 			p += 8;
 		}
 		*(p - 2) = '\0';
-		print_s(_("CPU op-mode(s):"), buf);
+		print_s(_("CPU op-mode(s):"), mbuf);
 	}
 #if !defined(WORDS_BIGENDIAN)
 	print_s(_("Byte Order:"), "Little Endian");
@@ -1141,11 +1141,11 @@ print_summary(struct lscpu_desc *desc, struct
lscpu_modifier *mod)
 		 */
 		if (path_exist(_PATH_PROC_SYSINFO)) {
 			FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
-			char buf[BUFSIZ];
+			char pbuf[BUFSIZ];
 			int t0, t1, t2;

-			while (fd && fgets(buf, sizeof(buf), fd) != NULL) {
-				if (sscanf(buf, "CPU Topology SW:%d%d%d%d%d%d",
+			while (fd && fgets(pbuf, sizeof(pbuf), fd) != NULL) {
+				if (sscanf(pbuf, "CPU Topology SW:%d%d%d%d%d%d",
 					   &t0, &t1, &t2, &books, &sockets_per_book,
 					   &cores_per_socket) == 6)
 					break;
@@ -1193,13 +1193,12 @@ print_summary(struct lscpu_desc *desc, struct
lscpu_modifier *mod)
 	if (desc->dispatching >= 0)
 		print_s(_("Dispatching mode:"), _(disp_modes[desc->dispatching]));
 	if (desc->ncaches) {
-		char buf[512];
-		int i;
+		char cbuf[512];

 		for (i = desc->ncaches - 1; i >= 0; i--) {
-			snprintf(buf, sizeof(buf),
+			snprintf(cbuf, sizeof(cbuf),
 					_("%s cache:"), desc->caches[i].name);
-			print_s(buf, desc->caches[i].size);
+			print_s(cbuf, desc->caches[i].size);
 		}
 	}

diff --git a/term-utils/script.c b/term-utils/script.c
index 8d7ab65..ccd8873 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -289,7 +289,7 @@ main(int argc, char **argv) {
 	return EXIT_SUCCESS;
 }

-void
+void __attribute__((__noreturn__))
 doinput(void) {
 	ssize_t cc;
 	char ibuf[BUFSIZ];
@@ -345,7 +345,7 @@ my_strftime(char *buf, size_t len, const char
*fmt, const struct tm *tm) {
 	strftime(buf, len, fmt, tm);
 }

-void
+void __attribute__((__noreturn__))
 dooutput(FILE *timingfd) {
 	ssize_t cc;
 	time_t tvec;
@@ -412,7 +412,7 @@ dooutput(FILE *timingfd) {
 	done();
 }

-void
+void __attribute__((__noreturn__))
 doshell(void) {
 	char *shname;

@@ -462,14 +462,14 @@ fixtty(void) {
 	tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 }

-void
+void __attribute__((__noreturn__))
 fail(void) {

 	kill(0, SIGTERM);
 	done();
 }

-void
+void __attribute__((__noreturn__))
 done(void) {
 	time_t tvec;

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 3083ac8..03148f7 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -218,11 +218,11 @@ static void screendump(int vcnum, FILE *F);
  */

 static void
-parse_term(int argc, char **argv, int *option, char **opt_term, int *bad_arg) {
+parse_term(int argc, char **argv, int *option, char **opt_trm, int *bad_arg) {
 	/* argc: Number of arguments for this option. */
 	/* argv: Arguments for this option. */
 	/* option: Term flag to set. */
-	/* opt_term: Terminal name to set. */
+	/* opt_trm: Terminal name to set. */
 	/* bad_arg: Set to true if an error is detected. */

 /* Parse a -term specification. */
@@ -231,7 +231,7 @@ parse_term(int argc, char **argv, int *option,
char **opt_term, int *bad_arg) {
 		*bad_arg = TRUE;
 	*option = TRUE;
 	if (argc == 1)
-		*opt_term = argv[0];
+		*opt_trm = argv[0];
 }

 static void
diff --git a/text-utils/hexdump.c b/text-utils/hexdump.c
index 90c2d77..a4a61cf 100644
--- a/text-utils/hexdump.c
+++ b/text-utils/hexdump.c
@@ -68,7 +68,7 @@ int main(int argc, char **argv)

 	/* figure out the data block size */
 	for (blocksize = 0, tfs = fshead; tfs; tfs = tfs->nextfs) {
-		tfs->bcnt = size(tfs);
+		tfs->bcnt = block_size(tfs);
 		if (blocksize < tfs->bcnt)
 			blocksize = tfs->bcnt;
 	}
diff --git a/text-utils/hexdump.h b/text-utils/hexdump.h
index 2222585..b9e67a1 100644
--- a/text-utils/hexdump.h
+++ b/text-utils/hexdump.h
@@ -81,7 +81,7 @@ extern off_t skip;                      /* bytes to skip */
 enum _vflag { ALL, DUP, FIRST, WAIT };	/* -v values */
 extern enum _vflag vflag;

-int size(FS *);
+int block_size(FS *);
 void add(const char *);
 void rewrite(FS *);
 void addfile(char *);
diff --git a/text-utils/more.c b/text-utils/more.c
index 4cf090f..58c99cc 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -755,7 +755,8 @@ void chgwinsz(int dummy __attribute__ ((__unused__)))
 ** Clean up terminal state and exit. Also come here if interrupt
signal received
 */

-void end_it (int dummy __attribute__ ((__unused__)))
+void __attribute__((__noreturn__))
+end_it (int dummy __attribute__ ((__unused__)))
 {
     reset_tty ();
     if (clreol) {
@@ -1120,10 +1121,10 @@ void prbuf (register char *s, register int n)
 	    {
 		wchar_t wc;
 		size_t mblength;
-		mbstate_t state;
-		memset (&state, '\0', sizeof (mbstate_t));
+		mbstate_t mbstate;
+		memset (&mbstate, '\0', sizeof (mbstate_t));
 		s--; n++;
-		mblength = mbrtowc (&wc, s, n, &state);
+		mblength = mbrtowc (&wc, s, n, &mbstate);
 		if (mblength == (size_t) -2 || mblength == (size_t) -1)
 			mblength = 1;
 		while (mblength--)
diff --git a/text-utils/parse.c b/text-utils/parse.c
index 481db6d..5f1e2bd 100644
--- a/text-utils/parse.c
+++ b/text-utils/parse.c
@@ -150,7 +150,7 @@ void add(const char *fmt)

 static const char *spec = ".#-+ 0123456789";

-int size(FS *fs)
+int block_size(FS *fs)
 {
 	FU *fu;
 	int bcnt, cursize;
diff --git a/text-utils/ul.c b/text-utils/ul.c
index 80bc7a1..3c7bf50 100644
--- a/text-utils/ul.c
+++ b/text-utils/ul.c
@@ -638,11 +638,11 @@ static void setcol(int newcol) {
 		needcol(col);
 }

-static void needcol(int col) {
-	maxcol = col;
+static void needcol(int acol) {
+	maxcol = acol;

 	/* If col >= obuflen, expand obuf until obuflen > col. */
-	while (col >= obuflen) {
+	while (acol >= obuflen) {
 		/* Paranoid check for obuflen == INT_MAX. */
 		if (obuflen == INT_MAX)
 			errx(EXIT_FAILURE, _("Input line too long."));

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
