Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/6] lib,path: move path access functions from lscpu into lib/path.c
Date: Thu, 15 Sep 2011 08:52:29 +0200
Message-Id: <1316069554-20977-2-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

A couple of these functions already have been copied to chcpu.c,
so it makes sense to move these functions into an own file.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/path.h        |   15 ++++
 lib/path.c            |  191 +++++++++++++++++++++++++++++++++++++++++++++++
 sys-utils/Makefile.am |    3 +-
 sys-utils/lscpu.c     |  199 ++++++-------------------------------------------
 4 files changed, 231 insertions(+), 177 deletions(-)
 create mode 100644 include/path.h
 create mode 100644 lib/path.c

diff --git a/include/path.h b/include/path.h
new file mode 100644
index 0000000..b1ee724
--- /dev/null
+++ b/include/path.h
@@ -0,0 +1,15 @@
+#include <stdio.h>
+
+extern FILE *path_fopen(const char *mode, int exit_on_err, const char *path, ...)
+			__attribute__ ((__format__ (__printf__, 3, 4)));
+extern void path_getstr(char *result, size_t len, const char *path, ...)
+			__attribute__ ((__format__ (__printf__, 3, 4)));
+extern int path_getnum(const char *path, ...)
+		       __attribute__ ((__format__ (__printf__, 1, 2)));
+extern int path_exist(const char *path, ...)
+		      __attribute__ ((__format__ (__printf__, 1, 2)));
+extern cpu_set_t *path_cpuset(int, const char *path, ...)
+			      __attribute__ ((__format__ (__printf__, 2, 3)));
+extern cpu_set_t *path_cpulist(int, const char *path, ...)
+			       __attribute__ ((__format__ (__printf__, 2, 3)));
+extern void path_setprefix(const char *);
diff --git a/lib/path.c b/lib/path.c
new file mode 100644
index 0000000..219eed6
--- /dev/null
+++ b/lib/path.c
@@ -0,0 +1,191 @@
+/*
+ * Simple functions to access files.
+ *
+ * Taken from lscpu.c
+ *
+ * Copyright (C) 2008 Cai Qian <qcai@redhat.com>
+ * Copyright (C) 2008 Karel Zak <kzak@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <stdarg.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+
+#include "cpuset.h"
+#include "path.h"
+#include "nls.h"
+#include "c.h"
+
+static size_t prefixlen;
+static char pathbuf[PATH_MAX];
+
+static const char *
+path_vcreate(const char *path, va_list ap)
+{
+	if (prefixlen)
+		vsnprintf(pathbuf + prefixlen,
+			  sizeof(pathbuf) - prefixlen, path, ap);
+	else
+		vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	return pathbuf;
+}
+
+static FILE *
+path_vfopen(const char *mode, int exit_on_error, const char *path, va_list ap)
+{
+	FILE *f;
+	const char *p = path_vcreate(path, ap);
+
+	f = fopen(p, mode);
+	if (!f && exit_on_error)
+		err(EXIT_FAILURE, _("error: cannot open %s"), p);
+	return f;
+}
+
+FILE *
+path_fopen(const char *mode, int exit_on_error, const char *path, ...)
+{
+	FILE *fd;
+	va_list ap;
+
+	va_start(ap, path);
+	fd = path_vfopen(mode, exit_on_error, path, ap);
+	va_end(ap);
+
+	return fd;
+}
+
+void
+path_getstr(char *result, size_t len, const char *path, ...)
+{
+	FILE *fd;
+	va_list ap;
+
+	va_start(ap, path);
+	fd = path_vfopen("r", 1, path, ap);
+	va_end(ap);
+
+	if (!fgets(result, len, fd))
+		err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
+	fclose(fd);
+
+	len = strlen(result);
+	if (result[len - 1] == '\n')
+		result[len - 1] = '\0';
+}
+
+int
+path_getnum(const char *path, ...)
+{
+	FILE *fd;
+	va_list ap;
+	int result;
+
+	va_start(ap, path);
+	fd = path_vfopen("r", 1, path, ap);
+	va_end(ap);
+
+	if (fscanf(fd, "%d", &result) != 1) {
+		if (ferror(fd))
+			err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
+		else
+			errx(EXIT_FAILURE, _("parse error: %s"), pathbuf);
+	}
+	fclose(fd);
+	return result;
+}
+
+int
+path_exist(const char *path, ...)
+{
+	va_list ap;
+	const char *p;
+
+	va_start(ap, path);
+	p = path_vcreate(path, ap);
+	va_end(ap);
+
+	return access(p, F_OK) == 0;
+}
+
+static cpu_set_t *
+path_cpuparse(int maxcpus, int islist, const char *path, va_list ap)
+{
+	FILE *fd;
+	cpu_set_t *set;
+	size_t setsize, len = maxcpus * 7;
+	char buf[len];
+
+	fd = path_vfopen("r", 1, path, ap);
+
+	if (!fgets(buf, len, fd))
+		err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
+	fclose(fd);
+
+	len = strlen(buf);
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
+	set = cpuset_alloc(maxcpus, &setsize, NULL);
+	if (!set)
+		err(EXIT_FAILURE, _("failed to callocate cpu set"));
+
+	if (islist) {
+		if (cpulist_parse(buf, set, setsize, 0))
+			errx(EXIT_FAILURE, _("failed to parse CPU list %s"), buf);
+	} else {
+		if (cpumask_parse(buf, set, setsize))
+			errx(EXIT_FAILURE, _("failed to parse CPU mask %s"), buf);
+	}
+	return set;
+}
+
+cpu_set_t *
+path_cpuset(int maxcpus, const char *path, ...)
+{
+	va_list ap;
+	cpu_set_t *set;
+
+	va_start(ap, path);
+	set = path_cpuparse(maxcpus, 0, path, ap);
+	va_end(ap);
+
+	return set;
+}
+
+cpu_set_t *
+path_cpulist(int maxcpus, const char *path, ...)
+{
+	va_list ap;
+	cpu_set_t *set;
+
+	va_start(ap, path);
+	set = path_cpuparse(maxcpus, 1, path, ap);
+	va_end(ap);
+
+	return set;
+}
+
+void
+path_setprefix(const char *prefix)
+{
+	prefixlen = strlen(prefix);
+	strncpy(pathbuf, prefix, sizeof(pathbuf));
+	pathbuf[sizeof(pathbuf) - 1] = '\0';
+}
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 1e5dcf4..f2a2c24 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -22,7 +22,8 @@ usrbin_exec_PROGRAMS += lscpu
 lscpu_SOURCES = lscpu.c $(top_srcdir)/lib/cpuset.c \
 			$(top_srcdir)/lib/strutils.c \
 			$(top_srcdir)/lib/mbsalign.c \
-			$(top_srcdir)/lib/tt.c
+			$(top_srcdir)/lib/tt.c \
+			$(top_srcdir)/lib/path.c
 dist_man_MANS += lscpu.1
 sbin_PROGRAMS += chcpu
 chcpu_SOURCES = chcpu.c $(top_srcdir)/lib/cpuset.c
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 6a37bb3..78d936f 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -40,6 +40,7 @@
 #include "strutils.h"
 #include "bitops.h"
 #include "tt.h"
+#include "path.h"
 
 #define CACHE_MAX 100
 
@@ -184,33 +185,26 @@ enum {
 	OUTPUT_READABLE,	/* -e */
 };
 
