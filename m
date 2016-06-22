Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31055 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751520AbcFVH0J (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Jun 2016 03:26:09 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5M7OEL4110450
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 03:26:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 23qd1gpv9u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 03:26:08 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 22 Jun 2016 08:26:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 88F2F1B0806E
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 08:27:16 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5M7Q4et10748186
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 07:26:04 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5M7Q4o3020693
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 01:26:04 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 2/6] lscpu: show static and dynamic MHz (s390)
Date: Wed, 22 Jun 2016 09:25:57 +0200
In-Reply-To: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1466580361-23435-3-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

s390 machines provide static and dynamic cpu mhz information via
/proc/cpuinfo. The static cpu mhz is the normal cpu frequency a cpu is
supposed to run with.

The dynamic cpu mhz is the actual frequency a cpu is running
with. This is usually the same as the static cpu mhz. Note that this
values are different to the min/max mhz values available on other
architecutes. The min/max values are unknown.

This patch adds two new fields to the summary output which display
these two values.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c                           | 8 ++++++++
 tests/expected/lscpu/lscpu-s390-lpar-drawer | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index c07b9d09683a..9b87e0431bac 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -208,6 +208,8 @@ struct lscpu_desc {
 	int	hyper;		/* hypervisor vendor ID */
 	int	virtype;	/* VIRT_PARA|FULL|NONE ? */
 	char	*mhz;
+	char	*dynamic_mhz;	/* dynamic mega hertz (s390) */
+	char	*static_mhz;	/* static mega hertz (s390) */
 	char	**maxmhz;	/* maximum mega hertz */
 	char	**minmhz;	/* minimum mega hertz */
 	char	*stepping;
@@ -489,6 +491,8 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		else if (lookup(buf, "model name", &desc->modelname)) ;
 		else if (lookup(buf, "stepping", &desc->stepping)) ;
 		else if (lookup(buf, "cpu MHz", &desc->mhz)) ;
+		else if (lookup(buf, "cpu MHz dynamic", &desc->dynamic_mhz)) ; /* s390 */
+		else if (lookup(buf, "cpu MHz static", &desc->static_mhz)) ;   /* s390 */
 		else if (lookup(buf, "flags", &desc->flags)) ;		/* x86 */
 		else if (lookup(buf, "features", &desc->flags)) ;	/* s390 */
 		else if (lookup(buf, "type", &desc->flags)) ;		/* sparc64 */
@@ -1718,6 +1722,10 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		print_s(_("Stepping:"), desc->stepping);
 	if (desc->mhz)
 		print_s(_("CPU MHz:"), desc->mhz);
+	if (desc->dynamic_mhz)
+		print_s(_("CPU dynamic MHz:"), desc->dynamic_mhz);
+	if (desc->static_mhz)
+		print_s(_("CPU static MHz:"), desc->static_mhz);
 	if (desc->maxmhz)
 		print_s(_("CPU max MHz:"), desc->maxmhz[0]);
 	if (desc->minmhz)
diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
index accbff821065..88fe1009ea0a 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar-drawer
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -9,6 +9,8 @@ Drawer(s):             4
 NUMA node(s):          1
 Vendor ID:             IBM/S390
 Model name:            0
+CPU dynamic MHz:       5000
+CPU static MHz:        5000
 BogoMIPS:              20325.00
 Hypervisor:            PR/SM
 Hypervisor vendor:     IBM
-- 
2.6.6

