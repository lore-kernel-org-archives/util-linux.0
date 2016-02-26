Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62766 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0M0LtB-1ZeZj63Ju9-00ubji for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:33 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/14] logger: use SCM_CREDENTIALS on LINUX only
Date: Fri, 26 Feb 2016 04:03:24 +0100
Message-Id: <1456455812-19453-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is a build fix of FreeBSD and OSX. Basically we revert
the following commit for non-linux systems:
27a9eb53 "use --id as local socket credentials"

Note I could also compile it like this:

  #ifdef HAVE_SYS_UCRED_H
  # define _WANT_UCRED
  # include <sys/param.h>
  # include <sys/ucred.h>
  # define SCM_CREDENTIALS SCM_CREDS
  #endif

  [...]
  #ifdef _linux_
  cred->pid = ctl->pid;
  #endif
  [...]

... but don't know how to test whether it does what it
should.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/logger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 4201e43..d9aee0e 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -446,12 +446,14 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 
 	if (!ctl->noact) {
 		struct msghdr message = { 0 };
+#ifdef SCM_CREDENTIALS
 		struct cmsghdr *cmhp;
 		struct ucred *cred;
 		union {
 			struct cmsghdr cmh;
 			char   control[CMSG_SPACE(sizeof(struct ucred))];
 		} cbuf;
+#endif
 
 		/* 4) add extra \n to make sure message is terminated */
 		if ((ctl->socket_type == TYPE_TCP) && !ctl->octet_count)
@@ -460,6 +462,7 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 		message.msg_iov = iov;
 		message.msg_iovlen = iovlen;
 
+#ifdef SCM_CREDENTIALS
 		/* syslog/journald may follow local socket credentials rather
 		 * than in the message PID. If we use --id as root than we can
 		 * force kernel to accept another valid PID than the real logger(1)
@@ -479,6 +482,7 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 
 			cred->pid = ctl->pid;
 		}
+#endif
 
 		if (sendmsg(ctl->fd, &message, 0) < 0)
 			warn(_("send message failed"));
-- 
1.8.4.5

