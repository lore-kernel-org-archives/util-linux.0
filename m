Return-Path: util-linux-owner@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751016AbdI0RpP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 27 Sep 2017 13:45:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8RHiQKP114397
        for <util-linux@vger.kernel.org>; Wed, 27 Sep 2017 13:45:15 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2d8f3snh3x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Wed, 27 Sep 2017 13:45:15 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <util-linux@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 27 Sep 2017 18:45:13 +0100
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 3/3] lsmem/chmem: add memory zone awareness to bash-completion
Date: Wed, 27 Sep 2017 19:44:46 +0200
In-Reply-To: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
References: <20170927174446.20459-1-gerald.schaefer@de.ibm.com>
Message-Id: <20170927174446.20459-4-gerald.schaefer@de.ibm.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Andre Wild <wild@linux.vnet.ibm.com>

This patch extends the valid --output values with ZONES for the
lsmem bash-completion, and adds the --zone option for the chmem
bash-completion.

Signed-off-by: Andre Wild <wild@linux.vnet.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
---
 bash-completion/chmem | 1 +
 bash-completion/lsmem | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/bash-completion/chmem b/bash-completion/chmem
index 00b870dbd90d..3e3af87acaa5 100644
--- a/bash-completion/chmem
+++ b/bash-completion/chmem
@@ -16,6 +16,7 @@ _chmem_module()
 				--disable
 				--blocks
 				--verbose
+				--zone
 				--help
 				--version
 			"
diff --git a/bash-completion/lsmem b/bash-completion/lsmem
index 8f7a46ec30af..9aa124569d53 100644
--- a/bash-completion/lsmem
+++ b/bash-completion/lsmem
@@ -9,7 +9,7 @@ _lsmem_module()
 			local prefix realcur OUTPUT_ALL OUTPUT
 			realcur="${cur##*,}"
 			prefix="${cur%$realcur}"
-			OUTPUT_ALL='RANGE SIZE STATE REMOVABLE BLOCK NODE'
+			OUTPUT_ALL='RANGE SIZE STATE REMOVABLE BLOCK NODE ZONES'
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
 					OUTPUT="$WORD ${OUTPUT:-""}"
-- 
2.13.5

