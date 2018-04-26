Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46800 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756148AbeDZUoN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 26 Apr 2018 16:44:13 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1-v6so58016976wrj.13
        for <util-linux@vger.kernel.org>; Thu, 26 Apr 2018 13:44:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] dmesg: link together with syslog(2) manual page
Date: Thu, 26 Apr 2018 21:44:08 +0100
Message-Id: <20180426204408.3591-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The dmesg may require capabilities(7) when /proc/sys/kernel/dmesg_restrict
has none zero value.  This is explained in detail in syslog(2) manual page.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.1 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 1dc9994ec..2b61c3739 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -228,7 +228,13 @@ The text of the message with the warning log priority.
 .TP
 .B segfault
 The text of the message that inform about segmentation fault.
-
+.SH EXIT STATUS
+.B dmesg
+can fail reporting permission denied error.  This is usually caused by
+.B dmesg_restrict
+kernel setting, please see
+.BR syslog (2)
+for more details.
 .SH SEE ALSO
 .BR terminal-colors.d (5),
 .BR syslogd (8)
-- 
2.17.0

