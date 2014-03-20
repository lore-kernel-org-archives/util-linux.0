Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:57951 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758574AbaCTJlg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Mar 2014 05:41:36 -0400
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <jananive@linux.vnet.ibm.com>;
	Thu, 20 Mar 2014 15:11:34 +0530
Subject: [PATCH 17/33] Daemonizing the Process
To: linux-kernel@vger.kernel.org
From: Janani Venkataraman <jananive@linux.vnet.ibm.com>
Cc: amwang@redhat.com, procps@freelists.org, rdunlap@xenotime.net,
        james.hogan@imgtec.com, aravinda@linux.vnet.ibm.com, hch@lst.de,
        mhiramat@redhat.com, jeremy.fitzhardinge@citrix.com,
        xemul@parallels.com, d.hatayama@jp.fujitsu.com, coreutils@gnu.org,
        kosaki.motohiro@jp.fujitsu.com, adobriyan@gmail.com,
        util-linux@vger.kernel.org, tarundsk@linux.vnet.ibm.com,
        vapier@gentoo.org, roland@hack.frob.com, ananth@linux.vnet.ibm.com,
        gorcunov@openvz.org, avagin@openvz.org, oleg@redhat.com,
        eparis@redhat.com, suzuki@linux.vnet.ibm.com, andi@firstfloor.org,
        tj@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Date: Thu, 20 Mar 2014 15:11:27 +0530
Message-ID: <20140320094127.14878.29621.stgit@localhost.localdomain>
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For the purpose of a self dump, we start a daemon which accepts requests and
acts like a server. This method was adapted from the CRIU self dump
application.

Checks if the process is running as root, if yes daemonizes it through the
daemon library call and opens a log file to log in the events of the daemon.

Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
---
 src/coredump.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/coredump.c b/src/coredump.c
index a6bcaae..09fb8da 100644
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -29,6 +29,9 @@
 #include <dirent.h>
 #include <errno.h>
 #include <elf.h>
+#include <errno.h>
+#include <syslog.h>
+#include <signal.h>
 #include <sys/ptrace.h>
 #include <coredump.h>
 
@@ -50,6 +53,13 @@ void gencore_log(char *fmt, ...)
 /* Core process object */
 struct core_proc cp;
 
+#ifndef GENCORE_DAEMON_LOGFILE
+#define GENCORE_DAEMON_LOGFILE "/var/log/gencored.log"
+#endif
+
+/* PID of Daemon */
+int pid_log;
+
 /* Initialised core process members */
 void init_core(void)
 {
@@ -248,6 +258,31 @@ cleanup:
 /* Daemon for self dump */
 int daemon_dump(void)
 {
+	/* Check if daemon is running as root */
+	if (geteuid()) {
+		fprintf(stderr, "Run the daemon as root.\n");
+		return -1;
+	}
+
+	/* Daemonizing it */
+	if (daemon(0, 0)) {
+		fprintf(stderr, "Daemon not up %s.", strerror(errno));
+		return -1;
+	}
+
+	/* Get the PID of the daemon */
+	pid_log = getpid();
+
+	fp_log = fopen(GENCORE_DAEMON_LOGFILE, "w+");
+	if (fp_log == NULL) {
+		openlog("gencore_daemon_log", LOG_PID|LOG_CONS, LOG_USER);
+		syslog(LOG_DAEMON, "Could not open: %s.\n",
+					GENCORE_DAEMON_LOGFILE);
+		closelog();
+		return -1;
+	}
+
+	fclose(fp_log);
 	return 0;
 }
 

