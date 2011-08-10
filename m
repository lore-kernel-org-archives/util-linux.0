Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083824.763229490@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:52 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 7/8] [PATCH] lscpu: add cpu polarization to parseable output
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When running in different dispatching mode the virtual cpus may
have different polarizations.
E.g. in "vertical" mode cpus may have a polarization of "vertical:high"
which means the virtual cpu has dedicated physical cpu assigned.
Print this information in the parsable output.

Note that this breaks the current rule that
a) the parseable output contains only numbers
b) these numbers are equal or increased in each line

Since however this new item must be selected with the "list" argument
this shouldn't be a problem.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    2 +-
 sys-utils/lscpu.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -32,7 +32,7 @@ separate CPU cache columns. If no CPU ca
 columns are not printed at all.
 
 The \fIlist\fP argument is comma delimited list of the columns. Currently
-supported are CPU, Core, Node, Socket, Book and Cache columns. If the
+supported are CPU, Core, Node, Socket, Book, Cache and Polarization columns. If the
 \fIlist\fP argument is given then always all requested columns are printed in
 the defined order. The Cache columns are separated by ':'.
 
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -108,6 +108,23 @@ const char *disp_modes[] = {
 	[DISP_VERTICAL]		= N_("vertical")
 };
 
+/* cpu polarization */
+enum {
+	POLAR_UNKNOWN	= 0,
+	POLAR_VLOW,
+	POLAR_VMEDIUM,
+	POLAR_VHIGH,
+	POLAR_HORIZONTAL
+};
+
+const char *polar_modes[] = {
+	[POLAR_UNKNOWN]		= "U",
+	[POLAR_VLOW]		= "VL",
+	[POLAR_VMEDIUM]		= "VM",
+	[POLAR_VHIGH]		= "VH",
+	[POLAR_HORIZONTAL]	= "H"
+};
+
 /* global description */
 struct lscpu_desc {
 	char	*arch;
@@ -149,6 +166,8 @@ struct lscpu_desc {
 
 	int		ncaches;
 	struct cpu_cache *caches;
+
+	int		*polarization;	/* cpu polarization */
 };
 
 static size_t sysrootlen;
@@ -179,7 +198,8 @@ enum {
 	COL_SOCKET,
 	COL_NODE,
 	COL_BOOK,
-	COL_CACHE
+	COL_CACHE,
+	COL_POLARIZATION
 };
 
 static const char *colnames[] =
@@ -189,7 +209,8 @@ static const char *colnames[] =
 	[COL_SOCKET] = "Socket",
 	[COL_NODE] = "Node",
 	[COL_BOOK] = "Book",
-	[COL_CACHE] = "Cache"
+	[COL_CACHE] = "Cache",
+	[COL_POLARIZATION] = "Polarization"
 };
 
 
@@ -717,6 +738,29 @@ read_topology(struct lscpu_desc *desc, i
 	if (book_siblings)
 		add_cpuset_to_array(desc->bookmaps, &desc->nbooks, book_siblings);
 }
+static void
+read_polarization(struct lscpu_desc *desc, int num)
+{
+	char mode[64];
+
+	if (desc->dispatching < 0)
+		return;
+	if (!path_exist(_PATH_SYS_CPU "/cpu%d/polarization", num))
+		return;
+	if (!desc->polarization)
+		desc->polarization = xcalloc(desc->ncpus, sizeof(int));
+	path_getstr(mode, sizeof(mode), _PATH_SYS_CPU "/cpu%d/polarization", num);
+	if (strncmp(mode, "vertical:low", sizeof(mode)) == 0)
+		desc->polarization[num] = POLAR_VLOW;
+	else if (strncmp(mode, "vertical:medium", sizeof(mode)) == 0)
+		desc->polarization[num] = POLAR_VMEDIUM;
+	else if (strncmp(mode, "vertical:high", sizeof(mode)) == 0)
+		desc->polarization[num] = POLAR_VHIGH;
+	else if (strncmp(mode, "horizontal", sizeof(mode)) == 0)
+		desc->polarization[num] = POLAR_HORIZONTAL;
+	else
+		desc->polarization[num] = POLAR_UNKNOWN;
+}
 
 static int
 cachecmp(const void *a, const void *b)
@@ -868,6 +912,10 @@ print_parsable_cell(struct lscpu_desc *d
 				putchar(',');
 		}
 		break;
+	case COL_POLARIZATION:
+		if (desc->polarization)
+			printf("%s", polar_modes[desc->polarization[i]]);
+		break;
 	}
 }
 
@@ -1181,6 +1229,7 @@ int main(int argc, char *argv[])
 			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
+		read_polarization(desc, i);
 	}
 
 	qsort(desc->caches, desc->ncaches, sizeof(struct cpu_cache), cachecmp);
