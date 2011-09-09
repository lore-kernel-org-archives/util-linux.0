Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:59037 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933191Ab1IIJUC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 05:20:02 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p899Jt70013552
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 09:19:56 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com [9.149.37.247])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p899Jt982220044
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:55 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p899JsjY029711
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 03:19:55 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 5/5] chcpu,cpuset: reduce code duplication for cpu list parsing
Date: Fri,  9 Sep 2011 11:19:34 +0200
Message-Id: <1315559974-26863-6-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reduce code duplication and print better error message if an
unsupported cpu number was passed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/cpuset.c      |    7 ++++++-
 sys-utils/chcpu.c |   28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index ebaffcc..c3b67a7 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -263,6 +263,11 @@ int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize)
 
 /*
  * Parses string with list of CPU ranges.
+ * Returns 0 on success.
+ * Returns 1 on error.
+ * Returns 2 if fail is set and a cpu number passed in the list doesn't fit
+ * into the cpu_set. If fail is not set cpu numbers that do not fit are
+ * ignored and 0 is returned instead.
  */
 int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 {
@@ -303,7 +308,7 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 			return 1;
 		while (a <= b) {
 			if (fail && (a >= max))
-				return 1;
+				return 2;
 			CPU_SET_S(a, setsize, set);
 			a += s;
 		}
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 2d5725f..a5d12c7 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -210,6 +210,18 @@ static int cpu_configure(cpu_set_t *cpu_set, size_t setsize, int configure)
 	return EXIT_SUCCESS;
 }
 
+static void cpu_parse(char *cpu_string, cpu_set_t *cpu_set, size_t setsize)
+{
+	int rc;
+
+	rc = cpulist_parse(cpu_string, cpu_set, setsize, 1);
+	if (rc == 0)
+		return;
+	if (rc == 2)
+		errx(EXIT_FAILURE, _("invalid CPU number in CPU list: %s"), cpu_string);
+	errx(EXIT_FAILURE, _("failed to parse CPU list: %s"), cpu_string);
+}
+
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fprintf(out, _(
@@ -269,27 +281,19 @@ int main(int argc, char *argv[])
 		switch (c) {
 		case 'c':
 			cmd = CMD_CPU_CONFIGURE;
-			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
-				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
-				     argv[optind -1 ]);
+			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'd':
 			cmd = CMD_CPU_DISABLE;
-			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
-				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
-				     argv[optind -1 ]);
+			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'e':
 			cmd = CMD_CPU_ENABLE;
-			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
-				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
-				     argv[optind -1 ]);
+			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'g':
 			cmd = CMD_CPU_DECONFIGURE;
-			if (cpulist_parse(argv[optind - 1], cpu_set, setsize, 1))
-				errx(EXIT_FAILURE, _("failed to parse CPU list: %s"),
-				     argv[optind -1 ]);
+			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'h':
 			usage(stdout);
-- 
1.7.5.4

