Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52869 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751468AbcG2MNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jul 2016 08:13:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6TC8rdl105806
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24fcm6rb8r-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 29 Jul 2016 13:13:42 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id B326E219005E
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 13:13:06 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6TCDeSm000286
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 12:13:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6TBDfNZ015634
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 05:13:42 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/5] lscpu: add --physical option
Date: Fri, 29 Jul 2016 14:13:32 +0200
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1469794416-97361-2-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

With the --physical option lscpu will use the IDs that are reported by
the kernel (e.g. core id for the CORE column) instead of calculating
them on it's own.

This has the advantage that it is possible to tell on which physical
hardware CPUs a Linux instance runs. The logical IDs that lscpu
generates on it own are based on comparing of CPU masks and may or may
not be identical with the physical IDs.

If the kernel was unable to retrieve an ID for a topology element then
the corresponding sysfs file will normally contain "-1". In the
extended and parsable output a dash "-" will be displayed for such
cases.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.1 |  12 +++++-
 sys-utils/lscpu.c | 111 ++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 103 insertions(+), 20 deletions(-)

diff --git a/sys-utils/lscpu.1 b/sys-utils/lscpu.1
index ffe18db63332..72065d611630 100644
--- a/sys-utils/lscpu.1
+++ b/sys-utils/lscpu.1
@@ -3,7 +3,7 @@
 lscpu \- display information about the CPU architecture
 .SH SYNOPSIS
 .B lscpu
-.RB [ \-a | \-b | \-c "] [" \-x "] [" \-s " \fIdirectory\fP] [" \-e [=\fIlist\fP]| \-p [=\fIlist\fP]]
+.RB [ \-a | \-b | \-c "] [" \-x "] [" \-y "] [" \-s " \fIdirectory\fP] [" \-e [=\fIlist\fP]| \-p [=\fIlist\fP]]
 .br
 .B lscpu
 .BR \-h | \-V
@@ -145,6 +145,16 @@ of the Linux instance to be inspected.
 Use hexadecimal masks for CPU sets (for example 0x3).  The default is to print
 the sets in list format (for example 0,1).
 .TP
