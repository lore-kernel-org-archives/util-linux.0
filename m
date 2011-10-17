Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 36/49] login: add login.defs code and tests
Date: Mon, 17 Oct 2011 13:15:15 +0200
Message-Id: <1318850128-23458-37-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

The new logindefs.c file contains /etc/login.defs parser and functions
for searching in the list of the login default variables. The patch
also contains a new regression test for the code.

Based on pam_login-4.0 from Suse.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/pathnames.h            |    2 +
 login-utils/.gitignore         |    1 +
 login-utils/Makefile.am        |    5 +-
 login-utils/logindefs.c        |  246 ++++++++++++++++++++++++++++++++++++++++
 login-utils/logindefs.h        |    9 ++
 tests/commands.sh.in           |    1 +
 tests/expected/login/logindefs |   14 +++
 tests/ts/login/logindefs       |   24 ++++
 tests/ts/login/logindefs.data  |   16 +++
 9 files changed, 317 insertions(+), 1 deletions(-)
 create mode 100644 login-utils/logindefs.c
 create mode 100644 login-utils/logindefs.h
 create mode 100644 tests/expected/login/logindefs
 create mode 100755 tests/ts/login/logindefs
 create mode 100644 tests/ts/login/logindefs.data

diff --git a/include/pathnames.h b/include/pathnames.h
index 1a54a03..07912bc 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -72,6 +72,8 @@
 /* used in term-utils/agetty.c */
 #define _PATH_ISSUE		"/etc/issue"
 
+#define _PATH_LOGINDEFS		"/etc/login.defs"
+
 /* used in misc-utils/look.c */
 #define _PATH_WORDS             "/usr/share/dict/words"
 #define _PATH_WORDS_ALT         "/usr/share/dict/web2"
diff --git a/login-utils/.gitignore b/login-utils/.gitignore
index 17b6f09..d3093bf 100644
--- a/login-utils/.gitignore
+++ b/login-utils/.gitignore
@@ -1,4 +1,5 @@
 test_islocal
+test_logindefs
 chfn
 chsh
 login
diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index a5909a6..84036fc 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -65,6 +65,9 @@ install-exec-hook::
 
 endif
 
-noinst_PROGRAMS = test_islocal
+noinst_PROGRAMS = test_islocal test_logindefs
 test_islocal_SOURCES = islocal.c
 test_islocal_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
