Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA51BF7FC
	for <util-linux@vger.kernel.org>; Wed, 21 Aug 2024 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230205; cv=none; b=JrmEoDgqwRIb8w8+UknmPEIie90euFYRjr+yq4XdaE5o4dOL7Svl1QQ2qQUI1df6Ul7dgNqU3uQRoLmkLxEaow5mAZ0FRV9fVbzrLXDROIbww0AtKOLVAra4Z9lPkBASqsRfkuFRjqGLTfe6t5n2G9rTD2gZyACsfZDhHRp7YO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230205; c=relaxed/simple;
	bh=nFiBOIUa+t3ze6BUpj4I10yLxFgLRiBpG/nH6WjqylU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fYaJcTexYdul3AqMsh7rJYaFRup8F/mDLyE2rpLya/0ZpGR6qNQZCfDSTUYeBG3z4HkMlpx0fj7Mwqd0wXhqQc+fnLMO7DIK7GSFVKHa9XIiaBm2fBxD+HciB9kNxrS95KLWOHrO6JgW3jAqiPkSAVJXgVmbNUmTfD9wu/ROe1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZEJajqCm; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZEJajqCm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724230200; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=CCLWv2DjIYbyjVmY6yl+mPdi4ob8Sgi9E0SGUzs4uDU=;
	b=ZEJajqCm7UYGdCLquqQa016lwe8ujrG7f1rwm3XRR109kx/DDEKHs7ElNlp884wCj/+kmjE/Xb82tzD3UCBHAYg9H+EoJEcTmOOk2dsjoCpUtPYSM7xvsl1xqNdDYZhdN5itg916GUK84JdHk4sJbISZAt8GEy58fAlDeghVfhE=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WDLIzuZ_1724230194)
          by smtp.aliyun-inc.com;
          Wed, 21 Aug 2024 16:49:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: qcai@redhat.com
Cc: util-linux@vger.kernel.org
Subject: [PATCH] lscpu: optimize query virt pci device
Date: Wed, 21 Aug 2024 16:49:54 +0800
Message-ID: <20240821084954.21566-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lscpu command needs to traverse the /proc/bus/pci/devices file
three times to check for any PCI devices related to virtualization.
If there are many PCI devices on the machine, this can lead to
increased execution time for lscpu. It would be beneficial to
consolidate these queries into a single check to optimize the
execution time of lscpu.

Use time command to test on a machine with 13000 PCI devices:
before:
	real  0m13.506s
	user  0m0.028s
	sys   0m13.409s
after:
	real  0m5.834s
	user  0m0.018s
	sys   0m5.771s

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 sys-utils/lscpu-virt.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/sys-utils/lscpu-virt.c b/sys-utils/lscpu-virt.c
index 051384622..f559d9c14 100644
--- a/sys-utils/lscpu-virt.c
+++ b/sys-utils/lscpu-virt.c
@@ -273,16 +273,15 @@ static int read_hypervisor_dmi(void)
 	return rc < 0 ? VIRT_VENDOR_NONE : rc;
 }
 
-static int has_pci_device(struct lscpu_cxt *cxt,
-			unsigned int vendor, unsigned int device)
+static int find_virt_pci_device(struct lscpu_cxt *cxt)
 {
 	FILE *f;
-	unsigned int num, fn, ven, dev;
-	int res = 1;
+	int num, fn, ven, dev;
+	int vendor = VIRT_VENDOR_NONE;
 
 	f = ul_path_fopen(cxt->procfs, "r", "bus/pci/devices");
 	if (!f)
-		return 0;
+		return vendor;
 
 	 /* for more details about bus/pci/devices format see
 	  * drivers/pci/proc.c in linux kernel
@@ -290,14 +289,28 @@ static int has_pci_device(struct lscpu_cxt *cxt,
 	while(fscanf(f, "%02x%02x\t%04x%04x\t%*[^\n]",
 			&num, &fn, &ven, &dev) == 4) {
 
-		if (ven == vendor && dev == device)
+		if (ven == hv_vendor_pci[VIRT_VENDOR_XEN] &&
+			dev == hv_graphics_pci[VIRT_VENDOR_XEN]) {
+			vendor = VIRT_VENDOR_XEN;
+			goto found;
+		}
+
+		if (ven == hv_vendor_pci[VIRT_VENDOR_VMWARE] &&
+			dev == hv_graphics_pci[VIRT_VENDOR_VMWARE]) {
+			vendor = VIRT_VENDOR_VMWARE;
+			goto found;
+		}
+
+		if (ven == hv_vendor_pci[VIRT_VENDOR_VBOX] &&
+			dev == hv_graphics_pci[VIRT_VENDOR_VBOX]) {
+			vendor = VIRT_VENDOR_VBOX;
 			goto found;
+		}
 	}
 
-	res = 0;
 found:
 	fclose(f);
-	return res;
+	return vendor;
 }
 
 #if defined(__x86_64__) || defined(__i386__)
@@ -597,16 +610,8 @@ struct lscpu_virt *lscpu_read_virtualization(struct lscpu_cxt *cxt)
 		virt->vendor = VIRT_VENDOR_XEN;
 
 	/* Xen full-virt on non-x86_64 */
-	} else if (has_pci_device(cxt, hv_vendor_pci[VIRT_VENDOR_XEN], hv_graphics_pci[VIRT_VENDOR_XEN])) {
-		virt->vendor = VIRT_VENDOR_XEN;
+	} else if ((virt->vendor = find_virt_pci_device(cxt))) {
 		virt->type = VIRT_TYPE_FULL;
-	} else if (has_pci_device(cxt, hv_vendor_pci[VIRT_VENDOR_VMWARE], hv_graphics_pci[VIRT_VENDOR_VMWARE])) {
-		virt->vendor = VIRT_VENDOR_VMWARE;
-		virt->type = VIRT_TYPE_FULL;
-	} else if (has_pci_device(cxt, hv_vendor_pci[VIRT_VENDOR_VBOX], hv_graphics_pci[VIRT_VENDOR_VBOX])) {
-		virt->vendor = VIRT_VENDOR_VBOX;
-		virt->type = VIRT_TYPE_FULL;
-
 	/* IBM PR/SM */
 	} else if ((fd = ul_path_fopen(cxt->procfs, "r", "sysinfo"))) {
 
-- 
2.30.1 (Apple Git-130)

