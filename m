Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:56193 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3DMTzY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:24 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2950913wey.28
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/33] setpriv: allow login and group name option arguments
Date: Sat, 13 Apr 2013 20:54:34 +0100
Message-Id: <1365882901-11429-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For an average user names are easier to use than uid and gid numbers.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setpriv.1 |  6 ++++--
 sys-utils/setpriv.c | 42 ++++++++++++++++++++++++++++++------------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index c56d89f..c05473c 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -55,7 +55,8 @@ inheritable set, you are likely to become confused.  Do not do that.
 Lists all known capabilities.  Must be specified alone.
 .TP
 \fB\-\-ruid\fR \fIuid\fR, \fB\-\-euid\fR \fIuid\fR, \fB\-\-reuid\fR \fIuid\fR
-Sets the real, effective, or both \fIuid\fRs.
+Sets the real, effective, or both \fIuid\fRs.  The uid argument can be
+given as textual login name.
 .IP
 Setting
 .I uid
@@ -68,7 +69,8 @@ something like:
 \-\-reuid=1000 \-\-\:regid=1000 \-\-\:caps=\-\:all
 .TP
 \fB\-\-rgid\fR \fIgid\fR, \fB\-\-egid\fR \fIgid\fR, \fB\-\-regid\fR \fIgid\fR
-Sets the real, effective, or both \fIgid\fRs.
+Sets the real, effective, or both \fIgid\fRs.  The gid argument can be
+given as textual group name.
 .IP
 For safety, you must specify one of \-\-\:keep\-\:groups,
 \-\-\:clear\-\:groups, or \-\-\:groups if you set any primary
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index a547fd7..7fa5f82 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -23,10 +23,12 @@
 #include <getopt.h>
 #include <grp.h>
 #include <linux/securebits.h>
+#include <pwd.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/prctl.h>
+#include <sys/types.h>
 #include <unistd.h>
 
 #include "c.h"
@@ -545,6 +547,28 @@ static void do_apparmor_profile(const char *label)
 		    _("write failed: %s"), _PATH_PROC_ATTR_EXEC);
 }
 
+static uid_t get_user(const char *s, const char *err)
+{
+	struct passwd *pw;
+	long tmp;
+	pw = getpwnam(s);
+	if (pw)
+		return pw->pw_uid;
+	tmp = strtol_or_err(s, err);
+	return tmp;
+}
+
+static gid_t get_group(const char *s, const char *err)
+{
+	struct group *gr;
+	long tmp;
+	gr = getgrnam(s);
+	if (gr)
+		return gr->gr_gid;
+	tmp = strtol_or_err(s, err);
+	return tmp;
+}
+
 int main(int argc, char **argv)
 {
 	enum {
@@ -627,43 +651,37 @@ int main(int argc, char **argv)
 			if (opts.have_ruid)
 				errx(EXIT_FAILURE, _("duplicate ruid"));
 			opts.have_ruid = 1;
-			opts.ruid = strtol_or_err(optarg,
-						  _("failed to parse ruid"));
+			opts.ruid = get_user(optarg, _("failed to parse ruid"));
 			break;
 		case EUID:
 			if (opts.have_euid)
 				errx(EXIT_FAILURE, _("duplicate euid"));
 			opts.have_euid = 1;
-			opts.euid = strtol_or_err(optarg,
-						  _("failed to parse euid"));
+			opts.euid = get_user(optarg, _("failed to parse euid"));
 			break;
 		case REUID:
 			if (opts.have_ruid || opts.have_euid)
 				errx(EXIT_FAILURE, _("duplicate ruid or euid"));
 			opts.have_ruid = opts.have_euid = 1;
-			opts.ruid = opts.euid = strtol_or_err(optarg,
-							      _("failed to parse reuid"));
+			opts.ruid = opts.euid = get_user(optarg, _("failed to parse reuid"));
 			break;
 		case RGID:
 			if (opts.have_rgid)
 				errx(EXIT_FAILURE, _("duplicate rgid"));
 			opts.have_rgid = 1;
-			opts.rgid = strtol_or_err(optarg,
-						  _("failed to parse rgid"));
+			opts.rgid = get_group(optarg, _("failed to parse rgid"));
 			break;
 		case EGID:
 			if (opts.have_egid)
 				errx(EXIT_FAILURE, _("duplicate egid"));
 			opts.have_egid = 1;
-			opts.egid = strtol_or_err(optarg,
-						  _("failed to parse egid"));
+			opts.egid = get_group(optarg, _("failed to parse egid"));
 			break;
 		case REGID:
 			if (opts.have_rgid || opts.have_egid)
 				errx(EXIT_FAILURE, _("duplicate rgid or egid"));
 			opts.have_rgid = opts.have_egid = 1;
-			opts.rgid = opts.egid = strtol_or_err(optarg,
-							      _("failed to parse regid"));
+			opts.rgid = opts.egid = get_group(optarg, _("failed to parse regid"));
 			break;
 		case CLEAR_GROUPS:
 			if (opts.clear_groups)
-- 
1.8.2.1

