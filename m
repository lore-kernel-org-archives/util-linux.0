Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f50.google.com ([209.85.219.50]:50984 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUai (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:38 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so6348247oag.9
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/10] kill: leeway deprecation of --pid invocation as command name
Date: Sun,  9 Mar 2014 15:30:19 -0500
Message-Id: <1394397023-7050-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Who knows if anyone is linking or copying kill to a file name 'pid' and
using --pid option functionality that way, so lets inform these users and
get rid of command name hack after few releases.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.1 | 5 +++++
 misc-utils/kill.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index 50f5cd2..e6c4000 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -88,6 +88,11 @@ Specify that
 .B kill
 should only print the process id (pid) of the named processes, and not send any
 signals.
+.IP
+The \-\-pid option functionality is enabled when the command
+copied or linked to name
+.BR pid .
+This functionality will be deprecated in future.
 .TP
 \fB\-q\fR, \fB\-\-queue\fR \fIsigval\fR
 Use
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 2fecda3..11c8cd2 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -170,6 +170,8 @@ int main(int argc, char **argv)
 
 	numsig = SIGTERM;
 	do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
+	if (do_pid)
+		warnx(_("use of 'kill --pid' option as command name will be deprecated in future"));
 	do_kill = 0;
 	check_all = 0;
 	/* Loop through the arguments.  Actually, -a is the only option
-- 
1.9.0

