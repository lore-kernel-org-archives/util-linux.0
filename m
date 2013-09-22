Return-Path: util-linux-owner@vger.kernel.org
Received: from g1t0029.austin.hp.com ([15.216.28.36]:13970 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab3IVDnm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 Sep 2013 23:43:42 -0400
Message-ID: <1379821420.2145.50.camel@buesod1.americas.hpqcorp.net>
Subject: [PATCH] lscpu: report cpu min mhz
From: Davidlohr Bueso <davidlohr@hp.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Date: Sat, 21 Sep 2013 20:43:40 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <davidlohr@hp.com>

The lscpu tool only shows the current and max CPU frequencies, however,
in many scenarios this is not enough. If there are energy saving situations
(like some CPUs being idle, or not fully used) the cpugov can lower this value.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 sys-utils/lscpu.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 98cee16..71ee84a 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -148,7 +148,8 @@ struct lscpu_desc {
 	int	hyper;		/* hypervisor vendor ID */
 	int	virtype;	/* VIRT_PARA|FULL|NONE ? */
 	char	*mhz;
-	char	**mmhz;		/* maximum mega hertz */
+	char	**maxmhz;	/* maximum mega hertz */
+	char	**minmhz;	/* minimum mega hertz */
 	char	*stepping;
 	char    *bogomips;
 	char	*flags;
@@ -231,7 +232,8 @@ enum {
 	COL_ADDRESS,
 	COL_CONFIGURED,
 	COL_ONLINE,
-	COL_MMHZ,
+	COL_MAXMHZ,
+	COL_MINMHZ,
 };
 
 /* column description
@@ -255,7 +257,8 @@ static struct lscpu_coldesc coldescs[] =
 	[COL_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU") },
 	[COL_CONFIGURED]   = { "CONFIGURED", N_("shows if the hypervisor has allocated the CPU") },
 	[COL_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU") },
-	[COL_MMHZ]	   = { "MMHZ", N_("shows the maximum mhz of the CPU") }
+	[COL_MAXMHZ]	   = { "MAXMHZ", N_("shows the maximum mhz of the CPU") },
+	[COL_MINMHZ]	   = { "MINMHZ", N_("shows the minimum mhz of the CPU") }
 };
 
 static int
@@ -785,13 +788,25 @@ read_max_mhz(struct lscpu_desc *desc, int num)
 {
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/cpufreq/cpuinfo_max_freq", num))
 		return;
-	if (!desc->mmhz)
-		desc->mmhz = xcalloc(desc->ncpuspos, sizeof(char *));
-	xasprintf(&(desc->mmhz[num]), "%.4f",
+	if (!desc->maxmhz)
+		desc->maxmhz = xcalloc(desc->ncpuspos, sizeof(char *));
+	xasprintf(&(desc->maxmhz[num]), "%.4f",
 		  (float)path_read_s32(_PATH_SYS_CPU
 				       "/cpu%d/cpufreq/cpuinfo_max_freq", num) / 1000);
 }
 
+static void
+read_min_mhz(struct lscpu_desc *desc, int num)
+{
+	if (!path_exist(_PATH_SYS_CPU "/cpu%d/cpufreq/cpuinfo_min_freq", num))
+		return;
+	if (!desc->minmhz)
+		desc->minmhz = xcalloc(desc->ncpuspos, sizeof(char *));
+	xasprintf(&(desc->minmhz[num]), "%.4f",
+		  (float)path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/cpufreq/cpuinfo_min_freq", num) / 1000);
+}
+
 static int
 cachecmp(const void *a, const void *b)
 {
@@ -980,9 +995,13 @@ get_cell_data(struct lscpu_desc *desc, int cpu, int col,
 			snprintf(buf, bufsz,
 				 is_cpu_online(desc, cpu) ? _("yes") : _("no"));
 		break;
-	case COL_MMHZ:
-		if (desc->mmhz)
-			xstrncpy(buf, desc->mmhz[cpu], bufsz);
+	case COL_MAXMHZ:
+		if (desc->maxmhz)
+			xstrncpy(buf, desc->maxmhz[cpu], bufsz);
+		break;
+	case COL_MINMHZ:
+		if (desc->minmhz)
+			xstrncpy(buf, desc->minmhz[cpu], bufsz);
 		break;
 	}
 	return buf;
@@ -1291,8 +1310,10 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		print_s(_("Stepping:"), desc->stepping);
 	if (desc->mhz)
 		print_s(_("CPU MHz:"), desc->mhz);
-	if (desc->mmhz)
-		print_s(_("CPU max MHz:"), desc->mmhz[0]);
+	if (desc->maxmhz)
+		print_s(_("CPU max MHz:"), desc->maxmhz[0]);
+	if (desc->minmhz)
+		print_s(_("CPU min MHz:"), desc->minmhz[0]);
 	if (desc->bogomips)
 		print_s(_("BogoMIPS:"), desc->bogomips);
 	if (desc->virtflag) {
@@ -1461,6 +1482,7 @@ int main(int argc, char *argv[])
 		read_address(desc, i);
 		read_configured(desc, i);
 		read_max_mhz(desc, i);
+		read_min_mhz(desc, i);
 	}
 
 	if (desc->caches)
@@ -1507,8 +1529,10 @@ int main(int argc, char *argv[])
 				columns[ncolumns++] = COL_POLARIZATION;
 			if (desc->addresses)
 				columns[ncolumns++] = COL_ADDRESS;
-			if (desc->mmhz)
-				columns[ncolumns++] = COL_MMHZ;
+			if (desc->maxmhz)
+				columns[ncolumns++] = COL_MAXMHZ;
+			if (desc->minmhz)
+				columns[ncolumns++] = COL_MINMHZ;
 		}
 		print_readable(desc, columns, ncolumns, mod);
 		break;
-- 
1.7.11.7



