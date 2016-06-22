Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56252 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750959AbcFVH0T (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 22 Jun 2016 03:26:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5M7OGYE011992
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 03:26:19 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23qcxdy6hj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 03:26:18 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <util-linux@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 22 Jun 2016 08:26:15 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id F01601B08074
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 08:27:16 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com [9.149.37.249])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u5M7Q5be66584628
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 07:26:05 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u5M7Q4Y2020707
	for <util-linux@vger.kernel.org>; Wed, 22 Jun 2016 01:26:04 -0600
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 3/6] lscpu: show machine type (s390)
Date: Wed, 22 Jun 2016 09:25:58 +0200
In-Reply-To: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1466580361-23435-1-git-send-email-heiko.carstens@de.ibm.com>
Message-Id: <1466580361-23435-4-git-send-email-heiko.carstens@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Show also the machine type within the lscpu output. With the machine
type it is possible to identify the cpu generation and the supported
features.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c                           | 12 ++++++++++++
 tests/expected/lscpu/lscpu-s390-kvm         |  1 +
 tests/expected/lscpu/lscpu-s390-lpar        |  1 +
 tests/expected/lscpu/lscpu-s390-lpar-drawer |  1 +
 tests/expected/lscpu/lscpu-s390-zvm         |  1 +
 5 files changed, 16 insertions(+)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 9b87e0431bac..883dff68bb85 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -198,6 +198,7 @@ struct polarization_modes polar_modes[] = {
 struct lscpu_desc {
 	char	*arch;
 	char	*vendor;
+	char	*machinetype;	/* s390 */
 	char	*family;
 	char	*model;
 	char	*modelname;
@@ -581,6 +582,15 @@ read_basicinfo(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 
 	if (mod->system == SYSTEM_LIVE)
 		read_physical_info_powerpc(desc);
+
+	if (path_exist(_PATH_PROC_SYSINFO)) {
+		FILE *fd = path_fopen("r", 0, _PATH_PROC_SYSINFO);
+
+		while (fd && fgets(buf, sizeof(buf), fd) != NULL && !desc->machinetype)
+			lookup(buf, "Type", &desc->machinetype);
+		if (fd)
+			fclose(fd);
+	}
 }
 
 static int
@@ -1712,6 +1722,8 @@ print_summary(struct lscpu_desc *desc, struct lscpu_modifier *mod)
 		print_n(_("NUMA node(s):"), desc->nnodes);
 	if (desc->vendor)
 		print_s(_("Vendor ID:"), desc->vendor);
+	if (desc->machinetype)
+		print_s(_("Machine type:"), desc->machinetype);
 	if (desc->family)
 		print_s(_("CPU family:"), desc->family);
 	if (desc->model || desc->revision)
diff --git a/tests/expected/lscpu/lscpu-s390-kvm b/tests/expected/lscpu/lscpu-s390-kvm
index 9632b055aef3..66d1c047c59c 100644
--- a/tests/expected/lscpu/lscpu-s390-kvm
+++ b/tests/expected/lscpu/lscpu-s390-kvm
@@ -6,6 +6,7 @@ Core(s) per socket:    1
 Socket(s) per book:    1
 Book(s):               3
 Vendor ID:             IBM/S390
+Machine type:          2817
 BogoMIPS:              14367.00
 Hypervisor:            KVM/Linux
 Hypervisor vendor:     KVM
diff --git a/tests/expected/lscpu/lscpu-s390-lpar b/tests/expected/lscpu/lscpu-s390-lpar
index a4265667f51d..9c8ac2c4f8dd 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar
+++ b/tests/expected/lscpu/lscpu-s390-lpar
@@ -7,6 +7,7 @@ Core(s) per socket:    4
 Socket(s) per book:    6
 Book(s):               4
 Vendor ID:             IBM/S390
+Machine type:          2817
 BogoMIPS:              14367.00
 Hypervisor:            PR/SM
 Hypervisor vendor:     IBM
diff --git a/tests/expected/lscpu/lscpu-s390-lpar-drawer b/tests/expected/lscpu/lscpu-s390-lpar-drawer
index 88fe1009ea0a..587e7a6ed18d 100644
--- a/tests/expected/lscpu/lscpu-s390-lpar-drawer
+++ b/tests/expected/lscpu/lscpu-s390-lpar-drawer
@@ -8,6 +8,7 @@ Book(s) per drawer:    2
 Drawer(s):             4
 NUMA node(s):          1
 Vendor ID:             IBM/S390
+Machine type:          2964
 Model name:            0
 CPU dynamic MHz:       5000
 CPU static MHz:        5000
diff --git a/tests/expected/lscpu/lscpu-s390-zvm b/tests/expected/lscpu/lscpu-s390-zvm
index 6cf24bf867c0..4cd6b8fa0fc1 100644
--- a/tests/expected/lscpu/lscpu-s390-zvm
+++ b/tests/expected/lscpu/lscpu-s390-zvm
@@ -6,6 +6,7 @@ Core(s) per socket:    1
 Socket(s) per book:    1
 Book(s):               4
 Vendor ID:             IBM/S390
+Machine type:          2817
 BogoMIPS:              14367.00
 Hypervisor:            z/VM 6.1.0
 Hypervisor vendor:     IBM
-- 
2.6.6

