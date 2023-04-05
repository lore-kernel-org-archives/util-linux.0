Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67430C7619A
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 06:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjDEGMv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 02:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbjDEGMq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 02:12:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B45421A
        for <util-linux@vger.kernel.org>; Tue,  4 Apr 2023 23:12:44 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso38567301pjb.0
        for <util-linux@vger.kernel.org>; Tue, 04 Apr 2023 23:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112; t=1680675163; x=1683267163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QdZbiaOkGcV1ryA7LWVscSX8SpIL2Fe5WGtxFiPOtxw=;
        b=r4sVcIcXxyaPW/xMWYtRJjongHtjbJIII4d9wqGH3MdkulI/hL/wPi/KksUuf8DWd4
         +BRQnRE0l33Sh/ZH6pb+R3K/m+99mnYTn3a0bfE2W4K/WxMhcqAwX2BsPyIU8Yew2ytm
         qL3z2hiNQtH2nzBeMdHXLQlTqZ/NAgvyUqKb2+YEZzrTp8tJunDeAlDA+cU9B38aAE2t
         x+eBEBRxCGYIpN65gu1wObLjEgGEtRhJcp+/gHzXj9Q0oN5+Hw0VybPZVWTx1L493/rk
         dTGr/iR3S+b8zraXSKLoHrznQnIoSDTEvkru1jvZTRVpUAt8djZoY6/X+V5V3MW/fzJz
         lgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680675163; x=1683267163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdZbiaOkGcV1ryA7LWVscSX8SpIL2Fe5WGtxFiPOtxw=;
        b=7d0BkJhAyIzgU103Vu3z80yY8UOnl7fUFS20knPid2qliqLaowBKKuo1FnHzokVXxw
         +wapNLO1f/CoMPMddWHBAMoQhmgPmli8YJImtg3mCOQnfdYt2pKDV+TJ45sevteKYZHi
         FVX587ZaHcb+JornzZ2F+AKlhtoWFAPmC9uiUtdGq5uiB0nek36xIj/kGDSCAPcOeDlI
         1/S6bxLVnK1MF34gKniJhvG2SY8JonK+60wC5CcLgC9SFB26rUfw+vWj3KqILVqSLMfF
         UD9KKrPaGb5mxgo5AjLP7E6X9tKmbac0ddK/N0q5wrTY2LDslH8sykrvc9tpAAp2Pr2z
         5K/w==
X-Gm-Message-State: AAQBX9c78OukfmiQDYESoGstQXAjKz2qZffZ05fOnwFVXVwzQuYQdj2/
        LljWKZlQ1YSMXI7rtqTtcRfjYLQ5c6tJ1VX+w87pSw==
X-Google-Smtp-Source: AKy350YgcUZOPe1B5n+qW1CL/V5ORXxqJst0kKvYMVvNkQPo2Yp0CPqrrDz+K+hEvFD3WNpJnm9RqA==
X-Received: by 2002:a17:903:230a:b0:1a1:b5e3:7db4 with SMTP id d10-20020a170903230a00b001a1b5e37db4mr5888022plh.18.1680675163359;
        Tue, 04 Apr 2023 23:12:43 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:4457:c267:5e09:481b])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b0019309be03e7sm9383853plb.66.2023.04.04.23.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 23:12:42 -0700 (PDT)
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     util-linux@vger.kernel.org,
        Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH] lscpu: Decouple cputype and topology
Date:   Wed,  5 Apr 2023 15:12:38 +0900
Message-Id: <20230405061238.11888-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Before this change, lscpu_cputype held topology information. This
design is incompatible with heterogenous configurations where there are
several CPU types.

One problem is that logical IDs of e.g. clusters overlap across
different CPU types. For example, consider a
1-socket/2-cluster/1-core/1-thread system. One of the clusters has
"P-cores", and the other has "E-cores". P-cores and E-cores have
different CPU types. Before this change,
"lscpu -p=CPU,Core,Cluster,Socket" output something like the following
for the system:
0,0,0,0
1,0,0,0

