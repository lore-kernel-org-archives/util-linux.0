Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083825.105988796@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:53 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 8/8] [PATCH] lscpu: add physical cpu address to parseable output
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Print also the physical cpu address for each logical cpu in parsable
output if selected and present via sysfs.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    5 +++--
 sys-utils/lscpu.c |   22 ++++++++++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -32,8 +32,9 @@ separate CPU cache columns. If no CPU ca
 columns are not printed at all.
 
 The \fIlist\fP argument is comma delimited list of the columns. Currently
-supported are CPU, Core, Node, Socket, Book, Cache and Polarization columns. If the
-\fIlist\fP argument is given then always all requested columns are printed in
+supported are CPU, Core, Node, Socket, Book, Cache, Polarization and Address
+columns.
+If the \fIlist\fP argument is given then always all requested columns are printed in
 the defined order. The Cache columns are separated by ':'.
 
 Note that the optional \fIlist\fP argument cannot be separated from the
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -168,6 +168,7 @@ struct lscpu_desc {
 	struct cpu_cache *caches;
 
 	int		*polarization;	/* cpu polarization */
+	int		*addresses;	/* physical cpu addresses */
 };
 
 static size_t sysrootlen;
@@ -199,7 +200,8 @@ enum {
 	COL_NODE,
 	COL_BOOK,
 	COL_CACHE,
-	COL_POLARIZATION
+	COL_POLARIZATION,
+	COL_ADDRESS
 };
 
 static const char *colnames[] =
@@ -210,7 +212,8 @@ static const char *colnames[] =
 	[COL_NODE] = "Node",
 	[COL_BOOK] = "Book",
 	[COL_CACHE] = "Cache",
-	[COL_POLARIZATION] = "Polarization"
+	[COL_POLARIZATION] = "Polarization",
+	[COL_ADDRESS] = "Address"
 };
 
 
@@ -762,6 +765,16 @@ read_polarization(struct lscpu_desc *des
 		desc->polarization[num] = POLAR_UNKNOWN;
 }
 
+static void
+read_address(struct lscpu_desc *desc, int num)
+{
+	if (!path_exist(_PATH_SYS_CPU "/cpu%d/address", num))
+		return;
+	if (!desc->addresses)
+		desc->addresses = xcalloc(desc->ncpus, sizeof(int));
+	desc->addresses[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/address", num);
+}
+
 static int
 cachecmp(const void *a, const void *b)
 {
@@ -916,6 +929,10 @@ print_parsable_cell(struct lscpu_desc *d
 		if (desc->polarization)
 			printf("%s", polar_modes[desc->polarization[i]]);
 		break;
+	case COL_ADDRESS:
+		if (desc->addresses)
+			printf("%d", desc->addresses[i]);
+		break;
 	}
 }
 
@@ -1230,6 +1247,7 @@ int main(int argc, char *argv[])
 		read_topology(desc, i);
 		read_cache(desc, i);
 		read_polarization(desc, i);
+		read_address(desc, i);
 	}
 
 	qsort(desc->caches, desc->ncaches, sizeof(struct cpu_cache), cachecmp);
