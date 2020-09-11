Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD47C433E2
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 17:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D012075A
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 17:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY9JDDoQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgIKRDQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgIKPDu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 11:03:50 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E545BC0617AB
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:57 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id cy2so5236110qvb.0
        for <util-linux@vger.kernel.org>; Fri, 11 Sep 2020 06:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6klTCdVdD91GXSyr1/x19Iiy6UsnPTyirF6NobTpms=;
        b=OY9JDDoQ6YUsHyTmZUwL5sq+vVGGONdP835778PTEPcvp8cv65VxdnaJ5jlBY1kOfT
         9Ruh9scPIMWdmGSP92avXpzqQcjwj/5h7j8PpmK26Je55GrDOfRvXwPrAST+vvvhS/Gl
         3zU/eMrjhoF9uUdv/R0RHc93EmXPM99Fzje6q1fBhvfrExDn8uq5fh5VqlqCgWMJnrao
         qdukB9JE3O1UmD47so89KVEQVJsVt2FSqvf7nJ9IiisDZFgmSzU2jP97VKbLIYRXRFJq
         ymXaCK2Vfkm1qHyRqn7od5wi2ZN0/QmuxHsa0X3+aFtP7F1N6pw/apkVHZqq2/8SltPT
         CsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6klTCdVdD91GXSyr1/x19Iiy6UsnPTyirF6NobTpms=;
        b=WtjAwL7Rzdy3KZuXvHbTg0pegY5OQUNjZT3HKPb+Bt/Jw66IbZnIdUQsG0LR06sU5r
         wsYakeajxpTJf53hNqCo9sjHmHkTyKLYfnKVPvjo0iN60ueKQz7flas7Yr/L/krf3aH9
         btKh2WiGl5g2oQLk5pNa1nW2uq03Tkj7/Ch7u7D6z+yoBgWgfk7pMxGeV4BEy14wZuD2
         ZVOSmwvcwiRFaZgtixH96vmqEPqnbhkYjwIq3Tbb5KPhI+rX+p+TI7KljFZXyjr5J0Sc
         MvdAqusbPRUjgSiR79djifoGsw1EiRyiEu2B8mjmfbLlbQ4RoFXAwx2EHIVrplfePCJU
         D/kA==
X-Gm-Message-State: AOAM533Y822DrhEWTmHw2bz/lulElX2Atdz3pWfiLK/ZIg8/CLufIMMF
        LvNsTWOz6OD8TbtRe30OSF14eCZd+w==
X-Google-Smtp-Source: ABdhPJxkeAznykeYcwidthPRwmPE/xuwJYB5RnEavO1NrhKhMrWGNaWefffmpUVqGg0t0FGEnzd6Mg==
X-Received: by 2002:a0c:b308:: with SMTP id s8mr2081092qve.31.1599832436980;
        Fri, 11 Sep 2020 06:53:56 -0700 (PDT)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r24sm2566572qtm.70.2020.09.11.06.53.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 06:53:56 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH 1/4] lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
Date:   Fri, 11 Sep 2020 09:53:25 -0400
Message-Id: <20200911135328.1465-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911135328.1465-1-msys.mizuma@gmail.com>
References: <20200911135328.1465-1-msys.mizuma@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

lscpu may show the wrong number of sockets if the machine is aarch64 and
doesn't have ACPI PPTT.

That's because lscpu show the number of sockets by using a sysfs entry
(cpu/cpuX/topology/core_siblings). The sysfs entry is set by MPIDR_EL1
register if the machine doesn't have ACPI PPTT. MPIDR_EL1 doesn't show
the physical socket information directly. It shows the affinity level.

According to linux/arch/arm64/kernel/topology.c:store_cpu_topology(),
the top level of affinity is called as 'Cluster'.

Use Cluster instead of Socket on the machine which doesn't have ACPI PPTT.

Note, ARM SBBR v1.2 requires ACPI PPTT, so this patch is needed for the
machine which is based on SBBR v1.0 and v1.1.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 sys-utils/lscpu.1 |  3 +++
 sys-utils/lscpu.c | 69 ++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index 1ef6ce021..928d39dee 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -52,6 +52,9 @@ The logical core number.  A core can contain several CPUs.
 .B SOCKET
 The logical socket number.  A socket can contain several cores.
 .TP
