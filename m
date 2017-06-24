Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56247 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751055AbdFXOFD (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:05:03 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 3/5] setpriv: proxy function to update capabilities
Date: Sat, 24 Jun 2017 16:04:32 +0200
Message-Id: <67161af0d3de99c7d70b8cb61bc86300b9e35220.1498312679.git.ps@pks.im>
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
In-Reply-To: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
References: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libcap-ng provides a function to update capabilities with
`capng_update`. As libcap-ng has not yet been updated to enable
modification of ambient capabilities, we cannot use it to update this
set, though. In order to allow easily extending the logic to also handle
ambient capability sets, we create a new function `cap_update`. Right
now, it simply calls out to `capng_update` for all supported capability
types.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 23224eff9..549d2b298 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -453,6 +453,21 @@ static void bump_cap(unsigned int cap)
 		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap);
 }
 
+static int cap_update(capng_act_t action,
+		enum cap_type type, unsigned int cap)
+{
+	switch (type) {
+		case CAP_TYPE_EFFECTIVE:
+		case CAP_TYPE_BOUNDING:
+		case CAP_TYPE_INHERITABLE:
+		case CAP_TYPE_PERMITTED:
+			return capng_update(action, (capng_type_t) type, cap);
+		default:
+			errx(EXIT_FAILURE, _("unsupported capability type"));
+			return -1;
+	}
+}
+
 static void do_caps(enum cap_type type, const char *caps)
 {
 	char *my_caps = xstrdup(caps);
@@ -475,11 +490,11 @@ static void do_caps(enum cap_type type, const char *caps)
 				errx(SETPRIV_EXIT_PRIVERR,
 				     _("libcap-ng is too old for \"all\" caps"));
 			for (i = 0; i <= CAP_LAST_CAP; i++)
-				capng_update(action, (capng_type_t) type, i);
+				cap_update(action, type, i);
 		} else {
 			int cap = capng_name_to_capability(c + 1);
 			if (0 <= cap)
-				capng_update(action, (capng_type_t) type, cap);
+				cap_update(action, type, cap);
 			else
 				errx(EXIT_FAILURE,
 				     _("unknown capability \"%s\""), c + 1);
-- 
2.13.1

