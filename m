Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53092 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755703Ab2ECTCK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:10 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 1B313979ED
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:10 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 10/15] uuidd: do not drop privileges
Date: Thu,  3 May 2012 21:01:56 +0200
Message-Id: <1336071721-32492-11-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libuuid can (for now) spawn uuidd on-demand. To support this scenario,
uuidd should be installed setuid/setgid to have access to
/var/lib/libuuid/clock.txt. Therefore, dropping the privileges is
not functional, so removing this ability.

Moreover, the ability to spawn uuidd on-demand will be removed anyway.

References: http://www.spinics.net/lists/util-linux-ng/msg05934.html

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   32 +-------------------------------
 1 files changed, 1 insertions(+), 31 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index fafc8d1..684e494 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -503,11 +503,9 @@ int main(int argc, char **argv)
 	char		buf[1024], *cp;
 	char		str[UUID_STR_LEN], *tmp;
 	uuid_t		uu;
-	uid_t		uid;
-	gid_t		gid;
 	int		i, c, ret;
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
-	int		timeout = 0, quiet = 0, drop_privs = 0;
+	int		timeout = 0, quiet = 0;
 	int		no_pid = 0, no_fork = 0;
 	int		no_sock = 0, s_flag = 0;
 
@@ -540,11 +538,9 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'd':
 			debug++;
-			drop_privs = 1;
 			break;
 		case 'k':
 			do_kill++;
-			drop_privs = 1;
 			break;
 		case 'n':
 			num = strtol(optarg, &tmp, 0);
@@ -555,20 +551,16 @@ int main(int argc, char **argv)
 			break;
 		case 'p':
 			pidfile_path_param = optarg;
-			drop_privs = 1;
 			break;
 		case 'P':
 			no_pid = 1;
-			drop_privs = 1;
 			break;
 		case 'F':
 			no_fork = 1;
-			drop_privs = 1;
 			break;
 		case 'S':
 #ifdef USE_SOCKET_ACTIVATION
 			no_sock = 1;
-			drop_privs = 1;
 			no_fork = 1;
 			no_pid = 1;
 #else
@@ -582,16 +574,13 @@ int main(int argc, char **argv)
 			break;
 		case 'r':
 			do_type = UUIDD_OP_RANDOM_UUID;
-			drop_privs = 1;
 			break;
 		case 's':
 			socket_path = optarg;
 			s_flag = 1;
-			drop_privs = 1;
 			break;
 		case 't':
 			do_type = UUIDD_OP_TIME_UUID;
-			drop_privs = 1;
 			break;
 		case 'T':
 			timeout = strtol(optarg, &tmp, 0);
@@ -626,25 +615,6 @@ int main(int argc, char **argv)
 		fprintf(stderr, _("Both --socket-activation and --socket specified. "
 				  "Ignoring --socket\n"));
 
-	uid = getuid();
-	if (uid && drop_privs) {
-		gid = getgid();
-#ifdef HAVE_SETRESGID
-		if (setresgid(gid, gid, gid) < 0)
-			err(EXIT_FAILURE, "setresgid");
-#else
-		if (setregid(gid, gid) < 0)
-			err(EXIT_FAILURE, "setregid");
-#endif
-
-#ifdef HAVE_SETRESUID
-		if (setresuid(uid, uid, uid) < 0)
-			err(EXIT_FAILURE, "setresuid");
-#else
-		if (setreuid(uid, uid) < 0)
-			err(EXIT_FAILURE, "setreuid");
-#endif
-	}
 	if (num && do_type) {
 		ret = call_daemon(socket_path, do_type + 2, buf,
 				  sizeof(buf), &num, &err_context);
-- 
1.7.7

