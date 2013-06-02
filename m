Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59816 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab3FBRvg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:51:36 -0400
Received: by mail-wi0-f173.google.com with SMTP id hi5so2027032wib.12
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:51:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/19] lscpu: add max MHz value to make cpu governor effects more visible
Date: Sun,  2 Jun 2013 18:51:08 +0100
Message-Id: <1370195485-27907-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The existing 'CPU MHz' is usually dynamic value, which CPU governor
changes up on needs of CPU demand.  Assuming lscpu is used to gather
information to a hardware inventory the dynamic value is misleading.  For
inventing the maximum MHz value is more sensible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lscpu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index dde227b..fbaaa31 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -148,6 +148,7 @@ struct lscpu_desc {
 	int	hyper;		/* hypervisor vendor ID */
 	int	virtype;	/* VIRT_PARA|FULL|NONE ? */
 	char	*mhz;
+	char	**mmhz;		/* maximum mega hertz */
 	char	*stepping;
 	char    *bogomips;
 	char	*flags;
@@ -230,6 +231,7 @@ enum {
 	COL_ADDRESS,
 	COL_CONFIGURED,
 	COL_ONLINE,
+	COL_MMHZ,
 };
 
 /* column description
@@ -252,7 +254,8 @@ static struct lscpu_coldesc coldescs[] =
 	[COL_POLARIZATION] = { "POLARIZATION", N_("CPU dispatching mode on virtual hardware") },
 	[COL_ADDRESS]      = { "ADDRESS", N_("physical address of a CPU") },
 	[COL_CONFIGURED]   = { "CONFIGURED", N_("shows if the hypervisor has allocated the CPU") },
-	[COL_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU") }
+	[COL_ONLINE]       = { "ONLINE", N_("shows if Linux currently makes use of the CPU") },
+	[COL_MMHZ]	   = { "MMHZ", N_("shows the maximum mhz of the CPU") }
 };
 
 static int
@@ -777,6 +780,18 @@ read_configured(struct lscpu_desc *desc, int num)
 	desc->configured[num] = path_read_s32(_PATH_SYS_CPU "/cpu%d/configure", num);
 }
 
+static void
+read_max_mhz(struct lscpu_desc *desc, int num)
+{
+	if (!path_exist(_PATH_SYS_CPU "/cpu%d/cpufreq/cpuinfo_max_freq", num))
+		return;
+	if (!desc->mmhz)
+		desc->mmhz = xcalloc(desc->ncpuspos, sizeof(char *));
+	xasprintf(&(desc->mmhz[num]), "%.4f",
+		  (float)path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/cpufreq/cpuinfo_max_freq", num) / 1000);
+}
+
 static int
 cachecmp(const void *a, const void *b)
 {
@@ -965,6 +980,10 @@ get_cell_data(struct lscpu_desc *desc, int cpu, int col,
 			snprintf(buf, bufsz,
 				 is_cpu_online(desc, cpu) ? _("yes") : _("no"));
 		break;
+	case COL_MMHZ:
+		if (desc->mmhz)
+			xstrncpy(buf, desc->mmhz[cpu], bufsz);
+		break;
 	}
 	return buf;
 }
@@ -1272,6 +1291,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		print_s(_("Stepping:"), desc->stepping);
 	if (desc->mhz)
 		print_s(_("CPU MHz:"), desc->mhz);
+	if (desc->mmhz)
+		print_s(_("CPU max MHz:"), desc->mmhz[0]);
 	if (desc->bogomips)
 		print_s(_("BogoMIPS:"), desc->bogomips);
 	if (desc->virtflag) {
@@ -1439,6 +1460,7 @@ int main(int argc, char *argv[])
 		read_polarization(desc, i);
 		read_address(desc, i);
 		read_configured(desc, i);
+		read_max_mhz(desc, i);
 	}
 
 	if (desc->caches)
@@ -1485,6 +1507,8 @@ int main(int argc, char *argv[])
 				columns[ncolumns++] = COL_POLARIZATION;
 			if (desc->addresses)
 				columns[ncolumns++] = COL_ADDRESS;
+			if (desc->mmhz)
+				columns[ncolumns++] = COL_MMHZ;
 		}
 		print_readable(desc, columns, ncolumns, mod);
 		break;
-- 
1.8.3

