Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50629 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759115Ab2C2Qpr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:47 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B5E6A8FB75
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:46 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 15/20] libuuid: implement --disable-libuuid-exec-uuidd configure option
Date: Thu, 29 Mar 2012 18:45:23 +0200
Message-Id: <1333039528-24784-16-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This option prevents libuuid from attempting to spawn uuidd. This
is intended to be used in conjunction with socket-activated uuidd.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 configure.ac           |   12 ++++++++++++
 libuuid/src/gen_uuid.c |    9 +++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8f89639..05e024a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1123,6 +1123,18 @@ fi
 AM_CONDITIONAL(WITH_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != "xno" ])
 
 
+AC_ARG_ENABLE([libuuid-exec-uuidd],
+  AS_HELP_STRING([--disable-libuuid-exec-uuidd], [disable spawning of uuidd from libuuid library]),
+  [], enable_libuuid_exec_uuidd=yes
+)
+
+AM_CONDITIONAL(LIBUUID_EXEC_UUIDD, test "x$enable_libuuid_exec_uuidd" = xyes)
+
+if test "x$enable_libuuid_exec_uuidd" = xyes; then
+  AC_DEFINE(LIBUUID_EXEC_UUIDD, 1, [Should libuuid attempt to exec uuidd daemon?])
+fi
+
+
 AC_ARG_ENABLE([login-stat-mail],
   AS_HELP_STRING([--enable-login-stat-mail], [let login stat() the mailbox]),
   [], enable_login_stat_mail=no
diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index 29211b9..0a75137 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -452,6 +452,7 @@ static ssize_t read_all(int fd, char *buf, size_t count)
 	return c;
 }
 
+#ifdef LIBUUID_EXEC_UUIDD
 /*
  * Close all file descriptors
  */
@@ -478,6 +479,7 @@ static void close_all_fds(void)
 			open("/dev/null", O_RDWR);
 	}
 }
+#endif
 
 /*
  * Try using the uuidd daemon to generate the UUID
@@ -495,8 +497,10 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 	struct stat st;
 	pid_t pid;
 	static const char *uuidd_path = UUIDD_PATH;
+#ifdef LIBUUID_EXEC_UUIDD
 	static int access_ret = -2;
 	static int start_attempts = 0;
+#endif
 
 	if ((s = socket(AF_UNIX, SOCK_STREAM, 0)) < 0)
 		return -1;
@@ -506,6 +510,7 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 
 	if (connect(s, (const struct sockaddr *) &srv_addr,
 		    sizeof(struct sockaddr_un)) < 0) {
+#ifdef LIBUUID_EXEC_UUIDD
 		if (access_ret == -2)
 			access_ret = access(uuidd_path, X_OK);
 		if (access_ret == 0)
@@ -525,7 +530,11 @@ static int get_uuid_via_daemon(int op, uuid_t out, int *num)
 				goto fail;
 		} else
 			goto fail;
+#else
+		goto fail;
+#endif
 	}
+
 	op_buf[0] = op;
 	op_len = 1;
 	if (op == UUIDD_OP_BULK_TIME_UUID) {
-- 
1.7.7