Note that lscpu assigns the same core/cluster ID for the two CPUs
although they are actually in different cores and clusters.

To fix the inconsistency and ambiguity of such IDs, move the topology
information from lscpu_cputype to lscpu_cxt. For the earlier example,
the output will change as follows:
0,0,0,0
1,1,1,0

This also changes how the topology is described in the summary which
lscpu prints when it is executed with no arguments. Before this change,
the topology information was associated with CPU types, but the
topology information is shown in a separate section now.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 sys-utils/lscpu-arm.c      |   6 +--
 sys-utils/lscpu-cputype.c  |   1 -
 sys-utils/lscpu-topology.c | 108 ++++++++-----------------------------
 sys-utils/lscpu.c          |  64 +++++++++++-----------
 sys-utils/lscpu.h          |  32 +++++------
 5 files changed, 70 insertions(+), 141 deletions(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 86e5ea7b4..5ea534bd9 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -343,9 +343,6 @@ static void arm_decode(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 
 	arm_ids_decode(ct);
 	arm_rXpY_decode(ct);
-
-	if (!cxt->noalive && cxt->is_cluster)
-		ct->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
 }
 
 static int is_cluster_arm(struct lscpu_cxt *cxt)
@@ -368,4 +365,7 @@ void lscpu_decode_arm(struct lscpu_cxt *cxt)
 
 	for (i = 0; i < cxt->ncputypes; i++)
 		arm_decode(cxt, cxt->cputypes[i]);
+
+	if (!cxt->noalive && cxt->is_cluster)
+		cxt->nr_socket_on_cluster = get_number_of_physical_sockets_from_dmi();
 }
diff --git a/sys-utils/lscpu-cputype.c b/sys-utils/lscpu-cputype.c
index 31f4009bc..18790f35f 100644
--- a/sys-utils/lscpu-cputype.c
+++ b/sys-utils/lscpu-cputype.c
@@ -77,7 +77,6 @@ void lscpu_unref_cputype(struct lscpu_cputype *ct)
 
 	if (--ct->refcount <= 0) {
 		DBG(TYPE, ul_debugobj(ct, "  freeing %s/%s", ct->vendor, ct->model));
-		lscpu_cputype_free_topology(ct);
 		free(ct->vendor);
 		free(ct->bios_vendor);
 		free(ct->machinetype);	/* s390 */
diff --git a/sys-utils/lscpu-topology.c b/sys-utils/lscpu-topology.c
index fe4da7cd5..379b2b584 100644
--- a/sys-utils/lscpu-topology.c
+++ b/sys-utils/lscpu-topology.c
@@ -41,14 +41,14 @@ static void free_cpuset_array(cpu_set_t **ary, int items)
 	free(ary);
 }
 
-void lscpu_cputype_free_topology(struct lscpu_cputype *ct)
+void lscpu_free_topology(struct lscpu_cxt *cxt)
 {
-	if (!ct)
+	if (!cxt)
 		return;
-	free_cpuset_array(ct->coremaps, ct->ncores);
-	free_cpuset_array(ct->socketmaps, ct->nsockets);
-	free_cpuset_array(ct->bookmaps, ct->nbooks);
-	free_cpuset_array(ct->drawermaps, ct->ndrawers);
+	free_cpuset_array(cxt->coremaps, cxt->ncores);
+	free_cpuset_array(cxt->socketmaps, cxt->nsockets);
+	free_cpuset_array(cxt->bookmaps, cxt->nbooks);
+	free_cpuset_array(cxt->drawermaps, cxt->ndrawers);
 }
 
 void lscpu_free_caches(struct lscpu_cache *caches, size_t n)
@@ -89,26 +89,21 @@ void lscpu_sort_caches(struct lscpu_cache *caches, size_t n)
 
 
 /* Read topology for specified type */