+.B CLUSTER
+The logical cluster number.  A cluster can contain several cores.
+.TP
 .B BOOK
 The logical book number.  A book can contain several sockets.
 .TP
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index ca085b665..8c823c170 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -68,6 +68,7 @@
 #define _PATH_SYS_HYP_FEATURES	"/sys/hypervisor/properties/features"
 #define _PATH_SYS_CPU		_PATH_SYS_SYSTEM "/cpu"
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
+#define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
 
 /* Xen Domain feature flag used for /sys/hypervisor/properties/features */
 #define XENFEAT_supervisor_mode_kernel		3
@@ -155,6 +156,7 @@ enum {
 	COL_CPU_CPU,
 	COL_CPU_CORE,
 	COL_CPU_SOCKET,
+	COL_CPU_CLUSTER,
 	COL_CPU_NODE,
 	COL_CPU_BOOK,
 	COL_CPU_DRAWER,
@@ -196,6 +198,7 @@ static struct lscpu_coldesc coldescs_cpu[] =
 {
 	[COL_CPU_CPU]          = { "CPU", N_("logical CPU number"), SCOLS_FL_RIGHT, 1 },
 	[COL_CPU_CORE]         = { "CORE", N_("logical core number"), SCOLS_FL_RIGHT },
+	[COL_CPU_CLUSTER]      = { "CLUSTER", N_("logical cluster number"), SCOLS_FL_RIGHT },
 	[COL_CPU_SOCKET]       = { "SOCKET", N_("logical socket number"), SCOLS_FL_RIGHT },
 	[COL_CPU_NODE]         = { "NODE", N_("logical NUMA node number"), SCOLS_FL_RIGHT },
 	[COL_CPU_BOOK]         = { "BOOK", N_("logical book number"), SCOLS_FL_RIGHT },
@@ -224,6 +227,26 @@ static struct lscpu_coldesc coldescs_cache[] =
 	[COL_CACHE_COHERENCYSIZE] = { "COHERENCY-SIZE", N_("minimum amount of data in bytes transferred from memory to cache"), SCOLS_FL_RIGHT }
 };
 
+static int is_fallback_to_cluster(struct lscpu_desc *desc)
+{
+	char *arch;
+	struct stat st;
+	struct utsname utsbuf;
+
+	if (desc)
+		arch = desc->arch;
+	else {
+		if (uname(&utsbuf) == -1)
+			err(EXIT_FAILURE, _("error: uname failed"));
+		arch = utsbuf.machine;
+	}
+
+	if (!(strcmp(arch, "aarch64")) && (stat(_PATH_ACPI_PPTT, &st) < 0))
+		return 1;
+	else
+		return 0;
+}
+
 
 static int get_cache_full_size(struct lscpu_desc *desc, struct cpu_cache *ca, uint64_t *res);
 
@@ -231,12 +254,21 @@ static int
 cpu_column_name_to_id(const char *name, size_t namesz)
 {
 	size_t i;
+	int is_cluster = is_fallback_to_cluster(NULL);
 
 	for (i = 0; i < ARRAY_SIZE(coldescs_cpu); i++) {
 		const char *cn = coldescs_cpu[i].name;
 
-		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
+		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz)) {
+			if ((!strncasecmp(cn, "cluster", namesz)) && (!is_cluster)) {
+				warnx(_("%s doesn't work on this machine. Use socket."), name);
+				return -1;
+			} else if ((!strncasecmp(cn, "socket", namesz)) && (is_cluster)) {
+				warnx(_("%s doesn't work on this machine. Use cluster."), name);
+				return -1;
+			}
 			return i;
+		}
 	}
 	warnx(_("unknown column: %s"), name);
 	return -1;
@@ -1506,6 +1538,7 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 		}
 		break;
 	case COL_CPU_SOCKET:
