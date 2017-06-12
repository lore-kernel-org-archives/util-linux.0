Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:33426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753879AbdFLPcm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 12 Jun 2017 11:32:42 -0400
From: Michal Suchanek <msuchanek@suse.de>
To: util-linux@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Ondrej Oprala <ooprala@redhat.com>,
        Karel Zak <kzak@redhat.com>, sbrabec@suse.com
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] lscpu: dmi: return HYPER_NONE when detection fails
Date: Mon, 12 Jun 2017 17:32:28 +0200
Message-Id: <20170612153228.2766-1-msuchanek@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is weird mix of logic in lscpu-dmi.c which sometimes returns 0 and
sometimes -1 on error. Since most checks are if (rc) goto done; this
bails out early on error skipping some detection methods. Further, in
lscpu.c all following detections are guarder by if(hyper) so returnning
-1 causes all following methods to be skipped. The hyper value is used
as array index so -1 is out of bounds.

Some users observe that they are running under hypervisor and this is
not detected so it is probably good idea to just try everything.

On the other hand, on some versions of Linux on arm64 reading /dev/mem
causes kernel oops killing lscpu. If it is desirable for lscpu to work
on these broken kernels an additional ifdef is required.

Fixes: 92a6392c41c1 ("lscpu: use sysfs for table access if available")
Fixes: fb2627cec4c8 ("lscpu: detect more hypervisor vendors")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 sys-utils/lscpu-dmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/lscpu-dmi.c b/sys-utils/lscpu-dmi.c
index 3ba999124a2e..71d6874c919d 100644
--- a/sys-utils/lscpu-dmi.c
+++ b/sys-utils/lscpu-dmi.c
@@ -187,7 +187,7 @@ static int hypervisor_decode_smbios(uint8_t *buf, const char *devmem)
 	if (!checksum(buf, buf[0x05])
 	    || memcmp(buf + 0x10, "_DMI_", 5) != 0
 	    || !checksum(buf + 0x10, 0x0F))
-		return -1;
+		return HYPER_NONE;
 
 	return hypervisor_from_dmi_table(DWORD(buf + 0x18), WORD(buf + 0x16),
 			 WORD(buf + 0x1C),
@@ -200,7 +200,7 @@ static int hypervisor_decode_sysfw(void)
 	struct stat st;
 
 	if (stat(sys_fw_dmi_tables, &st))
-		return -1;
+		return HYPER_NONE;
 
 	return hypervisor_from_dmi_table(0, st.st_size, st.st_size / 4,
 					 sys_fw_dmi_tables);
@@ -257,7 +257,7 @@ int read_hypervisor_dmi(void)
 		return rc;
 
 	rc = hypervisor_decode_sysfw();
-	if (rc >= 0)
+	if (rc > HYPER_NONE)
 		return rc;
 
 	/* First try EFI (ia64, Intel-based Mac) */
@@ -273,7 +273,7 @@ int read_hypervisor_dmi(void)
 		goto done;
 
 	rc = hypervisor_decode_smbios(buf, _PATH_DEV_MEM);
-	if (rc)
+	if (rc > HYPER_NONE)
 		goto done;
 	free(buf);
 	buf = NULL;
@@ -287,13 +287,13 @@ memory_scan:
 	for (fp = 0; fp <= 0xFFF0; fp += 16) {
 		if (memcmp(buf + fp, "_SM_", 4) == 0 && fp <= 0xFFE0) {
 			rc = hypervisor_decode_smbios(buf + fp, _PATH_DEV_MEM);
-			if (rc == -1)
+			if ( ! (rc > HYPER_NONE))
 				fp += 16;
 
 		} else if (memcmp(buf + fp, "_DMI_", 5) == 0)
 			rc = hypervisor_decode_legacy(buf + fp, _PATH_DEV_MEM);
 
-		if (rc >= 0)
+		if (rc > HYPER_NONE)
 			break;
 	}
 #endif
-- 
2.12.3

