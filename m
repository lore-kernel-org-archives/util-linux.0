Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:55402 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438AbaCTJls (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 20 Mar 2014 05:41:48 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <jananive@linux.vnet.ibm.com>;
	Thu, 20 Mar 2014 15:11:46 +0530
Subject: [PATCH 19/33] Block till request
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
Date: Thu, 20 Mar 2014 15:11:38 +0530
Message-ID: <20140320094138.14878.13459.stgit@localhost.localdomain>
In-Reply-To: <20140320093040.14878.903.stgit@localhost.localdomain>
References: <20140320093040.14878.903.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Block until input arrives on the socket.

Signed-off-by: Janani Venkataraman <jananive@linux.vnet.ibm.com>
---
 src/coredump.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/src/coredump.c b/src/coredump.c
index c992c66..d93f4b2 100644
--- a/src/coredump.c
+++ b/src/coredump.c
@@ -349,6 +349,38 @@ int setup_server(void)
 	return 0;
 }
 
+/* Blocking on a request */
+int block_on_request(void)
+{
+	fd_set read;
+
+	do {
+		/* Initialise */
+		FD_ZERO(&read);
+		FD_SET(socket_fd, &read);
+
+		gencore_log("[%d]: Waiting on incoming request.\n", pid_log);
+
+		if (select(socket_fd + 1, &read, NULL, NULL, NULL) <= 0) {
+			/*
+			 * EINTR just means a signal is caught and hence, we need not
+			 * terminate for this error.
+			 */
+			if (errno != EINTR) {
+				gencore_log("[%d]: Error while waiting for connection requests.\n",
+						pid_log, strerror(errno));
+				close(socket_fd);
+				return -1;
+			}
+		}
+
+	} while(FD_ISSET(socket_fd, &read) == 0);
+
+	gencore_log("[%d]: Request found.\n", pid_log);
+
+	return 0;
+}
+
 /* Daemon for self dump */
 int daemon_dump(void)
 {
@@ -386,6 +418,19 @@ int daemon_dump(void)
 	/* Flush the log */
 	fflush(fp_log);
 
+	while (1) {
+
+		/* Blocks on request */
+		ret = block_on_request();
+		if (ret)
+			goto cleanup;
+
+		/* Flush the log */
+		fflush(fp_log);
+	}
+
+	return 0;
+
 cleanup:
 
 	fclose(fp_log);

