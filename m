Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083823.094548131@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:47 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 2/8] [PATCH] lscpu: fix cpu map array sizes
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Completely virtualized architectures like s390 may have multiple
virtual sockets and/or cores where each of them has a different
number of cores and cpus.
So the general assumption within the allocation scheme that e.g.
each socket contains the same number of cores is not necessarily
true. To make sure the arrays are always large enough we simply
allocate enough memory so that each array could hold cpu masks
for all present cpus.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -660,11 +660,16 @@ read_topology(struct lscpu_desc *desc, i
 		 */
 		if (!desc->nthreads)
 			desc->nthreads = nsockets * ncores * nthreads;
+		/* For each map we make sure that it can have up to ncpus
+		 * entries. This is because we cannot reliably calculate the
+		 * number of cores, sockets and books on all architectures.
+		 * E.g. completely virtualized architectures like s390 may
+		 * have multiple sockets of different sizes.
+		 */
+		desc->coremaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
+		desc->socketmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
 		if (book_siblings)
-			desc->bookmaps = xcalloc(nbooks, sizeof(cpu_set_t *));
-
-		desc->socketmaps = xcalloc(nsockets, sizeof(cpu_set_t *));
-		desc->coremaps = xcalloc(ncores * nsockets, sizeof(cpu_set_t *));
+			desc->bookmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
