Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:18293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755894Ab2J2WdE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Oct 2012 18:33:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9TMX4jS023029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Mon, 29 Oct 2012 18:33:04 -0400
Received: from alice.com (ovpn-113-125.phx2.redhat.com [10.3.113.125])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q9TMX31q000860
	for <util-linux@vger.kernel.org>; Mon, 29 Oct 2012 18:33:03 -0400
From: Michal Schmidt <mschmidt@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] agetty: fix autodetection for TERM
Date: Mon, 29 Oct 2012 23:33:01 +0100
Message-Id: <1351549981-32412-1-git-send-email-mschmidt@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

open_tty() autodetects whether to set TERM to "linux" or "vt102", but it
can apply the result only if op->term is still NULL.
---
 term-utils/agetty.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index e53a701..2480f7d 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -283,7 +283,6 @@ int main(int argc, char **argv)
 		.flags  =  F_ISSUE,		/* show /etc/issue (SYSV_STYLE) */
 		.login  =  _PATH_LOGIN,		/* default login program */
 		.tty    = "tty1",		/* default tty line */
-		.term   =  DEFAULT_VCTERM,	/* terminal type */
 		.issue  =  ISSUE		/* default issue file */
 	};
 	char *login_argv[LOGIN_ARGV_MAX + 1];
-- 
1.7.11.7

