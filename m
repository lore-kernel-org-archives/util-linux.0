Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E31C433EF
	for <util-linux@archiver.kernel.org>; Tue, 29 Mar 2022 09:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiC2JFI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 29 Mar 2022 05:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbiC2JFH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 29 Mar 2022 05:05:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B87B24096
        for <util-linux@vger.kernel.org>; Tue, 29 Mar 2022 02:03:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p4-20020a17090ad30400b001c7ca87c05bso1507888pju.1
        for <util-linux@vger.kernel.org>; Tue, 29 Mar 2022 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3RXCgz4kbWH1449bZ0osiiB4ZDUOPpaBPaWCLFiQz0=;
        b=btFt5CCwjT2nO8sOj3HFH9doUuGz35+qEQLiB484BrwH3zxyrV/FCQWHg8PTcURcAi
         11xGzjO4Nf7j/cP5ffquHOEniuleaMR0skWzlcNPIOl/K+9rHZEJZQ9qaqZvCuiFvEZ6
         vUUqc5DV1AgeC+SFG6kEAu4lM2++SNevMzQy9Xns5x6C/f2WfJ52S4fJTGTMOyfpxUbP
         +jhOj7W6ZBh48hE4ThH3MxMakbcrs9iqreX7/isNKV59eF2dqLp5T+m0KMZWDSthVbRD
         eEqlepP4VR2dAeTFQGvX7uQXXLh9YgNnE563g21n98WWMVIix+fY8Ih3fpcGE9IntMV1
         vNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3RXCgz4kbWH1449bZ0osiiB4ZDUOPpaBPaWCLFiQz0=;
        b=F/5+OZqD6ROyIgxuyChIjmnPtegjfPUckTIYHoGyh4yG4H1dQnX7ZCmRTa6yci9MfX
         bC21c5bjDVKyS6Ke7eNMZJiwNZwgEbnWUxXIcwqJbfbkQHIqevBSAmA+UnDnAn9HKn2j
         COh63NpjaMk9omXaTFwlHtJSeI2xpTNoNDvMG3WoZFHsTT/gTNQRFk5JNhJTsVLb88Zm
         9Sj52YOO0X/bP5PrWRvsVUVLBlztVuWyWdPzV+lhvYq9QgESxhbZDRydflsuzs0PgN+R
         ThBXh0F4YUeytWebee9Pgm45lfw8jQveJUBEpyUQBHADOiHwyv95zi5V1pzTvlR/nKT3
         kjlA==
X-Gm-Message-State: AOAM532iuZPiKi0t99OZ9r+/rI0oB0TjD8klnlvMfw+NFNkz2cgtp8Sn
        OKVn3xNvwDweJDjqn4HUQeW8fA==
X-Google-Smtp-Source: ABdhPJxpdOyMxAmFHnLhlHcnie3OijXGu9xbb+FQCT1zTRtIATTSxD6jwszK9osk/CQ7qsyxLVDImQ==
X-Received: by 2002:a17:902:ce8b:b0:154:42e2:924e with SMTP id f11-20020a170902ce8b00b0015442e2924emr29715237plg.138.1648544600498;
        Tue, 29 Mar 2022 02:03:20 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id v22-20020a056a00149600b004fb34a7b500sm11015133pfu.203.2022.03.29.02.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:03:19 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] irqtop: support -C/--cpu-list
Date:   Tue, 29 Mar 2022 16:59:51 +0800
Message-Id: <20220329085951.766333-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Specify cpus list format to show by -C/--cpu-list parameters, for
example, on an AMD server with 192 CPUs, to show statistics on NUMA
node 1:
  ~# ./irqtop -d 1 -C 48-95,144-191

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 bash-completion/irqtop  |  4 ++++
 sys-utils/irq-common.c  | 46 ++++++++++++++++++++++++++++++-----------
 sys-utils/irq-common.h  |  9 ++++++--
 sys-utils/irqtop.1.adoc |  3 +++
 sys-utils/irqtop.c      | 29 +++++++++++++++++++++++---
 sys-utils/lsirq.c       |  2 +-
 6 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/bash-completion/irqtop b/bash-completion/irqtop
