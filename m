Return-Path: util-linux-owner@vger.kernel.org
Received: from cthulhu.worldbroken.com ([173.230.133.178]:58070 "EHLO
	cthulhu.worldbroken.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbbLJPMQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 10 Dec 2015 10:12:16 -0500
From: wfp5p@worldbroken.com
To: util-linux@vger.kernel.org
Subject: [PATCH] wipefs: Allow b to be used as the short option for backup
Date: Thu, 10 Dec 2015 10:02:34 -0500
Message-Id: <1449759754-29564-1-git-send-email-wfp5p@worldbroken.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Bill Pemberton <wfp5p@worldbroken.com>

'b' is documented as the short option for backup but b was not added
to the optstring on the getopt_long call.  Add it.

Signed-off-by: Bill Pemberton <wfp5p@worldbroken.com>
---
 misc-utils/wipefs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 589f53503847..594894447e63 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -504,7 +504,7 @@ main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "afhno:pqt:V", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "abfhno:pqt:V", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
-- 
2.5.0

