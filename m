Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:45794 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935457AbeEIQIf (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 May 2018 12:08:35 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1A97FABE7
        for <util-linux@vger.kernel.org>; Wed,  9 May 2018 16:08:33 +0000 (UTC)
To: util-linux@vger.kernel.org
Cc: Michael Matz <matz@suse.de>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] Avoid use of the old CPU macros
Message-ID: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
Date: Wed, 9 May 2018 18:08:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The old CPU macros are limited to 1024 cores. As a result, lscpu cannot
count sockets on large systems. Use new scalable macros.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Michael Matz <matz@suse.de>
---
 sys-utils/chcpu.c |  6 +++---
 sys-utils/lscpu.c | 13 +++++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 12e52d887..f32b7a6fc 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -81,7 +81,7 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 	size_t fails = 0;
 
 	for (cpu = 0; cpu < setsize; cpu++) {
-		if (!CPU_ISSET(cpu, cpu_set))
+		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
 			warnx(_("CPU %u does not exist"), cpu);
@@ -127,7 +127,7 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 			} else {
 				printf(_("CPU %u disabled\n"), cpu);
 				if (onlinecpus)
-					CPU_CLR(cpu, onlinecpus);
+					CPU_CLR_S(cpu, setsize, onlinecpus);
 			}
 		}
 	}
@@ -173,7 +173,7 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 	size_t fails = 0;
 
 	for (cpu = 0; cpu < setsize; cpu++) {
-		if (!CPU_ISSET(cpu, cpu_set))
+		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
 			warnx(_("CPU %u does not exist"), cpu);
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 2132511a5..fd6d63bbf 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -478,7 +478,7 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		desc->idx2cpunum = xcalloc(desc->ncpuspos, sizeof(int));
 
 		for (num = 0, idx = 0; num < maxcpus; num++) {
-			if (CPU_ISSET(num, tmp))
+			if (CPU_ISSET_S(num, setsize, tmp))
 				desc->idx2cpunum[idx++] = num;
 		}
 		cpuset_free(tmp);
@@ -1109,10 +1109,11 @@ cpu_max_mhz(struct lscpu_desc *desc, char *buf, size_t bufsz)
 {
 	int i;
 	float cpu_freq = 0.0;
+	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 
 	if (desc->present) {
 		for (i = 0; i < desc->ncpuspos; i++) {
-			if (CPU_ISSET(real_cpu_num(desc, i), desc->present)
+			if (CPU_ISSET_S(real_cpu_num(desc, i), setsize, desc->present)
 			    && desc->maxmhz[i]) {
 				float freq = atof(desc->maxmhz[i]);
 
@@ -1131,10 +1132,11 @@ cpu_min_mhz(struct lscpu_desc *desc, char *buf, size_t bufsz)
 {
 	int i;
 	float cpu_freq = -1.0;
+	size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 
 	if (desc->present) {
 		for (i = 0; i < desc->ncpuspos; i++) {
-			if (CPU_ISSET(real_cpu_num(desc, i), desc->present)
+			if (CPU_ISSET_S(real_cpu_num(desc, i), setsize, desc->present)
 			    && desc->minmhz[i]) {
 				float freq = atof(desc->minmhz[i]);
 
@@ -1931,6 +1933,7 @@ int main(int argc, char *argv[])
 	int c, i;
 	int columns[ARRAY_SIZE(coldescs)], ncolumns = 0;
 	int cpu_modifier_specified = 0;
+	size_t setsize;
 
 	static const struct option longopts[] = {
 		{ "all",        no_argument,       NULL, 'a' },
@@ -2034,10 +2037,12 @@ int main(int argc, char *argv[])
 
 	read_basicinfo(desc, mod);
 
+	setsize = CPU_ALLOC_SIZE(maxcpus);
+
 	for (i = 0; i < desc->ncpuspos; i++) {
 		/* only consider present CPUs */
 		if (desc->present &&
-		    !CPU_ISSET(real_cpu_num(desc, i), desc->present))
+		    !CPU_ISSET_S(real_cpu_num(desc, i), setsize, desc->present))
 			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
-- 
2.16.3

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
