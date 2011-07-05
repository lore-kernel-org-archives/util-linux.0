Return-Path: heiko.carstens@de.ibm.com
Date: Tue, 5 Jul 2011 13:29:10 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: add support for books
Message-ID: <20110705112909.GA3450@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This patch adds support for books in cpu topology output. Books are
currently only present on the s390 architecture, however it looks like
others will follow to use the extra scheduling domain of the kernel.

Books are logically between sockets and nodes. Therefore change the
parseable output accordingly to reflect this. Please note that I assume
that other programs that get fed by the output of lscpu actually parse
the last comment line and react in a sane way if new entries appear in
the cpu list.

Also the readable output is changed from
"CPU socket(s):" to "Socket(s) per book:" or simply "Socket(s):" in the
absence of books.
    
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 sys-utils/lscpu.c |   46 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 0c49b54..91cf97d 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -113,6 +113,11 @@ struct lscpu_desc {
 	int		nnodes;		/* number of NUMA modes */
 	cpu_set_t	**nodemaps;	/* array with NUMA nodes */
 
+	/* books -- based on book_siblings (internal kernel map of cpuX's
+	 * hardware threads within the same book */
+	int		nbooks;		/* number of all online books */
+	cpu_set_t	**bookmaps;	/* unique book_siblings */
+
 	/* sockets -- based on core_siblings (internal kernel map of cpuX's
 	 * hardware threads within the same physical_package_id (socket)) */
 	int		nsockets;	/* number of all online sockets */
@@ -583,7 +588,7 @@ static int add_cpuset_to_array(cpu_set_t **ary, int *items, cpu_set_t *set)
 static void
 read_topology(struct lscpu_desc *desc, int num)
 {
-	cpu_set_t *thread_siblings, *core_siblings;
+	cpu_set_t *thread_siblings, *core_siblings, *book_siblings;
 
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/topology/thread_siblings", num))
 		return;
@@ -592,17 +597,24 @@ read_topology(struct lscpu_desc *desc, int num)
 					"/cpu%d/topology/thread_siblings", num);
 	core_siblings = path_cpuset(_PATH_SYS_CPU
 					"/cpu%d/topology/core_siblings", num);
+	book_siblings = NULL;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/book_siblings", num)) {
+		book_siblings = path_cpuset(_PATH_SYS_CPU
+					    "/cpu%d/topology/book_siblings", num);
+	}
 
 	if (!desc->coremaps) {
-		int ncores, nsockets, nthreads;
+		int nbooks, nsockets, ncores, nthreads;
 		size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 
 		/* threads within one core */
 		nthreads = CPU_COUNT_S(setsize, thread_siblings);
 		/* cores within one socket */
 		ncores = CPU_COUNT_S(setsize, core_siblings) / nthreads;
-		/* number of sockets */
+		/* number of sockets within one book */
 		nsockets = desc->ncpus / nthreads / ncores;
+		/* number of books */
+		nbooks = desc->ncpus / nthreads / ncores / nsockets;
 
 		/* all threads, see also read_basicinfo()
 		 * -- this is fallback for kernels where is not
@@ -610,7 +622,11 @@ read_topology(struct lscpu_desc *desc, int num)
 		 */
 		if (!desc->nthreads)
 			desc->nthreads = nsockets * ncores * nthreads;
-
+		if (book_siblings) {
+			desc->bookmaps = calloc(nbooks, sizeof(cpu_set_t *));
+			if (!desc->bookmaps)
+				err(EXIT_FAILURE, _("error: calloc failed"));
+		}
 		desc->socketmaps = calloc(nsockets, sizeof(cpu_set_t *));
 		if (!desc->socketmaps)
 			err(EXIT_FAILURE, _("error: calloc failed"));
@@ -621,6 +637,8 @@ read_topology(struct lscpu_desc *desc, int num)
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
 	add_cpuset_to_array(desc->coremaps, &desc->ncores, thread_siblings);
+	if (book_siblings)
+		add_cpuset_to_array(desc->bookmaps, &desc->nbooks, book_siblings);
 }
 
 static int
@@ -732,7 +750,7 @@ print_parsable(struct lscpu_desc *desc)
 	"# The following is the parsable format, which can be fed to other\n"
 	"# programs. Each different item in every column has an unique ID\n"
 	"# starting from zero.\n"
-	"# CPU,Core,Socket,Node"));
+	"# CPU,Core,Socket,Book,Node"));
 
 	if (desc->ncaches) {
 		/* separator between CPU topology and cache information */
@@ -771,6 +789,16 @@ print_parsable(struct lscpu_desc *desc)
 		if (j == desc->nsockets)
 			putchar(',');
 
+		/* Book */
+		for (j = 0; j < desc->nbooks; j++) {
+			if (CPU_ISSET_S(i, setsize, desc->bookmaps[j])) {
+				printf(",%d", j);
+				break;
+			}
+		}
+		if (j == desc->nbooks)
+			putchar(',');
+
 		/* Nodes */
 		for (j = 0; j < desc->nnodes; j++) {
 			if (CPU_ISSET_S(i, setsize, desc->nodemaps[j])) {
@@ -883,9 +911,13 @@ print_readable(struct lscpu_desc *desc, int hex)
 	if (desc->nsockets) {
 		print_n(_("Thread(s) per core:"), desc->nthreads / desc->ncores);
 		print_n(_("Core(s) per socket:"), desc->ncores / desc->nsockets);
-		print_n(_("CPU socket(s):"), desc->nsockets);
+		if (desc->nbooks) {
+			print_n(_("Socket(s) per book:"), desc->nsockets / desc->nbooks);
+ 			print_n(_("Book(s):"), desc->nbooks);
+		} else {
+			print_n(_("Socket(s):"), desc->nsockets);
+		}
 	}
-
 	if (desc->nnodes)
 		print_n(_("NUMA node(s):"), desc->nnodes);
 	if (desc->vendor)
