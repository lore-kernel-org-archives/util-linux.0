Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35683 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934932AbeEIUNJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 May 2018 16:13:09 -0400
Subject: [PATCH] chcpu: Fix maximal number of CPUs
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Cc: Michael Matz <matz@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
References: <2985b3d2-facd-13f1-10f7-bc265edfed6d@suse.cz>
 <alpine.LSU.2.21.1805091812050.12477@wotan.suse.de>
 <e77e06a7-12a5-2e53-42ff-78e337bb6d14@suse.cz>
Message-ID: <0d09c045-91ce-062f-aaeb-b44a4abe797b@suse.cz>
Date: Wed, 9 May 2018 22:13:07 +0200
MIME-Version: 1.0
In-Reply-To: <e77e06a7-12a5-2e53-42ff-78e337bb6d14@suse.cz>
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

chcpu.c mixed maxcpus (number of cpus) and setsize (size of CPU bit
mask). It effectively limits number of CPUs to 1/8 of the supported
amount.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Michael Matz <matz@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/chcpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index f32b7a6fc..4b5c7579a 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -75,12 +75,12 @@ enum {
  */
 static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 {
-	unsigned int cpu;
+	int cpu;
 	int online, rc;
 	int configured = -1;
-	size_t fails = 0;
+	int fails = 0;
 
-	for (cpu = 0; cpu < setsize; cpu++) {
+	for (cpu = 0; cpu < maxcpus; cpu++) {
 		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
@@ -132,7 +132,7 @@ static int cpu_enable(cpu_set_t *cpu_set, size_t setsize, int enable)
 		}
 	}
 
-	return fails == 0 ? 0 : fails == setsize ? -1 : 1;
+	return fails == 0 ? 0 : fails == maxcpus ? -1 : 1;
 }
 
 static int cpu_rescan(void)
@@ -168,11 +168,11 @@ static int cpu_set_dispatch(int mode)
  */
 static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 {
-	unsigned int cpu;
+	int cpu;
 	int rc, current;
-	size_t fails = 0;
+	int fails = 0;
 
-	for (cpu = 0; cpu < setsize; cpu++) {
+	for (cpu = 0; cpu < maxcpus; cpu++) {
 		if (!CPU_ISSET_S(cpu, setsize, cpu_set))
 			continue;
 		if (!path_exist(_PATH_SYS_CPU "/cpu%d", cpu)) {
@@ -217,7 +217,7 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 		}
 	}
 
-	return fails == 0 ? 0 : fails == setsize ? -1 : 1;
+	return fails == 0 ? 0 : fails == maxcpus ? -1 : 1;
 }
 
 static void cpu_parse(char *cpu_string, cpu_set_t *cpu_set, size_t setsize)
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
