Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:46470 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbbBVOoo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:44 -0500
Received: by wevm14 with SMTP id m14so13558136wev.13
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:43 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 26/31] more: add -e posix compliance option
Date: Sun, 22 Feb 2015 14:43:22 +0000
Message-Id: <1424616207-747-27-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://pubs.opengroup.org/onlinepubs/7908799/xcu/more.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.1 | 5 +++++
 text-utils/more.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/text-utils/more.1 b/text-utils/more.1
index c289393..e9350fa 100644
--- a/text-utils/more.1
+++ b/text-utils/more.1
@@ -106,6 +106,11 @@ Start displaying each file at line
 The
 .I string
 to be searched in each file before starting to display it.
+.TP
+.B \-e
+Posix compliance.  This option makes more to exit immediately after
+writing the last line of the last file in the argument list, that is the
+default functionality so silently ignore the option.
 .SH COMMANDS
 Interactive commands for
 .B more
diff --git a/text-utils/more.c b/text-utils/more.c
index c5a41b8..7915e90 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -263,6 +263,8 @@ static void argscan(struct more_control *ctl, char *s)
 		case 'i':
 			ctl->ignore_case_opt = 1;
 			break;
+		case 'e':
+			break;
 		case '-':
 		case ' ':
 		case '\t':
-- 
2.3.0