+
+test_logindefs_SOURCES = logindefs.c logindefs.h
+test_logindefs_CPPFLAGS = -DTEST_PROGRAM $(AM_CPPFLAGS)
diff --git a/login-utils/logindefs.c b/login-utils/logindefs.c
new file mode 100644
index 0000000..27017c4
--- /dev/null
+++ b/login-utils/logindefs.c
@@ -0,0 +1,246 @@
+/*
+ * Copyright (C) 2003, 2004, 2005 Thorsten Kukuk
+ * Author: Thorsten Kukuk <kukuk@suse.de>
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ * 1. Redistributions of source code must retain any existing copyright
+ *    notice, and this entire permission notice in its entirety,
+ *    including the disclaimer of warranties.
+ *
+ * 2. Redistributions in binary form must reproduce all prior and current
+ *    copyright notices, this list of conditions, and the following
+ *    disclaimer in the documentation and/or other materials provided
+ *    with the distribution.
+ *
+ * 3. The name of any author may not be used to endorse or promote
+ *    products derived from this software without their specific prior
+ *   written permission.
+ */
+#include <errno.h>
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <limits.h>
+#include <assert.h>
+#include <sys/syslog.h>
+
+#include "c.h"
+#include "nls.h"
+#include "xalloc.h"
+#include "pathnames.h"
+#include "logindefs.h"
+
+struct item {
+	char *name;		/* name of the option.  */
+	char *value;		/* value of the option.  */
+	char *path;		/* name of config file for this option.  */
+
+	struct item *next;	/* pointer to next option.  */
+};
+
+static struct item *list = NULL;
+
+void free_getlogindefs_data(void)
+{
+	struct item *ptr;
+
+	ptr = list;
+	while (ptr) {
+		struct item *tmp = ptr->next;
+
+		free(ptr->path);
+		free(ptr->name);
+		free(ptr->value);
+		free(ptr);
+		ptr = tmp;
+	}
+
+	list = NULL;
+}
+
+static void store(const char *name, const char *value, const char *path)
+{
+	struct item *new = xmalloc(sizeof(struct item));
+
+	if (!name)
+		abort();
+
+	new->name = xstrdup(name);
+	new->value = value && *value ? xstrdup(value) : NULL;
+	new->path = xstrdup(path);
+	new->next = list;
+	list = new;
+}
+
+
+static void load_defaults(const char *filename)
+{
+	FILE *f;
+	char buf[BUFSIZ];
+
+	f = fopen(filename, "r");
+	if (!f)
+		return;
+
+	while (fgets(buf, sizeof(buf), f)) {
+
+		char *p, *name, *data = NULL;
+
+		if (*buf == '#' || *buf == '\n')
+			continue;			/* only comment or empty line */
+
+		p = strchr(buf, '#');
+		if (p)
+			*p = '\0';
+		else {
+			size_t n = strlen(buf);
+			if (n && *(buf + n - 1) == '\n')
+				*(buf + n - 1) = '\0';
+		}
+
+		if (!*buf)
+			continue;			/* empty line */
+
+		/* ignore space at begin of the line */
+		name = buf;
+		while (*name && isspace((unsigned) *name))
+			name++;
+
+		/* go to the end of the name */
+		data = name;
+		while (*data && !(isspace((unsigned) *data) || *data == '='))
+			data++;
+		if (data > name && *data)
+			*data++ = '\0';
+
+		if (!*name || data == name)
+			continue;
+
+		/* go to the begin of the value */
+		while (*data && (isspace((unsigned) *data) || *data == '=' || *data == '"'))
+			 data++;
+
+		/* remove space at the end of the value */
+		p = data + strlen(data);
+		if (p > data)
+			p--;
+		while (p > data && (isspace((unsigned) *p) || *p == '"'))
+			*p-- = '\0';
+
+		store(name, data, filename);
+	}
+
+	fclose(f);
+}
+
+static struct item *search(const char *name)
+{
+	struct item *ptr;
+
+	if (!list)
+		load_defaults(_PATH_LOGINDEFS);
+
+	ptr = list;
+	while (ptr != NULL) {
+		if (strcasecmp(name, ptr->name) == 0)
+			return ptr;
+		ptr = ptr->next;
+	}
+
+	return NULL;
+}
+
+static const char *search_config(const char *name)
+{
+	struct item *ptr;
+
+	ptr = list;
+	while (ptr != NULL) {
+		if (strcasecmp(name, ptr->name) == 0)
+			return ptr->path;
+		ptr = ptr->next;
+	}
+
+	return NULL;
+}
+
+int getlogindefs_bool(const char *name, int dflt)
+{
+	struct item *ptr= search(name);
+	return ptr && ptr->value ? (strcasecmp(ptr->value, "yes") == 0) : dflt;
+}
+
+long getlogindefs_num(const char *name, long dflt)
+{
+	struct item *ptr = search(name);
+	char *end = NULL;
+	long retval;
+
+	if (!ptr || !ptr->value)
+		return dflt;
+
+	errno = 0;
+	retval = strtol(ptr->value, &end, 0);
+	if (end && *end == '\0' && !errno)
+		return retval;
+
+	syslog(LOG_NOTICE, _("%s: %s contains invalid numerical value: %s"),
+		search_config(name), name, ptr->value);
+	return dflt;
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
+	struct item *ptr = search(name);
+
+	if (!ptr)
+		return dflt;
+	if (!ptr->value)
+		return "";
+	return ptr->value;
+}
+
+
+#ifdef TEST_PROGRAM
+int main(int argc, char *argv[])
+{
+	char *name, *type;
+
+	if (argc <= 1)
+		errx(EXIT_FAILURE, "usage: %s <filename> "
+				  "[<str|num|bool> <valname>]", argv[0]);
+
+	load_defaults(argv[1]);
+
+	if (argc != 4) {			/* list all */
+		struct item *ptr;
+
+		for (ptr = list; ptr; ptr = ptr->next)
+			printf("%s: $%s: '%s'\n", ptr->path, ptr->name, ptr->value);
+
+		return EXIT_SUCCESS;
+	}
+
+	type = argv[2];
+	name = argv[3];
+
+	if (strcmp(type, "str") == 0)
+		printf("$%s: '%s'\n", name, getlogindefs_str(name, "DEFAULT"));
+	else if (strcmp(type, "num") == 0)
+		printf("$%s: '%ld'\n", name, getlogindefs_num(name, 0));
+	else if (strcmp(type, "bool") == 0)
+		printf("$%s: '%s'\n", name, getlogindefs_bool(name, 0) ? "Y" : "N");
+
+	return EXIT_SUCCESS;
+}
+#endif
diff --git a/login-utils/logindefs.h b/login-utils/logindefs.h
new file mode 100644
index 0000000..37d19e1
--- /dev/null
+++ b/login-utils/logindefs.h
@@ -0,0 +1,9 @@
+#ifndef UTIL_LINUX_LOGINDEFS_H
+#define UTIL_LINUX_LOGINDEFS_H
+
+extern int getlogindefs_bool(const char *name, int dflt);
+extern long getlogindefs_num(const char *name, long dflt);
+extern const char *getlogindefs_str(const char *name, const char *dflt);
+extern void free_getlogindefs_data(void);
+
+#endif /* UTIL_LINUX_LOGINDEFS_H */
diff --git a/tests/commands.sh.in b/tests/commands.sh.in
index 63c146f..4695e8a 100644
--- a/tests/commands.sh.in
+++ b/tests/commands.sh.in
@@ -25,6 +25,7 @@ TS_HELPER_LIBMOUNT_CONTEXT="$top_builddir/libmount/src/test_context"
 TS_HELPER_LIBMOUNT_TABDIFF="$top_builddir/libmount/src/test_tab_diff"
 
 TS_HELPER_ISLOCAL="$top_builddir/login-utils/test_islocal"
