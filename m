Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5456 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753136Ab2FTImR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 20 Jun 2012 04:42:17 -0400
From: Cong Wang <amwang@redhat.com>
To: util-linux@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Karel Zak <kzak@redhat.com>
Subject: [Patch] lib/mangle.c: fix a memory leak in the test case
Date: Wed, 20 Jun 2012 16:42:05 +0800
Message-Id: <1340181725-5382-1-git-send-email-amwang@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Cong Wang <xiyou.wangcong@gmail.com>

Marek reported there is a memory leak in lib/mangle.c

  CC       mangle.o
mangle.c:160:9: warning: Memory is never released; potential leak of memory pointed to by 'ss'

This patch fixes it.

Reported-by: Marek Otahal <markotahal@gmail.com>
Cc: Karel Zak <kzak@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>

---
diff --git a/lib/mangle.c b/lib/mangle.c
index 656918c..faddeb8 100644
--- a/lib/mangle.c
+++ b/lib/mangle.c
@@ -131,14 +131,18 @@ char *unmangle(const char *s, char **end)
 #include <errno.h>
 int main(int argc, char *argv[])
 {
+	char *p = NULL;
 	if (argc < 3) {
 		fprintf(stderr, "usage: %s --mangle|unmangle <string>\n",
 						program_invocation_short_name);
 		return EXIT_FAILURE;
 	}
 
-	if (!strcmp(argv[1], "--mangle"))
-		printf("mangled: '%s'\n", mangle(argv[2]));
+	if (!strcmp(argv[1], "--mangle")) {
+		p = mangle(argv[2]);
+		printf("mangled: '%s'\n", p);
+		free(p);
+	}
 
 	else if (!strcmp(argv[1], "--unmangle")) {
 		char *x = unmangle(argv[2], NULL);
