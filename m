Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36817 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751235AbdFXOFG (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:05:06 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 4/5] setpriv: support dumping ambient capabilities
Date: Sat, 24 Jun 2017 16:04:33 +0200
Message-Id: <ccd7b1ecb6290d245c94ab606bb375b4787b2e1b.1498312679.git.ps@pks.im>
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
In-Reply-To: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Our code dumping owned capabilities does not yet handle ambient
capabilities, which were only recently introduced with Linux 4.3. This
commit implements printing ambient capabilities if they're supported by
the system.

Based on a patch by Andy Lutomirski.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 549d2b298..c0276ed27 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -46,13 +46,19 @@
 # define PR_GET_NO_NEW_PRIVS 39
 #endif
 
+#ifndef PR_CAP_AMBIENT
+# define PR_CAP_AMBIENT		47
+#  define PR_CAP_AMBIENT_IS_SET	1
+#endif
+
 #define SETPRIV_EXIT_PRIVERR 127	/* how we exit when we fail to set privs */
 
 enum cap_type {
 	CAP_TYPE_EFFECTIVE   = CAPNG_EFFECTIVE,
 	CAP_TYPE_PERMITTED   = CAPNG_PERMITTED,
 	CAP_TYPE_INHERITABLE = CAPNG_INHERITABLE,
-	CAP_TYPE_BOUNDING    = CAPNG_BOUNDING_SET
+	CAP_TYPE_BOUNDING    = CAPNG_BOUNDING_SET,
+	CAP_TYPE_AMBIENT     = (1 << 4)
 };
 
 /*
@@ -170,6 +176,9 @@ static int has_cap(enum cap_type which, unsigned int i)
 	case CAP_TYPE_INHERITABLE:
 	case CAP_TYPE_PERMITTED:
 		return capng_have_capability(which, i);
+	case CAP_TYPE_AMBIENT:
+		return prctl(PR_CAP_AMBIENT, PR_CAP_AMBIENT_IS_SET,
+				(unsigned long) i, 0UL, 0UL);
 	default:
 		warnx(_("invalid capability type"));
 		return -1;
@@ -365,6 +374,14 @@ static void dump(int dumplevel)
 		printf(_("[none]"));
 	printf("\n");
 
+	printf(_("Ambient capabilities: "));
+	x = print_caps(stdout, CAP_TYPE_AMBIENT);
+	if (x == 0)
+		printf(_("[none]"));
+	if (x < 0)
+		printf(_("[unsupported]"));
+	printf("\n");
+
 	printf(_("Capability bounding set: "));
 	if (print_caps(stdout, CAP_TYPE_BOUNDING) == 0)
 		printf(_("[none]"));
-- 
2.13.1

