Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:45602 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940AbaHXQFs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Aug 2014 12:05:48 -0400
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id 7EA5A140EF
	for <util-linux@vger.kernel.org>; Sun, 24 Aug 2014 18:05:17 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 4/4] kFreeBSD: add hacks in ipcrm to avoid FTBFS
Date: Sun, 24 Aug 2014 18:04:44 +0200
Message-Id: <1408896284-14467-5-git-send-email-andreas@fatal.se>
In-Reply-To: <1408896284-14467-1-git-send-email-andreas@fatal.se>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 sys-utils/ipcrm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index aa58172..6443f48 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -271,6 +271,13 @@ static int remove_all(type_id type)
 			ret |= remove_id(SEM, 0, rm_me);
 		}
 	}
+/* kFreeBSD hackery -- ah 20140723 */
+#ifndef MSG_STAT
+#define MSG_STAT 11
+#endif
+#ifndef MSG_INFO
+#define MSG_INFO 12
+#endif
 	if (type == MSG || type == ALL) {
 		maxid =
 		    msgctl(0, MSG_INFO, (struct msqid_ds *)(void *)&msginfo);
-- 
2.1.0.rc1

