Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f173.google.com ([74.125.82.173]:50892 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbaHJL4i (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Aug 2014 07:56:38 -0400
Received: by mail-we0-f173.google.com with SMTP id q58so7516697wes.18
        for <util-linux@vger.kernel.org>; Sun, 10 Aug 2014 04:56:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/5] docs: mentintion default udp and tcp ports logger is using
Date: Sun, 10 Aug 2014 12:56:11 +0100
Message-Id: <1407671771-29745-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
References: <1407671771-29745-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The fact that 'syslog tcp/514' does not exist in RFS's, which has lead
to 'syslog-conn 601/tcp' be used in place could be a suprice and should
be told in manual.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 1a366db..887fff2 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -77,6 +77,13 @@ but if thist fails a TCP connection is attempted.
 \fB\-P\fR, \fB\-\-port\fR \fIport\fR
 Use the specified
 .IR port .
+When
+.I port
+is not specified it defaults to
+.I syslog
+for udp and
+.I syslog-conn
+for tcp connections.
 .TP
 \fB\-f\fR, \fB\-\-file\fR \fIfile\fR
 Log the contents of the specified
-- 
2.0.4

