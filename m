Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29853C38145
	for <util-linux@archiver.kernel.org>; Wed,  7 Sep 2022 05:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiIGFln (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Sep 2022 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIGFlm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Sep 2022 01:41:42 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1296E2D6
        for <util-linux@vger.kernel.org>; Tue,  6 Sep 2022 22:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662529301; x=1694065301;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sDhjukleesK2yr7+drj/rTzzUPh1PTh//YFOPO6P1Ro=;
  b=SbxBS+zsBwYPqvePWfTB5tDaraypwvYF4pit7UOHWk2iPHAIFCXEmZU2
   To8d4f9iqyb91SOIt6CCUOEy5N9kpMKQCYtnIlHn+26atFQ+jddiI2NnH
   bCSKSFTLEM0Y8l4h5z3Q3FS4SUe/DVl7qENswokijZ0Zns2R8g8MR8A6m
   Ad/mvf3r5CJQUPl+d2kpXdfFIRn6Mq5Kn+jzTZ/LygYEHQTbxD42fazgZ
   BMVKIOElVkyMj3X8T6C5NN4qmrZeNWDeqbZhUAVJYSgzYzq3ZKVdlsRCI
   DkR9bstlvpp8J+/MNyjppKrgOKI0Kv5G5io3WAwysiE7OvFKRncw32doM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="298100693"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="298100693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:41:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="682675880"
Received: from asilke-mobl1.ger.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.0.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 22:41:39 -0700
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, peter.ujfalusi@linux.intel.com
Subject: [PATCH] lib/timeutils: Require '@' prefix for seconds since the Epoch timestamp
Date:   Wed,  7 Sep 2022 08:41:41 +0300
Message-Id: <20220907054141.15608-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since the seconds since the Epoch is just a number it might be better to
require special prefix to indicate the intention that the user wants to
interpret the number as seconds since the Epoch.

Use the same '@' character as prefix as used by systemd.time to make it
easier to integrate in scripts intended to be used on systems with or
without systemd.

Fix also the initial support which discarded the seconds from the converted
timestamp.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
Hi Karel,

I think this will be safer for the enduser. The original patch would interpret
_any_ number not matching with the other supported formats interpreted as seconds
since the Epoch, which might not something the user had in mind.

Sorry for the oversight on my side...

Kind regards,
Péter

 lib/timeutils.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index 6dda2e8deefb..4eaef9533ab2 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -181,7 +181,7 @@ int parse_timestamp(const char *t, usec_t *usec)
 	 *
 	 *   2012-09-22 16:34:22
 	 *   2012-09-22T16:34:22
-	 *   1348331662		  (seconds since the Epoch (1970-01-01 00:00 UTC))
+	 *   @1348331662	  (seconds since the Epoch (1970-01-01 00:00 UTC))
 	 *   2012-09-22 16:34	  (seconds will be set to 0)
 	 *   2012-09-22		  (time will be set to 00:00:00)
 	 *   16:34:22		  (date will be set to today)
@@ -233,7 +233,12 @@ int parse_timestamp(const char *t, usec_t *usec)
 			return r;
 
 		goto finish;
+	} else if (t[0] == '@') {
+		k = strptime(t + 1, "%s", &tm);
+		if (k && *k == 0)
+			goto finish;
 
+		return -EINVAL;
 	} else if (endswith(t, " ago")) {
 		char *z;
 
@@ -326,13 +331,6 @@ int parse_timestamp(const char *t, usec_t *usec)
 		goto finish;
 	}
 
-	tm = copy;
-	k = strptime(t, "%s", &tm);
-	if (k && *k == 0) {
-		tm.tm_sec = 0;
-		goto finish;
-	}
-
 	return -EINVAL;
 
  finish:
-- 
2.37.3

