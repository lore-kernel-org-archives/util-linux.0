Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/6] chcpu: provide better user feedback
Date: Thu, 15 Sep 2011 08:52:31 +0200
Message-Id: <1316069554-20977-4-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Instead of printing error messages like "I/O resource busy" which are
supplied by strerror, give better feedback if the reason of failure
is known.
E.g. taking the last cpu offline cannot succeed, therefore print a
message that gives this "hint".

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/chcpu.c |   51 ++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index d4a2510..2cf015f 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -42,9 +42,16 @@
 #include "path.h"
 
 #define _PATH_SYS_CPU		"/sys/devices/system/cpu"
+#define _PATH_SYS_CPU_ONLINE	_PATH_SYS_CPU "/online"
 #define _PATH_SYS_CPU_RESCAN	_PATH_SYS_CPU "/rescan"
 #define _PATH_SYS_CPU_DISPATCH	_PATH_SYS_CPU "/dispatching"
 
+static cpu_set_t *onlinecpus;
+static size_t maxcpus;
+
+#define is_cpu_online(cpu) (CPU_ISSET_S((cpu), CPU_ALLOC_SIZE(maxcpus), onlinecpus))
+#define num_online_cpus()  (CPU_COUNT_S(CPU_ALLOC_SIZE(maxcpus), onlinecpus))
+
 enum {
 	CMD_CPU_ENABLE	= 0,
 	CMD_CPU_DISABLE,
@@ -59,6 +66,7 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 {
 	unsigned int cpu;
 	int online, rc;
+	int configured = -1;
 
 	for (cpu = 0; cpu < setsize; cpu++) {
 		if (!CPU_ISSET(cpu, cpu_set))
@@ -80,20 +88,33 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 			printf(_("CPU %d is already disabled\n"), cpu);
 			continue;
 		}
+		if (path_exist(_PATH_SYS_CPU "/cpu%d/configure", cpu))
+			configured = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", cpu);
 		if (enable) {
 			rc = path_writestr("1", _PATH_SYS_CPU "/cpu%d/online", cpu);
-			if (rc == -1)
+			if ((rc == -1) && (configured == 0))
+				printf(_("CPU %d enable failed "
+					 "(CPU is deconfigured)\n"), cpu);
+			else if (rc == -1)
 				printf(_("CPU %d enable failed (%s)\n"), cpu,
 					strerror(errno));
 			else
 				printf(_("CPU %d enabled\n"), cpu);
 		} else {
+			if (onlinecpus && num_online_cpus() == 1) {
+				printf(_("CPU %d disable failed "
+					 "(last enabled CPU)\n"), cpu);
+				continue;
+			}
 			rc = path_writestr("0", _PATH_SYS_CPU "/cpu%d/online", cpu);
 			if (rc == -1)
 				printf(_("CPU %d disable failed (%s)\n"), cpu,
 					strerror(errno));
-			else
+			else {
 				printf(_("CPU %d disabled\n"), cpu);
+				if (onlinecpus)
+					CPU_CLR(cpu, onlinecpus);
+			}
 		}
 	}
 	return EXIT_SUCCESS;
@@ -105,6 +126,7 @@ static int cpu_rescan(void)
 		errx(EXIT_FAILURE, _("This system does not support rescanning of CPUs"));
 	if (path_writestr("1", _PATH_SYS_CPU_RESCAN) == -1)
 		err(EXIT_FAILURE, _("Failed to trigger rescan of CPUs"));
+	printf(_("Triggered rescan of CPUs\n"));
 	return EXIT_SUCCESS;
 }
 
@@ -150,6 +172,12 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 			printf(_("CPU %d is already deconfigured\n"), cpu);
 			continue;
 		}
+		if ((current == 1) && (configure == 0) && onlinecpus &&
+		    is_cpu_online(cpu)) {
+			printf(_("CPU %d deconfigure failed "
+				 "(CPU is enabled)\n"), cpu);
+			continue;
+		}
 		if (configure) {
 			rc = path_writestr("1", _PATH_SYS_CPU "/cpu%d/configure", cpu);
 			if (rc == -1)
@@ -203,7 +231,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 int main(int argc, char *argv[])
 {
 	cpu_set_t *cpu_set;
-	unsigned int ncpus;
 	size_t setsize;
 	int cmd = -1;
 	int c;
@@ -224,11 +251,13 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	ncpus = get_max_number_of_cpus();
-	if (ncpus <= 0)
+	maxcpus = get_max_number_of_cpus();
+	if (maxcpus <= 0)
 		errx(EXIT_FAILURE, _("cannot determine NR_CPUS; aborting"));
-	setsize = CPU_ALLOC_SIZE(ncpus);
-	cpu_set = CPU_ALLOC(ncpus);
+	if (path_exist(_PATH_SYS_CPU_ONLINE))
+		onlinecpus = path_cpulist(maxcpus, _PATH_SYS_CPU_ONLINE);
+	setsize = CPU_ALLOC_SIZE(maxcpus);
+	cpu_set = CPU_ALLOC(maxcpus);
 	if (!cpu_set)
 		err(EXIT_FAILURE, _("cpuset_alloc failed"));
 
@@ -282,13 +311,13 @@ int main(int argc, char *argv[])
 
 	switch (cmd) {
 	case CMD_CPU_ENABLE:
-		return cpu_enable(cpu_set, ncpus, 1);
+		return cpu_enable(cpu_set, maxcpus, 1);
 	case CMD_CPU_DISABLE:
-		return cpu_enable(cpu_set, ncpus, 0);
+		return cpu_enable(cpu_set, maxcpus, 0);
 	case CMD_CPU_CONFIGURE:
-		return cpu_configure(cpu_set, ncpus, 1);
+		return cpu_configure(cpu_set, maxcpus, 1);
 	case CMD_CPU_DECONFIGURE:
-		return cpu_configure(cpu_set, ncpus, 0);
+		return cpu_configure(cpu_set, maxcpus, 0);
 	case CMD_CPU_RESCAN:
 		return cpu_rescan();
 	case CMD_CPU_DISPATCH_HORIZONTAL:
-- 
1.7.5.4
