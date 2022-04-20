Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6EEC433F5
	for <util-linux@archiver.kernel.org>; Wed, 20 Apr 2022 09:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377251AbiDTJkV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377276AbiDTJkV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 20 Apr 2022 05:40:21 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1970B1FA68
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2022 02:37:34 -0700 (PDT)
X-UUID: 95fb82e1f54546f2a7fbf686f527e63e-20220420
X-UUID: 95fb82e1f54546f2a7fbf686f527e63e-20220420
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 601016529; Wed, 20 Apr 2022 17:36:12 +0800
X-ns-mid: postfix-625FD45B-5855607497
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id 8DB20383C03E
        for <util-linux@vger.kernel.org>; Wed, 20 Apr 2022 09:37:31 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     util-linux@vger.kernel.org
Subject: [PATCH] eject: update file provenance of DRIVER_SENSE in the comments
Date:   Wed, 20 Apr 2022 17:37:01 +0800
Message-Id: <20220420093701.868169-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The location where the macro DRIVER_SENSE is defined has been placed in
include/scsi/sg.h in the kernel upstream, but the comment was not
updated in time.  This patch updates the contents of this comment.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 sys-utils/eject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 5cd0beab2..717d9fe5b 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -55,7 +55,7 @@
 #include "monotonic.h"
 
 /*
- * sg_io_hdr_t driver_status -- see kernel include/scsi/scsi.h
+ * sg_io_hdr_t driver_status -- see kernel include/scsi/sg.h
  */
 #ifndef DRIVER_SENSE
 # define DRIVER_SENSE	0x08
-- 
2.25.1

