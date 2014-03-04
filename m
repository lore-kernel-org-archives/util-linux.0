Return-Path: util-linux-owner@vger.kernel.org
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:44850 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944AbaCDE1g (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Mar 2014 23:27:36 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <stewart@linux.vnet.ibm.com>;
	Tue, 4 Mar 2014 09:57:33 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id 10B6E1258044
	for <util-linux@vger.kernel.org>; Tue,  4 Mar 2014 09:59:39 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s244RQOf3408140
	for <util-linux@vger.kernel.org>; Tue, 4 Mar 2014 09:57:26 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
	by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s244RTEG019131
	for <util-linux@vger.kernel.org>; Tue, 4 Mar 2014 09:57:29 +0530
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: util-linux@vger.kernel.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH] lscpu: don't assume filesystem supports d_type when searching for NUMA nodes
Date: Tue,  4 Mar 2014 15:27:27 +1100
Message-Id: <1393907247-23750-1-git-send-email-stewart@linux.vnet.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Not all file systems support the d_type field and simply checking for
d_type == DT_DIR in is_node_dirent would cause the test suite to fail
if run on (for example) XFS.

The simple fix is to check for DT_DIR or DT_UNKNOWN in is_node_dirent.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 sys-utils/lscpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b8840ef..4760d4e 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -919,7 +919,7 @@ static inline int is_node_dirent(struct dirent *d)
 	return
 		d &&
 #ifdef _DIRENT_HAVE_D_TYPE
-		d->d_type == DT_DIR &&
+		(d->d_type == DT_DIR || d->d_type == DT_UNKNOWN) &&
 #endif
 		strncmp(d->d_name, "node", 4) == 0 &&
 		isdigit_string(d->d_name + 4);
-- 
1.8.5.3

