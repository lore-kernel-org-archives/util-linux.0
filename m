Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36378 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdDLJLm (ORCPT
        <rfc822;util-linux-ng@vger.kernel.org>);
        Wed, 12 Apr 2017 05:11:42 -0400
Received: by mail-wm0-f46.google.com with SMTP id o81so82168431wmb.1
        for <util-linux-ng@vger.kernel.org>; Wed, 12 Apr 2017 02:11:41 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: util-linux-ng@vger.kernel.org
Cc: leif.lindholm@linaro.org, agraf@suse.de, kzak@redhat.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] lspcu: use sysfs for table access if available
Date: Wed, 12 Apr 2017 10:11:29 +0100
Message-Id: <20170412091129.27283-1-ard.biesheuvel@linaro.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On ARM systems, accessing SMBIOS tables via /dev/mem using read()
calls is not supported. The reason is that such tables are usually
located in EFI_RUNTIME_SERVICE_DATA memory, which is not covered
by the linear mapping on those systems, and so read() calls will
fail.

So instead, use the /sys/firmware/dmi/tables/DMI sysfs file, which
contains the entire structure table array, and will be available
on any recent Linux system, even on ones that only export the rev3
SMBIOS entry point, which is currently ignored by lscpu.

Note that the max 'num' value is inferred from the size. This is not
a limitation of the sysfs interface, but a limitation of the rev3
entry point, which no longer carries a number of array elements.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 sys-utils/lscpu-dmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 0e497d10c..a8298ff74 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -192,6 +192,18 @@ static int hypervisor_decode_smbios(uint8_t *buf, const char *devmem)
 		devmem);
 }
 
+static int hypervisor_decode_sysfw(void)
+{
+	static char const sys_fw_dmi_tables[] = "/sys/firmware/dmi/tables/DMI";
+	struct stat st;
+
+	if (stat(sys_fw_dmi_tables, &st))
+		return -1;
+
+	return hypervisor_from_dmi_table(0, st.st_size, st.st_size / 4,
+					 sys_fw_dmi_tables);
+}
+
 /*
  * Probe for EFI interface
  */
@@ -242,6 +254,10 @@ int read_hypervisor_dmi(void)
 	    || '\0' != 0)
 		return rc;
 
+	rc = hypervisor_decode_sysfw();
+	if (rc >= 0)
+		return rc;
+
 	/* First try EFI (ia64, Intel-based Mac) */
 	switch (address_from_efi(&fp)) {
 		case EFI_NOT_FOUND:
-- 
2.11.0

