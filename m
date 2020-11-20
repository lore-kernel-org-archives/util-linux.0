Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2030C63798
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BD62237B
	for <util-linux@archiver.kernel.org>; Fri, 20 Nov 2020 05:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THSUVGWA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgKTFGY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 20 Nov 2020 00:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgKTFGX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Nov 2020 00:06:23 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255BC0617A7
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:23 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id q1so7496929ilt.6
        for <util-linux@vger.kernel.org>; Thu, 19 Nov 2020 21:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RGQfEIV0sXlHQoA5+SX76A7A6k0wFXmyNyIJ2Cdkql4=;
        b=THSUVGWAwubfA4GpxW4wwPcH1b8r1rylQWX3fCbKbMxG/AwQZxuioTmS2vwZlo9W8M
         +7Ij9ddyfTIUL/ZLo0MdY+oXfL1AG1pD0Y06cjc+eENTR4Bi98jZQ/Pvbs9p9JTX042C
         SV0hcdj1+CL0vWH/QccLOxQdkQmJP5aU1G7wNF1/D2jcpuJeMv4JHeHvKWFNhyd4oTyp
         HhtBRj26ULPN9jtRUJqC//l4Dbg+8Ecgd0UP3OBmwacvT+enXdYP0SWbsjlVTPb+X1l8
         0u1EYedP4PSKN9ZOMl8c6wyudXbuVjWviMG/UbfzY5mTaa5mumvhO9RGTW6w7HB0YMT1
         KNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RGQfEIV0sXlHQoA5+SX76A7A6k0wFXmyNyIJ2Cdkql4=;
        b=bPXd3ZhDxDF8eijQ9pSTyaKVG/ktRZZ8fQuU+RD9QLbvr6zJK4ezRoORxtavmOuvSB
         DEkKhBQdkxH5/2+evsYLf3qxIizA7ufH0NCnqgLwRSq2op1PBfKyS+rUSndg0yw8Sx+h
         dz7Ar11tjj00HPAuXzDoacE05UVqs7vVay6WKuZxXFQNW2os62fHNSSmUx1JymOkW50X
         yagTGVOCVvLqAPdL6KP/kYXb7WGxeD/HlYh+WIhrL4guuD90Trlk9jgLNLUQy6KlHoI5
         R6tO6Zpwz9B7texSVXzSTP7Ju0o2bKpQGHl9iksu3+sZs0c/y25bxYc23h2rojcd27p8
         hEaw==
X-Gm-Message-State: AOAM531KRRo8fXqXGmatN4qjNd8kqCyoW9cQ7IWVZCG5i6ERW1VGV17W
        tUfyJdjl+dwbpfIzcdw/xyR1EAM6qA==
X-Google-Smtp-Source: ABdhPJx1UU3S8K0ULKdiTz175gu9uEY/UMyn2fonQAYixKvvdMQgWL4Bgs589JJrCRHdLpGUQ01hIA==
X-Received: by 2002:a92:89d3:: with SMTP id w80mr22225701ilk.68.1605848782770;
        Thu, 19 Nov 2020 21:06:22 -0800 (PST)
Received: from localhost (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id f7sm793084ioo.37.2020.11.19.21.06.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 21:06:22 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     util-linux@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [PATCH v3 1/5] lscpu: use cluster on aarch64 machine which doesn't have ACPI PPTT
Date:   Fri, 20 Nov 2020 00:06:05 -0500
Message-Id: <20201120050609.17409-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120050609.17409-1-msys.mizuma@gmail.com>
References: <20201120050609.17409-1-msys.mizuma@gmail.com>
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
 sys-utils/lscpu-arm.c | 13 +++++++++++++
 sys-utils/lscpu.1     |  3 +++
 sys-utils/lscpu.c     | 34 ++++++++++++++++++++++++++++------
 sys-utils/lscpu.h     |  2 ++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 1cbc9775f..9391cca54 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -362,10 +362,23 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 	arm_rXpY_decode(ct);
 }
 
+static int lscpu_is_cluster_arm(struct lscpu_cxt *cxt)
+{
+	struct stat st;
+
+	if (!(strcmp(cxt->arch->name, "aarch64")) &&
+	     (stat(_PATH_ACPI_PPTT, &st) < 0) && (cxt->ncputypes == 1))
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
index 6e501b044..b9b8940a8 100644
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
@@ -339,6 +341,10 @@ static char *get_cell_data(
 	case COL_CPU_SOCKET:
 		fill_id(cxt, cpu, socket, buf, bufsz);
 		break;
+	case COL_CPU_CLUSTER:
+		if (cxt->is_cluster)
+			fill_id(cxt, cpu, socket, buf, bufsz);
+		break;
 	case COL_CPU_DRAWER:
 		fill_id(cxt, cpu, drawer, buf, bufsz);
 		break;
@@ -843,7 +849,10 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 		add_summary_s(tb, sec, _("Model:"), ct->revision ? ct->revision : ct->model);
 
 	add_summary_n(tb, sec, _("Thread(s) per core:"), ct->nthreads_per_core);
-	add_summary_n(tb, sec, _("Core(s) per socket:"), ct->ncores_per_socket);
+	if (cxt->is_cluster)
+		add_summary_n(tb, sec, _("Core(s) per cluster:"), ct->ncores_per_socket);
+	else
+		add_summary_n(tb, sec, _("Core(s) per socket:"), ct->ncores_per_socket);
 
 	if (ct->nbooks) {
 		add_summary_n(tb, sec, _("Socket(s) per book:"), ct->nsockets_per_book);
@@ -852,8 +861,14 @@ print_summary_cputype(struct lscpu_cxt *cxt,
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
@@ -1325,8 +1340,12 @@ int main(int argc, char *argv[])
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
@@ -1350,7 +1369,10 @@ int main(int argc, char *argv[])
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
index 465bd3fe2..7d42816c3 100644
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
-- 
2.27.0