index a3812acbb..7688f673c 100644
--- a/bash-completion/irqtop
+++ b/bash-completion/irqtop
@@ -9,6 +9,9 @@ _irqtop_module()
 			COMPREPLY=( $(compgen -W "auto enable disable" -- $cur) )
 			return 0
 			;;
+		'-C'|'--cpu-list')
+			return 0
+			;;
 		'-d'|'--delay')
 			COMPREPLY=( $(compgen -W "secs" -- $cur) )
 			return 0
@@ -35,6 +38,7 @@ _irqtop_module()
 			;;
 	esac
 	OPTS="	--cpu-stat
+		--cpu-list
 		--delay
 		--sort
 		--output
diff --git a/sys-utils/irq-common.c b/sys-utils/irq-common.c
index aa10f7e05..1bdcfad31 100644
--- a/sys-utils/irq-common.c
+++ b/sys-utils/irq-common.c
@@ -23,6 +23,7 @@
 #include <errno.h>
 #include <limits.h>
 #include <locale.h>
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -228,10 +229,19 @@ static char *remove_repeated_spaces(char *str)
 	return str;
 }
 
+static bool cpu_in_list(int cpu, size_t setsize, cpu_set_t *cpuset)
+{
+	/* no -C/--cpu-list specified, use all the CPUs */
+	if (!cpuset)
+		return true;
+
+	return CPU_ISSET_S(cpu, setsize, cpuset);
+}
+
 /*
  * irqinfo - parse the system's interrupts
  */
-static struct irq_stat *get_irqinfo(int softirq)
+static struct irq_stat *get_irqinfo(int softirq, size_t setsize, cpu_set_t *cpuset)
 {
 	FILE *irqfile;
 	char *line = NULL, *tmp;
@@ -292,9 +302,11 @@ static struct irq_stat *get_irqinfo(int softirq)
 
 			if (sscanf(tmp, " %10lu", &count) != 1)
 				continue;
-			curr->total += count;
-			cpu->total += count;
-			stat->total_irq += count;
+			if (cpu_in_list(index, setsize, cpuset)) {
+				curr->total += count;
+				cpu->total += count;
+				stat->total_irq += count;
+			}
 
 			tmp += 11;
 		}
@@ -422,13 +434,15 @@ void set_sort_func_by_key(struct irq_output *out, char c)
 
 struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 					struct irq_stat *prev,