-static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
+static int cputype_read_topology(struct lscpu_cxt *cxt)
 {
 	size_t i, npos;
 	struct path_cxt *sys;
-	int nthreads = 0, sw_topo = 0;
-	FILE *fd;
 
 	sys = cxt->syscpu;				/* /sys/devices/system/cpu/ */
 	npos = cxt->npossibles;				/* possible CPUs */
 
-	DBG(TYPE, ul_debugobj(ct, "reading %s/%s/%s topology",
-				ct->vendor ?: "", ct->model ?: "", ct->modelname ?:""));
-
 	for (i = 0; i < cxt->npossibles; i++) {
 		struct lscpu_cpu *cpu = cxt->cpus[i];
 		cpu_set_t *thread_siblings = NULL, *core_siblings = NULL;
 		cpu_set_t *book_siblings = NULL, *drawer_siblings = NULL;
-		int num, n;
+		int num;
 
-		if (!cpu || cpu->type != ct)
+		if (!cpu)
 			continue;
 
 		num = cpu->logical_id;
@@ -126,12 +121,6 @@ static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct
 		ul_path_readf_cpuset(sys, &drawer_siblings, cxt->maxcpus,
 					"cpu%d/topology/drawer_siblings", num);
 
-		n = CPU_COUNT_S(cxt->setsize, thread_siblings);
-		if (!n)
-			n = 1;
-		if (n > nthreads)
-			nthreads = n;
-
 		/* Allocate arrays for topology maps.
 		 *
 		 * For each map we make sure that it can have up to ncpuspos
@@ -140,76 +129,26 @@ static int cputype_read_topology(struct lscpu_cxt *cxt, struct lscpu_cputype *ct
 		 * E.g. completely virtualized architectures like s390 may
 		 * have multiple sockets of different sizes.
 		 */
-		if (!ct->coremaps)
-			ct->coremaps = xcalloc(npos, sizeof(cpu_set_t *));
-		if (!ct->socketmaps)
-			ct->socketmaps = xcalloc(npos, sizeof(cpu_set_t *));
-		if (!ct->bookmaps && book_siblings)
-			ct->bookmaps = xcalloc(npos, sizeof(cpu_set_t *));
-		if (!ct->drawermaps && drawer_siblings)
-			ct->drawermaps = xcalloc(npos, sizeof(cpu_set_t *));
+		if (!cxt->coremaps)
+			cxt->coremaps = xcalloc(npos, sizeof(cpu_set_t *));
+		if (!cxt->socketmaps)
+			cxt->socketmaps = xcalloc(npos, sizeof(cpu_set_t *));
+		if (!cxt->bookmaps && book_siblings)
+			cxt->bookmaps = xcalloc(npos, sizeof(cpu_set_t *));
+		if (!cxt->drawermaps && drawer_siblings)
+			cxt->drawermaps = xcalloc(npos, sizeof(cpu_set_t *));
 
 		/* add to topology maps */
-		add_cpuset_to_array(ct->coremaps, &ct->ncores, thread_siblings, cxt->setsize);
-		add_cpuset_to_array(ct->socketmaps, &ct->nsockets, core_siblings, cxt->setsize);
+		add_cpuset_to_array(cxt->coremaps, &cxt->ncores, thread_siblings, cxt->setsize);
+		add_cpuset_to_array(cxt->socketmaps, &cxt->nsockets, core_siblings, cxt->setsize);
 
 		if (book_siblings)
-			add_cpuset_to_array(ct->bookmaps, &ct->nbooks, book_siblings, cxt->setsize);
+			add_cpuset_to_array(cxt->bookmaps, &cxt->nbooks, book_siblings, cxt->setsize);
 		if (drawer_siblings)
-			add_cpuset_to_array(ct->drawermaps, &ct->ndrawers, drawer_siblings, cxt->setsize);
-
-	}
+			add_cpuset_to_array(cxt->drawermaps, &cxt->ndrawers, drawer_siblings, cxt->setsize);
 
-	/* s390 detects its cpu topology via /proc/sysinfo, if present.
-	 * Using simply the cpu topology masks in sysfs will not give
-	 * usable results since everything is virtualized. E.g.
-	 * virtual core 0 may have only 1 cpu, but virtual core 2 may
-	 * five cpus.
-	 * If the cpu topology is not exported (e.g. 2nd level guest)
-	 * fall back to old calculation scheme.
-	 */
-	if ((fd = ul_path_fopen(cxt->procfs, "r", "sysinfo"))) {
-		int t0, t1;
-		char buf[BUFSIZ];
-
-		DBG(TYPE, ul_debugobj(ct, " reading sysinfo"));
-
-		while (fgets(buf, sizeof(buf), fd) != NULL) {
-			if (sscanf(buf, "CPU Topology SW: %d %d %zu %zu %zu %zu",
-					&t0, &t1,
-					&ct->ndrawers_per_system,
-					&ct->nbooks_per_drawer,
-					&ct->nsockets_per_book,
-					&ct->ncores_per_socket) == 6) {
-				sw_topo = 1;
-				DBG(TYPE, ul_debugobj(ct, " using SW topology"));
-				break;
-			}
-		}
-		if (fd)
-			fclose(fd);
 	}
 
-	ct->nthreads_per_core = nthreads;
-	if (ct->mtid) {
-		uint64_t x;
-		if (ul_strtou64(ct->mtid, &x, 10) == 0 && x <= ULONG_MAX)
-			ct->nthreads_per_core = (size_t) x + 1;
-	}
-
-	if (!sw_topo) {
-		ct->ncores_per_socket = ct->nsockets ? ct->ncores / ct->nsockets : 0;
-		ct->nsockets_per_book = ct->nbooks   ? ct->nsockets / ct->nbooks : 0;
-		ct->nbooks_per_drawer = ct->ndrawers ? ct->nbooks / ct->ndrawers : 0;
-		ct->ndrawers_per_system = ct->ndrawers;
-	}
-
-	DBG(TYPE, ul_debugobj(ct, " nthreads: %zu (per core)", ct->nthreads_per_core));
-	DBG(TYPE, ul_debugobj(ct, "   ncores: %zu (%zu per socket)", ct->ncores, ct->ncores_per_socket));
-	DBG(TYPE, ul_debugobj(ct, " nsockets: %zu (%zu per books)", ct->nsockets, ct->nsockets_per_book));
-	DBG(TYPE, ul_debugobj(ct, "   nbooks: %zu (%zu per drawer)", ct->nbooks, ct->nbooks_per_drawer));
-	DBG(TYPE, ul_debugobj(ct, " ndrawers: %zu (%zu per system)", ct->ndrawers, ct->ndrawers_per_system));
-
 	return 0;
 }
 
