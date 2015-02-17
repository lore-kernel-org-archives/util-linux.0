Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:47917 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbbBQWbw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Feb 2015 17:31:52 -0500
Received: by mail-wg0-f46.google.com with SMTP id a1so38941821wgh.5
        for <util-linux@vger.kernel.org>; Tue, 17 Feb 2015 14:31:51 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] setarch: print error when command runs without arguments
Date: Tue, 17 Feb 2015 22:31:48 +0000
Message-Id: <1424212308-10034-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ ./setarch
Segmentation fault (core dumped)
$ coredumpctl gdb
...
Program terminated with signal SIGSEGV, Segmentation fault.
301                     if (*argv[1] != '-') {

Reference: 5edb0ea6bbd57dd916417737f98c9109dc1ecb5b
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 76892ab..337f8fb 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -298,7 +298,7 @@ int main(int argc, char *argv[])
 	if (archwrapper)
 		arch = program_invocation_short_name;	/* symlinks to setarch */
 	else {
-		if (*argv[1] != '-') {
+		if (1 < argc && *argv[1] != '-') {
 			arch = argv[1];
 			argv[1] = argv[0];	/* for getopt_long() to get the program name */
 			argv++;
-- 
2.3.0

