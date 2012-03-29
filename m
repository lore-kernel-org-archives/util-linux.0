Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50612 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759570Ab2C2Qpn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:43 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3F7EC90B1D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:42 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/20] uuidd: make drop_privs true by default in main()
Date: Thu, 29 Mar 2012 18:45:18 +0200
Message-Id: <1333039528-24784-11-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The drop_privs variable in main() was used to determine whether the
daemon will attempt to drop privileges (provided it has been installed
suid). As of now, it makes sense to drop the privileges each time it is
started. Therefore, this patch inverts the default value of drop_privs
to true, so that it does not need to be set in the getopt loop at
multiple places.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 10c3019..4b04390 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -530,9 +530,10 @@ int main(int argc, char **argv)
 	uid_t		uid;
 	int		i, c, ret;
 	int		debug = 0, do_type = 0, do_kill = 0, num = 0;
-	int		timeout = 0, quiet = 0, drop_privs = 0;
+	int		timeout = 0, quiet = 0;
 	int		no_pid = 0, no_fork = 0;
 	int		no_sock = 0, s_flag = 0;
+	int 		drop_privs = 1;
 
 	static const struct option longopts[] = {
 		{"pid", required_argument, NULL, 'p'},
@@ -562,11 +563,9 @@ int main(int argc, char **argv)
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
@@ -577,20 +576,16 @@ int main(int argc, char **argv)
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
 #ifdef UUIDD_SOCKET_ACTIVATION
 			no_sock = 1;
-			drop_privs = 1;
 			no_fork = 1;
 			no_pid = 1;
 #else
@@ -605,16 +600,13 @@ int main(int argc, char **argv)
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
-- 
1.7.7

