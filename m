Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110815153925.575706919@de.ibm.com>
Date: Mon, 15 Aug 2011 17:24:54 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH/RFC 1/2] cpuset: add option to allow cpulist_parse() to fail
References: <20110815152453.052584040@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This is a preparation patch for chcpu. If a cpu should be added to
a cpu_set where the cpu doesn't fit into the cpu_set this got silently
ignored.
Since the cpu-list is user space provided it should be checked if cpus
are specified that are completely out of range of the system.
In order to do that add a parameter which specifies if cpulist_parse()
should fail if it parses a cpu-list with "impossible" cpus.
The current callers have been converted so they behave like before.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 include/cpuset.h     |    2 +-
 lib/cpuset.c         |    7 +++++--
 schedutils/taskset.c |    2 +-
 sys-utils/lscpu.c    |    2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/cpuset.h b/include/cpuset.h
index 9364660..f65c0ca 100644
--- a/include/cpuset.h
+++ b/include/cpuset.h
@@ -67,7 +67,7 @@ extern cpu_set_t *cpuset_alloc(int ncpus, size_t *setsize, size_t *nbits);
 extern void cpuset_free(cpu_set_t *set);
 
 extern char *cpulist_create(char *str, size_t len, cpu_set_t *set, size_t setsize);
-extern int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize);
+extern int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail);
 
 extern char *cpumask_create(char *str, size_t len, cpu_set_t *set, size_t setsize);
 extern int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize);
diff --git a/lib/cpuset.c b/lib/cpuset.c
index 8aa296a..dd31f52 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -264,8 +264,9 @@ int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize)
 /*
  * Parses string with CPUs mask.
  */
-int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize)
+int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 {
+	size_t max = cpuset_nbits(setsize);
 	const char *p, *q;
 	q = str;
 
@@ -297,6 +298,8 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize)
 		if (!(a <= b))
 			return 1;
 		while (a <= b) {
+			if (fail && (a >= max))
+				return 1;
 			CPU_SET_S(a, setsize, set);
 			a += s;
 		}
@@ -359,7 +362,7 @@ int main(int argc, char *argv[])
 	if (mask)
 		rc = cpumask_parse(mask, set, setsize);
 	else
-		rc = cpulist_parse(range, set, setsize);
+		rc = cpulist_parse(range, set, setsize, 0);
 
 	if (rc)
 		errx(EXIT_FAILURE, "failed to parse string: %s", mask ? : range);
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 1457c65..085675d 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -208,7 +208,7 @@ int main(int argc, char **argv)
 		ts.get_only = 1;
 
 	else if (ts.use_list) {
-		if (cpulist_parse(argv[optind], new_set, new_setsize))
+		if (cpulist_parse(argv[optind], new_set, new_setsize, 0))
 			errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
 			     argv[optind]);
 	} else if (cpumask_parse(argv[optind], new_set, new_setsize)) {
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 50daf3c..12779f1 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -304,7 +304,7 @@ path_cpuparse(int islist, const char *path, va_list ap)
 		err(EXIT_FAILURE, _("failed to callocate cpu set"));
 
 	if (islist) {
-		if (cpulist_parse(buf, set, setsize))
+		if (cpulist_parse(buf, set, setsize, 0))
 			errx(EXIT_FAILURE, _("failed to parse CPU list %s"), buf);
 	} else {
 		if (cpumask_parse(buf, set, setsize))
-- 
1.7.5.4
