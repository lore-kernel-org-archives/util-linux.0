Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:49856 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751599AbaLXQ40 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:26 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/10] setarch: make the usage synopsis comprehensible for translators
Date: Wed, 24 Dec 2014 17:56:05 +0100
Message-Id: <1419440170-10850-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use two separate strings for the two different forms of setarch,
instead of filling in an untranslated word into a single string.
Also use the standard angular brackets for nonliteral arguments.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index ed2a6a6..e00198c 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -91,9 +91,10 @@ enum {
 static void __attribute__((__noreturn__)) show_help(void)
 {
 	fputs(USAGE_HEADER, stdout);
-	printf(_(" %s%s [options] [program [program arguments]]\n"),
-	       program_invocation_short_name,
-	       !strcmp(program_invocation_short_name, "setarch") ? " <arch>" : "");
+	if (!strcmp(program_invocation_short_name, "setarch"))
+		printf(_(" %s <arch> [options] [<program> [<argument>...]]\n"), program_invocation_short_name);
+	else
+		printf(_(" %s [options] [<program> [<argument>...]]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -v, --verbose            says what options are being switched on\n"), stdout);
 	fputs(_(" -R, --addr-no-randomize  disables randomization of the virtual address space\n"), stdout);
-- 
1.7.0.4

