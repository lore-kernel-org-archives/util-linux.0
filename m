Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate1.uk.ibm.com ([194.196.100.161]:42745 "EHLO
	mtagate1.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933164Ab1IIJT6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 05:19:58 -0400
Received: from d06nrmr1806.portsmouth.uk.ibm.com (d06nrmr1806.portsmouth.uk.ibm.com [9.149.39.193])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p899Jsm4002354
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 09:19:55 GMT
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by d06nrmr1806.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p899Js282314450
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:54 +0100
Received: from d06av08.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p899JrGx015286
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:54 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/5] lib,cpuset: fix stride handling in cpulist_parse()
Date: Fri,  9 Sep 2011 11:19:32 +0200
Message-Id: <1315559974-26863-4-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If cpulist_parse() gets passed a cpu list with a stride value of 0
it will be stuck in an endless loop.
E.g. the following cpu list will cause an endless loop: "0-2:0".
Fix this by causing a parse error if the stride value is 0.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/cpuset.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index cf22aa7..8592755 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -292,6 +292,8 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 			if (c1 != NULL && (c2 == NULL || c1 < c2)) {
 				if (sscanf(c1, "%u", &s) < 1)
 					return 1;
+				if (s == 0)
+					return 1;
 			}
 		}
 
-- 
1.7.5.4

