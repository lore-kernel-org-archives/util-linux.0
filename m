Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:64456 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbaGVWBM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:12 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so290497wes.4
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/10] logger: fix indentation issues
Date: Tue, 22 Jul 2014 23:00:51 +0100
Message-Id: <1406066459-4816-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 98 ++++++++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 6604d1a..204511d 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -76,8 +76,7 @@ enum {
 	OPT_JOURNALD
 };
 
-
-static char* get_prio_prefix(char *msg, int *prio)
+static char *get_prio_prefix(char *msg, int *prio)
 {
 	int p;
 	char *end = NULL;
@@ -133,8 +132,7 @@ static int pencode(char *s)
 		if (fac < 0)
 			errx(EXIT_FAILURE, _("unknown facility name: %s."), save);
 		*s++ = '.';
-	}
-	else {
+	} else {
 		fac = LOG_USER;
 		s = save;
 	}
@@ -261,30 +259,30 @@ static int journald_entry(FILE *fp)
 
 static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 {
-       char buf[1000], pid[30], *cp, *tp;
-       time_t now;
-
-       if (fd > -1) {
-               if (logflags & LOG_PID)
-                       snprintf (pid, sizeof(pid), "[%d]", getpid());
-	       else
-		       pid[0] = 0;
-               if (tag)
-		       cp = tag;
-	       else {
-		       cp = getlogin();
-		       if (!cp)
-			       cp = "<someone>";
-	       }
-	       time(&now);
-	       tp = ctime(&now)+4;
-
-               snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
-			pri, tp, cp, pid, msg);
-
-	       if (write_all(fd, buf, strlen(buf)+1) < 0)
-		       warn(_("write failed"));
-       }
+	char buf[1000], pid[30], *cp, *tp;
+	time_t now;
+
+	if (fd > -1) {
+		if (logflags & LOG_PID)
+			snprintf(pid, sizeof(pid), "[%d]", getpid());
+		else
+			pid[0] = 0;
+		if (tag)
+			cp = tag;
+		else {
+			cp = getlogin();
+			if (!cp)
+				cp = "<someone>";
+		}
+		time(&now);
+		tp = ctime(&now) + 4;
+
+		snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
+			 pri, tp, cp, pid, msg);
+
+		if (write_all(fd, buf, strlen(buf) + 1) < 0)
+			warn(_("write failed"));
+	}
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
@@ -450,17 +448,19 @@ int main(int argc, char **argv)
 		for (p = buf, endp = buf + sizeof(buf) - 2; *argv;) {
 			len = strlen(*argv);
 			if (p + len > endp && p > buf) {
-			    if (!usock && !server)
-				syslog(pri, "%s", buf);
-			    else
-				mysyslog(LogSock, logflags, pri, tag, buf);
+				if (!usock && !server)
+					syslog(pri, "%s", buf);
+				else
+					mysyslog(LogSock, logflags, pri, tag,
+						 buf);
 				p = buf;
 			}
 			if (len > sizeof(buf) - 1) {
-			    if (!usock && !server)
-				syslog(pri, "%s", *argv++);
-			    else
-				mysyslog(LogSock, logflags, pri, tag, *argv++);
+				if (!usock && !server)
+					syslog(pri, "%s", *argv++);
+				else
+					mysyslog(LogSock, logflags, pri, tag,
+						 *argv++);
 			} else {
 				if (p != buf)
 					*p++ = ' ';
@@ -469,31 +469,31 @@ int main(int argc, char **argv)
 			}
 		}
 		if (p != buf) {
-		    if (!usock && !server)
-			syslog(pri, "%s", buf);
-		    else
-			mysyslog(LogSock, logflags, pri, tag, buf);
+			if (!usock && !server)
+				syslog(pri, "%s", buf);
+			else
+				mysyslog(LogSock, logflags, pri, tag, buf);
 		}
 	} else {
 		char *msg;
 		int default_priority = pri;
 		while (fgets(buf, sizeof(buf), stdin) != NULL) {
-		    /* glibc is buggy and adds an additional newline,
-		       so we have to remove it here until glibc is fixed */
-		    int len = strlen(buf);
+			/* glibc is buggy and adds an additional newline,
+			   so we have to remove it here until glibc is fixed */
+			int len = strlen(buf);
 
-		    if (len > 0 && buf[len - 1] == '\n')
-			    buf[len - 1] = '\0';
+			if (len > 0 && buf[len - 1] == '\n')
+				buf[len - 1] = '\0';
 
 			msg = buf;
 			pri = default_priority;
 			if (prio_prefix && msg[0] == '<')
 				msg = get_prio_prefix(msg, &pri);
 
-		    if (!usock && !server)
-			syslog(pri, "%s", msg);
-		    else
-			mysyslog(LogSock, logflags, pri, tag, msg);
+			if (!usock && !server)
+				syslog(pri, "%s", msg);
+			else
+				mysyslog(LogSock, logflags, pri, tag, msg);
 		}
 	}
 	if (!usock && !server)
-- 
2.0.2