-					struct irq_stat *curr)
+					struct irq_stat *curr,
+					size_t setsize,
+					cpu_set_t *cpuset)
 {
 	struct libscols_table *table;
 	struct libscols_column *cl;
 	struct libscols_line *ln;
 	char colname[sizeof(stringify_value(LONG_MAX))];
-	size_t i;
+	size_t i, j;
 
 	if (prev) {
 		for (i = 0; i < curr->nr_active_cpu; i++) {
@@ -454,6 +468,8 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 		scols_table_new_column(table, "", 0, SCOLS_FL_RIGHT);
 
 	for (i = 0; i < curr->nr_active_cpu; i++) {
+		if (!cpu_in_list(i, setsize, cpuset))
+			continue;
 		snprintf(colname, sizeof(colname), "cpu%zu", i);
 		cl = scols_table_new_column(table, colname, 0, SCOLS_FL_RIGHT);
 		if (cl == NULL) {
@@ -469,12 +485,14 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 	if (!ln || (!out->json && scols_line_set_data(ln, 0, "%irq:") != 0))
 		goto err;
 
-	for (i = 0; i < curr->nr_active_cpu; i++) {
+	for (i = 0, j = 0; i < curr->nr_active_cpu; i++) {
 		struct irq_cpu *cpu = &curr->cpus[i];
 		char *str;
 
+		if (!cpu_in_list(i, setsize, cpuset))
+			continue;
 		xasprintf(&str, "%0.1f", (double)((long double) cpu->total / (long double) curr->total_irq * 100.0));
-		if (str && scols_line_refer_data(ln, i + 1, str) != 0)
+		if (str && scols_line_refer_data(ln, ++j, str) != 0)
 			goto err;
 	}
 
@@ -484,14 +502,16 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 	if (!ln || (!out->json && scols_line_set_data(ln, 0, _("%delta:")) != 0))
 		goto err;
 
-	for (i = 0; i < curr->nr_active_cpu; i++) {
+	for (i = 0, j = 0; i < curr->nr_active_cpu; i++) {
 		struct irq_cpu *cpu = &curr->cpus[i];
 		char *str;
 
+		if (!cpu_in_list(i, setsize, cpuset))
+			continue;
 		if (!curr->delta_irq)
 			continue;
 		xasprintf(&str, "%0.1f", (double)((long double) cpu->delta / (long double) curr->delta_irq * 100.0));
-		if (str && scols_line_refer_data(ln, i + 1, str) != 0)
+		if (str && scols_line_refer_data(ln, ++j, str) != 0)
 			goto err;
 	}
 
@@ -504,7 +524,9 @@ struct libscols_table *get_scols_cpus_table(struct irq_output *out,
 struct libscols_table *get_scols_table(struct irq_output *out,
 					      struct irq_stat *prev,
 					      struct irq_stat **xstat,
-					      int softirq)
+					      int softirq,
+					      size_t setsize,
+					      cpu_set_t *cpuset)
 {
 	struct libscols_table *table;
 	struct irq_info *result;
@@ -513,7 +535,7 @@ struct libscols_table *get_scols_table(struct irq_output *out,
 	size_t i;
 
 	/* the stats */
-	stat = get_irqinfo(softirq);
+	stat = get_irqinfo(softirq, setsize, cpuset);
 	if (!stat)
 		return NULL;
 
diff --git a/sys-utils/irq-common.h b/sys-utils/irq-common.h
index c4f1fa3a2..04c43207e 100644
--- a/sys-utils/irq-common.h
+++ b/sys-utils/irq-common.h
@@ -3,6 +3,7 @@
 
 #include "c.h"
 #include "nls.h"
+#include "cpuset.h"
 
 /* supported columns */
 enum {
@@ -63,10 +64,14 @@ void set_sort_func_by_key(struct irq_output *out, const char c);
 struct libscols_table *get_scols_table(struct irq_output *out,
                                               struct irq_stat *prev,
                                               struct irq_stat **xstat,
-                                              int softirq);
+                                              int softirq,
+                                              size_t setsize,
+                                              cpu_set_t *cpuset);
 
 struct libscols_table *get_scols_cpus_table(struct irq_output *out,
                                         struct irq_stat *prev,
-                                        struct irq_stat *curr);
+                                        struct irq_stat *curr,
+                                        size_t setsize,
+                                        cpu_set_t *cpuset);
 
 #endif /* UTIL_LINUX_H_IRQ_COMMON */
diff --git a/sys-utils/irqtop.1.adoc b/sys-utils/irqtop.1.adoc
index 3f215d2f0..a310ded9d 100644
--- a/sys-utils/irqtop.1.adoc
+++ b/sys-utils/irqtop.1.adoc
@@ -28,6 +28,9 @@ Specify which output columns to print. Use *--help* to get a list of all support
 *-c*, *--cpu-stat* _mode_::
 Show per-cpu statistics by specified mode. Available modes are: *auto*, *enable*, *disable*. The default option *auto* detects the width of window, then shows the per-cpu statistics if the width of window is large enouth to show a full line of statistics.
 
+*-C*, *--cpu-list* _list_::
+Specify cpus in list format to show.
+
 *-d*, *--delay* _seconds_::
 Update interrupt output every _seconds_ intervals.
 
diff --git a/sys-utils/irqtop.c b/sys-utils/irqtop.c
index adf75591b..eb0e6bc66 100644
--- a/sys-utils/irqtop.c
+++ b/sys-utils/irqtop.c
@@ -57,6 +57,7 @@
 #include <libsmartcols.h>
 
 #include "closestream.h"
+#include "cpuset.h"
 #include "monotonic.h"
 #include "pathnames.h"
 #include "strutils.h"
@@ -83,6 +84,8 @@ struct irqtop_ctl {
 
 	struct itimerspec timer;
 	struct irq_stat	*prev_stat;
+	size_t setsize;
+	cpu_set_t *cpuset;
 
 	enum irqtop_cpustat_mode cpustat_mode;
 	unsigned int request_exit:1;
@@ -111,7 +114,8 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 	char timestr[64], *data, *data0, *p;
 
 	/* make irqs table */
-	table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq);
+	table = get_scols_table(out, ctl->prev_stat, &stat, ctl->softirq, ctl->setsize,
+				ctl->cpuset);
 	if (!table) {
 		ctl->request_exit = 1;
 		return 1;
@@ -122,7 +126,8 @@ static int update_screen(struct irqtop_ctl *ctl, struct irq_output *out)
 
 	/* make cpus table */
 	if (ctl->cpustat_mode != IRQTOP_CPUSTAT_DISABLE) {
-		cpus = get_scols_cpus_table(out, ctl->prev_stat, stat);
+		cpus = get_scols_cpus_table(out, ctl->prev_stat, stat, ctl->setsize,
+					    ctl->cpuset);
 		scols_table_reduce_termwidth(cpus, 1);
 		if (ctl->cpustat_mode == IRQTOP_CPUSTAT_AUTO)
 			scols_table_enable_nowrap(cpus, 1);
@@ -261,6 +266,7 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_OPTIONS, stdout);
 	fputs(_(" -c, --cpu-stat <mode> show per-cpu stat (auto, enable, disable)\n"), stdout);
+	fputs(_(" -C, --cpu-list <list> specify cpus in list format\n"), stdout);
 	fputs(_(" -d, --delay <secs>   delay updates\n"), stdout);
 	fputs(_(" -o, --output <list>  define which output columns to use\n"), stdout);
 	fputs(_(" -s, --sort <column>  specify sort column\n"), stdout);
@@ -290,6 +296,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	const char *outarg = NULL;
 	static const struct option longopts[] = {
 		{"cpu-stat", required_argument, NULL, 'c'},
+		{"cpu-list", required_argument, NULL, 'C'},
 		{"delay", required_argument, NULL, 'd'},
 		{"sort", required_argument, NULL, 's'},
 		{"output", required_argument, NULL, 'o'},
@@ -300,7 +307,7 @@ static void parse_args(	struct irqtop_ctl *ctl,
 	};
 	int o;
 
-	while ((o = getopt_long(argc, argv, "c:d:o:s:ShV", longopts, NULL)) != -1) {
+	while ((o = getopt_long(argc, argv, "c:C:d:o:s:ShV", longopts, NULL)) != -1) {
 		switch (o) {
 		case 'c':
 			if (!strcmp(optarg, "auto"))
@@ -312,6 +319,21 @@ static void parse_args(	struct irqtop_ctl *ctl,
 			else
 				errx(EXIT_FAILURE, _("unsupported mode '%s'"), optarg);
 			break;
+		case 'C':
+			{
+				int ncpus = get_max_number_of_cpus();
+				if (ncpus <= 0)
+					errx(EXIT_FAILURE, _("cannot determine NR_CPUS; aborting"));
+
+				ctl->cpuset = cpuset_alloc(ncpus, &ctl->setsize, NULL);
+				if (!ctl->cpuset)
+					err(EXIT_FAILURE, _("cpuset_alloc failed"));
+
+				if (cpulist_parse(optarg, ctl->cpuset, ctl->setsize, 0))
+					errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
+						optarg);
+			}
+			break;
 		case 'd':
 			{
 				struct timeval delay;
@@ -388,6 +410,7 @@ int main(int argc, char **argv)
 
 	free_irqstat(ctl.prev_stat);
 	free(ctl.hostname);
+	cpuset_free(ctl.cpuset);
 
 	if (is_tty)
 		tcsetattr(STDIN_FILENO, TCSAFLUSH, &saved_tty);
diff --git a/sys-utils/lsirq.c b/sys-utils/lsirq.c
index 1a90efe21..375476dca 100644
--- a/sys-utils/lsirq.c
+++ b/sys-utils/lsirq.c
@@ -42,7 +42,7 @@ static int print_irq_data(struct irq_output *out, int softirq)
 {
 	struct libscols_table *table;
 
-	table = get_scols_table(out, NULL, NULL, softirq);
+	table = get_scols_table(out, NULL, NULL, softirq, 0, NULL);
 	if (!table)
 		return -1;
 
-- 
2.25.1

