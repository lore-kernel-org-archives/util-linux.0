Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4/6] lscpu: show additional caches (s390)
Date: Wed, 22 Jun 2016 09:25:59 +0200
In-Reply-To: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1466580361-23435-5-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The Linux kernel exposes the cache topology via sysfs. However on
virtualized machines like s390 the cache topology contains only cpu
private caches.

For shared caches it is not known which cpus share them. The
hypervisor would have to update this information whenever a virtual
cpu would be scheduled on a different physical cpu and make the guest
aware of that change. Given that there is hardly any benefit, if it
all, this isn't done.

However it is still of interest to know about the non-private
caches. Therefore this information is available via /proc/cpuinfo at
least on s390.

This patch adds additional lines to the summary output for all shared
caches for which information can be found in /proc/cpuinfo, since we
know these aren't exposed via sysfs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c                           | 70 +++++++++++++++++++++++++++++
 tests/expected/lscpu/lscpu-s390-lpar-drawer |  2 +
 2 files changed, 72 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 883dff68bb85..4bd8e872dfc0 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -229,6 +229,9 @@ struct lscpu_desc {
 	int		ncaches;
 	struct cpu_cache *caches;
 
+	int		necaches;	/* extra caches (s390) */
+	struct cpu_cache *ecaches;
+
 	/*
 	 * All maps are sequentially indexed (0..ncpuspos), the array index
 	 * does not have match with cpuX number as presented by kernel. You
@@ -405,6 +408,58 @@ lookup(char *line, char *pattern, char **value)
 	return 1;
 }
 
+/* Parse extra cache lines contained within /proc/cpuinfo but which are not
+ * part of the cache topology information within the sysfs filesystem.
+ * This is true for all shared caches on e.g. s390. When there are layers of
+ * hypervisors in between it is not knows which CPUs share which caches.
+ * Therefore information about shared caches is only available in
+ * /proc/cpuinfo.
+ * Format is:
+ * "cache<nr> : level=<lvl> type=<type> scope=<scope> size=<size> line_size=<lsz> associativity=<as>"
+ */
+static int
+lookup_cache(char *line, struct lscpu_desc *desc)
+{
+	struct cpu_cache *cache;
+	long long size;
+	char *p, type;
+	int level;
+
+	/* Make sure line starts with "cache<nr> :" */
+	if (strncmp(line, "cache", 5))
+		return 0;
+	for (p = line + 5; isdigit(*p); p++);
+	for (; isspace(*p); p++);
+	if (*p != ':')
+		return 0;
+
+	p = strstr(line, "scope=") + 6;
+	/* Skip private caches, also present in sysfs */
+	if (!p || strncmp(p, "Private", 7) == 0)
+		return 0;
+	p = strstr(line, "level=");
+	sscanf(p, "level=%d", &level);
+	p = strstr(line, "type=") + 5;
+	type = 0;
+	if (strncmp(p, "Data", 4) == 0)
+		type = 'd';
+	if (strncmp(p, "Instruction", 11) == 0)
+		type = 'i';
+	p = strstr(line, "size=");
+	sscanf(p, "size=%lld", &size);
+	desc->necaches++;
+	desc->ecaches = xrealloc(desc->ecaches,
+				 desc->necaches * sizeof(struct cpu_cache));
+	cache = &desc->ecaches[desc->necaches - 1];
+	memset(cache, 0 , sizeof(*cache));
+	if (type)
+		xasprintf(&cache->name, "L%d%c", level, type);
+	else
+		xasprintf(&cache->name, "L%d", level);
+	xasprintf(&cache->size, "%lldK", size);
+	return 1;
+}
+
 /* Don't init the mode for platforms where we are not able to
  * detect that CPU supports 64-bit mode.
  */
@@ -501,6 +556,7 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ; /* s390 */
 		else if (lookup(buf, "cpu", &desc->cpu)) ;
 		else if (lookup(buf, "revision", &desc->revision)) ;
+		else if (lookup_cache(buf, desc)) ;
 		else
 			continue;
 	}
@@ -1768,6 +1824,16 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		}
 	}
 
+	if (desc->necaches) {
+		char cbuf[512];
+
+		for (i = desc->necaches - 1; i >= 0; i--) {
+			snprintf(cbuf, sizeof(cbuf),
+					_("%s cache:"), desc->ecaches[i].name);
+			print_s(cbuf, desc->ecaches[i].size);
+		}
+	}
+
 	for (i = 0; i < desc->nnodes; i++) {
 		snprintf(buf, sizeof(buf), _("NUMA node%d CPU(s):"), desc->idx2nodenum[i]);
 		print_cpuset(buf, desc->nodemaps[i], mod->hex);
@@ -1928,6 +1994,10 @@ int main(int argc, char *argv[])
 		qsort(desc->caches, desc->ncaches,
 				sizeof(struct cpu_cache), cachecmp);
 
+	if (desc->ecaches)
+		qsort(desc->ecaches, desc->necaches,
+				sizeof(struct cpu_cache), cachecmp);
+
 	read_nodes(desc);
 	read_hypervisor(desc, mod);
 
diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
index 587e7a6ed18d..75ee33ff7704 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar-drawer
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -21,6 +21,8 @@ L1d cache:             128K
 L1i cache:             96K
 L2d cache:             2048K
 L2i cache:             2048K
+L3 cache:              65536K
+L4 cache:              491520K
 NUMA node0 CPU(s):     0-140
 Flags:                 esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs te vx sie
 
-- 
2.6.6
