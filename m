Return-Path: util-linux-owner@vger.kernel.org
Received: from g4t0014.houston.hp.com ([15.201.24.17]:15829 "EHLO
	g4t0014.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778Ab2KERLb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Nov 2012 12:11:31 -0500
From: Toshi Kani <toshi.kani@hp.com>
To: util-linux@vger.kernel.org, kzak@redhat.com
Cc: heiko.carstens@de.ibm.com, kerolasa@iki.fi, Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH RESEND] lscpu: Fix issue found on CPU hot-remove
Date: Mon,  5 Nov 2012 10:03:35 -0700
Message-Id: <1352135015-13946-1-git-send-email-toshi.kani@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

read_basicinfo() relies on sysfs cpu directories
"/sys/devices/system/cpu/cpu%d" with assumption that cpu
logical number %d is always sequentially assigned for all
CPUs. However, this assumption is not correct with CPU
hot-remove operation since it removes a target sysfs cpu
directory after it is ejected. As a result, lscpu may not
recognize all CPUs.

The issue can be easily reproduced on KVM or VirtualBox,
which supports CPU eject operation, as follows.

1) The system has 4 CPUs
  $ lscpu -a -e
  CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
  0   0    0      0    0:0:0      yes
  1   0    1      1    1:1:1      yes
  2   0    2      2    2:2:2      yes
  3   0    3      3    3:3:3      yes

2) Eject cpu2
  # echo 1 > /sys/bus/acpi/devices/LNXCPU:02/eject

3) lscpu no longer recognizes cpu3 after cpu2 is ejected
  $ lscpu -a -e
  CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
  0   0    0      0    0:0:0      yes
  1   0    1      1    1:1:1      yes

