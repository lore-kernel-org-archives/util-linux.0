Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f176.google.com ([74.125.82.176]:62614 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755031Ab3FBRw2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:28 -0400
Received: by mail-we0-f176.google.com with SMTP id t61so1036793wes.21
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/19] docs: add --time-format option and ISO-8601 format to manual
Date: Sun,  2 Jun 2013 18:51:22 +0100
Message-Id: <1370195485-27907-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.1 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index c060688..ce186d8 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -153,6 +153,28 @@ Wait for new messages. This feature is supported on systems with readable
 /dev/kmsg only (since kernel 3.5.0).
 .IP "\fB\-x\fR, \fB\-\-decode\fR"
 Decode facility and level (priority) number to human readable prefixes.
+.IP "\fB\-\-time\-format\fR \fIformat\fR"
+Print time stam using format
+.IR ctime ,
+.IR delta ,
+.I reltime
+or
+.IR iso .
+The three first time formats are aliases of time format specific options.
+The
+.I iso
+is a
+.B dmesg
+implementation of ISO-8601 timestamp format.  Purpose of this format is
+to make comparing of timestamps in between two system, and other parsing,
+easy.  The defition of timestamp is YYYY-MM-DD<T stands for date and time
+separator>HH:MM:SS,<microseconds><-+><GMT-0 timezone offset>.
+.IP
+The
+.I iso
+time format has the same issue as
+.IR ctime ,
+the time may be inaccurate if a system is suspended and resumed.
 .SH SEE ALSO
 .BR syslogd (8)
 .SH AUTHORS
-- 
1.8.3

