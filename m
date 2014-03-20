Return-Path: linux-kernel-owner@vger.kernel.org
Subject: [PATCH 24/33] Handling SIG TERM of the child
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
Date: Thu, 20 Mar 2014 15:12:16 +0530
Message-ID: <20140320094216.14878.32708.stgit@localhost.localdomain>
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We handle SIGTERM on the child, by sending a message to the client and then
closing the socket opened for that connection.

Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
---
 src/coredump.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/src/coredump.c b/src/coredump.c
index c0da457..ab120b9 100755
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -501,6 +501,18 @@ int dump_task(struct ucred *client_info, char *core_file)
 	return 0;
 }
 
+/* Handles signals to the child */
+void sig_handler_service_proc(int sig)
+{
+	if (sig != SIGPIPE)
+		send_reply(EINTR);
+	close(new_sock);
+
+	gencore_log("[%d]: Cleanup done and child exiting.\n", pid_log);
+
+	fflush(fp_log);
+}
+
 /* Services requests */
 int service_request(void)
 {
@@ -508,6 +520,11 @@ int service_request(void)
 	char core_file[CORE_FILE_NAME_SZ];
 	struct ucred client_info;
 
+	/* Handles stopping of the servicing process */
+	signal(SIGTERM, sig_handler_service_proc);
+	signal(SIGSEGV, sig_handler_service_proc);
+	signal(SIGPIPE, sig_handler_service_proc);
+
 	/* Receive the message */
 	ret = receive_core_filename(core_file);
 	if (ret)

