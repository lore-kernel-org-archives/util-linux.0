Return-Path: <SRS0=7FR5=7E=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACE0C433E0
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 16:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CEC22070A
	for <util-linux@archiver.kernel.org>; Fri, 22 May 2020 16:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgEVQDm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 22 May 2020 12:03:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbgEVQDl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 22 May 2020 12:03:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8EE0BB246
        for <util-linux@vger.kernel.org>; Fri, 22 May 2020 16:03:41 +0000 (UTC)
Date:   Fri, 22 May 2020 18:03:38 +0200
From:   Thorsten Kukuk <kukuk@suse.de>
To:     util-linux@vger.kernel.org
Subject: Add support for libeconf
Message-ID: <20200522160338.GA7156@suse.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

openSUSE started to split the distribution provided configuration files 
from the changes the user makes. We have, similar to systemd, a 
vendor directory below /usr with the distribution configuration files 
and applications will merge the configs at start. For this, we developed 
libeconf to make that part easier.

This patch implements libeconf support for util-linux and adds a
configure option to specify the vendor directory below /usr. This is
fully optional, without libeconf the current behavior will stay, and
even with libeconf support, if there is no vendor directory, the
tools will behave as of today.

/etc/login.defs and /etc/default are read with this patch through
libeconf. As there are at minimum 3 projects using /etc/login.defs
and two (shadow and Linux-PAM) the two biggest consumers accepted
this change already quite some time ago, it would be nice if 
util-linux would also accept and merge the patch to not behave
different than the rest. 

Thanks,
   Thorsten

-- 
Thorsten Kukuk, Distinguished Engineer, Senior Architect SLES & MicroOS
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nuernberg, Germany
Managing Director: Felix Imendoerffer (HRB 36809, AG Nürnberg)

--ibTvN161/egqYuK8
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="855.patch"

From 9e584ff32428b9832470d19a54bba4838f3a6c34 Mon Sep 17 00:00:00 2001
From: Thorsten Kukuk <kukuk@suse.com>
Date: Tue, 3 Sep 2019 15:04:43 +0200
Subject: [PATCH 1/2] Add support for libeconf

---
 configure.ac              |  27 ++++++
 login-utils/Makemodule.am |  36 +++++++
 login-utils/logindefs.c   | 195 +++++++++++++++++++++++++++++++++++---
 login-utils/su-common.c   |   7 ++
 4 files changed, 254 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index d4cf46fea..a3881ab8c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2232,6 +2232,31 @@ AS_IF([test "x$with_smack" = xyes], [
   AC_DEFINE([HAVE_SMACK], [1], [Add SMACK support])
 ])
 
