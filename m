Return-Path: util-linux-owner@vger.kernel.org
Received: from g6t0186.atlanta.hp.com ([15.193.32.63]:26231 "EHLO
	g6t0186.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796Ab3EETqv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 5 May 2013 15:46:51 -0400
Message-ID: <1367783211.1823.2.camel@buesod1.americas.hpqcorp.net>
Subject: [PATCH] prlimit: delete rem_prlim prototype
From: Davidlohr Bueso <davidlohr.bueso@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Sun, 05 May 2013 12:46:51 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

We can just move the function up before any of its callers.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/prlimit.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 9098e49..6d9ded2 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -144,8 +144,6 @@ static int prlimit(pid_t p, int resource,
 }
 #endif
 
-static void rem_prlim(struct prlimit *lim);
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	size_t i;
@@ -273,6 +271,14 @@ static int column_name_to_id(const char *name, size_t namesz)
 	return -1;
 }
 
+static void rem_prlim(struct prlimit *lim)
+{
+	if (!lim)
+		return;
+	list_del(&lim->lims);
+	free(lim);
+}
+
 static int show_limits(struct list_head *lims, int tt_flags)
 {
 	int i;
@@ -372,8 +378,6 @@ static void do_prlimit(struct list_head *lims)
 	}
 }
 
-
-
 static int get_range(char *str, rlim_t *soft, rlim_t *hard, int *found)
 {
 	char *end = NULL;
@@ -466,14 +470,6 @@ static int add_prlim(char *ops, struct list_head *lims, size_t id)
 	return 0;
 }
 
-static void rem_prlim(struct prlimit *lim)
-{
-	if (!lim)
-		return;
-	list_del(&lim->lims);
-	free(lim);
-}
-
 int main(int argc, char **argv)
 {
 	int opt, tt_flags = 0;
-- 
1.7.11.7



