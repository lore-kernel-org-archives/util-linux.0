Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:56377 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933107Ab1IIJT5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 05:19:57 -0400
Received: from d06nrmr1507.portsmouth.uk.ibm.com (d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p899Js4d023105
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 09:19:54 GMT
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com [9.149.37.250])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p899JrSF2445518
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:53 +0100
Received: from d06av09.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p899Jrin002421
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 03:19:53 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/5] lib,cpuset: fix odd placed braces in cpulist_parse()
Date: Fri,  9 Sep 2011 11:19:31 +0200
Message-Id: <1315559974-26863-3-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The opening and closing braces for two following if statements within
cpulist_parse() are placed in an odd manner.
Just fix this to prevent broken code in the future.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/cpuset.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index 842e8c8..cf22aa7 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -289,8 +289,8 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 			if (sscanf(c1, "%u", &b) < 1)
 				return 1;
 			c1 = nexttoken(c1, ':');
-			if (c1 != NULL && (c2 == NULL || c1 < c2))
-				if (sscanf(c1, "%u", &s) < 1) {
+			if (c1 != NULL && (c2 == NULL || c1 < c2)) {
+				if (sscanf(c1, "%u", &s) < 1)
 					return 1;
 			}
 		}
-- 
1.7.5.4

