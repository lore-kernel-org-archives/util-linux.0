Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221Ab2KGLr3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Nov 2012 06:47:29 -0500
Date: Wed, 7 Nov 2012 12:47:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Toshi Kani <toshi.kani@hp.com>
Cc: util-linux@vger.kernel.org, heiko.carstens@de.ibm.com, kerolasa@iki.fi
Subject: Re: [PATCH] lscpu: Fix issue found on CPU hot-remove
Message-ID: <20121107114714.GA29982@x2.net.home>
References: <1351021786-3362-1-git-send-email-toshi.kani@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351021786-3362-1-git-send-email-toshi.kani@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 23, 2012 at 01:49:46PM -0600, Toshi Kani wrote:
> 1) The system has 4 CPUs
>   $ lscpu -a -e
>   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
>   0   0    0      0    0:0:0      yes
>   1   0    1      1    1:1:1      yes
>   2   0    2      2    2:2:2      yes
>   3   0    3      3    3:3:3      yes
> 
> 2) Eject cpu2
>   # echo 1 > /sys/bus/acpi/devices/LNXCPU:02/eject
> 
> 3) lscpu no longer recognizes cpu3 after cpu2 is ejected
>   $ lscpu -a -e
>   CPU NODE SOCKET CORE L1d:L1i:L2 ONLINE
>   0   0    0      0    0:0:0      yes
>   1   0    1      1    1:1:1      yes
> 
> The following changes are made to address this issue.
>  - Use maxcpus to allocate and parse bitmaps.
>  - Set desc->ncpu from cpu/present, which includes both on-line
>    and off-line CPUs.

 In the directory tests we have a dump from some strange machine

    tests/ts/lscpu/dumps/sparc64-UltraSparc-T1.tar.gz

 where is 32 /sys/devices/system/cpu/cpu[0-9]* subdirectories, but the
 present mask is 0-23, all the masks from the dump:

 present: 0-23
 possible: 0-31
 online: 0-23
 offline: 24-31
 count: 32      (means ls -d sys/devices/system/cpu/cpu[0-9]* | wc -l)

 strange, right? But I guess we can ignore this dump, according to
 kernel Documentation/cpu-hotplug.txt the cpu[0-9]* subdirectories
 have to follow the present mask. Maybe the dump is broken or so..

 Note that many of our old dumps in the tests/ts/lscpu/dumps don't
 contain /sys/devices/system/cpu/{present,online,possible} masks, but
 I will drop these incomplete dumps.

> -		desc->coremaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
> -		desc->socketmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
> +		desc->coremaps = xcalloc(maxcpus, sizeof(cpu_set_t *));
> +		desc->socketmaps = xcalloc(maxcpus, sizeof(cpu_set_t *));

[...]

