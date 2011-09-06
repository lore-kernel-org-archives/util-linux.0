Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010159.243405331@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:58 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 07/11] [PATCH] lscpu: add configured state to output
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

CPUs may be in a configured or deconfigured state depending if the
CPU resource may be used by the guest.
If a CPU is in configured state the guest may use it (i.e. set it
online). It it is in deconfigured state it cannot use it before
changing its state to configured.
Display this CPU attribute as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    2 +-
 sys-utils/lscpu.c |   28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index db7fe72..6c18e2f 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -21,7 +21,7 @@ which can be fed to other programs.
 
 Some options have a \fIlist\fP argument. The \fIlist\fP argument is a comma
 delimited list of the columns. Currently supported are CPU, Core, Node, Socket,
-Book, Cache, Polarization and Address columns.
+Book, Cache, Polarization, Address and Configured columns.
 If the \fIlist\fP argument is given then all requested columns are printed in
 the defined order.
 
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index bb0201b..efa5b84 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -175,6 +175,7 @@ struct lscpu_desc {
 
 	int		*polarization;	/* cpu polarization */
 	int		*addresses;	/* physical cpu addresses */
+	int		*configured;	/* cpu configured */
 };
 
 struct lscpu_modifier {
@@ -213,7 +214,8 @@ enum {
 	COL_BOOK,
 	COL_CACHE,
 	COL_POLARIZATION,
-	COL_ADDRESS
+	COL_ADDRESS,
+	COL_CONFIGURED,
 };
 
 static const char *colnames[] =
@@ -225,7 +227,8 @@ static const char *colnames[] =
 	[COL_BOOK] = "Book",
 	[COL_CACHE] = "Cache",
 	[COL_POLARIZATION] = "Polarization",
-	[COL_ADDRESS] = "Address"
+	[COL_ADDRESS] = "Address",
+	[COL_CONFIGURED] = "Configured",
 };
 
 
@@ -787,6 +790,16 @@ read_address(struct lscpu_desc *desc, int num)
 	desc->addresses[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/address", num);
 }
 
+static void
+read_configured(struct lscpu_desc *desc, int num)
+{
+	if (!path_exist(_PATH_SYS_CPU "/cpu%d/configure", num))
+		return;
+	if (!desc->configured)
+		desc->configured = xcalloc(desc->ncpus, sizeof(int));
+	desc->configured[num] = path_getnum(_PATH_SYS_CPU "/cpu%d/configure", num);
+}
+
 static int
 cachecmp(const void *a, const void *b)
 {
@@ -977,6 +990,14 @@ print_cell(struct lscpu_desc *desc, int i, int col, int c,
 		if (desc->addresses)
 			asprintfc(&buffer, "%d", desc->addresses[i]);
 		break;
+	case COL_CONFIGURED:
+		if (!desc->configured)
+			break;
+		if (mod->formatted)
+			asprintfc(&buffer, desc->configured[i] ? "yes" : "no");
+		else
+			asprintfc(&buffer, "%d", desc->configured[i]);
+		break;
 	}
 	if (mod->formatted) {
 		if (strlen(buffer) == 0)
@@ -1358,6 +1379,7 @@ int main(int argc, char *argv[])
 		read_cache(desc, i);
 		read_polarization(desc, i);
 		read_address(desc, i);
+		read_configured(desc, i);
 	}
 
 	qsort(desc->caches, desc->ncaches, sizeof(struct cpu_cache), cachecmp);
@@ -1380,6 +1402,8 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_CORE;
 		if (desc->caches)
 			columns[ncolumns++] = COL_CACHE;
+		if (desc->configured)
+			columns[ncolumns++] = COL_CONFIGURED;
 		if (desc->polarization)
 			columns[ncolumns++] = COL_POLARIZATION;
 		if (desc->addresses)
-- 
1.7.5.4
