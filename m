Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49502 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbcCVQxR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 12:53:17 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Lkwpt-1aABKh3wub-00ajVI for
 <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 17:53:15 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] setarch: add "exec" message to --verbose
Date: Tue, 22 Mar 2016 17:53:12 +0100
Message-Id: <1458665593-7963-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
References: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Also we don't need fflush() in non-verbose case.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setarch.c         | 7 +++++--
 tests/expected/misc/setarch | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index b5e401c..cf29cf7 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -391,8 +391,11 @@ int main(int argc, char *argv[])
 	if (set_arch(arch, options, 0))
 		err(EXIT_FAILURE, _("failed to set personality to %s"), arch);
 
-	/* flush all output streams before exec */
-	fflush(NULL);
+	if (verbose) {
+		printf(_("Execute command `%s'.\n"), argc ? argv[0] : "/bin/sh");
+		/* flush all output streams before exec */
+		fflush(NULL);
+	}
 
 	if (!argc) {
 		execl("/bin/sh", "-sh", NULL);
diff --git a/tests/expected/misc/setarch b/tests/expected/misc/setarch
index 54208ac..0024930 100644
--- a/tests/expected/misc/setarch
+++ b/tests/expected/misc/setarch
@@ -9,4 +9,5 @@ Switching on WHOLE_SECONDS.
 Switching on STICKY_TIMEOUTS.
 Switching on ADDR_LIMIT_3GB.
 Switching on UNAME26.
+Execute command `echo'.
 success
-- 
1.8.4.5

