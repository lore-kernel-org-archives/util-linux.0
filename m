Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:39435 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab2GHVis (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Jul 2012 17:38:48 -0400
Received: by wibhr14 with SMTP id hr14so2719268wib.1
        for <util-linux@vger.kernel.org>; Sun, 08 Jul 2012 14:38:47 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 8 Jul 2012 23:38:47 +0200
Message-ID: <CAG27Bk3f3moSFyOzLiTiRE-1vSVJn+PFh0-K_s65cD=h8MdJgg@mail.gmail.com>
Subject: [pull] few utmpdump fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Here's my changes to the latest addition of the util-linux package.
Four out of five patches are mostly boring.  The only one worth to
mention is inotify, which makes process scheduling happy.  Command no
longer activates every second to check there are no updates for most of
the time.


The following changes since commit 839be2ba6b44fa9dc927f081d547ebadec9de19c:

  hwclock: don't set time for --systz (2012-07-04 13:43:51 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk27

for you to fetch changes up to 9e4fd3a7ae7b68e34cc9b31cc7a951b5078bca45:

  utmpdump: encourage users not to follow stdin (2012-07-08 23:20:04 +0200)

----------------------------------------------------------------
Sami Kerola (5):
      docs: clean up utmpdump.1 manual
      utmpdump: white space fix
      utmpdump: fixes based on static analysis [cppcheck]
      utmpdump: use inotify to when following file
      utmpdump: encourage users not to follow stdin

 login-utils/utmpdump.1 |  54 +++++++++--------
 login-utils/utmpdump.c | 161 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 156 insertions(+), 59 deletions(-)

diff --git a/login-utils/utmpdump.1 b/login-utils/utmpdump.1
index 65dfe32..e8ee585 100644
--- a/login-utils/utmpdump.1
+++ b/login-utils/utmpdump.1
@@ -15,46 +15,44 @@
 .\" along with this program; if not, write to the Free Software
 .\" Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA
 .\"
-.TH UTMPDUMP 1 "Februar 8, 2010" "" "Linux System Administrator's Manual"
+.TH UTMPDUMP "1" "July 2012" "util-linux" "System Administration"
 .SH NAME
 utmpdump \- dump UTMP and WTMP files in raw format
 .SH SYNOPSIS
-.B utmpdump
-.RB [ \-frh ]
-.I filename
+utmpdump [\-frh] filename
 .SH DESCRIPTION
-\fButmpdump\fP is a simple program to dump UTMP and WTMP files
-in raw format, so they can be examined.
+.B utmpdump
+is a simple program to dump UTMP and WTMP files in raw format, so they
+can be examined.
 .SH OPTIONS
-.IP "\fB\-f, \-\-follow\fP"
-output appended data as the file grows.
-.IP "\fB\-r, \-\-reverse\fP
+.IP "\fB\-f\fR, \fB\-\-follow\fP"
+Output appended data as the file grows.
+.IP "\fB\-r\fR, \fB\-\-reverse\fP
 Undump, write back edited login information into utmp or wtmp files.
-.IP "\fB\-h, \-\-help\fP"
+.IP "\fB\-h\fR, \fB\-\-help\fP"
 Print a help text and exit.
-.IP "\fB\-V, \-\-version\fP"
+.IP "\fB\-V\fR, \fB\-\-version\fP"
 Output version information and exit.
 .SH NOTES
-utmpdump can be useful in cases of corrupted utmp or wtmp entries.  It can dump
-out utmp/wtmp to an ASCII file, then that file can be edited to remove bogus
-entries and reintegrated, using
+.B utmpdump
+can be useful in cases of corrupted utmp or wtmp entries.  It can dump
+out utmp/wtmp to an ASCII file, then that file can be edited to remove
+bogus entries and reintegrated, using
 .PP
-.sp 1
-.in +1c
-.nf
-\fButmpdump -r < ascii file > wtmp\fP
-.fi
-.in -1c
-.sp 1
+.RS
+utmpdump -r < ascii_file > wtmp
+.RE
+.PP
 but be warned as
 .B utmpdump
 was written for debugging purpose only.
 .SH BUGS
 You may
 .B not
-use the option \fB\-r\fP as the format for the
-utmp/wtmp files strongly depends on the
-input format. This tool was
+use the option
+.B \-r
+as the format for the utmp/wtmp files strongly depends on the input
+format.  This tool was
 .B not
 written for normal use but for debugging.
 .SH AUTHOR
@@ -63,4 +61,10 @@ Michael Krapp
 .BR last (1),
 .BR w (1),
 .BR who (1),
-.BR utmp (5),
+.BR utmp (5)
+.SH AVAILABILITY
+The utmpdump command is part of the util-linux package and is available
+from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index ac072d4..fc9c040 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -35,6 +35,10 @@
 #include <unistd.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <sys/stat.h>
+#ifdef HAVE_INOTIFY_INIT
+#include <sys/inotify.h>
+#endif

 #include "c.h"
 #include "nls.h"
@@ -43,7 +47,7 @@

 static char *timetostr(const time_t time)
 {
-	static char s[29];    /* [Sun Sep 01 00:00:00 1998 PST] */
+	static char s[29];	/* [Sun Sep 01 00:00:00 1998 PST] */

 	if (time != 0)
 		strftime(s, 29, "%a %b %d %T %Y %Z", localtime(&time));
@@ -79,15 +83,6 @@ static void xcleanse(char *s, int len)
 			*s = '?';
 }

-static void unspace(char *s, int len)
-{
-	while (*s && *s != ' ' && len--)
-		++s;
-
-	if (len > 0)
-		*s = '\0';
-}
-
 static void print_utline(struct utmp ut)
 {
 	char *addr_string, *time_string;
@@ -101,14 +96,111 @@ static void print_utline(struct utmp ut)
 	cleanse(ut.ut_line);
 	cleanse(ut.ut_host);

-        /*            pid    id       user     line     host     addr
      time */
+	/*            pid    id       user     line     host     addr       time */
 	printf("[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15.15s]
[%-28.28s]\n",
 	       ut.ut_type, ut.ut_pid, ut.ut_id, 8, UT_NAMESIZE, ut.ut_user,
 	       12, UT_LINESIZE, ut.ut_line, 20, UT_HOSTSIZE, ut.ut_host,
-               addr_string, time_string);
+	       addr_string, time_string);
+}
+
+#ifdef HAVE_INOTIFY_INIT
+
+static void
+roll_file(const char *filename, off_t *size)
+{
+	FILE *fp;
+	struct stat st;
+	struct utmp ut;
+	off_t pos;
+
+	if (!(fp = fopen(filename, "r")))
+		err(EXIT_FAILURE, _("cannot open \"%s\" for read"), filename);
+
+	if (fstat(fileno(fp), &st) == -1)
+		err(EXIT_FAILURE, _("cannot stat \"%s\""), filename);
+
+	if (st.st_size == *size) {
+		fclose(fp);
+		return;
+	}
+
+	if (fseek(fp, *size, SEEK_SET) != (off_t)-1) {
+		while (fread(&ut, sizeof(ut), 1, fp) == 1)
+			print_utline(ut);
+	}
+
+	pos = ftello(fp);
+	/* If we've successfully read something, use the file position, this
+	 * avoids data duplication.  If we read nothing or hit an error,
+	 * reset to the reported size, this handles truncated files.
+	 */
+	*size = (pos != -1 && pos != *size) ? pos : st.st_size;
+
+	fclose(fp);
+}
+
+#define EVENTS		(IN_MODIFY|IN_DELETE_SELF|IN_MOVE_SELF|IN_UNMOUNT)
+#define NEVENTS		4
+
+static void
+dump(FILE *fp, const char *filename, int forever)
+{
+	struct utmp ut;
+
+	if (forever) {
+		char buf[NEVENTS * sizeof(struct inotify_event)];
+		int fd, wd, event;
+		off_t size;
+		ssize_t length;
+
+		/* print last 10 lines */
+		fseek(fp, -10 * sizeof(ut), SEEK_END);
+		while (fread(&ut, sizeof(ut), 1, fp) == 1)
+			print_utline(ut);
+		size = ftello(fp);
+		fclose(fp);
+
+		/* start following file */
+		fd = inotify_init();
+		if (fd == -1)
+			err(EXIT_FAILURE, _("inotify_init failed"));
+		wd = inotify_add_watch(fd, filename, EVENTS);
+		if (wd == -1)
+			err(EXIT_FAILURE, _("%s: cannot add inotify watch."),
+			    filename);
+
+		while (0 <= wd) {
+			length = read(fd, buf, sizeof(buf));
+			if (length < 0 && (errno == EINTR || errno == EAGAIN))
+				continue;
+			if (length < 0)
+				err(EXIT_FAILURE,
+				    _("%s: cannot read inotify events"),
+				    filename);
+			for (event = 0; event < length;) {
+				struct inotify_event *ev =
+				    (struct inotify_event *)&buf[event];
+				if (ev->mask & IN_MODIFY)
+					roll_file(filename, &size);
+				else {
+					close(wd);
+					wd = -1;
+					break;
+				}
+				event += sizeof(struct inotify_event) + ev->len;
+			}
+		}
+		close(fd);
+	} else {
+		/* not in follow mode */
+		while (fread(&ut, sizeof(ut), 1, fp) == 1)
+			print_utline(ut);
+	}
 }

