Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52632 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751994AbdF1QlB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 12:41:01 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MK3bN-1dR4yE1tDB-001RRV for <util-linux@vger.kernel.org>; Wed, 28 Jun 2017
 18:40:59 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] misc: avoid some dead initialization warnings
Date: Wed, 28 Jun 2017 18:40:54 +0200
Message-Id: <1498668057-8256-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
References: <1498668057-8256-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Clang analyzer warnings:

Dead store, Dead initialization:

    lib/mbsedit.c:154:8: warning: Value stored to 'in' during its initialization is never read
            char *in = (char *) &c;
                  ^~   ~~~~~~~~~~~

    misc-utils/findmnt-verify.c:129:14: warning: Value stored to 'cn' during its initialization is never read
            const char *cn = tgt;
                        ^~   ~~~
Dead store, Dead increment:

    sys-utils/hwclock.c:1461:2: warning: Value stored to 'argv' is never read
            argv += optind;
            ^       ~~~~~~

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/mbsedit.c               | 3 ++-
 misc-utils/findmnt-verify.c | 3 +--
 sys-utils/hwclock.c         | 5 +----
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/mbsedit.c b/lib/mbsedit.c
index d464358..e028c49 100644
--- a/lib/mbsedit.c
+++ b/lib/mbsedit.c
@@ -151,7 +151,7 @@ static size_t mbs_insert(char *str, wint_t c, size_t *ncells)
 {
 	/* all in bytes! */
 	size_t n = 1, bytes;
-	char *in = (char *) &c;
+	char *in;
 
 #ifdef HAVE_WIDECHAR
 	wchar_t wc = (wchar_t) c;
@@ -162,6 +162,7 @@ static size_t mbs_insert(char *str, wint_t c, size_t *ncells)
 	in = in_buf;
 #else
 	*ncells = 1;
+	in = (char *) &c;
 #endif
 	bytes       = strlen(str);
 
diff --git a/misc-utils/findmnt-verify.c b/misc-utils/findmnt-verify.c
index b32901d..1cc62de 100644
--- a/misc-utils/findmnt-verify.c
+++ b/misc-utils/findmnt-verify.c
@@ -126,14 +126,13 @@ done:
 static int verify_target(struct verify_context *vfy)
 {
 	const char *tgt = mnt_fs_get_target(vfy->fs);
-	const char *cn = tgt;
 	struct stat sb;
 
 	if (!tgt)
 		return verify_err(vfy, _("undefined target (fs_file)"));
 
 	if (!(flags & FL_NOCACHE)) {
-		cn = mnt_resolve_target(tgt, cache);
+		const char *cn = mnt_resolve_target(tgt, cache);
 		if (!cn)
 			return -ENOMEM;
 		if (strcmp(cn, tgt) != 0)
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 98ee5be..2f2c03a 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1457,10 +1457,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	argc -= optind;
-	argv += optind;
-
-	if (argc > 0) {
+	if (argc > optind) {
 		warnx(_("%d too many arguments given"), argc);
 		errtryhelp(EXIT_FAILURE);
 	}
-- 
1.8.5.6

