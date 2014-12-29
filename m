Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:51207 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbaL2KRk (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:40 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/11] setarch: make the usage synopsis comprehensible for translators
Date: Mon, 29 Dec 2014 11:17:01 +0100
Message-Id: <1419848226-2533-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
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
index 0943038..518eaca 100644
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
 
 	fputs(USAGE_SEPARATOR, stdout);
 	fputs(_("Change the reported architecture and set personality flags.\n"), stdout);
-- 
1.7.0.4