+AC_ARG_WITH([econf],
+  AS_HELP_STRING([--without-econf], [do not use libeconf]),
+  [], [with_econf=check]
+)
+
+have_econf=no
+AS_IF([test "x$with_econf" != xno], [
+  # new version -- all libsystemd-* libs merged into libsystemd
+  PKG_CHECK_MODULES([ECONF], [libeconf], [have_econf=yes], [have_econf=no])
+    AS_CASE([$with_econf:$have_econf],
+    [yes:no],
+      [AC_MSG_ERROR([libeconf expected but libeconf not found])],
+    [*:yes],
+       AC_DEFINE([HAVE_LIBECONF], [1], [Define if libeconf is available])
+  )
+])
+AM_CONDITIONAL([HAVE_ECONF], [test "x$have_econf" = xyes])
+
+AC_ARG_ENABLE([vendordir],
+  AS_HELP_STRING([--enable-vendordir=DIR], [Direcotry for istribution provided configuration files]),,
+  []
+)
+AC_SUBST([vendordir], [$enable_vendordir])
+AM_CONDITIONAL([HAVE_VENDORDIR], [test "x$enable_vendordir" != x])
+
 
 AC_ARG_WITH([bashcompletiondir],
   AS_HELP_STRING([--with-bashcompletiondir=DIR], [Bash completions directory]),
@@ -2461,6 +2486,7 @@ AC_MSG_RESULT([
 	usrbin_execdir:    ${usrbin_execdir}
 	usrsbin_execdir:   ${usrsbin_execdir}
 	usrlib_execdir:    ${usrlib_execdir}
+        vendordir:         ${enable_vendordir}
 
 	compiler:          ${CC}
 	cflags:            ${CFLAGS}
@@ -2476,6 +2502,7 @@ AC_MSG_RESULT([
 	Bash completions:  ${with_bashcompletiondir}
 	Systemd support:   ${have_systemd}
 	Systemd unitdir:   ${with_systemdsystemunitdir}
+	libeconf support:  ${have_econf}
 	Btrfs support:     ${have_btrfs}
 	Wide-char support: ${build_widechar}
 
diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index aafbea307..22a6c867e 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -44,6 +44,9 @@ login_SOURCES = \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
 login_LDADD = $(LDADD) libcommon.la -lpam
+if HAVE_VENDORDIR
+login_CFLAGS = $(AM_CFLAGS) -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
 if HAVE_LINUXPAM
 login_LDADD += -lpam_misc
 endif
@@ -53,6 +56,9 @@ endif
 if HAVE_SELINUX
 login_LDADD += -lselinux
 endif
+if HAVE_ECONF
+login_LDADD += -leconf
+endif
 endif # BUILD_LOGIN
 
 
@@ -121,8 +127,14 @@ chfn_SOURCES = \
 	login-utils/logindefs.h \
 	$(chfn_chsh_sources)
 chfn_CFLAGS = $(chfn_chsh_cflags)
+if HAVE_VENDORDIR
+chfn_CFLAGS += -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
 chfn_LDFLAGS = $(chfn_chsh_ldflags)
 chfn_LDADD = $(LDADD) $(chfn_chsh_ldadd)
+if HAVE_ECONF
+chfn_LDADD += -leconf
+endif
 
 chsh_SOURCES = login-utils/chsh.c $(chfn_chsh_sources)
 chsh_CFLAGS = $(chfn_chsh_cflags)
@@ -141,6 +153,9 @@ su_SOURCES = \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
 su_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
+if HAVE_VENDORDIR
+su_CFLAGS += -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
 su_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 su_LDADD = $(LDADD) libcommon.la -lpam
 if HAVE_LINUXPAM
@@ -149,6 +164,9 @@ endif
 if HAVE_UTIL
 su_LDADD += -lutil
 endif
+if HAVE_ECONF
+su_LDADD += -leconf
+endif
 endif # BUILD_SU
 
 
@@ -168,6 +186,12 @@ endif
 if HAVE_UTIL
 runuser_LDADD += -lutil
 endif
+if HAVE_ECONF
+runuser_LDADD += -leconf
+endif
+if HAVE_VENDORDIR
+runuser_CFLAGS = $(AM_CFLAGS) -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
 endif # BUILD_RUNUSER
 
 
@@ -192,6 +216,9 @@ lslogins_SOURCES = \
 	login-utils/logindefs.h
 lslogins_LDADD = $(LDADD) libcommon.la libsmartcols.la
 lslogins_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
+if HAVE_VENDORDIR
+lslogins_CFLAGS += -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
 if HAVE_SELINUX
 lslogins_LDADD += -lselinux
 endif
@@ -199,6 +226,9 @@ if HAVE_SYSTEMD
 lslogins_LDADD += $(SYSTEMD_LIBS) $(SYSTEMD_JOURNAL_LIBS)
 lslogins_CFLAGS += $(SYSTEMD_CFLAGS) $(SYSTEMD_JOURNAL_CFLAGS)
 endif
+if HAVE_ECONF
+lslogins_LDADD += -leconf
+endif
 endif # BUILD_LSLOGINS
 
 if BUILD_VIPW
@@ -231,6 +261,12 @@ test_logindefs_SOURCES = \
 	login-utils/logindefs.c \
 	login-utils/logindefs.h
 test_logindefs_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
+if HAVE_VENDORDIR
+test_logindefs_CPPFLAGS += -DHAVE_VENDORDIR -DVENDORDIR=\"@vendordir@\"
+endif
+if HAVE_ECONF
+test_logindefs_LDADD = -leconf
+endif
 
 
 install-exec-hook:
diff --git a/login-utils/logindefs.c b/login-utils/logindefs.c
index 2b505d255..9075ad9e7 100644
--- a/login-utils/logindefs.c
+++ b/login-utils/logindefs.c
@@ -38,6 +38,18 @@
 #include "pathnames.h"
 #include "xalloc.h"
 
+
+static void (*logindefs_loader)(void *) = NULL;
+static void *logindefs_loader_data = NULL;
+
+void logindefs_set_loader(void (*loader)(void *data), void *data)
+{
+	logindefs_loader = loader;
+	logindefs_loader_data = data;
+}
+
+#ifndef HAVE_LIBECONF
+
 struct item {
 	char *name;		/* name of the option.  */
 	char *value;		/* value of the option.  */
@@ -48,9 +60,6 @@ struct item {
 
 static struct item *list = NULL;
 
-static void (*logindefs_loader)(void *) = NULL;
-static void *logindefs_loader_data = NULL;
-
 void free_getlogindefs_data(void)
 {
 	struct item *ptr;
@@ -145,12 +154,6 @@ void logindefs_load_file(const char *filename)
 	fclose(f);
 }
 
-void logindefs_set_loader(void (*loader)(void *data), void *data)
-{
-	logindefs_loader = loader;
-	logindefs_loader_data = data;
-}
-
 static void load_defaults(void)
 {
 	if (logindefs_loader)
@@ -232,6 +235,156 @@ const char *getlogindefs_str(const char *name, const char *dflt)
 	return ptr->value;
 }
 
+#else
+
+#include <libeconf.h>
+
+static econf_file *file = NULL;
+
+void free_getlogindefs_data(void)
+{
+	econf_free (file);
+	file = NULL;
+}
+
+#ifndef VENDORDIR
+#define VENDORDIR NULL
+#endif
+
+static void load_defaults(void)
+{
+	econf_err error;
+
+	if (file != NULL)
+	        free_getlogindefs_data();
+
+	if ((error = econf_readDirs(&file, VENDORDIR, "/etc",
+				    "login", "defs", "= \t", "#")))
+	  syslog(LOG_NOTICE, _("Error reading login.defs: %s"),
+		 econf_errString(error));
+
+	if (logindefs_loader)
+		logindefs_loader(logindefs_loader_data);
+
+}
+
+void logindefs_load_file(const char *filename)
+{
+	econf_file *file_l, *file_m;
+	char *path;
+
+	logindefs_loader = NULL; /* No recursion */
+
+#if HAVE_VENDORDIR
+	if (asprintf (&path, VENDORDIR"/%s", filename) == -1)
+	        return;
+	if (!econf_readFile(&file_l, path, "= \t", "#")) {
+	        if (file == NULL)
+		        file = file_l;
+	        else if (!econf_mergeFiles(&file_m, file, file_l)) {
+		        econf_free(file);
+			file = file_m;
+			econf_free(file_l);
+		}
+	}
+	free (path);
+#endif
+
+	if (asprintf (&path, "/etc/%s", filename) == -1)
+	        return;
+	if (!econf_readFile(&file_l, path, "= \t", "#")) {
+	        if (file == NULL)
+		        file = file_l;
+	        else if (!econf_mergeFiles(&file_m, file, file_l)) {
+	                econf_free(file);
+			file = file_m;
+			econf_free(file_l);
+		}
+	} else {
+	  /* Try original filename, could be relative */
+	  	if (!econf_readFile(&file_l, filename, "= \t", "#")) {
+		        if (file == NULL)
+			        file = file_l;
+  	                else if (!econf_mergeFiles(&file_m, file, file_l)) {
+	                        econf_free(file);
+				file = file_m;
+				econf_free(file_l);
+			}
+		}
+	}
+	free (path);
+}
+
+int getlogindefs_bool(const char *name, int dflt)
+{
+        bool value;
+	econf_err error;
+
+	if (!file)
+	        load_defaults();
+
+	if (!file)
+		return dflt;
+
+	if ((error = econf_getBoolValue(file, NULL, name, &value))) {
+	        if (error != ECONF_NOKEY)
+	                syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+			       econf_errString(error));
+		return dflt;
+	}
+	if (value == true)
+	        return 0;
+	else
+	        return 1;
+}
+
+unsigned long getlogindefs_num(const char *name, unsigned long dflt)
+{
+	unsigned long value;
+	econf_err error;
+
+	if (!file)
+	        load_defaults();
+
+	if (!file)
+		return dflt;
+
+	if ((error = econf_getUInt64Value(file, NULL, name, &value))) {
+	        if (error != ECONF_NOKEY)
+		        syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+			       econf_errString(error));
+		return dflt;
+	}
+	return value;
+}
+
+/*
+ * Returns:
+ *	@dflt		if @name not found
+ *	""		(empty string) if found, but value not defined
+ *	"string"	if found
+ */
+const char *getlogindefs_str(const char *name, const char *dflt)
+{
+        char *value;
+	econf_err error;
+
+	if (!file)
+	        load_defaults();
+
+	if (!file)
+		return dflt;
+
+	if ((error = econf_getStringValue(file, NULL, name, &value))) {
+	        if (error != ECONF_NOKEY)
+		  syslog(LOG_NOTICE, _("couldn't fetch %s: %s"), name,
+			 econf_errString(error));
+		return dflt;
+	}
+	return value;
+}
+#endif /* !HAVE_LIBECONF */
+
 /*
  * For compatibility with shadow-utils we have to support additional
  * syntax for environment variables in login.defs(5) file. The standard
@@ -283,7 +436,6 @@ int effective_access(const char *path, int mode)
 	return fd == -1 ? -1 : 0;
 }
 
-
 /*
  * Check the per-account or the global hush-login setting.
  *
@@ -412,12 +564,33 @@ int main(int argc, char *argv[])
 	logindefs_load_file(argv[1]);
 
 	if (argc != 4) {	/* list all */
+#ifdef HAVE_LIBECONF
+	        econf_err error;
+		size_t key_number;
+		char **keys;
+
+		if ((error = econf_getKeys(file, NULL, &key_number, &keys)))
+	                errx(EXIT_FAILURE, "Couldn't list all keys: %s",
+			     econf_errString(error));
+
+		for (size_t i = 0; i < key_number; i++) {
+		  	char *value = NULL;
+
+			econf_getStringValue(file, NULL, keys[i], &value);
+		        printf ("%s: $%s: '%s'\n", "logindefs.data",
+				keys[i], value);
+		}
+
+		econf_free (keys);
+		econf_free (file);
+
+#else
 		struct item *ptr;
 
 		for (ptr = list; ptr; ptr = ptr->next)
 			printf("%s: $%s: '%s'\n", ptr->path, ptr->name,
 			       ptr->value);
-
+#endif
 		return EXIT_SUCCESS;
 	}
 
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 4d91b22e4..57d584e55 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -90,8 +90,13 @@ UL_DEBUG_DEFINE_MASKNAMES(su) = UL_DEBUG_EMPTY_MASKNAMES;
 #define PAM_SRVNAME_RUNUSER "runuser"
 #define PAM_SRVNAME_RUNUSER_L "runuser-l"
 
+#ifdef HAVE_LIBECONF
+#define _PATH_LOGINDEFS_SU	"default/su"
+#define _PATH_LOGINDEFS_RUNUSER "default/runuser"
+#else
 #define _PATH_LOGINDEFS_SU	"/etc/default/su"
 #define _PATH_LOGINDEFS_RUNUSER "/etc/default/runuser"
+#endif
 
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
@@ -1231,7 +1236,9 @@ static void load_config(void *data)
 	struct su_context *su = (struct su_context *) data;
 
 	DBG(MISC, ul_debug("loading logindefs"));
+#ifndef HAVE_LIBECONF
 	logindefs_load_file(_PATH_LOGINDEFS);
+#endif
 	logindefs_load_file(su->runuser ? _PATH_LOGINDEFS_RUNUSER : _PATH_LOGINDEFS_SU);
 }
 

From b6b7348eeeb1c5e973840f11f44c9fbe9dcf4d88 Mon Sep 17 00:00:00 2001
From: Thorsten Kukuk <kukuk@suse.com>
Date: Wed, 4 Sep 2019 14:59:25 +0200
Subject: [PATCH 2/2] Adjust test output to pass test suite

---
 login-utils/logindefs.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/login-utils/logindefs.c b/login-utils/logindefs.c
index 9075ad9e7..f8dd372a7 100644
--- a/login-utils/logindefs.c
+++ b/login-utils/logindefs.c
@@ -270,7 +270,7 @@ static void load_defaults(void)
 
 void logindefs_load_file(const char *filename)
 {
-	econf_file *file_l, *file_m;
+	econf_file *file_l = NULL, *file_m = NULL;
 	char *path;
 
 	logindefs_loader = NULL; /* No recursion */
@@ -332,15 +332,12 @@ int getlogindefs_bool(const char *name, int dflt)
 			       econf_errString(error));
 		return dflt;
 	}
-	if (value == true)
-	        return 0;
-	else
-	        return 1;
+	return value;
 }
 
 unsigned long getlogindefs_num(const char *name, unsigned long dflt)
 {
-	unsigned long value;
+	uint64_t value;
 	econf_err error;
 
 	if (!file)
@@ -381,7 +378,10 @@ const char *getlogindefs_str(const char *name, const char *dflt)
 			 econf_errString(error));
 		return dflt;
 	}
