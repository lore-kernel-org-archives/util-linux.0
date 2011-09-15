Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/6] chcpu: convert to use lib/path.c
Date: Thu, 15 Sep 2011 08:52:30 +0200
Message-Id: <1316069554-20977-3-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Use the common path access functions. In order to simplify chcpu also implement
and use path_writestr() which writes a string to the path specified.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/path.h        |    2 +
 lib/path.c            |   26 +++++++++++++++++
 sys-utils/Makefile.am |    3 +-
 sys-utils/chcpu.c     |   73 +++++++++++--------------------------------------
 4 files changed, 46 insertions(+), 58 deletions(-)

diff --git a/include/path.h b/include/path.h
index b1ee724..8e79a85 100644
--- a/include/path.h
+++ b/include/path.h
@@ -4,6 +4,8 @@ extern FILE *path_fopen(const char *mode, int exit_on_err, const char *path, ...
 			__attribute__ ((__format__ (__printf__, 3, 4)));
 extern void path_getstr(char *result, size_t len, const char *path, ...)
 			__attribute__ ((__format__ (__printf__, 3, 4)));
+extern int path_writestr(const char *str, const char *path, ...)
+			 __attribute__ ((__format__ (__printf__, 2, 3)));
 extern int path_getnum(const char *path, ...)
 		       __attribute__ ((__format__ (__printf__, 1, 2)));
 extern int path_exist(const char *path, ...)
diff --git a/lib/path.c b/lib/path.c
index 219eed6..e2bb398 100644
--- a/lib/path.c
+++ b/lib/path.c
@@ -58,6 +58,18 @@ path_vfopen(const char *mode, int exit_on_error, const char *path, va_list ap)
 	return f;
 }
 
+static int
+path_vopen(int flags, const char *path, va_list ap)
+{
+	int fd;
+	const char *p = path_vcreate(path, ap);
+
+	fd = open(p, flags);
+	if (fd == -1)
+		err(EXIT_FAILURE, _("error: cannot open %s"), p);
+	return fd;
+}
+
 FILE *
 path_fopen(const char *mode, int exit_on_error, const char *path, ...)
 {
@@ -112,6 +124,20 @@ path_getnum(const char *path, ...)
 }
 
 int