-static void dump(FILE *fp, int forever)
+#else /* not HAVE_INOTIFY_INIT */
+static void dump(FILE *fp, const char *filename __attribute__ ((__unused__)),
+		 int forever)
 {
 	struct utmp ut;

@@ -122,13 +214,13 @@ static void dump(FILE *fp, int forever)
 			sleep(1);
 	} while (forever);
 }
+#endif /* HAVE_INOTIFY_INIT */

 /* This function won't work properly if there's a ']' or a ' ' in the real
  * token.  Thankfully, this should never happen.  */
 static int gettok(char *line, char *dest, int size, int eatspace)
 {
 	int bpos, epos, eaten;
-        char *t;

 	bpos = strchr(line, '[') - line;
 	if (bpos < 0)
@@ -137,16 +229,17 @@ static int gettok(char *line, char *dest, int
size, int eatspace)
 	line += 1 + bpos;
 	epos = strchr(line, ']') - line;
 	if (epos < 0)
-		errx(EXIT_FAILURE,_("Extraneous newline in file. Exiting."));
+		errx(EXIT_FAILURE, _("Extraneous newline in file. Exiting."));

 	line[epos] = '\0';
 	eaten = bpos + epos + 1;

 	if (eatspace) {
-                if ((t = strchr(line, ' ')))
-                    *t = 0;
+		char *t;
+		if ((t = strchr(line, ' ')))
+			*t = 0;
 	}
-        strncpy(dest, line, size);
+	strncpy(dest, line, size);

 	return eaten + 1;
 }
