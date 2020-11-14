Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D4BC5519F
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B6C2225D
	for <util-linux@archiver.kernel.org>; Sat, 14 Nov 2020 04:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go06FYYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKNEN1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 13 Nov 2020 23:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNEN0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 13 Nov 2020 23:13:26 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC6CC0613D1
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:26 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d9so11617243qke.8
        for <util-linux@vger.kernel.org>; Fri, 13 Nov 2020 20:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T/FhlJyxbap7nZNt4mhRzJvM3XSZz6ymIEtxXcGNEeg=;
        b=go06FYYdqMyCbO4MdhlfXbnczRvU0ypKn9s080uz5xY/CLGU1mWEhD026WJguX3f6I
         sCiWRfFYVMg+AAsgj/QeLhCMyI89k7YftHKAAz+HAAI2zKA7vN5JT9KxTsM4W6t0nuRN
         /tPxi2jsdy38ZbKBQgdNxqoRPLLyQV8+fFYEmGtsStgmHRQherdPT0wQkMXUjEsEcoXF
         nhwWpHktnzNJEZQxkAIkYL3X5sD36JRrxI1Fb8WwFvO+wsaT8/IGWbd3dI9wtXnBnfqb
         AT7USQp0ocLEoHABvXf4VWXbLvQvuRlUWg8TfwoeonlkNWPXO+gdQcnVulBjnh6smB7h
         gIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T/FhlJyxbap7nZNt4mhRzJvM3XSZz6ymIEtxXcGNEeg=;
        b=tevCYszfSmTRvdZnniWh9WNF60awazI97PTTeVPycR4PRlRYLcmaYIuVWsudu4+XdJ
         r6OSh2Yyv6nYFSNs+UOu7+X8avjdrCOouG31/RahpYs1eJhV/jvFnXHoQKnU5IqMnaSx
         ICyQPkerYyzbQ9u+MJdPFLKid934Lpbr5d4P/2hh+uEb6EIrrVdmP9hfWxww+1p8RLFH
         88GXXmyopvQceWsnkiALRIe82o7NCswDDKYabbBbdMUbYIhZjNPM+mMoHjykDlyw1/qL
         pnkIAlyIozIRrAHZFYCnAJFX5wfx7UuDkEIfMMqj03eA0Vjztu1gip+3S+7ZQyQjFmg5
         DSJA==
X-Gm-Message-State: AOAM530woDavWLtENjCih5LN34P/2Kz0UM5J2Crs6vYXRWmDfFp+uWqs
        PkU2Nj6SjdIpceLndhLXVFZNrxkcxQ==
X-Google-Smtp-Source: ABdhPJznie4FLGQl45jcd3HfKp37trIP8gzFWVRQ6+aJ68vowvbn9uW1fph8mSZUSovVJCHiqy6r1w==
X-Received: by 2002:ae9:ef12:: with SMTP id d18mr5308306qkg.473.1605327205044;
        Fri, 13 Nov 2020 20:13:25 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w192sm8247966qkb.17.2020.11.13.20.13.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 20:13:24 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v2 1/5] lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
Date:   Fri, 13 Nov 2020 23:12:25 -0500
Message-Id: <20201114041229.26417-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201114041229.26417-1-msys.mizuma@gmail.com>
References: <20201114041229.26417-1-msys.mizuma@gmail.com>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

lscpu may show the wrong number of sockets if the machine is aarch64 and
doesn't have ACPI PPTT.

That's because lscpu shows the number of sockets by using a sysfs entry
(cpu/cpuX/topology/core_siblings). The sysfs entry is set by MPIDR_EL1
register if the machine doesn't have ACPI PPTT. MPIDR_EL1 doesn't show
the physical socket information directly. It shows the affinity level.

According to linux/arch/arm64/kernel/topology.c:store_cpu_topology(),
the top level of affinity is called as 'Cluster'.

Use Cluster instead of Socket on the machine which doesn't have ACPI PPTT.