+TS_HELPER_LOGINDEFS="$top_builddir/login-utils/test_logindefs"
 
 # TODO: use partx
 TS_HELPER_PARTITIONS="$top_builddir/libblkid/samples/partitions"
diff --git a/tests/expected/login/logindefs b/tests/expected/login/logindefs
new file mode 100644
index 0000000..aca2a1f
--- /dev/null
+++ b/tests/expected/login/logindefs
@@ -0,0 +1,14 @@
+logindefs.data: $END: 'the is end'
+logindefs.data: $EMPTY: '(null)'
+logindefs.data: $CRAZY3: 'FoooBaaar'
+logindefs.data: $CRAZY2: 'fooBar'
+logindefs.data: $CRAZY1: 'this is crazy format'
+logindefs.data: $BOOLEAN: 'yEs'
+logindefs.data: $NUMBER: '123456'
+logindefs.data: $STRING: 'this_is_string'
+logindefs.data: $HELLO_WORLD: 'hello world!'
+$STRING: 'this_is_string'
+$NUMBER: '123456'
+$BOOLEAN: 'Y'
+$EMPTY: ''
+$UNKNOWN: 'DEFAULT'
diff --git a/tests/ts/login/logindefs b/tests/ts/login/logindefs
new file mode 100755
index 0000000..10caed7
--- /dev/null
+++ b/tests/ts/login/logindefs
@@ -0,0 +1,24 @@
+#!/bin/bash
+#
+# Copyright (C) 2011 Karel Zak <kzak@redhat.com>
+#
+# This file is part of util-linux.
+#
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="defs"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+# list all items
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" | sed 's:'$TS_SELF'/::g' >> $TS_OUTPUT
+
+# search
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" str STRING >> $TS_OUTPUT
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" num NUMBER >> $TS_OUTPUT
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" bool BOOLEAN >> $TS_OUTPUT
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" str EMPTY >> $TS_OUTPUT
+
+$TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" str UNKNOWN >> $TS_OUTPUT
+
+ts_finalize
diff --git a/tests/ts/login/logindefs.data b/tests/ts/login/logindefs.data
new file mode 100644
index 0000000..b899ff7
--- /dev/null
+++ b/tests/ts/login/logindefs.data
@@ -0,0 +1,16 @@
+#
+# this is /etc/login.defs sample
+#
+
+HELLO_WORLD	"hello world!"
+STRING		this_is_string		# another comment
+NUMBER		123456
+BOOLEAN		yEs
+
+CRAZY1 = "this is crazy format"
+CRAZY2=fooBar
+CRAZY3    FoooBaaar
+
+EMPTY
+
+END	"the is end"
-- 
1.7.6.4