+	case COL_CPU_CLUSTER:
 		if (mod->physical) {
 			if (desc->socketids[idx] ==  -1)
 				snprintf(buf, bufsz, "-");
@@ -2100,6 +2133,7 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		int threads_per_core, cores_per_socket, sockets_per_book;
 		int books_per_drawer, drawers;
 		FILE *fd;
+		int is_cluster;
 
 		threads_per_core = cores_per_socket = sockets_per_book = 0;
 		books_per_drawer = drawers = 0;
@@ -2124,12 +2158,19 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			if (fd)
 				fclose(fd);
 		}
+
+		is_cluster = is_fallback_to_cluster(desc);
+
 		if (desc->mtid)
 			threads_per_core = atoi(desc->mtid) + 1;
 		add_summary_n(tb, _("Thread(s) per core:"),
 			threads_per_core ?: desc->nthreads / desc->ncores);
-		add_summary_n(tb, _("Core(s) per socket:"),
-			cores_per_socket ?: desc->ncores / desc->nsockets);
+		if (is_cluster)
+			add_summary_n(tb, _("Core(s) per cluster:"),
+				cores_per_socket ?: desc->ncores / desc->nsockets);
+		else
+			add_summary_n(tb, _("Core(s) per socket:"),
+				cores_per_socket ?: desc->ncores / desc->nsockets);
 		if (desc->nbooks) {
 			add_summary_n(tb, _("Socket(s) per book:"),
 				sockets_per_book ?: desc->nsockets / desc->nbooks);
@@ -2141,7 +2182,11 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 				add_summary_n(tb, _("Book(s):"), books_per_drawer ?: desc->nbooks);
 			}
 		} else {
-			add_summary_n(tb, _("Socket(s):"), sockets_per_book ?: desc->nsockets);
+			if (is_cluster)
+				add_summary_n(tb, _("Cluster(s):"), desc->nsockets);
+			else
+				add_summary_n(tb, _("Socket(s):"),
+						sockets_per_book ?: desc->nsockets);
 		}
 	}
 	if (desc->nnodes)
@@ -2300,6 +2345,7 @@ int main(int argc, char *argv[])
 	int columns[ARRAY_SIZE(coldescs_cpu)], ncolumns = 0;
 	int cpu_modifier_specified = 0;
 	size_t setsize;
+	int is_cluster;
 
 	enum {
 		OPT_OUTPUT_ALL = CHAR_MAX + 1,
@@ -2479,6 +2525,8 @@ int main(int argc, char *argv[])
 	read_hypervisor(desc, mod);
 	arm_cpu_decode(desc);
 
+	is_cluster = is_fallback_to_cluster(desc);
+
 	switch(mod->mode) {
 	case OUTPUT_SUMMARY:
 		print_summary(desc, mod);
@@ -2501,7 +2549,10 @@ int main(int argc, char *argv[])
 		if (!ncolumns) {
 			columns[ncolumns++] = COL_CPU_CPU;
 			columns[ncolumns++] = COL_CPU_CORE;
-			columns[ncolumns++] = COL_CPU_SOCKET;
+			if (is_cluster)
+				columns[ncolumns++] = COL_CPU_CLUSTER;
+			else
+				columns[ncolumns++] = COL_CPU_SOCKET;
 			columns[ncolumns++] = COL_CPU_NODE;
 			columns[ncolumns++] = COL_CPU_CACHE;
 			mod->compat = 1;
@@ -2518,8 +2569,12 @@ int main(int argc, char *argv[])
 				columns[ncolumns++] = COL_CPU_DRAWER;
 			if (desc->bookmaps)
 				columns[ncolumns++] = COL_CPU_BOOK;
-			if (desc->socketmaps)
-				columns[ncolumns++] = COL_CPU_SOCKET;
+			if (desc->socketmaps) {
+				if (is_cluster)
+					columns[ncolumns++] = COL_CPU_CLUSTER;
+				else
+					columns[ncolumns++] = COL_CPU_SOCKET;
+			}
 			if (desc->coremaps)
 				columns[ncolumns++] = COL_CPU_CORE;
 			if (desc->caches)
-- 
2.27.0

