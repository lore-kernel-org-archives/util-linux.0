Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58641 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbeIZMec (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Sep 2018 08:34:32 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E5B221F1A
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:14 -0400 (EDT)
Received: from apu2 (x4db4907c.dyn.telefonica.de [77.180.144.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id AFAC2E4439
        for <util-linux@vger.kernel.org>; Wed, 26 Sep 2018 02:23:13 -0400 (EDT)
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] lsblk: fix unknown type `stat` caused by missing header
Date: Wed, 26 Sep 2018 08:23:08 +0200
Message-Id: <887b46a6a20224db2f5b54a518d2b9522399d7d8.1537942755.git.ps@pks.im>
In-Reply-To: <cover.1537942755.git.ps@pks.im>
References: <cover.1537942755.git.ps@pks.im>
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The structure `blkdev_cxt` has a `struct stat` member embedded, whose
size may not be known on some systems because of a missing include for
"sys/stat.h". On glibc-based systems, this header is included
transitively via "sys/statvfs.h", but on musl-based systems it is not.

Fix the resulting compile error due to unknown size of the struct by
including "sys/stat.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 misc-utils/lsblk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/lsblk.h b/misc-utils/lsblk.h
index 6e0186576..baad3aa9b 100644
--- a/misc-utils/lsblk.h
+++ b/misc-utils/lsblk.h
@@ -8,6 +8,7 @@
 
 #include <stdint.h>
 #include <inttypes.h>
+#include <sys/stat.h>
 #include <sys/statvfs.h>
 
 #include <libsmartcols.h>
-- 
2.19.0
