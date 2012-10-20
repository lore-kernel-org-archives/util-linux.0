Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([74.201.84.155]:34915 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbbDFWZ0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 6 Apr 2015 18:25:26 -0400
From: =?UTF-8?q?=C3=81ngel=20Gonz=C3=A1lez?= <ingenit@zoho.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Provide -h flag when calling shutdown (8) from rtcwake.
Date: Sat, 20 Oct 2012 17:28:45 +0200
Message-Id: <1350746925-2984-1-git-send-email-ingenit@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Otherwise, when calling rtcwake -m off you get:
"shutdown: -H and -P flags can only be used along with -h flag."
accompanied by the shutdown usage, instead of a halt.

Signed-off-by: Ángel González <ingenit@zoho.com>
---
 sys-utils/rtcwake.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/rtcwake.c b/sys-utils/rtcwake.c
index 0e16bd3..a8c2424 100644
--- a/sys-utils/rtcwake.c
+++ b/sys-utils/rtcwake.c
@@ -561,13 +561,14 @@ int main(int argc, char **argv)
 		dryrun = 1;	/* to skip disabling alarm at the end */
 
 	} else if (strcmp(suspend, "off") == 0) {
-		char *arg[4];
+		char *arg[5];
 		int i = 0;
 
 		if (verbose)
 			printf(_("suspend mode: off; executing %s\n"),
 						_PATH_SHUTDOWN);
 		arg[i++] = _PATH_SHUTDOWN;
+		arg[i++] = "-h";
 		arg[i++] = "-P";
 		arg[i++] = "now";
 		arg[i]   = NULL;
-- 
1.7.11.5