@@ -622,11 +561,10 @@ float lsblk_cputype_get_scalmhz(struct lscpu_cxt *cxt, struct lscpu_cputype *ct)
 int lscpu_read_topology(struct lscpu_cxt *cxt)
 {
 	size_t i;
-	int rc = 0;
+	int rc;
 
 
-	for (i = 0; i < cxt->ncputypes; i++)
-		rc += cputype_read_topology(cxt, cxt->cputypes[i]);
+	rc = cputype_read_topology(cxt);
 
 	for (i = 0; rc == 0 && i < cxt->npossibles; i++) {
 		struct lscpu_cpu *cpu = cxt->cpus[i];
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 86fd0b968..9516112cc 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -285,6 +285,8 @@ static void lscpu_free_context(struct lscpu_cxt *cxt)
 	lscpu_free_caches(cxt->ecaches, cxt->necaches);
 	lscpu_free_caches(cxt->caches, cxt->ncaches);
 
+	lscpu_free_topology(cxt);
+
 	free(cxt);
 }
 
@@ -329,8 +331,8 @@ static void get_cell_boolean(
 #define fill_id(_cxt, _cpu, NAME, _buf, _bufsz) \
 		__fill_id(_cxt, (_cpu), \
 			(_cpu)-> NAME ## id, \
-			(_cpu)->type-> NAME ## maps, \
-			(_cpu)->type->n ## NAME ## s, \
+			(_cxt)-> NAME ## maps, \
+			(_cxt)->n ## NAME ## s, \
 			_buf, _bufsz)
 
 static char *get_cell_data(
@@ -872,33 +874,6 @@ print_summary_cputype(struct lscpu_cxt *cxt,
 	if (ct->model || ct->revision)
 		add_summary_s(tb, sec, _("Model:"), ct->revision ? ct->revision : ct->model);
 
-	add_summary_n(tb, sec, _("Thread(s) per core:"), ct->nthreads_per_core);
-	if (cxt->is_cluster)
-		add_summary_n(tb, sec, _("Core(s) per cluster:"), ct->ncores_per_socket);
-	else
-		add_summary_n(tb, sec, _("Core(s) per socket:"), ct->ncores_per_socket);
-
-	if (ct->nbooks) {
-		add_summary_n(tb, sec, _("Socket(s) per book:"), ct->nsockets_per_book);
-		if (ct->ndrawers_per_system || ct->ndrawers) {
-			add_summary_n(tb, sec, _("Book(s) per drawer:"), ct->nbooks_per_drawer);
-			add_summary_n(tb, sec, _("Drawer(s):"), ct->ndrawers_per_system ?: ct->ndrawers);
-		} else
-			add_summary_n(tb, sec, _("Book(s):"), ct->nbooks_per_drawer ?: ct->nbooks);
-	} else {
-		if (cxt->is_cluster) {
-			if (ct->nr_socket_on_cluster > 0)
-				add_summary_n(tb, sec, _("Socket(s):"), ct->nr_socket_on_cluster);
-			else
-				add_summary_s(tb, sec, _("Socket(s):"), "-");
-
-			add_summary_n(tb, sec, _("Cluster(s):"),
-					ct->nsockets_per_book ?: ct->nsockets);
-		} else
-			add_summary_n(tb, sec, _("Socket(s):"),
-					ct->nsockets_per_book ?: ct->nsockets);
-	}
-
 	if (ct->stepping)
 		add_summary_s(tb, sec, _("Stepping:"), ct->stepping);
 	if (ct->freqboost >= 0)
@@ -1042,6 +1017,29 @@ static void print_summary(struct lscpu_cxt *cxt)
 		print_summary_cputype(cxt, cxt->cputypes[i], tb, sec);
 	sec = NULL;
 
+
+	/* Section: topology */
+	sec = add_summary_e(tb, NULL, _("Topology:"));
+	add_summary_n(tb, sec, _("Thread(s):"), cxt->npossibles);
+	add_summary_n(tb, sec, _("Core(s):"), cxt->ncores);
+
+	if (cxt->is_cluster) {
+		add_summary_n(tb, sec, _("Cluster(s):"), cxt->nsockets);
+
+		if (cxt->nr_socket_on_cluster > 0)
+			add_summary_n(tb, sec, _("Socket(s):"), cxt->nr_socket_on_cluster);
+		else
+			add_summary_s(tb, sec, _("Socket(s):"), "-");
+	} else
+		add_summary_n(tb, sec, _("Socket(s):"), cxt->nsockets);
+
+	if (cxt->nbooks) {
+		if (cxt->ndrawers)
+			add_summary_n(tb, sec, _("Drawer(s):"), cxt->ndrawers);
+
+		add_summary_n(tb, sec, _("Book(s):"), cxt->nbooks);
+	}
+
 	/* Section: vitualiazation */
 	if (cxt->virt) {
 		sec = add_summary_e(tb, NULL, _("Virtualization features:"));
@@ -1376,17 +1374,17 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_CPU_CPU;
 			if (cxt->nnodes)
 				columns[ncolumns++] = COL_CPU_NODE;
-			if (ct && ct->ndrawers)
+			if (cxt->ndrawers)
 				columns[ncolumns++] = COL_CPU_DRAWER;
-			if (ct && ct->nbooks)
+			if (cxt->nbooks)
 				columns[ncolumns++] = COL_CPU_BOOK;
-			if (ct && ct->nsockets) {
+			if (cxt->nsockets) {
 				if (cxt->is_cluster)
 					columns[ncolumns++] = COL_CPU_CLUSTER;
 				else
 					columns[ncolumns++] = COL_CPU_SOCKET;
 			}
-			if (ct && ct->ncores)
+			if (cxt->ncores)
 				columns[ncolumns++] = COL_CPU_CORE;
 			if (cxt->ncaches)
 				columns[ncolumns++] = COL_CPU_CACHE;
diff --git a/sys-utils/lscpu.h b/sys-utils/lscpu.h
index 8cb0d630c..5f6617b76 100644
--- a/sys-utils/lscpu.h
+++ b/sys-utils/lscpu.h
@@ -78,31 +78,13 @@ struct lscpu_cputype {
 	size_t	physchips;	/* Physical chips */
 	size_t	physcoresperchip;	/* Physical cores per chip */
 
-	size_t	nthreads_per_core;
-	size_t	ncores_per_socket;
-	size_t	nsockets_per_book;
-	size_t	nbooks_per_drawer;
-	size_t	ndrawers_per_system;
-
 	char	*dynamic_mhz;	/* s390; copy from the first CPU */
 	char	*static_mhz;	/* s390; copy from the first CPU */
 
-	/* siblings maps */
-	size_t		ncores;
-	cpu_set_t	**coremaps;
-	size_t		nsockets;
-	cpu_set_t       **socketmaps;
-	size_t		nbooks;
-	cpu_set_t	**bookmaps;
-	size_t		ndrawers;
-	cpu_set_t	**drawermaps;
-
 	unsigned int	has_freq : 1,
 			has_configured : 1,
 			has_polarization : 1,
 			has_addresses : 1;
-
-	size_t nr_socket_on_cluster; /* the number of sockets if the is_cluster is 1 */
 };
 
 /* dispatching modes */
@@ -247,6 +229,18 @@ struct lscpu_cxt {
 		     bytes : 1;
 
 	int is_cluster; /* For aarch64 if the machine doesn't have ACPI PPTT */
+
+	/* siblings maps */
+	size_t		ncores;
+	cpu_set_t	**coremaps;
+	size_t		nsockets;
+	cpu_set_t       **socketmaps;
+	size_t		nbooks;
+	cpu_set_t	**bookmaps;
+	size_t		ndrawers;
+	cpu_set_t	**drawermaps;
+
+	size_t nr_socket_on_cluster; /* the number of sockets if the is_cluster is 1 */
 };
 
 #define is_cpu_online(_cxt, _cpu) \
@@ -277,7 +271,7 @@ struct lscpu_cache *lscpu_cpu_get_cache(struct lscpu_cxt *cxt,
                                 struct lscpu_cpu *cpu, const char *name);
 
 int lscpu_read_topology(struct lscpu_cxt *cxt);
-void lscpu_cputype_free_topology(struct lscpu_cputype *ct);
+void lscpu_free_topology(struct lscpu_cxt *cxt);
 
 float lsblk_cputype_get_maxmhz(struct lscpu_cxt *cxt, struct lscpu_cputype *ct);
 float lsblk_cputype_get_minmhz(struct lscpu_cxt *cxt, struct lscpu_cputype *ct);
-- 
2.40.0