+enum {
+	SYSTEM_LIVE = 0,	/* analyzing a live system */
+	SYSTEM_SNAPSHOT,	/* analyzing a snapshot of a different system */
+};
+
 struct lscpu_modifier {
 	int		mode;		/* OUTPUT_* */
+	int		system;		/* SYSTEM_* */
 	unsigned int	hex:1,		/* print CPU masks rather than CPU lists */
 			compat:1,	/* use backwardly compatible format */
 			allcpus:1,	/* print all CPUs */
 			online:1;	/* print online CPUs only */
 };
 
-static size_t sysrootlen;
-static char pathbuf[PATH_MAX];
 static int maxcpus;		/* size in bits of kernel cpu mask */
 
 #define is_cpu_online(_d, _cpu) \
 		((_d) && (_d)->online ? \
 			CPU_ISSET_S((_cpu), CPU_ALLOC_SIZE(maxcpus), (_d)->online) : 0)
 
-static FILE *path_fopen(const char *mode, int exit_on_err, const char *path, ...)
-		__attribute__ ((__format__ (__printf__, 3, 4)));
-static void path_getstr(char *result, size_t len, const char *path, ...)
-		__attribute__ ((__format__ (__printf__, 3, 4)));
-static int path_getnum(const char *path, ...)
-		__attribute__ ((__format__ (__printf__, 1, 2)));
-static int path_exist(const char *path, ...)
-		__attribute__ ((__format__ (__printf__, 1, 2)));
-static cpu_set_t *path_cpuset(const char *path, ...)
-		__attribute__ ((__format__ (__printf__, 1, 2)));
-
 /*
  * Parsable output
  */
