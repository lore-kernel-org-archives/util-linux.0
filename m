Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03572C54EE9
	for <util-linux@archiver.kernel.org>; Tue,  6 Sep 2022 07:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiIFHEl (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 6 Sep 2022 03:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiIFHEi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 6 Sep 2022 03:04:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2BEE00C
        for <util-linux@vger.kernel.org>; Tue,  6 Sep 2022 00:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662447876; x=1693983876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yTAnRAWTx1ASj7IGg2VGjzG7ltqT62r/Pkh1xKbRrtI=;
  b=ngzJjE9v+mq+uNeLHXvKxwLVnBolwJ/jYiO4DZqwAJQSoq60u/yhpbFW
   Tu8m2Azlu26F7nM9fncb68udpuBRfa7pE+39fAsxQ8HiQRvWEdpkSHIn/
   sQI8cIOg7Pe+WdMfYdJpL+EVxOQe+wV9rVixCSUhf/pDjuTfHSjUGDjQ0
   evtUALeXSweRj7mG5lyKxxnu/xaL3kJNROUSnpXMMcCPVdYPgCBKXc/VZ
   z95nh43LfThyi4Kq10rDlAmfeug6KBGg2gMICxOLujQCK3qtcwfpuFvLN
   r59/ZNswWie1FO2Y3AUmWPqTL7bOil+45xl3dVoIDKklAritkeX/hNFFF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10461"; a="295256983"
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="295256983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 00:04:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,293,1654585200"; 
   d="scan'208";a="644047925"
Received: from plbrigh-mobl2.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.15.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 00:04:35 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, peter.ujfalusi@linux.intel.com
Subject: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to parse_timestamp()
Date:   Tue,  6 Sep 2022 10:04:36 +0300
Message-Id: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The %s comes handy with for example dmesg with the --since within scripts
to handle log rages.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 lib/timeutils.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index 2e28ada8bc47..6dda2e8deefb 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -181,6 +181,7 @@ int parse_timestamp(const char *t, usec_t *usec)
 	 *
 	 *   2012-09-22 16:34:22
 	 *   2012-09-22T16:34:22
+	 *   1348331662		  (seconds since the Epoch (1970-01-01 00:00 UTC))
 	 *   2012-09-22 16:34	  (seconds will be set to 0)
 	 *   2012-09-22		  (time will be set to 00:00:00)
 	 *   16:34:22		  (date will be set to today)
@@ -325,6 +326,13 @@ int parse_timestamp(const char *t, usec_t *usec)
 		goto finish;
 	}
 
+	tm = copy;
+	k = strptime(t, "%s", &tm);
+	if (k && *k == 0) {
+		tm.tm_sec = 0;
+		goto finish;
+	}
+
 	return -EINVAL;
 
  finish:
-- 
2.37.3

