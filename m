Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp1.ono.com ([62.42.230.162]:20969 "EHLO smtp1.ono.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbbFFE1B (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 6 Jun 2015 00:27:01 -0400
Received: from gaara.hadrons.org (85.137.227.73) by smtp1.ono.com (8.6.122.04) (authenticated as guillemj@ono.com)
        id 555173AF00CA5E71 for util-linux@vger.kernel.org; Sat, 6 Jun 2015 06:27:00 +0200
Received: from guillem by gaara.hadrons.org with local (Exim 4.85)
	(envelope-from <guillemj@ono.com>)
	id 1Z15h3-0002XI-TX
	for util-linux@vger.kernel.org; Sat, 06 Jun 2015 06:26:49 +0200
From: Guillem Jover <guillem@hadrons.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] sulogin: Use read instead of allocated size from getline()
Date: Sat,  6 Jun 2015 06:26:43 +0200
Message-Id: <1433564803-9702-1-git-send-email-guillem@hadrons.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getline function distinguishes between the allocated and read
lenghts, and we should not mix them up, as we might end up processing
junk.

Signed-off-by: Guillem Jover <guillem@hadrons.org>
---
 login-utils/sulogin-consoles.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/login-utils/sulogin-consoles.c b/login-utils/sulogin-consoles.c
index 9fd1034..39d24d2 100644
--- a/login-utils/sulogin-consoles.c
+++ b/login-utils/sulogin-consoles.c
@@ -154,13 +154,15 @@ char *oneline(const char *file)
 {
 	FILE *fp;
 	char *ret = NULL;
-	size_t len = 0;
+	size_t dummy = 0;
+	ssize_t len;
 
 	DBG(dbgprint("reading %s", file));
 
 	if (!(fp = fopen(file, "re")))
 		return NULL;
-	if (getline(&ret, &len, fp) >= 0) {
+	len = getline(&ret, &dummy, fp);
+	if (len >= 0) {
 		char *nl;
 
 		if (len)
-- 
2.2.1.209.g41e5f3a

