Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37955 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754931AbdFXOFI (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 24 Jun 2017 10:05:08 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, luto@kernel.org, kzak@redhat.com
Subject: [PATCH 1/5] setpriv: introduce indirection for `capng_type` enum
Date: Sat, 24 Jun 2017 16:04:30 +0200
Message-Id: <9ace66eed2d16303fd2a8d157875c4acca043f14.1498312679.git.ps@pks.im>
In-Reply-To: <cover.1498312509.git.ps@pks.im>
References: <cover.1498312509.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The capng_type is used to distinguish the different types of capability
sets, that is the effective, inheratibale, permitted capabilities as
well as the capability bounding set. In Linux 4.3, a new set of
capabilities was introduced with ambient capabilities. Unfortunately,
libcap-ng does not provide any support for these kind of capabilities
and as such, we will have to roll our own support.

As a first step, we introduce an indirection for the `capng_type` enum,
allowing us to add the ambient capability type later on. Right now, no
functional change is expected from this change and in fact, each of the
newly introduce enums should have the same value as respective enum of
libcap-ng.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/setpriv.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
index 8d996e8be..4ee07862f 100644
--- a/sys-utils/setpriv.c
+++ b/sys-utils/setpriv.c
@@ -48,6 +48,13 @@
 
 #define SETPRIV_EXIT_PRIVERR 127	/* how we exit when we fail to set privs */
 
+enum cap_type {
+	CAP_TYPE_EFFECTIVE   = CAPNG_EFFECTIVE,
+	CAP_TYPE_PERMITTED   = CAPNG_PERMITTED,
+	CAP_TYPE_INHERITABLE = CAPNG_INHERITABLE,
+	CAP_TYPE_BOUNDING    = CAPNG_BOUNDING_SET
+};
+
 /*
  * Note: We are subject to https://bugzilla.redhat.com/show_bug.cgi?id=895105
  * and we will therefore have problems if new capabilities are added.  Once
@@ -156,12 +163,12 @@ static int real_cap_last_cap(void)
 }
 
 /* Returns the number of capabilities printed. */
-static int print_caps(FILE *f, capng_type_t which)
+static int print_caps(FILE *f, enum cap_type which)
 {
 	int i, n = 0, max = real_cap_last_cap();
 
 	for (i = 0; i <= max; i++) {
-		if (capng_have_capability(which, i)) {
+		if (capng_have_capability((capng_type_t) which, i)) {
 			const char *name = capng_capability_to_name(i);
 			if (n)
 				fputc(',', f);
@@ -175,6 +182,7 @@ static int print_caps(FILE *f, capng_type_t which)
 			n++;
 		}
 	}
+
 	return n;
 }
 
@@ -323,23 +331,23 @@ static void dump(int dumplevel)
 
 	if (2 <= dumplevel) {
 		printf(_("Effective capabilities: "));
-		if (print_caps(stdout, CAPNG_EFFECTIVE) == 0)
+		if (print_caps(stdout, CAP_TYPE_EFFECTIVE) == 0)
 			printf(_("[none]"));
 		printf("\n");
 
 		printf(_("Permitted capabilities: "));
-		if (print_caps(stdout, CAPNG_PERMITTED) == 0)
+		if (print_caps(stdout, CAP_TYPE_PERMITTED) == 0)
 			printf(_("[none]"));
 		printf("\n");
 	}
 
 	printf(_("Inheritable capabilities: "));
-	if (print_caps(stdout, CAPNG_INHERITABLE) == 0)
+	if (print_caps(stdout, CAP_TYPE_INHERITABLE) == 0)
 		printf(_("[none]"));
 	printf("\n");
 
 	printf(_("Capability bounding set: "));
-	if (print_caps(stdout, CAPNG_BOUNDING_SET) == 0)
+	if (print_caps(stdout, CAP_TYPE_BOUNDING) == 0)
 		printf(_("[none]"));
 	printf("\n");
 
@@ -426,7 +434,7 @@ static void bump_cap(unsigned int cap)
 		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap);
 }
 
-static void do_caps(capng_type_t type, const char *caps)
+static void do_caps(enum cap_type type, const char *caps)
 {
 	char *my_caps = xstrdup(caps);
 	char *c;
@@ -448,11 +456,11 @@ static void do_caps(capng_type_t type, const char *caps)
 				errx(SETPRIV_EXIT_PRIVERR,
 				     _("libcap-ng is too old for \"all\" caps"));
 			for (i = 0; i <= CAP_LAST_CAP; i++)
-				capng_update(action, type, i);
+				capng_update(action, (capng_type_t) type, i);
 		} else {
 			int cap = capng_name_to_capability(c + 1);
 			if (0 <= cap)
-				capng_update(action, type, cap);
+				capng_update(action, (capng_type_t) type, cap);
 			else
 				errx(EXIT_FAILURE,
 				     _("unknown capability \"%s\""), c + 1);
@@ -886,14 +894,14 @@ int main(int argc, char **argv)
 		err(SETPRIV_EXIT_PRIVERR, _("set process securebits failed"));
 
 	if (opts.bounding_set) {
-		do_caps(CAPNG_BOUNDING_SET, opts.bounding_set);
+		do_caps(CAP_TYPE_BOUNDING, opts.bounding_set);
 		errno = EPERM;	/* capng doesn't set errno if we're missing CAP_SETPCAP */
 		if (capng_apply(CAPNG_SELECT_BOUNDS) != 0)
 			err(SETPRIV_EXIT_PRIVERR, _("apply bounding set"));
 	}
 
 	if (opts.caps_to_inherit) {
-		do_caps(CAPNG_INHERITABLE, opts.caps_to_inherit);
+		do_caps(CAP_TYPE_INHERITABLE, opts.caps_to_inherit);
 		if (capng_apply(CAPNG_SELECT_CAPS) != 0)
 			err(SETPRIV_EXIT_PRIVERR, _("apply capabilities"));
 	}
-- 
2.13.1

