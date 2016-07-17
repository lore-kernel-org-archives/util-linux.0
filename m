Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35672 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751767AbcGQNAj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so8763850wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/13] dmesg: drop core at impossible case in read_buffer() [oclint]
Date: Sun, 17 Jul 2016 14:00:11 +0100
Message-Id: <20160717130015.31760-10-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 4544388..92de6e2 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -591,6 +591,8 @@ static ssize_t read_buffer(struct dmesg_control *ctl, char **buf)
 		if (n == 0 && ctl->action == SYSLOG_ACTION_READ_CLEAR)
 			n = klogctl(SYSLOG_ACTION_CLEAR, NULL, 0);
 		break;
+	default:
+		abort();	/* impossible method -> drop core */
 	}
 
 	return n;
-- 
2.9.0