@@ -256,153 +250,6 @@ static int column_name_to_id(const char *name, size_t namesz)
 	return -1;
 }
 
-static const char *
-path_vcreate(const char *path, va_list ap)
-{
-	if (sysrootlen)
-		vsnprintf(pathbuf + sysrootlen,
-			  sizeof(pathbuf) - sysrootlen, path, ap);
-	else
-		vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
-	return pathbuf;
-}
-
-static FILE *
-path_vfopen(const char *mode, int exit_on_error, const char *path, va_list ap)
-{
-	FILE *f;
-	const char *p = path_vcreate(path, ap);
-
-	f = fopen(p, mode);
-	if (!f && exit_on_error)
-		err(EXIT_FAILURE, _("error: cannot open %s"), p);
-	return f;
-}
-
-static FILE *
-path_fopen(const char *mode, int exit_on_error, const char *path, ...)
-{
-	FILE *fd;
-	va_list ap;
-
-	va_start(ap, path);
-	fd = path_vfopen(mode, exit_on_error, path, ap);
-	va_end(ap);
-
-	return fd;
-}
-
-static void
-path_getstr(char *result, size_t len, const char *path, ...)
-{
-	FILE *fd;
-	va_list ap;
-
-	va_start(ap, path);
-	fd = path_vfopen("r", 1, path, ap);
-	va_end(ap);
-
-	if (!fgets(result, len, fd))
-		err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
-	fclose(fd);
-
-	len = strlen(result);
-	if (result[len - 1] == '\n')
-		result[len - 1] = '\0';
-}
-
-static int
-path_getnum(const char *path, ...)
-{
-	FILE *fd;
-	va_list ap;
-	int result;
-
-	va_start(ap, path);
-	fd = path_vfopen("r", 1, path, ap);
-	va_end(ap);
-
-	if (fscanf(fd, "%d", &result) != 1) {
-		if (ferror(fd))
-			err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
-		else
-			errx(EXIT_FAILURE, _("parse error: %s"), pathbuf);
-	}
-	fclose(fd);
-	return result;
-}
-
-static int
-path_exist(const char *path, ...)
-{
-	va_list ap;
-	const char *p;
-
-	va_start(ap, path);
-	p = path_vcreate(path, ap);
-	va_end(ap);
-
-	return access(p, F_OK) == 0;
-}
-
-static cpu_set_t *
-path_cpuparse(int islist, const char *path, va_list ap)
-{
-	FILE *fd;
-	cpu_set_t *set;
-	size_t setsize, len = maxcpus * 7;
-	char buf[len];
-
-	fd = path_vfopen("r", 1, path, ap);
-
-	if (!fgets(buf, len, fd))
-		err(EXIT_FAILURE, _("failed to read: %s"), pathbuf);
-	fclose(fd);
-
-	len = strlen(buf);
-	if (buf[len - 1] == '\n')
-		buf[len - 1] = '\0';
-
-	set = cpuset_alloc(maxcpus, &setsize, NULL);
-	if (!set)
-		err(EXIT_FAILURE, _("failed to callocate cpu set"));
-
-	if (islist) {
-		if (cpulist_parse(buf, set, setsize, 0))
-			errx(EXIT_FAILURE, _("failed to parse CPU list %s"), buf);
-	} else {
-		if (cpumask_parse(buf, set, setsize))
-			errx(EXIT_FAILURE, _("failed to parse CPU mask %s"), buf);
-	}
-	return set;
-}
-
-static cpu_set_t *
-path_cpuset(const char *path, ...)
-{
-	va_list ap;
-	cpu_set_t *set;
-
-	va_start(ap, path);
-	set = path_cpuparse(0, path, ap);
-	va_end(ap);
-
-	return set;
-}
-
-static cpu_set_t *
-path_cpulist(const char *path, ...)
-{
-	va_list ap;
-	cpu_set_t *set;
-
-	va_start(ap, path);
-	set = path_cpuparse(1, path, ap);
-	va_end(ap);
-
-	return set;
-}
-
 /* Lookup a pattern and get the value from cpuinfo.
  * Format is:
  *
@@ -448,11 +295,11 @@ int lookup(char *line, char *pattern, char **value)
  * detect that CPU supports 64-bit mode.
  */
 static int
