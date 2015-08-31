Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.windriver.com ([147.11.1.11]:55834 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbbHaIc4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 31 Aug 2015 04:32:56 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id t7V8WuMq013043
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <util-linux@vger.kernel.org>; Mon, 31 Aug 2015 01:32:56 -0700 (PDT)
From: Chen Qi <Qi.Chen@windriver.com>
To: <util-linux@vger.kernel.org>
Subject: replace siginterrupt with sigaction
Date: Mon, 31 Aug 2015 16:23:46 +0800
Message-ID: <1441009426-13799-3-git-send-email-Qi.Chen@windriver.com>
In-Reply-To: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
References: <1441009426-13799-1-git-send-email-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 login-utils/login.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index ebb76f5..38c881b 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1110,6 +1110,7 @@ int main(int argc, char **argv)
 	char *buff;
 	int childArgc = 0;
 	int retcode;
+	struct sigaction act;
 
 	char *pwdbuf = NULL;
 	struct passwd *pwd = NULL, _pwd;
@@ -1123,7 +1124,9 @@ int main(int argc, char **argv)
 	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
 
 	signal(SIGALRM, timedout);
-	siginterrupt(SIGALRM, 1);	/* we have to interrupt syscalls like ioctl() */
+	(void) sigaction(SIGALRM, NULL, &act);
+	act.sa_flags &= ~SA_RESTART;
+	sigaction(SIGALRM, &act, NULL);
 	alarm(timeout);
 	signal(SIGQUIT, SIG_IGN);
 	signal(SIGINT, SIG_IGN);
-- 
1.9.1

