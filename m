Return-Path: util-linux-owner@vger.kernel.org
Received: from mtagate2.uk.ibm.com ([194.196.100.162]:59030 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933185Ab1IIJUB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 9 Sep 2011 05:20:01 -0400
Received: from d06nrmr1307.portsmouth.uk.ibm.com (d06nrmr1307.portsmouth.uk.ibm.com [9.149.38.129])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p899JthY013542
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 09:19:55 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
	by d06nrmr1307.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p899JsRO2351304
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 10:19:54 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p899Jsuh017692
	for <util-linux@vger.kernel.org>; Fri, 9 Sep 2011 03:19:54 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4/5] lib,cpuset: enforce stricter parsing of cpu lists
Date: Fri,  9 Sep 2011 11:19:33 +0200
Message-Id: <1315559974-26863-5-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1315559974-26863-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The current cpulist_parse() function ignores extra non-parsable characters
at the end of the to be parsed cpu list string.
E.g. it would accept something like "0bla" and just set bit 0 in the cpu set.
Since such a string is invalid implement stricter parsing that makes sure
that everything of the string has been succesfully parsed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 lib/cpuset.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/cpuset.c b/lib/cpuset.c
index 8592755..ebaffcc 100644
--- a/lib/cpuset.c
+++ b/lib/cpuset.c
@@ -268,8 +268,9 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 {
 	size_t max = cpuset_nbits(setsize);
 	const char *p, *q;
-	q = str;
+	int r;
 
+	q = str;
 	CPU_ZERO_S(setsize, set);
 
 	while (p = q, q = nexttoken(q, ','), p) {
@@ -277,8 +278,9 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 		unsigned int b;	/* end of range */
 		unsigned int s;	/* stride */
 		const char *c1, *c2;
+		char c;
 
-		if (sscanf(p, "%u", &a) < 1)
+		if ((r = sscanf(p, "%u%c", &a, &c)) < 1)
 			return 1;
 		b = a;
 		s = 1;
@@ -286,11 +288,11 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 		c1 = nexttoken(p, '-');
 		c2 = nexttoken(p, ',');
 		if (c1 != NULL && (c2 == NULL || c1 < c2)) {
-			if (sscanf(c1, "%u", &b) < 1)
+			if ((r = sscanf(c1, "%u%c", &b, &c)) < 1)
 				return 1;
 			c1 = nexttoken(c1, ':');
 			if (c1 != NULL && (c2 == NULL || c1 < c2)) {
-				if (sscanf(c1, "%u", &s) < 1)
+				if ((r = sscanf(c1, "%u%c", &s, &c)) < 1)
 					return 1;
 				if (s == 0)
 					return 1;
@@ -307,6 +309,8 @@ int cpulist_parse(const char *str, cpu_set_t *set, size_t setsize, int fail)
 		}
 	}
 
+	if (r == 2)
+		return 1;
 	return 0;
 }
 
-- 
1.7.5.4

