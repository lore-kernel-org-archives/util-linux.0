Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:42969 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855AbaLHWVB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Dec 2014 17:21:01 -0500
Received: by mail-wg0-f46.google.com with SMTP id x13so4869591wgg.33
        for <util-linux@vger.kernel.org>; Mon, 08 Dec 2014 14:21:00 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] lslogins: align usage() and manual with struct option longopts
Date: Mon,  8 Dec 2014 22:20:56 +0000
Message-Id: <1418077256-24258-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418077256-24258-1-git-send-email-kerolasa@iki.fi>
References: <1418077256-24258-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Short option -G goes together with long option --supp-groups, while
neither of -m or --groups-info has worked in a release so remove them
from usage() and manual.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.1 | 5 +----
 login-utils/lslogins.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 0a9e703..0dbeebd 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -31,7 +31,7 @@ Output data in the format of NAME=VALUE.
 \fB\-f\fR, \fB\-\-failed\fR
 Display data about the users' last failed login attempts.
 .TP
-\fB\-G\fR, \fB\-\-groups\-info\fR
+\fB\-G\fR, \fB\-\-supp\-groups\fR
 Show information about groups.
 .TP
 \fB\-g\fR, \fB\-\-groups\fR=\fIgroups\fR
@@ -48,9 +48,6 @@ Display data containing information about the users' last login sessions.
 Only show data of users with a login specified in \fIlogins\fR (user names or user
 IDS).  More than one login may be specified; the list has to be comma-separated.
 .TP
-\fB\-m\fR, \fB\-\-supp\-groups\fR
-Show supplementary groups.
-.TP
 \fB\-n\fR, \fB\-\-newline\fR
 Display each piece of information on a separate line.
 .TP
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 38d3cf6..abce949 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -1189,11 +1189,10 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -c, --colon-separate     display data in a format similar to /etc/passwd\n"), out);
 	fputs(_(" -e, --export             display in an export-able output format\n"), out);
 	fputs(_(" -f, --failed             display data about the users' last failed logins\n"), out);
-	fputs(_(" -G, --groups-info        display information about groups\n"), out);
+	fputs(_(" -G, --supp-groups        display information about groups\n"), out);
 	fputs(_(" -g, --groups=<groups>    display users belonging to a group in <groups>\n"), out);
 	fputs(_(" -L, --last               show info about the users' last login sessions\n"), out);
 	fputs(_(" -l, --logins=<logins>    display only users from <logins>\n"), out);
-	fputs(_(" -m, --supp-groups        display supplementary groups as well\n"), out);
 	fputs(_(" -n, --newline            display each piece of information on a new line\n"), out);
 	fputs(_("     --noheadings         don't print headings\n"), out);
 	fputs(_("     --notruncate         don't truncate output\n"), out);
-- 
2.1.3