> -	for (i = 0; i < desc->ncpus; i++) {
> +	for (i = 0; i < maxcpus; i++) {
>  		read_topology(desc, i);
>  		read_cache(desc, i);
>  		read_polarization(desc, i);

 What about to read /sys/devices/system/cpu/possible to determine the
 maximal possible number of CPUs on the machine. It seems like
 overkill to follow the maximal size of the cpu_set_t mask (=maxcpus).

 The "possible" mask is static and no affected by hot-plug.

 See the patch below.

    Karel


diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 25a0273..5b1a0af 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -150,7 +150,9 @@ struct lscpu_desc {
 	int	dispatching;	/* none, horizontal or vertical */
 	int	mode;		/* rm, lm or/and tm */
 
-	int		ncpus;		/* number of CPUs */
+	int		ncpuspos;	/* maximal possible CPUs */
+	int		ncpus;		/* number of present CPUs */
+	cpu_set_t	*present;	/* mask with present CPUs */
 	cpu_set_t	*online;	/* mask with online CPUs */
 
 	int		nnodes;		/* number of NUMA modes */
@@ -204,8 +206,11 @@ struct lscpu_modifier {
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
@@ -334,16 +339,13 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	FILE *fp = path_fopen("r", 1, _PATH_PROC_CPUINFO);
 	char buf[BUFSIZ];
 	struct utsname utsbuf;
+	size_t setsize;
 
 	/* architecture */
 	if (uname(&utsbuf) == -1)
 		err(EXIT_FAILURE, _("error: uname failed"));
 	desc->arch = xstrdup(utsbuf.machine);
 
-	/* count CPU(s) */
-	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", desc->ncpus))
-		desc->ncpus++;
-
 	/* details */
 	while (fgets(buf, sizeof(buf), fp) != NULL) {
 		if (lookup(buf, "vendor", &desc->vendor)) ;
@@ -391,11 +393,27 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	if (maxcpus <= 0)
 		/* error or we are reading some /sys snapshot instead of the
 		 * real /sys, let's use any crazy number... */
-		maxcpus = desc->ncpus > 2048 ? desc->ncpus : 2048;
+		maxcpus = 2048;
+
+	setsize = CPU_ALLOC_SIZE(maxcpus);
+
+	if (path_exist(_PATH_SYS_SYSTEM "/cpu/possible")) {
+		cpu_set_t *tmp = path_cpulist(maxcpus, _PATH_SYS_SYSTEM "/cpu/possible");
+		desc->ncpuspos = CPU_COUNT_S(setsize, tmp);
+		cpuset_free(tmp);
+	} else
+		err(EXIT_FAILURE, _("failed to determine number of CPUs: %s"),
+				_PATH_SYS_SYSTEM "/cpu/possible");
+
+
+	/* get mask for present CPUs */
+	if (path_exist(_PATH_SYS_SYSTEM "/cpu/present")) {
+		desc->present = path_cpulist(maxcpus, _PATH_SYS_SYSTEM "/cpu/present");
+		desc->ncpus = CPU_COUNT_S(setsize, desc->present);
+	}
 
 	/* get mask for online CPUs */
 	if (path_exist(_PATH_SYS_SYSTEM "/cpu/online")) {
-		size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 		desc->online = path_cpulist(maxcpus, _PATH_SYS_SYSTEM "/cpu/online");
 		desc->nthreads = CPU_COUNT_S(setsize, desc->online);
 	}
@@ -626,16 +644,16 @@ read_topology(struct lscpu_desc *desc, int num)
 		 */
 		if (!desc->nthreads)
 			desc->nthreads = nbooks * nsockets * ncores * nthreads;
-		/* For each map we make sure that it can have up to ncpus
+		/* For each map we make sure that it can have up to ncpuspos
 		 * entries. This is because we cannot reliably calculate the
 		 * number of cores, sockets and books on all architectures.
 		 * E.g. completely virtualized architectures like s390 may
 		 * have multiple sockets of different sizes.
 		 */
-		desc->coremaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
-		desc->socketmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+		desc->coremaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
+		desc->socketmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 		if (book_siblings)
-			desc->bookmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+			desc->bookmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
@@ -653,7 +671,7 @@ read_polarization(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/polarization", num))
 		return;
 	if (!desc->polarization)
-		desc->polarization = xcalloc(desc->ncpus, sizeof(int));
+		desc->polarization = xcalloc(desc->ncpuspos, sizeof(int));
 	path_getstr(mode, sizeof(mode), _PATH_SYS_CPU "/cpu%d/polarization", num);
 	if (strncmp(mode, "vertical:low", sizeof(mode)) == 0)
 		desc->polarization[num] = POLAR_VLOW;
@@ -673,7 +691,7 @@ read_address(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/address", num))
 		return;
 	if (!desc->addresses)
-		desc->addresses = xcalloc(desc->ncpus, sizeof(int));
+		desc->addresses = xcalloc(desc->ncpuspos, sizeof(int));
 	desc->addresses[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/address", num);
 }
 
@@ -683,7 +701,7 @@ read_configured(struct lscpu_desc *desc, int num)
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/configure", num))
 		return;
 	if (!desc->configured)
-		desc->configured = xcalloc(desc->ncpus, sizeof(int));
+		desc->configured = xcalloc(desc->ncpuspos, sizeof(int));
 	desc->configured[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", num);
 }
 
@@ -756,7 +774,7 @@ read_cache(struct lscpu_desc *desc, int num)
 				  num, i);
 
 		if (!ca->sharedmaps)
-			ca->sharedmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+			ca->sharedmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 		add_cpuset_to_array(ca->sharedmaps, &ca->nsharedmaps, map);
 	}
 }
@@ -982,13 +1000,15 @@ print_parsable(struct lscpu_desc *desc, int cols[], int ncols,
 	/*
 	 * Data
 	 */
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < desc->ncpuspos; i++) {
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
@@ -1026,7 +1046,7 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 		tt_define_column(tt, xstrdup(data), 0, 0);
 	}
 
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < desc->ncpuspos; i++) {
 		int c;
 		struct tt_line *line;
 
@@ -1034,6 +1054,8 @@ print_readable(struct lscpu_desc *desc, int cols[], int ncols,
 			continue;
 		if (!mod->online && desc->online && is_cpu_online(desc, i))
 			continue;
+		if (desc->present && !is_cpu_present(desc, i))
+			continue;
 
 		line = tt_add_line(tt, NULL);
 
@@ -1117,8 +1139,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		if (!set)
 			err(EXIT_FAILURE, _("failed to callocate cpu set"));
 		CPU_ZERO_S(setsize, set);
-		for (i = 0; i < desc->ncpus; i++) {
-			if (!is_cpu_online(desc, i))
+		for (i = 0; i < desc->ncpuspos; i++) {
+			if (!is_cpu_online(desc, i) && is_cpu_present(desc, i))
 				CPU_SET_S(i, setsize, set);
 		}
 		print_cpuset(mod->hex ? _("Off-line CPU(s) mask:") :
@@ -1339,7 +1361,7 @@ int main(int argc, char *argv[])
 
 	read_basicinfo(desc, mod);
 
-	for (i = 0; i < desc->ncpus; i++) {
+	for (i = 0; i < desc->ncpuspos; i++) {
 		read_topology(desc, i);
 		read_cache(desc, i);
 		read_polarization(desc, i);

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
