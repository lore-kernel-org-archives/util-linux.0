Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083823.429610834@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:48 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 3/8] [PATCH] lscpu: fix fallback nthreads calculation
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The fallback calculation of nthreads did not consider books.
In order to avoid division/multiply by/with zero make sure each number
used is at least "1".

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -649,17 +649,21 @@ read_topology(struct lscpu_desc *desc, i
 		nthreads = CPU_COUNT_S(setsize, thread_siblings);
 		/* cores within one socket */
 		ncores = CPU_COUNT_S(setsize, core_siblings) / nthreads;
-		/* number of sockets within one book */
-		nsockets = desc->ncpus / nthreads / ncores;
+		/* number of sockets within one book.
+		 * Because of odd / non-present cpu maps and to keep
+		 * calculation easy we make sure that nsockets and
+		 * nbooks is at least 1.
+		 */
+		nsockets = desc->ncpus / nthreads / ncores ?: 1;
 		/* number of books */
-		nbooks = desc->ncpus / nthreads / ncores / nsockets;
+		nbooks = desc->ncpus / nthreads / ncores / nsockets ?: 1;
 
 		/* all threads, see also read_basicinfo()
-		 * -- this is fallback for kernels where is not
+		 * -- fallback for kernels without
 		 *    /sys/devices/system/cpu/online.
 		 */
 		if (!desc->nthreads)
-			desc->nthreads = nsockets * ncores * nthreads;
+			desc->nthreads = nbooks * nsockets * ncores * nthreads;
 		/* For each map we make sure that it can have up to ncpus
 		 * entries. This is because we cannot reliably calculate the
 		 * number of cores, sockets and books on all architectures.
