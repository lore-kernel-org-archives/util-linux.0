Return-Path: util-linux-owner@vger.kernel.org
Received: from comal.ext.ti.com ([198.47.26.152]:59763 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755416Ab2JVRAC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 13:00:02 -0400
From: Venkatraman S <venkat@linaro.org>
To: <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <arnd.bergmann@linaro.org>,
        Venkatraman S <venkat@linaro.org>
Subject: [RFC PATCH 3/4] mkswap: Add additional fields in swapheader
Date: Mon, 22 Oct 2012 22:27:26 +0530
Message-ID: <1350925048-31084-4-git-send-email-venkat@linaro.org>
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the padding section to add useful information in
swap header. This is backward compatible with
SWAPSPACE2 headers.

Signed-off-by: Venkatraman S <venkat@linaro.org>
---
 include/swapheader.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/swapheader.h b/include/swapheader.h
index 42d521a..90d13ef 100644
--- a/include/swapheader.h
+++ b/include/swapheader.h
@@ -21,7 +21,12 @@ struct swap_header_v1_2 {
 	unsigned int  nr_badpages;
 	unsigned char uuid[SWAP_UUID_LENGTH];
 	char	      volume_name[SWAP_LABEL_LENGTH];
-	unsigned int  padding[117];
+	union {
+		struct {
+			unsigned int erase_blk_size;
+		} blkdevinfo;
+		unsigned int  padding[117];
+	} swp_headerinfo ;
 	unsigned int  badpages[1];
 };
 
-- 
1.7.11.1.25.g0e18bef