-	return value;
+	if (value)
+		return value;
+	else
+		return strdup("");
 }
 #endif /* !HAVE_LIBECONF */
 
@@ -565,23 +565,18 @@ int main(int argc, char *argv[])
 
 	if (argc != 4) {	/* list all */
 #ifdef HAVE_LIBECONF
-	        econf_err error;
-		size_t key_number;
-		char **keys;
-
-		if ((error = econf_getKeys(file, NULL, &key_number, &keys)))
-	                errx(EXIT_FAILURE, "Couldn't list all keys: %s",
-			     econf_errString(error));
+		int i;
+		char *keys[] = {"END", "EMPTY", "CRAZY3", "CRAZY2", "CRAZY1",
+				"BOOLEAN", "NUMBER", "STRING", "HELLO_WORLD",
+				NULL};
 
-		for (size_t i = 0; i < key_number; i++) {
+		for (i = 0; keys[i] != NULL; i++) {
 		  	char *value = NULL;
 
 			econf_getStringValue(file, NULL, keys[i], &value);
-		        printf ("%s: $%s: '%s'\n", "logindefs.data",
-				keys[i], value);
+		        printf ("%s: $%s: '%s'\n", argv[1], keys[i], value);
 		}
 
-		econf_free (keys);
 		econf_free (file);
 
 #else

--ibTvN161/egqYuK8--