This patch is useful for aarch64 machine which is based on ARM
SBBR v1.0 and v1.1, the specs don't require ACPI PPTT. ARM SBBR v1.2
requires ACPI PPTT.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 include/c.h           |  1 +
 sys-utils/lscpu-arm.c | 23 +++++++++++++++++++++++
 sys-utils/lscpu.1     |  3 +++
 sys-utils/lscpu.c     | 42 +++++++++++++++++++++++++++++++++++-------
 sys-utils/lscpu.h     |  3 +++
 5 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/include/c.h b/include/c.h
index ae0813109..e92636177 100644
--- a/include/c.h
+++ b/include/c.h
@@ -16,6 +16,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/utsname.h>
 
 #include <assert.h>
 
diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 1cbc9775f..7ef05e8e7 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -362,10 +362,33 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 	arm_rXpY_decode(ct);
 }
 
+int lscpu_is_cluster_arm(struct lscpu_cxt *cxt)
+{
+	char *arch;
+	struct stat st;
+	struct utsname utsbuf;
+
+	if (cxt)
+		arch = cxt->arch->name;
+	else {
+		if (uname(&utsbuf) == -1)
+			err(EXIT_FAILURE, _("error: uname failed"));
+		arch = utsbuf.machine;
+	}
+
+	if (!(strcmp(arch, "aarch64")) && (stat(_PATH_ACPI_PPTT, &st) < 0)
+			&& (cxt->ncputypes == 1))
+		return 1;
+	else
+		return 0;
+}
+
 void lscpu_decode_arm(struct lscpu_cxt *cxt)
 {
 	size_t i;
 
+	cxt->is_cluster = lscpu_is_cluster_arm(cxt);
+
 	for (i = 0; i < cxt->ncputypes; i++)
 		arm_decode(cxt, cxt->cputypes[i]);
 }
diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index ed14dc663..a41125395 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -55,6 +55,9 @@ The logical core number.  A core can contain several CPUs.
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
index 6e501b044..c5a4cc984 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -95,6 +95,7 @@ enum {
 	COL_CPU_CPU,
 	COL_CPU_CORE,
 	COL_CPU_SOCKET,
+	COL_CPU_CLUSTER,
 	COL_CPU_NODE,
 	COL_CPU_BOOK,
 	COL_CPU_DRAWER,
@@ -138,6 +139,7 @@ static struct lscpu_coldesc coldescs_cpu[] =
 	[COL_CPU_BOGOMIPS]     = { "BOGOMIPS", N_("crude measurement of CPU speed"), SCOLS_FL_RIGHT, 1 },
 	[COL_CPU_CPU]          = { "CPU", N_("logical CPU number"), SCOLS_FL_RIGHT, 1 },
 	[COL_CPU_CORE]         = { "CORE", N_("logical core number"), SCOLS_FL_RIGHT },
+	[COL_CPU_CLUSTER]      = { "CLUSTER", N_("logical cluster number"), SCOLS_FL_RIGHT },
 	[COL_CPU_SOCKET]       = { "SOCKET", N_("logical socket number"), SCOLS_FL_RIGHT },
 	[COL_CPU_NODE]         = { "NODE", N_("logical NUMA node number"), SCOLS_FL_RIGHT },
 	[COL_CPU_BOOK]         = { "BOOK", N_("logical book number"), SCOLS_FL_RIGHT },
@@ -181,12 +183,21 @@ static int
 cpu_column_name_to_id(const char *name, size_t namesz)
 {
 	size_t i;
+	int is_cluster = lscpu_is_cluster_arm(NULL);
 
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
@@ -337,6 +348,7 @@ static char *get_cell_data(
 		fill_id(cxt, cpu, core, buf, bufsz);
 		break;
 	case COL_CPU_SOCKET:
+	case COL_CPU_CLUSTER:
 		fill_id(cxt, cpu, socket, buf, bufsz);
 		break;
 	case COL_CPU_DRAWER:
@@ -843,7 +855,10 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 		add_summary_s(tb, sec, _("Model:"), ct->revision ? ct->revision : ct->model);
 
 	add_summary_n(tb, sec, _("Thread(s) per core:"), ct->nthreads_per_core);
-	add_summary_n(tb, sec, _("Core(s) per socket:"), ct->ncores_per_socket);
+	if (cxt->is_cluster)
+		add_summary_n(tb, sec, _("Core(s) per cluster:"), ct->ncores_per_socket);
+	else
+		add_summary_n(tb, sec, _("Core(s) per socket:"), ct->ncores_per_socket);
 
 	if (ct->nbooks) {
 		add_summary_n(tb, sec, _("Socket(s) per book:"), ct->nsockets_per_book);
@@ -852,8 +867,14 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 			add_summary_n(tb, sec, _("Drawer(s):"), ct->ndrawers_per_system ?: ct->ndrawers);
 		} else
 			add_summary_n(tb, sec, _("Book(s):"), ct->nbooks_per_drawer ?: ct->nbooks);
-	} else
-		add_summary_n(tb, sec, _("Socket(s):"), ct->nsockets_per_book ?: ct->nsockets);
+	} else {
+		if (cxt->is_cluster)
+			add_summary_n(tb, sec, _("Cluster(s):"),
+					ct->nsockets_per_book ?: ct->nsockets);
+		else
+			add_summary_n(tb, sec, _("Socket(s):"),
+					ct->nsockets_per_book ?: ct->nsockets);
+	}
 
 	if (ct->stepping)
 		add_summary_s(tb, sec, _("Stepping:"), ct->stepping);
@@ -1325,8 +1346,12 @@ int main(int argc, char *argv[])
 				columns[ncolumns++] = COL_CPU_DRAWER;
 			if (ct && ct->nbooks)
 				columns[ncolumns++] = COL_CPU_BOOK;
-			if (ct && ct->nsockets)
-				columns[ncolumns++] = COL_CPU_SOCKET;
+			if (ct && ct->nsockets) {
+				if (cxt->is_cluster)
+					columns[ncolumns++] = COL_CPU_CLUSTER;
+				else
+					columns[ncolumns++] = COL_CPU_SOCKET;
+			}
 			if (ct && ct->ncores)
 				columns[ncolumns++] = COL_CPU_CORE;
 			if (cxt->ncaches)
@@ -1350,7 +1375,10 @@ int main(int argc, char *argv[])
 		if (!ncolumns) {
 			columns[ncolumns++] = COL_CPU_CPU;
 			columns[ncolumns++] = COL_CPU_CORE;
-			columns[ncolumns++] = COL_CPU_SOCKET;
+			if (cxt->is_cluster)
+				columns[ncolumns++] = COL_CPU_CLUSTER;
+			else
+				columns[ncolumns++] = COL_CPU_SOCKET;
 			columns[ncolumns++] = COL_CPU_NODE;
 			columns[ncolumns++] = COL_CPU_CACHE;
 			cxt->show_compatible = 1;
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 465bd3fe2..227e7f391 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -33,6 +33,7 @@ UL_DEBUG_DECLARE_MASK(lscpu);
 #define _PATH_SYS_NODE		_PATH_SYS_SYSTEM "/node"
 #define _PATH_SYS_DMI		"/sys/firmware/dmi/tables/DMI"
 #define _PATH_SYS_DMI_TYPE4	"/sys/firmware/dmi/entries/4-0/raw"
+#define _PATH_ACPI_PPTT		"/sys/firmware/acpi/tables/PPTT"
 
 struct lscpu_cache {
 	int		id;		/* unique identifier */
@@ -242,6 +243,7 @@ struct lscpu_cxt {
 		     json : 1,
 		     bytes : 1;
 
+	int is_cluster; /* For aarch64 if the machine doesn't have ACPI PPTT */
 };
 
 #define is_cpu_online(_cxt, _cpu) \
@@ -291,6 +293,7 @@ int lscpu_cpu_set_type(struct lscpu_cpu *cpu, struct lscpu_cputype *type);
 int lscpu_create_cpus(struct lscpu_cxt *cxt, cpu_set_t *cpuset, size_t setsize);
 struct lscpu_cpu *lscpu_cpus_loopup_by_type(struct lscpu_cxt *cxt, struct lscpu_cputype *ct);
 
+int lscpu_is_cluster_arm(struct lscpu_cxt *cxt);
 void lscpu_decode_arm(struct lscpu_cxt *cxt);
 
 int lookup(char *line, char *pattern, char **value);
-- 
2.27.0

