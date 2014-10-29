Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:55295 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbaJ2ETK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Oct 2014 00:19:10 -0400
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id CC741340309
	for <util-linux@vger.kernel.org>; Wed, 29 Oct 2014 04:19:04 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] libmount: improve kernel command line parsing
Date: Wed, 29 Oct 2014 00:19:03 -0400
Message-Id: <1414556343-10046-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The current command line parser will stop at the first occurrence of an
option, however the kernel does the opposite.  So if you have:
	root=/dev/sda1 root=/dev/sda2
When you look for "root", the kernel will use /dev/sda2, but util-linux
uses /dev/sda1.

Further, if args are passed to custom init programs, the parser will
pick those up as kernel options.  So if you have:
	root=/dev/sda1 -- /foo bar=yes
The kernel will stop at the "--" and pass the rest to userland.  But if
you look for "bar", util-linux will incorrectly return "yes".

Ultimately, there's no way for util-linux to exactly parse the command
line the same way as the kernel -- we don't know exactly which ones the
kernel picks up and which it passes on to userland (either as env vars
or as command line args).  The kernel passes all unrecognized options.
These updates are simple best effort.

URL: https://bugs.gentoo.org/526754
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 libmount/src/utils.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index dc265c2..456a898 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -1034,24 +1034,28 @@ char *mnt_get_fs_root(const char *path, const char *mnt)
  *
  * Returns newly allocated string with a parameter argument if the @name is
  * specified as "name=" or returns pointer to @name or returns NULL if not
- * found.
+ * found.  If it is specified more than once, we grab the last copy.
  *
  * For example cmdline: "aaa bbb=BBB ccc"
  *
  *	@name is "aaa"	--returns--> "aaa" (pointer to @name)
  *	@name is "bbb=" --returns--> "BBB" (allocated)
  *	@name is "foo"  --returns--> NULL
+ *
+ * Note: It is not really feasible to parse the command line exactly the same
+ * as the kernel does since we don't know which options are valid.  We can use
+ * the -- marker though and not walk past that.
  */
 char *mnt_get_kernel_cmdline_option(const char *name)
 {
 	FILE *f;
 	size_t len;
 	int val = 0;
-	char *p, *res = NULL;
+	char *p, *res = NULL, *mem = NULL;
 	char buf[BUFSIZ];	/* see kernel include/asm-generic/setup.h: COMMAND_LINE_SIZE */
 	const char *path = _PATH_PROC_CMDLINE;
 
-	if (!name)
+	if (!name || !name[0])
 		return NULL;
 
 #ifdef TEST_PROGRAM
@@ -1069,14 +1073,20 @@ char *mnt_get_kernel_cmdline_option(const char *name)
 	if (!p || !*p || *p == '\n')
 		return NULL;
 
-	len = strlen(buf);
-	*(buf + len - 1) = '\0';	/* remove last '\n' */
+	p = strstr(p, " -- ");
+	if (p) {
+		/* no more kernel args after this */
+		*p = '\0';
+	} else {
+		len = strlen(buf);
+		buf[len - 1] = '\0';	/* remove last '\n' */
+	}
 
 	len = strlen(name);
-	if (len && *(name + len - 1) == '=')
+	if (name[len - 1] == '=')
 		val = 1;
 
-	for ( ; p && *p; p++) {
+	for (p = buf; p && *p; p++) {
 		if (!(p = strstr(p, name)))
 			break;			/* not found the option */
 		if (p != buf && !isblank(*(p - 1)))
@@ -1085,15 +1095,19 @@ char *mnt_get_kernel_cmdline_option(const char *name)
 			continue;		/* no space after the option */
 		if (val) {
 			char *v = p + len;
+			int end;
 
 			while (*p && !isblank(*p))	/* jump to the end of the argument */
 				p++;
+			end = (*p == '\0');
 			*p = '\0';
-			res = strdup(v);
-			break;
+			free(mem);
+			res = mem = strdup(v);
+			if (end)
+				break;
 		} else
 			res = (char *) name;	/* option without '=' */
-		break;
+		/* don't break -- keep scanning for more options */
 	}
 
 	return res;
-- 
2.1.2

