Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37884 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbCOMzI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:08 -0400
Received: by wixw10 with SMTP id w10so21676582wix.0
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/8] tests: add test_logger helper command
Date: Sun, 15 Mar 2015 12:54:49 +0000
Message-Id: <1426424094-25451-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am |  4 ++++
 misc-utils/logger.c      | 36 ++++++++++++++++++++++++++++++++++++
 tests/commands.sh        |  1 +
 3 files changed, 41 insertions(+)

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index f7485c9..309727b 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -26,6 +26,10 @@ if HAVE_SYSTEMD
 logger_LDADD = $(SYSTEMD_LIBS) $(SYSTEMD_DAEMON_LIBS) $(SYSTEMD_JOURNAL_LIBS)
 logger_CFLAGS = $(SYSTEMD_CFLAGS) $(SYSTEMD_DAEMON_CFLAGS) $(SYSTEMD_JOURNAL_CFLAGS)
 endif
+check_PROGRAMS += test_logger
+test_logger_SOURCES = $(logger_SOURCES)
+test_logger_LDADD = $(logger_LDADD)
+test_logger_CFLAGS = -DTEST_LOGGER $(logger_CFLAGS)
 endif # BUILD_LOGGER
 
 
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 2e37d14..838d225 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -310,7 +310,12 @@ static const char *rfc3164_current_time(void)
 		"Sep", "Oct", "Nov", "Dec"
 	};
 
+#ifndef TEST_LOGGER
 	gettimeofday(&tv, NULL);
+#else
+	tv.tv_sec = 1234567890;
+	tv.tv_usec = 123456;
+#endif
 	tm = localtime(&tv.tv_sec);
 	snprintf(time, sizeof(time),"%s %2d %2.2d:%2.2d:%2.2d",
 		monthnames[tm->tm_mon], tm->tm_mday,
@@ -326,7 +331,9 @@ static const char *rfc3164_current_time(void)
 static void write_output(const struct logger_ctl *ctl, const char *const msg)
 {
 	char *buf;
+#ifndef TEST_LOGGER
 	const size_t len = xasprintf(&buf, "%s%s", ctl->hdr, msg);
+
 	if (write_all(ctl->fd, buf, len) < 0)
 		warn(_("write failed"));
 	else if (ctl->socket_type == TYPE_TCP)
@@ -338,6 +345,9 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 		 */
 		if (write_all(ctl->fd, "\n", 1) < 0)
 			warn(_("write failed"));
+#else
+	xasprintf(&buf, "%s%s", ctl->hdr, msg);
+#endif
 	if (ctl->stderr_printout)
 		fprintf(stderr, "%s\n", buf);
 }
@@ -353,12 +363,16 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
 	if (ctl->pid)
 		snprintf(pid, sizeof(pid), "[%d]", ctl->pid);
 
+#ifndef TEST_LOGGER
 	if ((hostname = xgethostname())) {
 		char *dot = strchr(hostname, '.');
 		if (dot)
 			*dot = '\0';
 	} else
 		hostname = xstrdup(NILVALUE);
+#else
+	hostname = xstrdup("test-hostname");
+#endif
 
 	xasprintf(&ctl->hdr, "<%d>%.15s %s %.200s%s: ",
 		 ctl->pri, rfc3164_current_time(), hostname, ctl->tag, pid);
@@ -402,7 +416,12 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 		struct timeval tv;
 		struct tm *tm;
 
+#ifndef TEST_LOGGER
 		gettimeofday(&tv, NULL);
+#else
+		tv.tv_sec = 1234567890;
+		tv.tv_usec = 123456;
+#endif
 		if ((tm = localtime(&tv.tv_sec)) != NULL) {
 			char fmt[64];
 			const size_t i = strftime(fmt, sizeof(fmt),
@@ -418,8 +437,12 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 		time = xstrdup(NILVALUE);
 
 	if (ctl->rfc5424_host) {
+#ifndef TEST_LOGGER
 		if (!(hostname = xgethostname()))
 			hostname = xstrdup(NILVALUE);
+#else
+		hostname = xstrdup("test-hostname");
+#endif
 		/* Arbitrary looking 'if (var < strlen()) checks originate from
 		 * RFC 5424 - 6 Syslog Message Format definition.  */
 		if (255 < strlen(hostname))
@@ -443,7 +466,12 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 		if (ntp_gettime(&ntptv) == TIME_OK)
 			xasprintf(&structured_data,
 				 "[timeQuality tzKnown=\"1\" isSynced=\"1\" syncAccuracy=\"%ld\"]",
+#ifndef TEST_LOGGER
 				 ntptv.maxerror);
+#else
+				 123456L);
+#endif
+
 		else
 #endif
 			xasprintf(&structured_data,
@@ -747,7 +775,11 @@ int main(int argc, char **argv)
 			ctl.skip_empty_lines = 1;
 			break;
 		case 'i':		/* log process id also */
+#ifndef TEST_LOGGER
 			ctl.pid = getpid();
+#else
+			ctl.pid = 98765;
+#endif
 			break;
 		case OPT_ID:
 			if (optarg) {
@@ -757,7 +789,11 @@ int main(int argc, char **argv)
 					p++;
 				ctl.pid = strtoul_or_err(optarg, _("failed to parse id"));
 			} else
+#ifndef TEST_LOGGER
 				ctl.pid = getpid();
+#else
+				ctl.pid = 98765;
+#endif
 			break;
 		case 'p':		/* priority */
 			ctl.pri = pencode(optarg);
diff --git a/tests/commands.sh b/tests/commands.sh
index e11bd2a..fd07b17 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -17,6 +17,7 @@ TS_HELPER_LIBMOUNT_DEBUG="$top_builddir/test_mount_debug"
 TS_HELPER_PYLIBMOUNT_CONTEXT="$top_srcdir/libmount/python/test_mount_context.py"
 TS_HELPER_PYLIBMOUNT_TAB="$top_srcdir/libmount/python/test_mount_tab.py"
 TS_HELPER_PYLIBMOUNT_UPDATE="$top_srcdir/libmount/python/test_mount_tab_update.py"
+TS_HELPER_LOGGER="$top_builddir/test_logger"
 TS_HELPER_LOGINDEFS="$top_builddir/test_logindefs"
 TS_HELPER_MD5="$top_builddir/test_md5"
 TS_HELPER_MORE=${TS_HELPER_MORE-"$top_builddir/test_more"}
-- 
2.3.2

