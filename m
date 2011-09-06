Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010159.811744148@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 08/11] [PATCH] lscpu: add online state to output
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

lscpu only prints lines for online CPUs. At least for the human readable
list the offline CPUs are of interest as well. In order to distinguish
between online and offline CPUs introduce the "Online" column.
By default the human readable output now displays online and offline CPUs.
The parsable output is not changed. It will print only lines for online
CPUs as it used to do.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |    2 +-
 sys-utils/lscpu.c |   18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 6c18e2f..3bf341b 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -21,7 +21,7 @@ which can be fed to other programs.
 
 Some options have a \fIlist\fP argument. The \fIlist\fP argument is a comma
 delimited list of the columns. Currently supported are CPU, Core, Node, Socket,
-Book, Cache, Polarization, Address and Configured columns.
+Book, Cache, Polarization, Address, Configured and Online columns.
 If the \fIlist\fP argument is given then all requested columns are printed in
 the defined order.
 
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index efa5b84..2e45b05 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -182,6 +182,7 @@ struct lscpu_modifier {
 	int compat;
 	int formatted;
 	int hex;
+	int allcpus;
 };
 
 static size_t sysrootlen;
@@ -216,6 +217,7 @@ enum {
 	COL_POLARIZATION,
 	COL_ADDRESS,
 	COL_CONFIGURED,
+	COL_ONLINE,
 };
 
 static const char *colnames[] =
@@ -229,6 +231,7 @@ static const char *colnames[] =
 	[COL_POLARIZATION] = "Polarization",
 	[COL_ADDRESS] = "Address",
 	[COL_CONFIGURED] = "Configured",
+	[COL_ONLINE] = "Online",
 };
 
 
@@ -998,6 +1001,14 @@ print_cell(struct lscpu_desc *desc, int i, int col, int c,
 		else
 			asprintfc(&buffer, "%d", desc->configured[i]);
 		break;
+	case COL_ONLINE:
+		if (!desc->online)
+			break;
+		if (mod->formatted)
+			asprintfc(&buffer, is_cpu_online(desc, i) ? "yes" : "no");
+		else
+			asprintfc(&buffer, "%d", !!is_cpu_online(desc, i));
+		break;
 	}
 	if (mod->formatted) {
 		if (strlen(buffer) == 0)
@@ -1094,7 +1105,7 @@ print_table(struct lscpu_desc *desc, int cols[], int ncols, struct lscpu_modifie
 	for (i = 0; i < desc->ncpus; i++) {
 		struct tt_line *line;
 
-		if (desc->online && !is_cpu_online(desc, i))
+		if (!mod->allcpus && desc->online && !is_cpu_online(desc, i))
 			continue;
 		if (mod->formatted)
 			line = tt_add_line(tt, NULL);
@@ -1321,6 +1332,7 @@ int main(int argc, char *argv[])
 		case 'e':
 			print_cpu_table = 1;
 			mod->formatted = 1;
+			mod->allcpus = 1;
 			ncolumns = -1;
 			if (optarg) {
 				if (*optarg == '=')
@@ -1373,7 +1385,7 @@ int main(int argc, char *argv[])
 	read_basicinfo(desc);
 
 	for (i = 0; i < desc->ncpus; i++) {
-		if (desc->online && !is_cpu_online(desc, i))
+		if (!mod->allcpus && desc->online && !is_cpu_online(desc, i))
 			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
@@ -1402,6 +1414,8 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_CORE;
 		if (desc->caches)
 			columns[ncolumns++] = COL_CACHE;
+		if (desc->online)
+			columns[ncolumns++] = COL_ONLINE;
 		if (desc->configured)
 			columns[ncolumns++] = COL_CONFIGURED;
 		if (desc->polarization)
-- 
1.7.5.4