+path_writestr(const char *str, const char *path, ...)
+{
+	int fd, result;
+	va_list ap;
+
+	va_start(ap, path);
+	fd = path_vopen(O_WRONLY, path, ap);
+	va_end(ap);
+	result = write(fd, str, strlen(str));
+	close(fd);
+	return result;
+}
+
+int
 path_exist(const char *path, ...)
 {
 	va_list ap;
diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index f2a2c24..ab138e8 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -26,7 +26,8 @@ lscpu_SOURCES = lscpu.c $(top_srcdir)/lib/cpuset.c \
 			$(top_srcdir)/lib/path.c
 dist_man_MANS += lscpu.1
 sbin_PROGRAMS += chcpu
-chcpu_SOURCES = chcpu.c $(top_srcdir)/lib/cpuset.c
+chcpu_SOURCES = chcpu.c $(top_srcdir)/lib/cpuset.c \
+			$(top_srcdir)/lib/path.c
 dist_man_MANS += chcpu.1
 endif
 
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index a5d12c7..d4a2510 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -39,13 +39,12 @@
 #include "c.h"
 #include "strutils.h"
 #include "bitops.h"
+#include "path.h"
 
 #define _PATH_SYS_CPU		"/sys/devices/system/cpu"
 #define _PATH_SYS_CPU_RESCAN	_PATH_SYS_CPU "/rescan"
 #define _PATH_SYS_CPU_DISPATCH	_PATH_SYS_CPU "/dispatching"
 
-static char pathbuf[PATH_MAX];
-
 enum {
 	CMD_CPU_ENABLE	= 0,
 	CMD_CPU_DISABLE,
@@ -56,35 +55,10 @@ enum {
 	CMD_CPU_DISPATCH_VERTICAL,
 };
 
-static int path_open(mode_t mode, const char *path, ...)
-{
-	va_list ap;
-	int fd;
-
-	va_start(ap, path);
-	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
-	va_end(ap);
-	fd = open(pathbuf, mode);
-	if (fd == -1)
-		err(EXIT_FAILURE, "error: cannot open %s", pathbuf);
-	return fd;
-}
-
-static int path_exist(const char *path, ...)
-{
-	va_list ap;
-
-	va_start(ap, path);
-	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
-	va_end(ap);
-	return access(pathbuf, F_OK) == 0;
-}
-
 static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 {
 	unsigned int cpu;
-	int fd, rc;
-	char c;
+	int online, rc;
 
 	for (cpu = 0; cpu < setsize; cpu++) {
 		if (!CPU_ISSET(cpu, cpu_set))
@@ -97,76 +71,64 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 			printf(_("CPU %d is not hot pluggable\n"), cpu);
 			continue;
 		}
-		fd = path_open(O_RDWR, _PATH_SYS_CPU "/cpu%d/online", cpu);
-		if (read(fd, &c, 1) == -1)
-			err(EXIT_FAILURE, "error: cannot read from %s", pathbuf);
-		if ((c == '1') && (enable == 1)) {
+		online = path_getnum(_PATH_SYS_CPU "/cpu%d/online", cpu);
+		if ((online == 1) && (enable == 1)) {
 			printf(_("CPU %d is already enabled\n"), cpu);
 			continue;
 		}
-		if ((c == '0') && (enable == 0)) {
+		if ((online == 0) && (enable == 0)) {
 			printf(_("CPU %d is already disabled\n"), cpu);
 			continue;
 		}
 		if (enable) {
-			rc = write(fd, "1", 1);
+			rc = path_writestr("1", _PATH_SYS_CPU "/cpu%d/online", cpu);
 			if (rc == -1)
 				printf(_("CPU %d enable failed (%s)\n"), cpu,
 					strerror(errno));
 			else
 				printf(_("CPU %d enabled\n"), cpu);
 		} else {
-			rc = write(fd, "0", 1);
+			rc = path_writestr("0", _PATH_SYS_CPU "/cpu%d/online", cpu);
 			if (rc == -1)
 				printf(_("CPU %d disable failed (%s)\n"), cpu,
 					strerror(errno));
 			else
 				printf(_("CPU %d disabled\n"), cpu);
 		}
-		close(fd);
 	}
 	return EXIT_SUCCESS;
 }
 
 static int cpu_rescan(void)
 {
-	int fd;
-
 	if (!path_exist(_PATH_SYS_CPU_RESCAN))
 		errx(EXIT_FAILURE, _("This system does not support rescanning of CPUs"));
-	fd = path_open(O_WRONLY, _PATH_SYS_CPU_RESCAN);
-	if (write(fd, "1", 1) == -1)
+	if (path_writestr("1", _PATH_SYS_CPU_RESCAN) == -1)
 		err(EXIT_FAILURE, _("Failed to trigger rescan of CPUs"));
-	close(fd);
 	return EXIT_SUCCESS;
 }
 
 static int cpu_set_dispatch(int mode)
 {
-	int fd;
-
 	if (!path_exist(_PATH_SYS_CPU_DISPATCH))
 		errx(EXIT_FAILURE, _("This system does not support setting "
 				     "the dispatching mode of CPUs"));
-	fd = path_open(O_WRONLY, _PATH_SYS_CPU_DISPATCH);
 	if (mode == 0) {
-		if (write(fd, "0", 1) == -1)
+		if (path_writestr("0", _PATH_SYS_CPU_DISPATCH) == -1)
 			err(EXIT_FAILURE, _("Failed to set horizontal dispatch mode"));
 		printf(_("Succesfully set horizontal dispatching mode\n"));
 	} else {
-		if (write(fd, "1", 1) == -1)
+		if (path_writestr("1", _PATH_SYS_CPU_DISPATCH) == -1)
 			err(EXIT_FAILURE, _("Failed to set vertical dispatch mode"));
 		printf(_("Succesfully set vertical dispatching mode\n"));
 	}
-	close(fd);
 	return EXIT_SUCCESS;
 }
 
 static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 {
 	unsigned int cpu;
-	int fd, rc;
-	char c;
+	int rc, current;
 
 	for (cpu = 0; cpu < setsize; cpu++) {
 		if (!CPU_ISSET(cpu, cpu_set))
@@ -179,33 +141,30 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 			printf(_("CPU %d is not configurable\n"), cpu);
 			continue;
 		}
-		fd = path_open(O_RDWR, _PATH_SYS_CPU "/cpu%d/configure", cpu);
-		if (read(fd, &c, 1) == -1)
-			err(EXIT_FAILURE, "error: cannot read from %s", pathbuf);
-		if ((c == '1') && (configure == 1)) {
+		current = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", cpu);
+		if ((current == 1) && (configure == 1)) {
 			printf(_("CPU %d is already configured\n"), cpu);
 			continue;
 		}
-		if ((c == '0') && (configure == 0)) {
+		if ((current == 0) && (configure == 0)) {
 			printf(_("CPU %d is already deconfigured\n"), cpu);
 			continue;
 		}
 		if (configure) {
-			rc = write(fd, "1", 1);
+			rc = path_writestr("1", _PATH_SYS_CPU "/cpu%d/configure", cpu);
 			if (rc == -1)
 				printf(_("CPU %d configure failed (%s)\n"), cpu,
 					strerror(errno));
 			else
 				printf(_("CPU %d configured\n"), cpu);
 		} else {
-			rc = write(fd, "0", 1);
+			rc = path_writestr("0", _PATH_SYS_CPU "/cpu%d/configure", cpu);
 			if (rc == -1)
 				printf(_("CPU %d deconfigure failed (%s)\n"), cpu,
 					strerror(errno));
 			else
 				printf(_("CPU %d deconfigured\n"), cpu);
 		}
-		close(fd);
 	}
 	return EXIT_SUCCESS;
 }
-- 
1.7.5.4
