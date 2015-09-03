Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45946 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbbICLlU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 Sep 2015 07:41:20 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 8909C8E3E5
	for <util-linux@vger.kernel.org>; Thu,  3 Sep 2015 11:41:20 +0000 (UTC)
Received: from hp.brq.redhat.com (dhcp-27-139.brq.redhat.com [10.34.27.139])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t83BfJlb016424
	for <util-linux@vger.kernel.org>; Thu, 3 Sep 2015 07:41:20 -0400
From: Michal Schmidt <mschmidt@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] logger man page: improve logger --journald example
Date: Thu,  3 Sep 2015 13:41:19 +0200
Message-Id: <1441280479-7251-1-git-send-email-mschmidt@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The example use of logger --journald in the man page has a couple of flaws:
 - It's missing a "MESSAGE=" field. This is supposed to be the primary
   human readable text. Without it the log entry is invisible in a
   plain "journalctl" output.
 - The MESSAGE_ID is supposed to be a 128-bit hexadecimal string that
   globally uniquely identifies the message type.
   One can generate such an id with "journalctl --new-id".

This patches fixes the above and also changes the example to use a
here-document instead of printf. In my opinion it makes the expected
multi-line data format more obvious.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 misc-utils/logger.1 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 36c923d52c..5deb3f0a1f 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -81,7 +81,13 @@ for details.  The use of a MESSAGE_ID field is generally a good idea, as it
 makes finding entries easy.  Examples:
 .IP
 .nf
-\fB    printf \(dq%s\\n%s\\n%s\\n\(dq MESSAGE_ID=42 DOGS=bark \(dqCARAVAN=goes on\(dq | logger --journald
+\fB    logger --journald <<end
+\fB    MESSAGE_ID=67feb6ffbaf24c5cbec13c008dd72309
+\fB    MESSAGE=The dogs bark, but the caravan goes on.
+\fB    DOGS=bark
+\fB    CARAVAN=goes on
+\fB    end
+.IP
 \fB    logger --journald=entry.txt
 .fi
 .IP
-- 
2.4.3

