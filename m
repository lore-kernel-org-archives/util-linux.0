Return-Path: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 23/33] Handling SIG TERM of the daemon
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
Date: Thu, 20 Mar 2014 15:12:10 +0530
Message-ID: <20140320094210.14878.75209.stgit@localhost.localdomain>
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We handle SIGTERM on the daemon, by closing the socket opened for that
connection.

Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
---
 src/coredump.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/coredump.c b/src/coredump.c
index 72ba8d8..c0da457 100755
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -562,6 +562,17 @@ int handle_request(void)
 	return 0;
 }
 
+/* Handles Signals to the Daemon */
+void sig_daemon_handler(int sig)
+{
+	close(socket_fd);
+	unlink(SOCKET_PATH);
+
+	gencore_log("[%d]: Cleanup done and daemon exiting.\n", pid_log);
+
+	fclose(fp_log);
+}
+
 /* Daemon for self dump */
 int daemon_dump(void)
 {
@@ -602,6 +613,11 @@ int daemon_dump(void)
 	/* SIGCHILD - Signal handler */
 	signal(SIGCHLD, sigchild_handler);
 
+	/* Terminate Daemon - signal handler */
+	signal(SIGTERM, sig_daemon_handler);
+	signal(SIGSEGV, sig_daemon_handler);
+	signal(SIGPIPE, sig_daemon_handler);
+
 	while (1) {
 
 		/* Blocks on request */