-init_mode(void)
+init_mode(struct lscpu_modifier *mod)
 {
 	int m = 0;
 
-	if (sysrootlen)
+	if (mod->system == SYSTEM_SNAPSHOT)
 		/* reading info from any /{sys,proc} dump, don't mix it with
 		 * information about our real CPU */
 		return 0;
@@ -470,7 +317,7 @@ init_mode(void)
 }
 
 static void
-read_basicinfo(struct lscpu_desc *desc)
+read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 {
 	FILE *fp = path_fopen("r", 1, _PATH_PROC_CPUINFO);
 	char buf[BUFSIZ];
@@ -503,7 +350,7 @@ read_basicinfo(struct lscpu_desc *desc)
 			continue;
 	}
 
-	desc->mode = init_mode();
+	desc->mode = init_mode(mod);
 
 	if (desc->flags) {
 		snprintf(buf, sizeof(buf), " %s ", desc->flags);
@@ -525,7 +372,7 @@ read_basicinfo(struct lscpu_desc *desc)
 		/* note that kernel_max is maximum index [NR_CPUS-1] */
 		maxcpus = path_getnum(_PATH_SYS_SYSTEM "/cpu/kernel_max") + 1;
 
-	else if (!sysrootlen)
+	else if (mod->system == SYSTEM_LIVE)
 		/* the root is '/' so we are working with data from the current kernel */
 		maxcpus = get_max_number_of_cpus();
 	else
@@ -536,7 +383,7 @@ read_basicinfo(struct lscpu_desc *desc)
 	/* get mask for online CPUs */
 	if (path_exist(_PATH_SYS_SYSTEM "/cpu/online")) {
 		size_t setsize = CPU_ALLOC_SIZE(maxcpus);
-		desc->online = path_cpulist(_PATH_SYS_SYSTEM "/cpu/online");
+		desc->online = path_cpulist(maxcpus, _PATH_SYS_SYSTEM "/cpu/online");
 		desc->nthreads = CPU_COUNT_S(setsize, desc->online);
 	}
 
@@ -733,13 +580,13 @@ read_topology(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/topology/thread_siblings", num))
 		return;
 
-	thread_siblings = path_cpuset(_PATH_SYS_CPU
+	thread_siblings = path_cpuset(maxcpus, _PATH_SYS_CPU
 					"/cpu%d/topology/thread_siblings", num);
-	core_siblings = path_cpuset(_PATH_SYS_CPU
+	core_siblings = path_cpuset(maxcpus, _PATH_SYS_CPU
 					"/cpu%d/topology/core_siblings", num);
 	book_siblings = NULL;
 	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/book_siblings", num)) {
-		book_siblings = path_cpuset(_PATH_SYS_CPU
+		book_siblings = path_cpuset(maxcpus, _PATH_SYS_CPU
 					    "/cpu%d/topology/book_siblings", num);
 	}
 
@@ -891,8 +738,9 @@ read_cache(struct lscpu_desc *desc, int num)
 		}
 
 		/* information about how CPUs share different caches */
-		map = path_cpuset(_PATH_SYS_CPU "/cpu%d/cache/index%d/shared_cpu_map",
-				num, i);
+		map = path_cpuset(maxcpus,
+				  _PATH_SYS_CPU "/cpu%d/cache/index%d/shared_cpu_map",
+				  num, i);
 
 		if (!ca->sharedmaps)
 			ca->sharedmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
@@ -916,7 +764,7 @@ read_nodes(struct lscpu_desc *desc)
 
 	/* information about how nodes share different CPUs */
 	for (i = 0; i < desc->nnodes; i++)
-		desc->nodemaps[i] = path_cpuset(
+		desc->nodemaps[i] = path_cpuset(maxcpus,
 					_PATH_SYS_SYSTEM "/node/node%d/cpumap",
 					i);
 }
@@ -1404,9 +1252,8 @@ int main(int argc, char *argv[])
 			mod->mode = c == 'p' ? OUTPUT_PARSABLE : OUTPUT_READABLE;
 			break;
 		case 's':
-			sysrootlen = strlen(optarg);
-			strncpy(pathbuf, optarg, sizeof(pathbuf));
-			pathbuf[sizeof(pathbuf) - 1] = '\0';
+			path_setprefix(optarg);
+			mod->system = SYSTEM_SNAPSHOT;
 			break;
 		case 'x':
 			mod->hex = 1;
@@ -1420,7 +1267,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	read_basicinfo(desc);
+	read_basicinfo(desc, mod);
 
 	for (i = 0; i < desc->ncpus; i++) {
 		if (desc->online && !is_cpu_online(desc, i))
-- 
1.7.5.4
