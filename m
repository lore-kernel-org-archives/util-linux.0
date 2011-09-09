Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:42746 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185Ab1IIJT6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 05:19:58 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p899Jr5v002340
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 09:19:53 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com [9.149.37.216])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p899Jqhv2596942
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:52 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p899Jq49031960
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 03:19:52 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 1/5] lib,cpuset: fix comments for cpu mask/list functions
Date: Fri,  9 Sep 2011 11:19:30 +0200
Message-Id: <1315559974-26863-2-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The comments for cpumask_parse() and cpulist_parse() each describe
the wrong function. Just exchange the comments.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/cpuset.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index dd31f52..842e8c8 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -221,7 +221,7 @@ char *cpumask_create(char *str, size_t len,
 }
 
 /*
- * Parses string with list of CPU ranges.
+ * Parses string with CPUs mask.
  */
 int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize)
 {
@@ -262,7 +262,7 @@ int cpumask_parse(const char *str, cpu_set_t *set, size_t setsize)
 }
 
 /*
- * Parses string with CPUs mask.
+ * Parses string with list of CPU ranges.
  */
 int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 {
-- 
1.7.5.4