@@ -161,23 +254,22 @@ static void undump(FILE *fp)
 	s_addr[15] = 0;
 	s_time[28] = 0;

-	while (fgets(linestart, 1023, fp))
-	{
+	while (fgets(linestart, 1023, fp)) {
 		line = linestart;
-                memset(&ut, '\0', sizeof(ut));
-                sscanf(line, "[%hd] [%d] [%4c] ", &ut.ut_type,
&ut.ut_pid, ut.ut_id);
+		memset(&ut, '\0', sizeof(ut));
+		sscanf(line, "[%1hd] [%1d] [%4c] ", &ut.ut_type, &ut.ut_pid, ut.ut_id);

 		line += 19;
-                line += gettok(line, ut.ut_user, sizeof(ut.ut_user), 1);
-                line += gettok(line, ut.ut_line, sizeof(ut.ut_line), 1);
-                line += gettok(line, ut.ut_host, sizeof(ut.ut_host), 1);
-		line += gettok(line, s_addr, sizeof(s_addr)-1, 1);
-		line += gettok(line, s_time, sizeof(s_time)-1, 0);
+		line += gettok(line, ut.ut_user, sizeof(ut.ut_user), 1);
+		line += gettok(line, ut.ut_line, sizeof(ut.ut_line), 1);
+		line += gettok(line, ut.ut_host, sizeof(ut.ut_host), 1);
+		line += gettok(line, s_addr, sizeof(s_addr) - 1, 1);
+		line += gettok(line, s_time, sizeof(s_time) - 1, 0);

-                ut.ut_addr = inet_addr(s_addr);
-                ut.ut_time = strtotime(s_time);
+		ut.ut_addr = inet_addr(s_addr);
+		ut.ut_time = strtotime(s_time);

-                fwrite(&ut, sizeof(ut), 1, stdout);
+		fwrite(&ut, sizeof(ut), 1, stdout);

 		++count;
 	}
@@ -189,8 +281,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);

-	fprintf(out,
-		_(" %s [options]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);

 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -f, --follow           output appended data as the file grows\n"
@@ -249,7 +340,9 @@ int main(int argc, char **argv)
 		if (!fp)
 			err(EXIT_FAILURE, _("%s: open failed"), filename);
 	} else {
-		filename = "stdin";
+		filename = "/dev/stdin";
+		if (forever)
+			warnx(_("warning: following standard input indefinitely is ineffective"));
 		fp = stdin;
 	}

@@ -258,7 +351,7 @@ int main(int argc, char **argv)
 		undump(fp);
 	} else {
 		fprintf(stderr, _("Utmp dump of %s\n"), filename);
-		dump(fp, forever);
+		dump(fp, filename, forever);
 	}

 	if (fp != stdin)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
