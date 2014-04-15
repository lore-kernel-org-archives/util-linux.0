Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:58333 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaDOLPs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:48 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so9444782wgh.7
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 3/9] tests: add signal receiver program
Date: Tue, 15 Apr 2014 12:15:29 +0100
Message-Id: <1397560535-14622-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Target to kill with a check that will be wrote later.

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/helpers/Makemodule.am     |   3 +
 tests/helpers/test_sigreceive.c | 153 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)
 create mode 100644 tests/helpers/test_sigreceive.c

diff --git a/tests/helpers/Makemodule.am b/tests/helpers/Makemodule.am
index 9724dae..0b927e9 100644
--- a/tests/helpers/Makemodule.am
+++ b/tests/helpers/Makemodule.am
@@ -10,3 +10,6 @@ test_pathnames_SOURCES = tests/helpers/test_pathnames.c
 
 check_PROGRAMS += test_sysinfo
 test_sysinfo_SOURCES = tests/helpers/test_sysinfo.c
+
+check_PROGRAMS += test_sigreceive
+test_sigreceive_SOURCES = tests/helpers/test_sigreceive.c
diff --git a/tests/helpers/test_sigreceive.c b/tests/helpers/test_sigreceive.c
new file mode 100644
index 0000000..a84f95a
--- /dev/null
+++ b/tests/helpers/test_sigreceive.c
@@ -0,0 +1,153 @@
+/*
+ * test_sigreceive - wait for signal and exit with value of it
+ *
+ * Written by Sami Kerola <kerolasa@iki.fi>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <err.h>
+#include <errno.h>
+#include <signal.h>
+#include <stdio.h>
+#include <sys/select.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <xalloc.h>
+
+char *pid_path;
+int fd;
+
+static __attribute__ ((__noreturn__))
+void exiter(int sig)
+{
+	close(fd);
+	unlink(pid_path);
+	_exit(sig);
+}
+
+int main(int argc, char **argv)
+{
+	struct sigaction sigact;
+	fd_set rfds;
+	struct timeval timeout;
+	struct stat statbuf;
+	mode_t mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH;
+
+	if (argc != 2) {
+		fputs("Usage: test_sigreceive <file|directory>\n", stderr);
+		return -1;
+	}
+
+	if (!stat(argv[1], &statbuf)) {
+		if (S_ISDIR(statbuf.st_mode))
+			xasprintf(&pid_path, "%s/%d", argv[1], getpid());
+	} else
+		xasprintf(&pid_path, "%s", argv[1]);
+
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = 0;
+	sigact.sa_handler = exiter;
+	timeout.tv_sec = 5;
+	timeout.tv_usec = 0;
+
+	sigaction(SIGHUP, &sigact, NULL);
+	sigaction(SIGINT, &sigact, NULL);
+	sigaction(SIGQUIT, &sigact, NULL);
+	sigaction(SIGILL, &sigact, NULL);
+#ifdef SIGTRAP
+	sigaction(SIGTRAP, &sigact, NULL);
+#endif
+	sigaction(SIGABRT, &sigact, NULL);
+#ifdef SIGIOT
+	sigaction(SIGIOT, &sigact, NULL);
+#endif
+#ifdef SIGEMT
+	sigaction(SIGEMT, &sigact, NULL);
+#endif
+#ifdef SIGBUS
+	sigaction(SIGBUS, &sigact, NULL);
+#endif
+	sigaction(SIGFPE, &sigact, NULL);
+	sigaction(SIGKILL, &sigact, NULL);
+	sigaction(SIGUSR1, &sigact, NULL);
+	sigaction(SIGSEGV, &sigact, NULL);
+	sigaction(SIGUSR2, &sigact, NULL);
+	sigaction(SIGPIPE, &sigact, NULL);
+	sigaction(SIGALRM, &sigact, NULL);
+	sigaction(SIGTERM, &sigact, NULL);
+#ifdef SIGSTKFLT
+	sigaction(SIGSTKFLT, &sigact, NULL);
+#endif
+	sigaction(SIGCHLD, &sigact, NULL);
+#ifdef SIGCLD
+	sigaction(SIGCLD, &sigact, NULL);
+#endif
+	sigaction(SIGCONT, &sigact, NULL);
+	sigaction(SIGSTOP, &sigact, NULL);
+	sigaction(SIGTSTP, &sigact, NULL);
+	sigaction(SIGTTIN, &sigact, NULL);
+	sigaction(SIGTTOU, &sigact, NULL);
+#ifdef SIGURG
+	sigaction(SIGURG, &sigact, NULL);
+#endif
+#ifdef SIGXCPU
+	sigaction(SIGXCPU, &sigact, NULL);
+#endif
+#ifdef SIGXFSZ
+	sigaction(SIGXFSZ, &sigact, NULL);
+#endif
+#ifdef SIGVTALRM
+	sigaction(SIGVTALRM, &sigact, NULL);
+#endif
+#ifdef SIGPROF
+	sigaction(SIGPROF, &sigact, NULL);
+#endif
+#ifdef SIGWINCH
+	sigaction(SIGWINCH, &sigact, NULL);
+#endif
+#ifdef SIGIO
+	sigaction(SIGIO, &sigact, NULL);
+#endif
+#ifdef SIGPOLL
+	sigaction(SIGPOLL, &sigact, NULL);
+#endif
+#ifdef SIGINFO
+	sigaction(SIGINFO, &sigact, NULL);
+#endif
+#ifdef SIGLOST
+	sigaction(SIGLOST, &sigact, NULL);
+#endif
+#ifdef SIGPWR
+	sigaction(SIGPWR, &sigact, NULL);
+#endif
+#ifdef SIGUNUSED
+	sigaction(SIGUNUSED, &sigact, NULL);
+#endif
+#ifdef SIGSYS
+	sigaction(SIGSYS, &sigact, NULL);
+#endif
+#ifdef SIGRTMIN
+	sigaction(SIGRTMIN+0, &sigact, NULL);
+	sigaction(SIGRTMAX+0, &sigact, NULL);
+#endif
+	FD_ZERO(&rfds);
+	FD_SET(0, &rfds);
+
+	if (!(fd = open(pid_path, O_WRONLY | O_CREAT | O_TRUNC, mode)))
+		err(EXIT_FAILURE, "cannot open pid file: %s", pid_path);
+	select(STDIN_FILENO, &rfds, NULL, NULL, &timeout);
+	exiter(0);
+}
-- 
1.9.2

