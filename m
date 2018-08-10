Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726807AbeHJLxI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 10 Aug 2018 07:53:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D60CD40216FB
        for <util-linux@vger.kernel.org>; Fri, 10 Aug 2018 09:24:04 +0000 (UTC)
Received: from ws.net.home (ovpn-117-34.ams2.redhat.com [10.36.117.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3886521565E1
        for <util-linux@vger.kernel.org>; Fri, 10 Aug 2018 09:24:04 +0000 (UTC)
Date: Fri, 10 Aug 2018 11:24:01 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: su(1) --whitelist-environment
Message-ID: <20180810092401.inc32ady3eidzyjo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi all,

I'd like to add a new feature to su(1). Look forward to see your
objections and comments.

Example:

         # export FOO="this is foo"

         # su - kzak
         $ echo $FOO

         # su ---whitelist-environment FOO - kzak
         $ echo $FOO
         this is foo

Note that the currently supported --preserve-environment may be
overkill or dangerous in some use-cases as it does not reset
environment at all. The whitelist provides better control (for 
example for scripts) over environment in the new session.

 Karel


>From 384c16960cf279caf1d8e4d721a81f2da66c6a51 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Fri, 10 Aug 2018 10:49:15 +0200
Subject: [PATCH] su: add --whitelist-environment

* usable with --login to whitelist specified environment variables

* the list is ignored for the core variables like HOME, SHELL, USER,
  LOGNAME and PATH (su --login always resets these variables)

Note that su(1) requires password and after successful authentication
user has full control over the session, so he can set arbitrary
environment variables. The whitelist makes things more user friendly
only.

The patch removes unnecessary optimization when allocate environ[]. It
seems better to keep all in glibc hands and just reset the environment
array only.

Addresses: https://github.com/karelzak/util-linux/issues/221
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 configure.ac            |   1 +
 login-utils/su-common.c | 106 ++++++++++++++++++++++++++++++++++++++++--------
 login-utils/su.1        |  10 +++++
 3 files changed, 101 insertions(+), 16 deletions(-)

diff --git a/configure.ac b/configure.ac
index a41ca7689..995d1d70e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -454,6 +454,7 @@ AC_CHECK_DECL([SO_PASSCRED],
                #include <sys/socket.h>])
 
 AC_CHECK_FUNCS([ \
+	clearenv \
 	__fpurge \
 	fpurge \
 	__fpending \
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index c1b1a04e4..c730df95f 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -55,6 +55,7 @@
 #include "pathnames.h"
 #include "env.h"
 #include "closestream.h"
+#include "strv.h"
 #include "strutils.h"
 #include "ttyutils.h"
 #include "pwdutils.h"
@@ -130,6 +131,9 @@ struct su_context {
 	pid_t		child;			/* fork() baby */
 	int		childstatus;		/* wait() status */
 
+	char		**env_whitelist_names;	/* environment whitelist */
+	char		**env_whitelist_vals;
+
 	struct sigaction oldact[SIGNALS_IDX_COUNT];	/* original sigactions indexed by SIG*_IDX */
 
 #ifdef USE_PTY
@@ -925,6 +929,56 @@ static void create_watching_parent(struct su_context *su)
 	exit(status);
 }
 
+/* Adds @name from the current environment to the whitelist. If @name is not
+ * set then nothing is added to the whitelist and returns 1.
+ */
+static int env_whitelist_add(struct su_context *su, const char *name)
+{
+	const char *env = getenv(name);
+
+	if (!env)
+		return 1;
+	if (strv_extend(&su->env_whitelist_names, name))
+                err_oom();
+	if (strv_extend(&su->env_whitelist_vals, env))
+                err_oom();
+	return 0;
+}
+
+static int env_whitelist_setenv(struct su_context *su, int overwrite)
+{
+	char **one;
+	size_t i = 0;
+	int rc;
+
+	STRV_FOREACH(one, su->env_whitelist_names) {
+		rc = setenv(*one, su->env_whitelist_vals[i], overwrite);
+		if (rc)
+			return rc;
+		i++;
+	}
+
+	return 0;
+}
+
+/* Creates (add to) whitelist from comma delimited string */
+static int env_whitelist_from_string(struct su_context *su, const char *str)
+{
+	char **all = strv_split(str, ",");
+	char **one;
+
+	if (!all) {
+		if (errno == ENOMEM)
+			err_oom();
+		return -EINVAL;
+	}
+
+	STRV_FOREACH(one, all)
+		env_whitelist_add(su, *one);
+	strv_free(all);
+	return 0;
+}
+
 static void setenv_path(const struct passwd *pw)
 {
 	int rc;
@@ -949,26 +1003,38 @@ static void modify_environment(struct su_context *su, const char *shell)
 	DBG(MISC, ul_debug("modify environ[]"));
 
 	/* Leave TERM unchanged.  Set HOME, SHELL, USER, LOGNAME, PATH.
-	 * Unset all other environment variables.
+	 *
+	 * Unset all other environment variables, but follow
+	 * --whitelist-environment if specified.
 	 */
 	if (su->simulate_login) {
-		char *term = getenv("TERM");
-		if (term)
-			term = xstrdup(term);
-
-		environ = xmalloc((6 + ! !term) * sizeof(char *));
-		environ[0] = NULL;
-		if (term) {
-			xsetenv("TERM", term, 1);
-			free(term);
-		}
-
-		xsetenv("HOME", pw->pw_dir, 1);
+		/* leave TERM unchanged */
+		env_whitelist_add(su, "TERM");
+
+		/* Note that original su(1) has allocated environ[] by malloc
+		 * to the number of expected variables. This seems unnecessary
+		 * optimization as libc later realloc(current_size+2) and for
+		 * empty environ[] the curren_size is zero. It seems better to
+		 * keep all logic around environment in glibc's hands.
+		 *                                           --kzak [Aug 2018]
+		 */
+#ifdef HAVE_CLEARENV
+		clearenv();
+#else
+		environ = NULL;
+#endif
+		/* always reset */
 		if (shell)
 			xsetenv("SHELL", shell, 1);
+
+		setenv_path(pw);
+
+		xsetenv("HOME", pw->pw_dir, 1);
 		xsetenv("USER", pw->pw_name, 1);
 		xsetenv("LOGNAME", pw->pw_name, 1);
-		setenv_path(pw);
+
+		/* apply all from whitelist, but no overwrite */
+		env_whitelist_setenv(su, 0);
 
 	/* Set HOME, SHELL, and (if not becoming a superuser) USER and LOGNAME.
 	 */
@@ -1089,7 +1155,10 @@ static bool is_restricted_shell(const char *shell)
 
 static void usage_common(void)
 {
-	fputs(_(" -m, -p, --preserve-environment  do not reset environment variables\n"), stdout);
+	fputs(_(" -m, -p, --preserve-environment      do not reset environment variables\n"), stdout);
+	fputs(_(" -w, --whitelist-environment <list>  don't reset specified variables\n"), stdout);
+	fputs(USAGE_SEPARATOR, stdout);
+
 	fputs(_(" -g, --group <group>             specify the primary group\n"), stdout);
 	fputs(_(" -G, --supp-group <group>        specify a supplemental group\n"), stdout);
 	fputs(USAGE_SEPARATOR, stdout);
@@ -1234,6 +1303,7 @@ int su_main(int argc, char **argv, int mode)
 		{"group", required_argument, NULL, 'g'},
 		{"supp-group", required_argument, NULL, 'G'},
 		{"user", required_argument, NULL, 'u'},	/* runuser only */
+		{"whitelist-environment", required_argument, NULL, 'w'},
 		{"help", no_argument, 0, 'h'},
 		{"version", no_argument, 0, 'V'},
 		{NULL, 0, NULL, 0}
@@ -1248,7 +1318,7 @@ int su_main(int argc, char **argv, int mode)
 	su->conv.appdata_ptr = (void *) su;
 
 	while ((optc =
-		getopt_long(argc, argv, "c:fg:G:lmpPs:u:hV", longopts,
+		getopt_long(argc, argv, "c:fg:G:lmpPs:u:hVw:", longopts,
 			    NULL)) != -1) {
 		switch (optc) {
 		case 'c':
@@ -1283,6 +1353,10 @@ int su_main(int argc, char **argv, int mode)
 			su->change_environment = false;
 			break;
 
+		case 'w':
+			env_whitelist_from_string(su, optarg);
+			break;
+
 		case 'P':
 #ifdef USE_PTY
 			su->pty = 1;
diff --git a/login-utils/su.1 b/login-utils/su.1
index 84ca104ef..be3ccc9b0 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -79,6 +79,7 @@ login:
 o
 clears all the environment variables except
 .B TERM
+or variables specified by \fB\-\-whitelist\-environment\fR
 .TP
 o
 initializes the environment variables
@@ -153,6 +154,15 @@ Same as
 .B \-c
 but do not create a new session.  (Discouraged.)
 .TP
+.BR \-w , " \-\-whitelist\-environment" = \fIlist
+Don't reset environment variables specified in comma separated \fIlist\fR when clears
+environment for \fB\-\-login\fR. The whitelist is ignored for the environment variables
+.BR HOME ,
+.BR SHELL ,
+.BR USER ,
+.BR LOGNAME ", and"
+.BR PATH "."
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
-- 
2.14.4



    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
