Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13536 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751504AbcG2MNq (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jul 2016 08:13:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6TC8qdm102418
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 24fcm30hm0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 08:13:45 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Fri, 29 Jul 2016 13:13:43 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2675F2190066
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 13:13:07 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com [9.149.37.251])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6TCDeLg20185566
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 12:13:40 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6TBDgT7015704
	for <util-linux@vger.kernel.org>; Fri, 29 Jul 2016 05:13:42 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/5] lscpu: only try to read sysfs attributes of present CPUs
Date: Fri, 29 Jul 2016 14:13:34 +0200
In-Reply-To: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1469794416-97361-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1469794416-97361-4-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

lscpu can skip all CPUs which are possible but not present. For
configurations where a lot of CPUs are possible but only few CPUs are
present this saves a lot of pointless glibc/system calls.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index dbb639c2fe2a..1da595b3dac7 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -2059,6 +2059,10 @@ int main(int argc, char *argv[])
 	read_basicinfo(desc, mod);
 
 	for (i = 0; i < desc->ncpuspos; i++) {
+		/* only consider present CPUs */
+		if (desc->present &&
+		    !CPU_ISSET(real_cpu_num(desc, i), desc->present))
+			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
 		read_polarization(desc, i);
-- 
2.6.6

