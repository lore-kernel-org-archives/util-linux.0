Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab2HALjZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 1 Aug 2012 07:39:25 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q71BdPO0031612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Wed, 1 Aug 2012 07:39:25 -0400
From: harald@redhat.com
To: util-linux@vger.kernel.org
Cc: Harald Hoyer <harald@redhat.com>
Subject: [PATCH] wdctl: add "--settimeout" to set the timeout
Date: Wed,  1 Aug 2012 13:39:06 +0200
Message-Id: <1343821146-28238-1-git-send-email-harald@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Harald Hoyer <harald@redhat.com>

---
 sys-utils/wdctl.8 |  2 ++
 sys-utils/wdctl.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/sys-utils/wdctl.8 b/sys-utils/wdctl.8
index a8f2254..5fa1173 100644
--- a/sys-utils/wdctl.8
+++ b/sys-utils/wdctl.8
@@ -27,6 +27,8 @@ Do not print a header line for flags table.
 Do not print watchdog identity information.
 .IP "\fB\-T\fR, \fB\-\-notimeouts\fP"
 Do not print watchdog timeouts.
+.IP "\fB\-s\fR, \fB\-\-settimeout \fI<seconds>\fP"
+Set the watchdog timeout in seconds.
 .IP "\fB\-o\fR, \fB\-\-output \fIlist\fP"
 Define the output columns to use in table of watchdog flags.  If no
 output arrangement is specified, then a default set is used.  Use
diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 7605864..b266969 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -154,6 +154,7 @@ static void usage(FILE *out)
 		" -o, --output <list>   output columns of the flags\n"
 		" -r, --raw             use raw output format for flags table\n"
 		" -T, --notimeouts      don't print watchdog timeouts\n"
+		" -s, --settimeout      set watchdog timeout\n"
 		" -x, --flags-only      print only flags table (same as -I -T)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
@@ -258,6 +259,60 @@ done:
 	tt_free_table(tt);
 	return rc;
 }
+/*
+ * Warning: successfully opened watchdog has to be properly closed with magic
+ * close character otherwise the machine will be rebooted!
+ *
+ * Don't use err() or exit() here!
+ */
+static int set_watchdog(struct wdinfo *wd, int timeout)
+{
+	int fd;
+	sigset_t sigs, oldsigs;
+	int rc = 0;
+
+	assert(wd->device);
+
+	sigemptyset(&oldsigs);
+	sigfillset(&sigs);
+	sigprocmask(SIG_BLOCK, &sigs, &oldsigs);
+
+	fd = open(wd->device, O_WRONLY|O_CLOEXEC);
+
+	if (fd < 0) {
+		if (errno == EBUSY)
+			warnx(_("%s: watchdog already in use, terminating."),
+					wd->device);
+		warn(_("cannot open %s"), wd->device);
+		return -1;
+	}
+
+	for (;;) {
+		/* We just opened this to query the state, not to arm
+		 * it hence use the magic close character */
+		static const char v = 'V';
+
+		if (write(fd, &v, 1) >= 0)
+			break;
+		if (errno != EINTR) {
+			warn(_("%s: failed to disarm watchdog"), wd->device);
+			break;
+		}
+		/* Let's try hard, since if we don't get this right
+		 * the machine might end up rebooting. */
+	}
+
+	if (ioctl(fd, WDIOC_SETTIMEOUT, &timeout) != 0) {
+		rc = errno;
+		warn(_("cannot set timeout for %s"), wd->device);
+	}
+
+	close(fd);
+	sigprocmask(SIG_SETMASK, &oldsigs, NULL);
+	printf("Set timeout to %d seconds\n", timeout);
+
+	return rc;
+}
 
 /*
  * Warning: successfully opened watchdog has to be properly closed with magic
@@ -381,6 +436,7 @@ int main(int argc, char *argv[])
 	int c, tt_flags = 0, res = EXIT_SUCCESS, count = 0;
 	char noflags = 0, noident = 0, notimeouts = 0, oneline = 0;
 	uint32_t wanted = 0;
+	int timeout = 0;
 
 	static const struct option long_opts[] = {
 		{ "flags",      required_argument, NULL, 'f' },
@@ -390,6 +446,7 @@ int main(int argc, char *argv[])
 		{ "noheadings", no_argument,       NULL, 'n' },
 		{ "noident",	no_argument,       NULL, 'I' },
 		{ "notimeouts", no_argument,       NULL, 'T' },
+		{ "settimeout", required_argument, NULL, 's' },
 		{ "output",     required_argument, NULL, 'o' },
 		{ "oneline",    no_argument,       NULL, 'O' },
 		{ "raw",        no_argument,       NULL, 'r' },
@@ -409,7 +466,7 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);
 
 	while ((c = getopt_long(argc, argv,
-				"d:f:hFnITo:OrVx", long_opts, NULL)) != -1) {
+				"d:f:hFnITo:s:OrVx", long_opts, NULL)) != -1) {
 
 		err_exclusive_options(c, long_opts, excl, excl_st);
 
@@ -421,6 +478,9 @@ int main(int argc, char *argv[])
 			if (ncolumns < 0)
 				return EXIT_FAILURE;
 			break;
+		case 's':
+			timeout = strtos32_or_err(optarg, _("invalid timeout argument"));
+			break;
 		case 'f':
 			if (string_to_bitmask(optarg, (unsigned long *) &wanted, name2bit) != 0)
 				return EXIT_FAILURE;
@@ -481,6 +541,13 @@ int main(int argc, char *argv[])
 			fputc('\n', stdout);
 		count++;
 
+		if (timeout) {
+			rc = set_watchdog(&wd, timeout);
+			if (rc) {
+				res = EXIT_FAILURE;
+			}
+		}
+
 		rc = read_watchdog(&wd);
 		if (rc) {
 			res = EXIT_FAILURE;
-- 
1.7.11.2

