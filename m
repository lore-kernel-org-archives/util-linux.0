Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46817 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdFXOE6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:04:58 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 2/5] setpriv: proxy function checking whether a capability is set
Date: Sat, 24 Jun 2017 16:04:31 +0200
Message-Id: <a71a588d9507911d541388872a987d219d236f49.1498312679.git.ps@pks.im>
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
In-Reply-To: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The loop in `print_caps` iterates over every capability, checks whether
it is set and, if so, prints out its name. Currently, the checking and
printing is rather intertwined, making it harder to extend the check
whether we own a capability.

Prepare code for the introduction of ambient capabilities by
disentangling the code checking for a capability and printing code. A
new function `has_cap` is introduced and `print_caps` will now simply
call out to it and only handle printing itself. This easily allows to
extend the capability check based on which capability set is queried.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 4ee07862f..23224eff9 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -162,13 +162,32 @@ static int real_cap_last_cap(void)
 	return ret;
 }
 
+static int has_cap(enum cap_type which, unsigned int i)
+{
+	switch (which) {
+	case CAP_TYPE_EFFECTIVE:
+	case CAP_TYPE_BOUNDING:
+	case CAP_TYPE_INHERITABLE:
+	case CAP_TYPE_PERMITTED:
+		return capng_have_capability(which, i);
+	default:
+		warnx(_("invalid capability type"));
+		return -1;
+	}
+}
+
 /* Returns the number of capabilities printed. */
 static int print_caps(FILE *f, enum cap_type which)
 {
 	int i, n = 0, max = real_cap_last_cap();
 
 	for (i = 0; i <= max; i++) {
-		if (capng_have_capability((capng_type_t) which, i)) {
+		int ret = has_cap(which, i);
+
+		if (i == 0 && ret < 0)
+			return -1;
+
+		if (ret == 1) {
 			const char *name = capng_capability_to_name(i);
 			if (n)
 				fputc(',', f);
-- 
2.13.1

