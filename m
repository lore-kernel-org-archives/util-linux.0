Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6342C433FE
	for <util-linux@archiver.kernel.org>; Mon, 10 Oct 2022 09:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJJJlY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Oct 2022 05:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiJJJlX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2022 05:41:23 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1A9647EF
        for <util-linux@vger.kernel.org>; Mon, 10 Oct 2022 02:41:21 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MmDML2zwKzmVBl;
        Mon, 10 Oct 2022 17:36:46 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:41:18 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 10 Oct 2022 17:41:18 +0800
Message-ID: <f53df0ef-8474-6b0c-1a36-cf3e1282106c@huawei.com>
Date:   Mon, 10 Oct 2022 17:41:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Karel Zak <kzak@redhat.com>
CC:     <util-linux@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        <djwong@kernel.org>, <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [PATCH] disk-utils/fsck.c: Processes may kill other processes.
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100008.china.huawei.com (7.185.36.48) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

A error in disk-utils/fsck.c, if run the fsck -N command, processes
don't execute, just show what would be done. However, the pid whose
value is -1 is added to the instance_list list in the execute
function,if the kill_all function is called later, kill(-1, signum)
is executed, Signals are sent to all processes except the number one
process and itself. Other processes will be killed if they use the
default signal processing function.

Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
  disk-utils/fsck.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 505952c81..800d3ce08 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -730,6 +730,8 @@ static int kill_all(int signum)
      for (inst = instance_list; inst; inst = inst->next) {
          if (inst->flags & FLAG_DONE)
              continue;
+        if (inst->pid <= 0)
+            continue;
          kill(inst->pid, signum);
          n++;
      }
-- 
2.27.0
