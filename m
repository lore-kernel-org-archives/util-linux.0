Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53077 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646Ab2ECTCE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:04 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4F7E6975D0
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:03 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 01/15] uuidd: use UUIDD_OP_GETPID instead of magic number
Date: Thu,  3 May 2012 21:01:47 +0200
Message-Id: <1336071721-32492-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Make parameters passed to call_daemon() more descriptive:
- use UUIDD_OP_GETPID instead of magic number 0
- call_daemon() takes pointer as a last argument, so pass NULL instead
  of 0

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 7c19615..80600f1 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -244,7 +244,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			fprintf(stderr, _("Failed to lock %s: %m\n"), pidfile_path);
 		exit(EXIT_FAILURE);
 	}
-	ret = call_daemon(socket_path, 0, reply_buf, sizeof(reply_buf), 0, 0);
+	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
 	if (ret > 0) {
 		if (!quiet)
 			printf(_("uuidd daemon already running at pid %s\n"),
@@ -578,7 +578,7 @@ int main(int argc, char **argv)
 	}
 
 	if (do_kill) {
-		ret = call_daemon(socket_path, 0, buf, sizeof(buf), 0, 0);
+		ret = call_daemon(socket_path, UUIDD_OP_GETPID, buf, sizeof(buf), 0, NULL);
 		if ((ret > 0) && ((do_kill = atoi((char *) buf)) > 0)) {
 			ret = kill(do_kill, SIGTERM);
 			if (ret < 0) {
-- 
1.7.7

