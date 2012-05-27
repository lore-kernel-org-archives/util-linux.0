Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcagg.dreamhost.com ([208.97.132.66]:38567 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751950Ab2E0ToC (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 May 2012 15:44:02 -0400
Subject: [PATCH 1/7] fdisk: stop buffering welcome message
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:43:56 +0200
Message-ID: <1338147836.22474.0.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Recently, commit 0a86755fe8af1da510d2eca43bdfcd70af098c19 directed the welcome message output from stderr to stdout breaking regression tests.
Correct this by flushing stdout and stop buffering the output - a trivial function is created as well.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 12706c2..084253d 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -1984,6 +1984,15 @@ unknown_command(int c) {
 	printf(_("%c: unknown command\n"), c);
 }
 
+static void print_welcome(void)
+{
+	printf(_("Welcome to fdisk (%s).\n\n"
+		 "Changes will remain in memory only, until you decide to write them.\n"
+		 "Be careful before using the write command.\n\n"), PACKAGE_STRING);
+
+	fflush(stdout);
+}
+
 static void command_prompt(void)
 {
 	int c;
@@ -2211,9 +2220,7 @@ int main(int argc, char **argv)
 	else
 		usage(stderr);
 
-	printf(_("Welcome to fdisk (%s).\n\n"
-		"Changes will remain in memory only, until you decide to write them.\n"
-		"Be careful before using the write command.\n\n"), PACKAGE_STRING);
+	print_welcome();
 
 	gpt_warning(cxt->dev_path);
 	get_boot(0);
-- 
1.7.4.1




