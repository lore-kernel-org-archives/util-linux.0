Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47003 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751604AbcG2MNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jul 2016 08:13:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6TC8vqs143900
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:46 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 24fj2p91hk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 29 Jul 2016 13:13:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 17D871B0804B
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 13:15:09 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6TCDeaQ3473882
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 12:13:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6TBDgSm015746
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 05:13:43 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 5/5] lscpu: print correct number of threads per core if possible
Date: Fri, 29 Jul 2016 14:13:36 +0200
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1469794416-97361-6-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lscpu calculates the number of threads per core by dividing the number
of online cpus with the number of cores. This may or may not give the
correct number of threads per core depending on the number of online
CPUs (and which CPUs are online).

At least on s390 there is a new "max thread id" field within
/proc/cpuinfo present which reliably allows us to tell the number of
threads per core. Let's use this instead, like we already have also
special treatment to figure out the number core per socket etc. on
s390.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 1da595b3dac7..52a944d3a99c 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -216,6 +216,7 @@ struct lscpu_desc {
 	char	*stepping;
 	char    *bogomips;
 	char	*flags;
+	char	*mtid;		/* maximum thread id (s390) */
 	int	dispatching;	/* none, horizontal or vertical */
 	int	mode;		/* rm, lm or/and tm */
 
@@ -566,6 +567,7 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "bogomips per cpu", &desc->bogomips)) ; /* s390 */
 		else if (lookup(buf, "cpu", &desc->cpu)) ;
 		else if (lookup(buf, "revision", &desc->revision)) ;
+		else if (lookup(buf, "max thread id", &desc->mtid)) ; /* s390 */
 		else if (lookup_cache(buf, desc)) ;
 		else
 			continue;
@@ -1804,9 +1806,11 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 	}
 
 	if (desc->nsockets) {
-		int cores_per_socket, sockets_per_book, books_per_drawer, drawers;
+		int threads_per_core, cores_per_socket, sockets_per_book;
+		int books_per_drawer, drawers;
 
-		cores_per_socket = sockets_per_book = books_per_drawer = drawers = 0;
+		threads_per_core = cores_per_socket = sockets_per_book = 0;
+		books_per_drawer = drawers = 0;
 		/* s390 detects its cpu topology via /proc/sysinfo, if present.
 		 * Using simply the cpu topology masks in sysfs will not give
 		 * usable results since everything is virtualized. E.g.
@@ -1830,7 +1834,10 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 			if (fd)
 				fclose(fd);
 		}
-		print_n(_("Thread(s) per core:"), desc->nthreads / desc->ncores);
+		if (desc->mtid)
+			threads_per_core = atoi(desc->mtid) + 1;
+		print_n(_("Thread(s) per core:"),
+			threads_per_core ?: desc->nthreads / desc->ncores);
 		print_n(_("Core(s) per socket:"),
 			cores_per_socket ?: desc->ncores / desc->nsockets);
 		if (desc->nbooks) {
-- 
2.6.6

