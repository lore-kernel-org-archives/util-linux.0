Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755690AbcLAIwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:17 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MaV3V-1cRR8o0xI1-00KAjJ for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:15 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/11] utmpdump: code formatting for readability
Date: Thu,  1 Dec 2016 09:52:07 +0100
Message-Id: <1480582332-17407-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

BTW avoid using the defined sizes.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/utmpdump.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 8f438b0..4a85afa 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -112,10 +112,12 @@ static void print_utline(struct utmp *ut, FILE *out)
 	cleanse(ut->ut_line);
 	cleanse(ut->ut_host);
 
-	/*            pid    id       user     line     host     addr       time */
+	/*            type pid    id       user     line     host     addr    time */
 	fprintf(out, "[%d] [%05d] [%-4.4s] [%-*.*s] [%-*.*s] [%-*.*s] [%-15s] [%s]\n",
-	       ut->ut_type, ut->ut_pid, ut->ut_id, 8, UT_NAMESIZE, ut->ut_user,
-	       12, UT_LINESIZE, ut->ut_line, 20, UT_HOSTSIZE, ut->ut_host,
+	       ut->ut_type, ut->ut_pid, ut->ut_id,
+	       8, (int)sizeof(ut->ut_user), ut->ut_user,
+	       12, (int)sizeof(ut->ut_line), ut->ut_line,
+	       20, (int)sizeof(ut->ut_host), ut->ut_host,
 	       addr_string, time_string);
 }
 
-- 
1.8.5.6

