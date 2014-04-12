Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:55475 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbaDLK25 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 12 Apr 2014 06:28:57 -0400
Received: by mail-we0-f176.google.com with SMTP id x48so6408491wes.35
        for <util-linux@vger.kernel.org>; Sat, 12 Apr 2014 03:28:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/7] tests: add signal receiver program
Date: Sat, 12 Apr 2014 11:28:40 +0100
Message-Id: <1397298524-3364-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
References: <1397298524-3364-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Target to kill with a check that will be wrote later.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/helpers/Makemodule.am     |   3 +
 tests/helpers/test_sigreceive.c | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)
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
index 0000000..a2d3f53
--- /dev/null
+++ b/tests/helpers/test_sigreceive.c
@@ -0,0 +1,126 @@
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
+#include <signal.h>
+#include <sys/select.h>
+#include <unistd.h>
+
+static __attribute__ ((__noreturn__))
+void exiter(int sig)
+{
+	_exit(sig);
+}
+
+int main(void)
+{
+	struct sigaction sigact;
+	fd_set rfds;
+	struct timeval timeout;
+
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = 0;
+	sigact.sa_handler = exiter;
+	timeout.tv_sec = 2;
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
+	select(STDIN_FILENO, &rfds, NULL, NULL, &timeout);
+	return 0;
+}
-- 
1.9.2

