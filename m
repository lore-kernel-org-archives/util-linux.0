Return-Path: <SRS0=+DDw=DB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E357EC4363D
	for <util-linux@archiver.kernel.org>; Thu, 24 Sep 2020 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EC6239EC
	for <util-linux@archiver.kernel.org>; Thu, 24 Sep 2020 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPjzV23j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIXV4Z (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Sep 2020 17:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIXV4Z (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Thu, 24 Sep 2020 17:56:25 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600984583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=/E2TLdmV44pAqgcu9eBtSea69ctXo8sb8ylQwIuJ3Y8=;
        b=RPjzV23jtI5OazDnwKIMNZTIc2IZObBhDI3OWgp4zW7eqStkwPzqPl7y9rybtzB786UkUQ
        +J7fvH/wocJvtmnK3+Q2xkKoMoA2KIefG/bR/IOOFH4xdeucva9JFO56TVLq82Z+dHC8IC
        hMAdfAuM7UjqE1cbtvBkFoZP6iZQ1fw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-9Amw2eozP36AXPMPSHEeHg-1; Thu, 24 Sep 2020 17:56:21 -0400
X-MC-Unique: 9Amw2eozP36AXPMPSHEeHg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E395801AC8
        for <util-linux@vger.kernel.org>; Thu, 24 Sep 2020 21:56:20 +0000 (UTC)
Received: from tarantula.users.ipa.redhat.com (unknown [10.10.115.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C9573692
        for <util-linux@vger.kernel.org>; Thu, 24 Sep 2020 21:56:20 +0000 (UTC)
Date:   Thu, 24 Sep 2020 16:56:17 -0500
From:   Jeffrey Bastian <jbastian@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] use SMBIOS tables on ARM for lscpu
Message-ID: <20200924215617.c3oqc5tkuhjs5fyp@tarantula.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

ARM SBBR (Sever Base Boot Requirements) require SMBIOS tables, and
SMBIOS Type 4 describes the CPU manufacturer and model name (among other
details).  If SMBIOS Type 4 is present, use it to extract these strings.

Example output (before and after the patch) on an HP m400, Lenovo HR330A,
and HPE Apollo 70:

[root@hp-m400 ~]# /usr/bin/lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:           APM
Model:               1
Model name:          X-Gene
Stepping:            0x0
[root@hp-m400 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:                       AppliedMicro
Model:                           1
Model name:                      X-Gene
Stepping:                        0x0

[root@lenovo-hr330a ~]# /usr/bin/lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:           APM
Model:               2
Model name:          X-Gene
Stepping:            0x3
[root@lenovo-hr330a ~]# ./lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:                       Ampere(TM)
Model:                           2
Model name:                      eMAG
Stepping:                        0x3

[root@hpe-apollo-70 ~]# /usr/bin/lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
[root@hpe-apollo-70 ~]# ./lscpu | grep -i -e vendor -e model -e stepping
Vendor ID:                       Cavium Inc.
Model:                           1
Model name:                      Cavium ThunderX2(R) CPU CN9980 v2.1 @ 2.20GHz
Stepping:                        0x1

Signed-off-by: Jeffrey Bastian <jbastian@redhat.com>
---
  sys-utils/lscpu-arm.c | 88 ++++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/sys-utils/lscpu-arm.c b/sys-utils/lscpu-arm.c
index 270866191875..82cc23ca830c 100644
--- a/sys-utils/lscpu-arm.c
+++ b/sys-utils/lscpu-arm.c
@@ -22,7 +22,15 @@
   *  - Linux kernel: arch/armX/include/asm/cputype.h
   *  - GCC sources: config/arch/arch-cores.def
   *  - Ancient wisdom
+ *  - SMBIOS tables (if applicable)
   */
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
  #include "lscpu.h"
  
  struct id_part {
@@ -202,7 +210,7 @@ static const struct hw_impl hw_implementer[] = {
      { -1,   unknown_part, "unknown" },
  };
  
-void arm_cpu_decode(struct lscpu_desc *desc)
+static void _arm_cpu_decode(struct lscpu_desc *desc)
  {
  	int j, impl, part;
  	const struct id_part *parts = NULL;
@@ -260,3 +268,81 @@ void arm_cpu_decode(struct lscpu_desc *desc)
  		desc->stepping = xstrdup(buf);
  	}
  }
+
+/* TODO: struct dmi_header, to_dmi_header() and dmi_string() are copied
+ * from lscpu-dmi.c.  Move them to a library?
+ */
+struct dmi_header
+{
+	uint8_t type;
+	uint8_t length;
+	uint16_t handle;
+	uint8_t *data;
+};
+
+static void to_dmi_header(struct dmi_header *h, uint8_t *data)
+{
+	h->type = data[0];
+	h->length = data[1];
+	memcpy(&h->handle, data + 2, sizeof(h->handle));
+	h->data = data;
+}
+
+static char *dmi_string(const struct dmi_header *dm, uint8_t s)
+{
+	char *bp = (char *)dm->data;
+
+	if (s == 0)
+		return NULL;
+
+	bp += dm->length;
+	while (s > 1 && *bp)
+	{
+		bp += strlen(bp);
+		bp++;
+		s--;
+	}
+
+	if (!*bp)
+		return NULL;
+
+	return bp;
+}
+
+#define _PATH_SYS_DMI_TYPE4	"/sys/firmware/dmi/entries/4-0/raw"
+#define PROC_MFR_OFFSET		0x07
+#define PROC_VERSION_OFFSET	0x10
+
+static void _arm_cpu_smbios(struct lscpu_desc *desc)
+{
+	uint8_t data[8192];
+	char buf[128];
+	struct dmi_header h;
+	int raw_fd = -1;
+
+	raw_fd = open(_PATH_SYS_DMI_TYPE4, O_RDONLY);
+	if (raw_fd == -1) {
+		return;
+	}
+	read(raw_fd, data, 8192);
+	close(raw_fd);
+
+	to_dmi_header(&h, data);
+
+	strncpy(buf, dmi_string(&h, data[PROC_MFR_OFFSET]), 127);
+	desc->vendor = xstrdup(buf);
+
+	strncpy(buf, dmi_string(&h, data[PROC_VERSION_OFFSET]), 127);
+	desc->modelname = xstrdup(buf);
+}
+
+void arm_cpu_decode(struct lscpu_desc *desc)
+{
+	/* use SMBIOS Type 4 data if available,
+	 * else fall back to manual decoding using the tables above */
+	if (access(_PATH_SYS_DMI_TYPE4, R_OK) != -1) {
+		_arm_cpu_smbios(desc);
+	} else {
+		_arm_cpu_decode(desc);
+	}
+}
-- 
2.26.2

