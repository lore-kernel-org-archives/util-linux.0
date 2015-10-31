Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33139 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbbJaM2F (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 08:28:05 -0400
Received: by wmeg8 with SMTP id g8so28646014wme.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 05:28:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] logger: shadow declaration
Date: Sat, 31 Oct 2015 12:27:36 +0000
Message-Id: <1446294456-1846-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/logger.c:448:17: warning: declaration of 'msg' shadows a
				parameter [-Wshadow]
misc-utils/logger.c:429:74: note: shadowed declaration is here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index eda160a..e439266 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -445,7 +445,7 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 	iovec_add_string(iov, iovlen, msg, 0);
 
 	if (!ctl->noact) {
-		struct msghdr msg = { 0 };
+		struct msghdr message = { 0 };
 		struct cmsghdr *cmhp;
 		struct ucred *cred;
 		union {
@@ -457,8 +457,8 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 		if ((ctl->socket_type == TYPE_TCP) && !ctl->octet_count)
 			iovec_add_string(iov, iovlen, "\n", 1);
 
-		msg.msg_iov = iov;
-		msg.msg_iovlen = iovlen;
+		message.msg_iov = iov;
+		message.msg_iovlen = iovlen;
 
 		/* syslog/journald may follow local socket credentials rather
 		 * than in the message PID. If we use --id as root than we can
@@ -468,10 +468,10 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 		if (ctl->pid && !ctl->server && ctl->pid != getpid()
 		    && geteuid() == 0 && kill(ctl->pid, 0) == 0) {
 
-			msg.msg_control = cbuf.control;
-			msg.msg_controllen = CMSG_SPACE(sizeof(struct ucred));
+			message.msg_control = cbuf.control;
+			message.msg_controllen = CMSG_SPACE(sizeof(struct ucred));
 
-			cmhp = CMSG_FIRSTHDR(&msg);
+			cmhp = CMSG_FIRSTHDR(&message);
 			cmhp->cmsg_len = CMSG_LEN(sizeof(struct ucred));
 			cmhp->cmsg_level = SOL_SOCKET;
 			cmhp->cmsg_type = SCM_CREDENTIALS;
@@ -480,7 +480,7 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 			cred->pid = ctl->pid;
 		}
 
-		if (sendmsg(ctl->fd, &msg, 0) < 0)
+		if (sendmsg(ctl->fd, &message, 0) < 0)
 			warn(_("send message failed"));
 	}
 
-- 
2.6.2

