Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110810083824.427282451@de.ibm.com>
Date: Wed, 10 Aug 2011 10:36:51 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 6/8] [PATCH] lscpu: show dispatching mode
References: <20110810083645.135814950@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

A virtual guest my run in either "horiziontal" or "vertical" mode
which is the mode in which the underlying hypervisor schedules the
guest cpu.
Since this is of interest print this in the readable output.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -97,6 +97,17 @@ struct cpu_cache {
 	cpu_set_t	**sharedmaps;
 };
 
+/* dispatching modes */
+enum {
+	DISP_HORIZONTAL = 0,
+	DISP_VERTICAL	= 1
+};
+
+const char *disp_modes[] = {
+	[DISP_HORIZONTAL]	= N_("horizontal"),
+	[DISP_VERTICAL]		= N_("vertical")
+};
+
 /* global description */
 struct lscpu_desc {
 	char	*arch;
@@ -110,6 +121,7 @@ struct lscpu_desc {
 	char	*stepping;
 	char    *bogomips;
 	char	*flags;
+	int	dispatching;	/* none, horizontal or vertical */
 	int	mode;		/* rm, lm or/and tm */
 
 	int		ncpus;		/* number of CPUs */
@@ -478,6 +490,12 @@ read_basicinfo(struct lscpu_desc *desc)
 		desc->online = path_cpulist(_PATH_SYS_SYSTEM "/cpu/online");
 		desc->nthreads = CPU_COUNT_S(setsize, desc->online);
 	}
+
+	/* get dispatching mode */
+	if (path_exist(_PATH_SYS_SYSTEM "/cpu/dispatching"))
+		desc->dispatching = path_getnum(_PATH_SYS_SYSTEM "/cpu/dispatching");
+	else
+		desc->dispatching = -1;
 }
 
 static int
@@ -1065,6 +1083,8 @@ print_readable(struct lscpu_desc *desc,
 		print_s(_("Hypervisor vendor:"), hv_vendors[desc->hyper]);
 		print_s(_("Virtualization type:"), virt_types[desc->virtype]);
 	}
+	if (desc->dispatching >= 0)
+		print_s(_("Dispatching mode:"), disp_modes[desc->dispatching]);
 	if (desc->ncaches) {
 		char buf[512];
 		int i;