The following changes are made to address this issue.
 - Use maxcpus to allocate and parse bitmaps.
 - Set desc->ncpu from cpu/present, which includes both on-line
   and off-line CPUs.
 - Add is_cpu_present() to check if a CPU is present. Ejected
   CPUs are not present.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 sys-utils/lscpu.c | 53 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 25a0273..946eb41 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -150,7 +150,8 @@ struct lscpu_desc {
 	int	dispatching;	/* none, horizontal or vertical */
 	int	mode;		/* rm, lm or/and tm */
 
-	int		ncpus;		/* number of CPUs */
+	int		ncpus;		/* number of present CPUs */
+	cpu_set_t	*present;	/* mask with present CPUs */
 	cpu_set_t	*online;	/* mask with online CPUs */
 
 	int		nnodes;		/* number of NUMA modes */
@@ -204,8 +205,11 @@ struct lscpu_modifier {
 static int maxcpus;		/* size in bits of kernel cpu mask */
 
 #define is_cpu_online(_d, _cpu) \
-		((_d) && (_d)->online ? \
-			CPU_ISSET_S((_cpu), CPU_ALLOC_SIZE(maxcpus), (_d)->online) : 0)
+	((_d) && (_d)->online ? \
+		CPU_ISSET_S((_cpu), CPU_ALLOC_SIZE(maxcpus), (_d)->online) : 0)
+#define is_cpu_present(_d, _cpu) \
+	((_d) && (_d)->present ? \
+		CPU_ISSET_S((_cpu), CPU_ALLOC_SIZE(maxcpus), (_d)->present) : 0)
 
 /*
  * IDs
@@ -340,10 +344,6 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		err(EXIT_FAILURE, _("error: uname failed"));
 	desc->arch = xstrdup(utsbuf.machine);
 
-	/* count CPU(s) */
-	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", desc->ncpus))
-		desc->ncpus++;
-
 	/* details */
 	while (fgets(buf, sizeof(buf), fp) != NULL) {
 		if (lookup(buf, "vendor", &desc->vendor)) ;
@@ -391,7 +391,14 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	if (maxcpus <= 0)
 		/* error or we are reading some /sys snapshot instead of the
 		 * real /sys, let's use any crazy number... */
-		maxcpus = desc->ncpus > 2048 ? desc->ncpus : 2048;
+		maxcpus = 2048;
+
+	/* get mask for present CPUs */
+	if (path_exist(_PATH_SYS_SYSTEM "/cpu/present")) {
+		size_t setsize = CPU_ALLOC_SIZE(maxcpus);
+		desc->present = path_cpulist(maxcpus, _PATH_SYS_SYSTEM "/cpu/present");
+		desc->ncpus = CPU_COUNT_S(setsize, desc->present);
+	}
 
 	/* get mask for online CPUs */
 	if (path_exist(_PATH_SYS_SYSTEM "/cpu/online")) {
@@ -626,16 +633,16 @@ read_topology(struct lscpu_desc *desc, int num)
 		 */
 		if (!desc->nthreads)
 			desc->nthreads = nbooks * nsockets * ncores * nthreads;
-		/* For each map we make sure that it can have up to ncpus
+		/* For each map we make sure that it can have up to maxcpus
 		 * entries. This is because we cannot reliably calculate the
 		 * number of cores, sockets and books on all architectures.
 		 * E.g. completely virtualized architectures like s390 may
 		 * have multiple sockets of different sizes.
 		 */
-		desc->coremaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
-		desc->socketmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+		desc->coremaps = xcalloc(maxcpus, sizeof(cpu_set_t *));
+		desc->socketmaps = xcalloc(maxcpus, sizeof(cpu_set_t *));
 		if (book_siblings)
-			desc->bookmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+			desc->bookmaps = xcalloc(maxcpus, sizeof(cpu_set_t *));
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
@@ -653,7 +660,7 @@ read_polarization(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/polarization", num))
 		return;
 	if (!desc->polarization)
-		desc->polarization = xcalloc(desc->ncpus, sizeof(int));
+		desc->polarization = xcalloc(maxcpus, sizeof(int));
 	path_getstr(mode, sizeof(mode), _PATH_SYS_CPU "/cpu%d/polarization", num);
 	if (strncmp(mode, "vertical:low", sizeof(mode)) == 0)
 		desc->polarization[num] = POLAR_VLOW;
@@ -673,7 +680,7 @@ read_address(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/address", num))
 		return;
 	if (!desc->addresses)
-		desc->addresses = xcalloc(desc->ncpus, sizeof(int));
+		desc->addresses = xcalloc(maxcpus, sizeof(int));
 	desc->addresses[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/address", num);
 }
 
@@ -683,7 +690,7 @@ read_configured(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/configure", num))
 		return;
 	if (!desc->configured)
-		desc->configured = xcalloc(desc->ncpus, sizeof(int));
+		desc->configured = xcalloc(maxcpus, sizeof(int));
 	desc->configured[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", num);
 }
 
@@ -756,7 +763,7 @@ read_cache(struct lscpu_desc *desc, int num)
 				  num, i);
 
 		if (!ca->sharedmaps)
-			ca->sharedmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+			ca->sharedmaps = xcalloc(maxcpus, sizeof(cpu_set_t *));
 		add_cpuset_to_array(ca->sharedmaps, &ca->nsharedmaps, map);
 	}
 }
@@ -982,13 +989,15 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 	/*
 	 * Data
 	 */
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < maxcpus; i++) {
 		int c;
 
 		if (!mod->offline && desc->online && !is_cpu_online(desc, i))
 			continue;
 		if (!mod->online && desc->online && is_cpu_online(desc, i))
 			continue;
+		if (desc->present && !is_cpu_present(desc, i))
+			continue;
 		for (c = 0; c < ncols; c++) {
 			if (mod->compat && cols[c] == COL_CACHE) {
 				if (!desc->ncaches)
@@ -1026,7 +1035,7 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 		tt_define_column(tt, xstrdup(data), 0, 0);
 	}
 
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < maxcpus; i++) {
 		int c;
 		struct tt_line *line;
 
@@ -1034,6 +1043,8 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 			continue;
 		if (!mod->online && desc->online && is_cpu_online(desc, i))
 			continue;
+		if (desc->present && !is_cpu_present(desc, i))
+			continue;
 
 		line = tt_add_line(tt, NULL);
 
@@ -1117,8 +1128,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		if (!set)
 			err(EXIT_FAILURE, _("failed to callocate cpu set"));
 		CPU_ZERO_S(setsize, set);
-		for (i = 0; i < desc->ncpus; i++) {
-			if (!is_cpu_online(desc, i))
+		for (i = 0; i < maxcpus; i++) {
+			if (!is_cpu_online(desc, i) && is_cpu_present(desc, i))
 				CPU_SET_S(i, setsize, set);
 		}
 		print_cpuset(mod->hex ? _("Off-line CPU(s) mask:") :
@@ -1339,7 +1350,7 @@ int main(int argc, char *argv[])
 
 	read_basicinfo(desc, mod);
 
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < maxcpus; i++) {
 		read_topology(desc, i);
 		read_cache(desc, i);
 		read_polarization(desc, i);
-- 
1.7.11.7

