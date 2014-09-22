Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:63009 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752887AbaIVUVL (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:21:11 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/10] textual: angular brackets around a non-literal argument, singular
Date: Mon, 22 Sep 2014 22:15:39 +0200
Message-Id: <1411416940-3249-9-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/nsenter.c |    2 +-
 sys-utils/setpriv.c |    5 ++++-
 sys-utils/unshare.c |    4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index 87c6549..7da44e7 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -62,7 +62,7 @@ static void usage(int status)
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
 
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] <program> [args...]\n"),
+	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
 		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index ccfa993..06d9fe4 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -90,7 +90,9 @@ struct privctx {
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] <program> [args...]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
+		program_invocation_short_name);
+
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -d, --dump               show current state (and do not exec anything)\n"), out);
 	fputs(_(" --nnp, --no-new-privs    disallow granting new privileges\n"), out);
@@ -108,6 +110,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" --securebits <bits>      set securebits\n"), out);
 	fputs(_(" --selinux-label <label>  set SELinux label\n"), out);
 	fputs(_(" --apparmor-profile <pr>  set AppArmor profile\n"), out);
+
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 95e4afb..933f621 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -60,8 +60,8 @@ static void usage(int status)
 	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
 
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options] <program> [args...]\n"),	program_invocation_short_name);
+	fprintf(out, _(" %s [options] <program> [<argument>...]\n"),
+		program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -m, --mount               unshare mounts namespace\n"), out);
-- 
1.7.0.4

