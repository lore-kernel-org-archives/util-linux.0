Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:46196 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbCEVMN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Mar 2015 16:12:13 -0500
Received: by wggy19 with SMTP id y19so56010955wgg.13
        for <util-linux@vger.kernel.org>; Thu, 05 Mar 2015 13:12:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Rainer Gerhards <rgerhards@adiscon.com>
Subject: [PATCH] logger: make unix socket logging to use syslog_local format by default
Date: Thu,  5 Mar 2015 21:12:00 +0000
Message-Id: <1425589920-850-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The message format when writing to local sockets were inconsistent since
commit 4de2e8a, for example:

$ ./logger --stderr test
<5>Mär  4 11:03:30 logger: test

$ ./logger --socket /dev/log --stderr test
<5>1 2015-03-04T11:03:31.699841+0100 ubuntu1404esp rger - [timeQuality ...

This change makes the --socket  format to default use the same format as
the first message, as what used to be the case earlier.  Notice that
full-blown RFC format on the log socket causes problems with receivers
who do not expect such format, like rsyslog.

Addresses: https://github.com/karelzak/util-linux/issues/157
Reported-by: Rainer Gerhards <rgerhards@adiscon.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 1e7e2dc..04d2453 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -484,7 +484,7 @@ static void logger_open(struct logger_ctl *ctl)
 	if (ctl->unix_socket) {
 		ctl->fd = unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
 		if (!ctl->syslogfp)
-			ctl->syslogfp = syslog_rfc5424;
+			ctl->syslogfp = syslog_local;
 		return;
 	}
 	ctl->fd = unix_socket(ctl, _PATH_DEVLOG, ctl->socket_type);
-- 
2.3.1

