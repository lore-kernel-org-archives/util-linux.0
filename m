Return-Path: dave@gnu.org
Subject: [PATCH] lscpu: use xalloc
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jul 2011 18:52:31 -0400
Message-ID: <1311547951.3367.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Sun, 24 Jul 2011 14:39:15 -0400

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 sys-utils/lscpu.c |   34 ++++++++++------------------------
 1 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 6fa7daf..9d3d3cb 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -622,17 +622,11 @@ read_topology(struct lscpu_desc *desc, int num)
 		 */
 		if (!desc->nthreads)
 			desc->nthreads = nsockets * ncores * nthreads;
-		if (book_siblings) {
-			desc->bookmaps = calloc(nbooks, sizeof(cpu_set_t *));
-			if (!desc->bookmaps)
-				err(EXIT_FAILURE, _("error: calloc failed"));
-		}
-		desc->socketmaps = calloc(nsockets, sizeof(cpu_set_t *));
-		if (!desc->socketmaps)
-			err(EXIT_FAILURE, _("error: calloc failed"));
-		desc->coremaps = calloc(ncores * nsockets, sizeof(cpu_set_t *));
-		if (!desc->coremaps)
-			err(EXIT_FAILURE, _("error: calloc failed"));
+		if (book_siblings)
+			desc->bookmaps = xcalloc(nbooks, sizeof(cpu_set_t *));
+		
+		desc->socketmaps = xcalloc(nsockets, sizeof(cpu_set_t *));
+		desc->coremaps = xcalloc(ncores * nsockets, sizeof(cpu_set_t *));
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
@@ -664,9 +658,7 @@ read_cache(struct lscpu_desc *desc, int num)
 		if (!desc->ncaches)
 			return;
 
-		desc->caches = calloc(desc->ncaches, sizeof(*desc->caches));
-		if (!desc->caches)
-			err(EXIT_FAILURE, _("calloc failed"));
+		desc->caches = xcalloc(desc->ncaches, sizeof(*desc->caches));
 	}
 	for (i = 0; i < desc->ncaches; i++) {
 		struct cpu_cache *ca = &desc->caches[i];
@@ -707,12 +699,8 @@ read_cache(struct lscpu_desc *desc, int num)
 		map = path_cpuset(_PATH_SYS_CPU "/cpu%d/cache/index%d/shared_cpu_map",
 				num, i);
 
-		if (!ca->sharedmaps) {
-			ca->sharedmaps = calloc(desc->ncpus, sizeof(cpu_set_t *));
-			if (!ca->sharedmaps)
-				err(EXIT_FAILURE, _("error: calloc failed"));
-		}
-
+		if (!ca->sharedmaps)
+			ca->sharedmaps = xcalloc(desc->ncpus, sizeof(cpu_set_t *));
 		add_cpuset_to_array(ca->sharedmaps, &ca->nsharedmaps, map);
 	}
 }
@@ -729,10 +717,8 @@ read_nodes(struct lscpu_desc *desc)
 	if (!desc->nnodes)
 		return;
 
-	desc->nodemaps = calloc(desc->nnodes, sizeof(cpu_set_t *));
-	if (!desc->nodemaps)
-		err(EXIT_FAILURE, _("error: calloc failed"));
-
+	desc->nodemaps = xcalloc(desc->nnodes, sizeof(cpu_set_t *));
+	
 	/* information about how nodes share different CPUs */
 	for (i = 0; i < desc->nnodes; i++)
 		desc->nodemaps[i] = path_cpuset(
-- 
1.7.4.1
