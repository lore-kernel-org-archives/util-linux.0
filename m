Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] lscpu: add drawer support
Date: Tue, 14 Jun 2016 09:22:34 +0200
In-Reply-To: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1465888954-62716-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1465888954-62716-2-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The s390 architecture gained another cpu topology level called
"drawer" which is above the book level.

Add support for this to lscpu.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |  5 ++++-
 sys-utils/lscpu.c | 51 +++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 35dfe7f8790b..167567fa9be0 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -50,8 +50,11 @@ The logical socket number.  A socket can contain several cores.
 .B BOOK
 The logical book number.  A book can contain several sockets.
 .TP
+.B DRAWER
+The logical drawer number.  A drawer can contain several books.
+.TP
 .B NODE
-The logical NUMA node number.  A node may contain several books.
+The logical NUMA node number.  A node may contain several drawers.
 .TP
 .B CACHE
 Information about how caches are shared between CPUs.
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 267e728e1c4a..41316ccafeec 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -240,6 +240,11 @@ struct lscpu_desc {
 	int		*idx2nodenum;	/* Support for discontinuous nodes */
 	cpu_set_t	**nodemaps;	/* array with NUMA nodes */
 
+	/* drawers -- based on drawer_siblings (internal kernel map of cpuX's
+	 * hardware threads within the same drawer */
+	int		ndrawers;	/* number of all online drawers */
+	cpu_set_t	**drawermaps;	/* unique drawer_siblings */
+
 	/* books -- based on book_siblings (internal kernel map of cpuX's
 	 * hardware threads within the same book */
 	int		nbooks;		/* number of all online books */
@@ -303,6 +308,7 @@ enum {
 	COL_SOCKET,
 	COL_NODE,
 	COL_BOOK,
+	COL_DRAWER,
 	COL_CACHE,
 	COL_POLARIZATION,
 	COL_ADDRESS,
@@ -328,6 +334,7 @@ static struct lscpu_coldesc coldescs[] =
 	[COL_SOCKET]       = { "SOCKET", N_("logical socket number") },
 	[COL_NODE]         = { "NODE", N_("logical NUMA node number") },
 	[COL_BOOK]         = { "BOOK", N_("logical book number") },
+	[COL_DRAWER]       = { "DRAWER", N_("logical drawer number") },
 	[COL_CACHE]        = { "CACHE", N_("shows how caches are shared between CPUs") },
 	[COL_POLARIZATION] = { "POLARIZATION", N_("CPU dispatching mode on virtual hardware") },
 	[COL_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU") },
@@ -974,7 +981,8 @@ static int add_cpuset_to_array(cpu_set_t **ary, int *items, cpu_set_t *set)
 static void
 read_topology(struct lscpu_desc *desc, int idx)
 {
-	cpu_set_t *thread_siblings, *core_siblings, *book_siblings;
+	cpu_set_t *thread_siblings, *core_siblings;
+	cpu_set_t *book_siblings, *drawer_siblings;
 	int num = real_cpu_num(desc, idx);
 
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/topology/thread_siblings", num))
@@ -988,9 +996,13 @@ read_topology(struct lscpu_desc *desc, int idx)
 	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/book_siblings", num))
 		book_siblings = path_read_cpuset(maxcpus, _PATH_SYS_CPU
 					    "/cpu%d/topology/book_siblings", num);
+	drawer_siblings = NULL;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/drawer_siblings", num))
+		drawer_siblings = path_read_cpuset(maxcpus, _PATH_SYS_CPU
+					    "/cpu%d/topology/drawer_siblings", num);
 
 	if (!desc->coremaps) {
-		int nbooks, nsockets, ncores, nthreads;
+		int ndrawers, nbooks, nsockets, ncores, nthreads;
 		size_t setsize = CPU_ALLOC_SIZE(maxcpus);
 
 		/* threads within one core */
@@ -1016,12 +1028,17 @@ read_topology(struct lscpu_desc *desc, int idx)
 		if (!nbooks)
 			nbooks = 1;
 
+		/* number of drawers */
+		ndrawers = desc->ncpus / nbooks / nthreads / ncores / nsockets;
+		if (!ndrawers)
+			ndrawers = 1;
+
 		/* all threads, see also read_basicinfo()
 		 * -- fallback for kernels without
 		 *    /sys/devices/system/cpu/online.
 		 */
 		if (!desc->nthreads)
-			desc->nthreads = nbooks * nsockets * ncores * nthreads;
+			desc->nthreads = ndrawers * nbooks * nsockets * ncores * nthreads;
 
 		/* For each map we make sure that it can have up to ncpuspos
 		 * entries. This is because we cannot reliably calculate the
@@ -1033,12 +1050,16 @@ read_topology(struct lscpu_desc *desc, int idx)
 		desc->socketmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 		if (book_siblings)
 			desc->bookmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
+		if (drawer_siblings)
+			desc->drawermaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
 	add_cpuset_to_array(desc->coremaps, &desc->ncores, thread_siblings);
 	if (book_siblings)
 		add_cpuset_to_array(desc->bookmaps, &desc->nbooks, book_siblings);
+	if (drawer_siblings)
+		add_cpuset_to_array(desc->drawermaps, &desc->ndrawers, drawer_siblings);
 }
 
 static void
@@ -1289,6 +1310,11 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 				     desc->nnodes, setsize, &i) == 0)
 			snprintf(buf, bufsz, "%d", desc->idx2nodenum[i]);
 		break;
+	case COL_DRAWER:
+		if (cpuset_ary_isset(cpu, desc->drawermaps,
+				     desc->ndrawers, setsize, &i) == 0)
+			snprintf(buf, bufsz, "%zu", i);
+		break;
 	case COL_BOOK:
 		if (cpuset_ary_isset(cpu, desc->bookmaps,
 				     desc->nbooks, setsize, &i) == 0)
@@ -1635,9 +1661,9 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	}
 
 	if (desc->nsockets) {
-		int cores_per_socket, sockets_per_book, books;
+		int cores_per_socket, sockets_per_book, books_per_drawer, drawers;
 
-		cores_per_socket = sockets_per_book = books = 0;
+		cores_per_socket = sockets_per_book = books_per_drawer = drawers = 0;
 		/* s390 detects its cpu topology via /proc/sysinfo, if present.
 		 * Using simply the cpu topology masks in sysfs will not give
 		 * usable results since everything is virtualized. E.g.
@@ -1649,11 +1675,12 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		if (path_exist(_PATH_PROC_SYSINFO)) {
 			FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
 			char pbuf[BUFSIZ];
-			int t0, t1, t2;
+			int t0, t1;
 
 			while (fd && fgets(pbuf, sizeof(pbuf), fd) != NULL) {
 				if (sscanf(pbuf, "CPU Topology SW:%d%d%d%d%d%d",
-					   &t0, &t1, &t2, &books, &sockets_per_book,
+					   &t0, &t1, &drawers, &books_per_drawer,
+					   &sockets_per_book,
 					   &cores_per_socket) == 6)
 					break;
 			}
@@ -1666,7 +1693,13 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		if (desc->nbooks) {
 			print_n(_("Socket(s) per book:"),
 				sockets_per_book ?: desc->nsockets / desc->nbooks);
-			print_n(_("Book(s):"), books ?: desc->nbooks);
+			if (desc->ndrawers) {
+				print_n(_("Book(s) per drawer:"),
+					books_per_drawer ?: desc->nbooks / desc->ndrawers);
+				print_n(_("Drawers(s):"), drawers ?: desc->ndrawers);
+			} else {
+				print_n(_("Book(s):"), books_per_drawer ?: desc->nbooks);
+			}
 		} else {
 			print_n(_("Socket(s):"), sockets_per_book ?: desc->nsockets);
 		}
@@ -1899,6 +1932,8 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_CPU;
 			if (desc->nodemaps)
 				columns[ncolumns++] = COL_NODE;
+			if (desc->drawermaps)
+				columns[ncolumns++] = COL_DRAWER;
 			if (desc->bookmaps)
 				columns[ncolumns++] = COL_BOOK;
 			if (desc->socketmaps)
-- 
2.6.6
