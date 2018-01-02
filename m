Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39302 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeABUpN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Jan 2018 15:45:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so62711790wmf.4
        for <util-linux@vger.kernel.org>; Tue, 02 Jan 2018 12:45:12 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] libfdisk: fsync(2) after writing partition data
Date: Tue,  2 Jan 2018 20:45:04 +0000
Message-Id: <20180102204504.1543-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In reply to reference comment commit:
> It would be nice to have something more elegant than sleep, any idea?

Adding fsync(2) might be superficial when writing to device file, but
perhaps it helps ensuring what is meant to write is wrote.  In any case it
is difficult to think this could make libfdisk worse.

Reference: a60d6b52179d851d1d1165a06afa778ac9868107
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/gpt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 94b4d292e..49357c449 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -1978,6 +1978,8 @@ static int gpt_write_partitions(struct fdisk_context *cxt,
 	ssz = write(cxt->dev_fd, ents, towrite);
 	if (ssz < 0 || (ssize_t) towrite != ssz)
 		return -errno;
+	if (fsync(cxt->dev_fd) != 0)
+		return -errno;
 
 	return 0;
 }
-- 
2.15.1