+.BR \-y , " \-\-physical"
+Display physical IDs for all columns with topology elements (core, socket, etc.).
+Other than logical IDs, which are assigned by \fBlscpu\fP, physical IDs are
+platform-specific values that are provided by the kernel. Physical IDs are not
+necessarily unique and they might not be arranged sequentially.
+If the kernel could not retrieve a physical ID for an element \fBlscpu\fP prints
+the dash (-) character.
+
+The CPU logical numbers are not affected by this option.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .SH BUGS
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b30b003b1674..dbb639c2fe2a 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -250,21 +250,25 @@ struct lscpu_desc {
 	 * hardware threads within the same drawer */
 	int		ndrawers;	/* number of all online drawers */
 	cpu_set_t	**drawermaps;	/* unique drawer_siblings */
+	int		*drawerids;	/* physical drawer ids */
 
 	/* books -- based on book_siblings (internal kernel map of cpuX's
 	 * hardware threads within the same book */
 	int		nbooks;		/* number of all online books */
 	cpu_set_t	**bookmaps;	/* unique book_siblings */
+	int		*bookids;	/* physical book ids */
 
 	/* sockets -- based on core_siblings (internal kernel map of cpuX's
 	 * hardware threads within the same physical_package_id (socket)) */
 	int		nsockets;	/* number of all online sockets */
 	cpu_set_t	**socketmaps;	/* unique core_siblings */
+	int		*socketids;	/* physical socket ids */
 
 	/* cores -- based on thread_siblings (internal kernel map of cpuX's
 	 * hardware threads within the same core as cpuX) */
 	int		ncores;		/* number of all online cores */
 	cpu_set_t	**coremaps;	/* unique thread_siblings */
+	int		*coreids;	/* physical core ids */
 
 	int		*polarization;	/* cpu polarization */
 	int		*addresses;	/* physical cpu addresses */
@@ -291,7 +295,8 @@ struct lscpu_modifier {
 	unsigned int	hex:1,		/* print CPU masks rather than CPU lists */
 			compat:1,	/* use backwardly compatible format */
 			online:1,	/* print online CPUs */
-			offline:1;	/* print offline CPUs */
+			offline:1,	/* print offline CPUs */
+			physical:1;	/* use physical numbers */
 };
 
 static int maxcpus;		/* size in bits of kernel cpu mask */
@@ -1058,7 +1063,8 @@ read_topology(struct lscpu_desc *desc, int idx)
 {
 	cpu_set_t *thread_siblings, *core_siblings;
 	cpu_set_t *book_siblings, *drawer_siblings;
-	int num = real_cpu_num(desc, idx);
+	int coreid, socketid, bookid, drawerid;
+	int i, num = real_cpu_num(desc, idx);
 
 	if (!path_exist(_PATH_SYS_CPU "/cpu%d/topology/thread_siblings", num))
 		return;
@@ -1075,6 +1081,22 @@ read_topology(struct lscpu_desc *desc, int idx)
 	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/drawer_siblings", num))
 		drawer_siblings = path_read_cpuset(maxcpus, _PATH_SYS_CPU
 					    "/cpu%d/topology/drawer_siblings", num);
+	coreid = -1;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/core_id", num))
+		coreid = path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/topology/core_id", num);
+	socketid = -1;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/physical_package_id", num))
+		socketid = path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/topology/physical_package_id", num);
+	bookid = -1;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/book_id", num))
+		bookid = path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/topology/book_id", num);
+	drawerid = -1;
+	if (path_exist(_PATH_SYS_CPU "/cpu%d/topology/drawer_id", num))
+		drawerid = path_read_s32(_PATH_SYS_CPU
+				       "/cpu%d/topology/drawer_id", num);
 
 	if (!desc->coremaps) {
 		int ndrawers, nbooks, nsockets, ncores, nthreads;
@@ -1123,18 +1145,36 @@ read_topology(struct lscpu_desc *desc, int idx)
 		 */
 		desc->coremaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
 		desc->socketmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
-		if (book_siblings)
+		desc->coreids = xcalloc(desc->ncpuspos, sizeof(*desc->drawerids));
+		desc->socketids = xcalloc(desc->ncpuspos, sizeof(*desc->drawerids));
+		for (i = 0; i < desc->ncpuspos; i++)
+			desc->coreids[i] = desc->socketids[i] = -1;
+		if (book_siblings) {
 			desc->bookmaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
-		if (drawer_siblings)
+			desc->bookids = xcalloc(desc->ncpuspos, sizeof(*desc->drawerids));
+			for (i = 0; i < desc->ncpuspos; i++)
+				desc->bookids[i] = -1;
+		}
+		if (drawer_siblings) {
 			desc->drawermaps = xcalloc(desc->ncpuspos, sizeof(cpu_set_t *));
+			desc->drawerids = xcalloc(desc->ncpuspos, sizeof(*desc->drawerids));
+			for (i = 0; i < desc->ncpuspos; i++)
+				desc->drawerids[i] = -1;
+		}
 	}
 
 	add_cpuset_to_array(desc->socketmaps, &desc->nsockets, core_siblings);
+	desc->coreids[idx] = coreid;
 	add_cpuset_to_array(desc->coremaps, &desc->ncores, thread_siblings);
-	if (book_siblings)
+	desc->socketids[idx] = socketid;
+	if (book_siblings) {
 		add_cpuset_to_array(desc->bookmaps, &desc->nbooks, book_siblings);
-	if (drawer_siblings)
+		desc->bookids[idx] = bookid;
+	}
+	if (drawer_siblings) {
 		add_cpuset_to_array(desc->drawermaps, &desc->ndrawers, drawer_siblings);
+		desc->drawerids[idx] = drawerid;
+	}
 }
 
 static void
@@ -1371,14 +1411,28 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 		snprintf(buf, bufsz, "%d", cpu);
 		break;
 	case COL_CORE:
-		if (cpuset_ary_isset(cpu, desc->coremaps,
-				     desc->ncores, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zu", i);
+		if (mod->physical) {
+			if (desc->coreids[idx] == -1)
+				snprintf(buf, bufsz, "-");
+			else
+				snprintf(buf, bufsz, "%d", desc->coreids[idx]);
+		} else {
+			if (cpuset_ary_isset(cpu, desc->coremaps,
+					     desc->ncores, setsize, &i) == 0)
+				snprintf(buf, bufsz, "%zu", i);
+		}
 		break;
 	case COL_SOCKET:
-		if (cpuset_ary_isset(cpu, desc->socketmaps,
-				     desc->nsockets, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zu", i);
+		if (mod->physical) {
+			if (desc->socketids[idx] ==  -1)
+				snprintf(buf, bufsz, "-");
+			else
+				snprintf(buf, bufsz, "%d", desc->socketids[idx]);
+		} else {
+			if (cpuset_ary_isset(cpu, desc->socketmaps,
+					     desc->nsockets, setsize, &i) == 0)
+				snprintf(buf, bufsz, "%zu", i);
+		}
 		break;
 	case COL_NODE:
 		if (cpuset_ary_isset(cpu, desc->nodemaps,
@@ -1386,14 +1440,28 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 			snprintf(buf, bufsz, "%d", desc->idx2nodenum[i]);
 		break;
 	case COL_DRAWER:
-		if (cpuset_ary_isset(cpu, desc->drawermaps,
-				     desc->ndrawers, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zu", i);
+		if (mod->physical) {
+			if (desc->drawerids[idx] == -1)
+				snprintf(buf, bufsz, "-");
+			else
+				snprintf(buf, bufsz, "%d", desc->drawerids[idx]);
+		} else {
+			if (cpuset_ary_isset(cpu, desc->drawermaps,
+					     desc->ndrawers, setsize, &i) == 0)
+				snprintf(buf, bufsz, "%zu", i);
+		}
 		break;
 	case COL_BOOK:
-		if (cpuset_ary_isset(cpu, desc->bookmaps,
-				     desc->nbooks, setsize, &i) == 0)
-			snprintf(buf, bufsz, "%zu", i);
+		if (mod->physical) {
+			if (desc->bookids[idx] == -1)
+				snprintf(buf, bufsz, "-");
+			else
+				snprintf(buf, bufsz, "%d", desc->bookids[idx]);
+		} else {
+			if (cpuset_ary_isset(cpu, desc->bookmaps,
+					     desc->nbooks, setsize, &i) == 0)
+				snprintf(buf, bufsz, "%zu", i);
+		}
 		break;
 	case COL_CACHE:
 	{
@@ -1872,6 +1940,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -p, --parse[=<list>]    print out a parsable format\n"), out);
 	fputs(_(" -s, --sysroot <dir>     use specified directory as system root\n"), out);
 	fputs(_(" -x, --hex               print hexadecimal masks rather than lists of CPUs\n"), out);
+	fputs(_(" -y, --physical          print physical instead of logical IDs\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -1902,6 +1971,7 @@ int main(int argc, char *argv[])
 		{ "extended",	optional_argument, 0, 'e' },
 		{ "parse",	optional_argument, 0, 'p' },
 		{ "sysroot",	required_argument, 0, 's' },
+		{ "physical",	no_argument,	   0, 'y' },
 		{ "hex",	no_argument,	   0, 'x' },
 		{ "version",	no_argument,	   0, 'V' },
 		{ NULL,		0, 0, 0 }
@@ -1919,7 +1989,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "abce::hp::s:xV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "abce::hp::s:xyV", longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
 
@@ -1958,6 +2028,9 @@ int main(int argc, char *argv[])
 		case 'x':
 			mod->hex = 1;
 			break;
+		case 'y':
+			mod->physical = 1;
+			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
-- 
2.6.6

