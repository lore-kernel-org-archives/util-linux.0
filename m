Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77740C433EF
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 12:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235468AbiATMQs (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 07:16:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43634 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiATMQs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Jan 2022 07:16:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B3E1218A9;
        Thu, 20 Jan 2022 12:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642681007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xm2gEgQ/GphIRSXeJtkhT8moF0hzHObgRcj95+YfVRQ=;
        b=VapXV/3ciKe/KvXRqvY//eayHiQOIG07HM+hEMyVwkWo4u+yYEFIr5giBu/mRF09Y6ihFt
        ArjXJPlQ9d8NThymlehdxndbBUM66EeWClokNiVFKsuA761JKRD5Qj+t1l6YxHIC0NWjol
        /IkFrzsJROWGB7Z4HDLWnwJBvRc/luo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642681007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xm2gEgQ/GphIRSXeJtkhT8moF0hzHObgRcj95+YfVRQ=;
        b=Mf22ICwPvnT8vIGtsrNwrQ/T9xZ1hfNjCyTpmzdjREn/TLUctJpBde1+ZRq4qHZ8AeQ+xv
        KRAb8Vm/AC6juJDw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5FADDA3B85;
        Thu, 20 Jan 2022 12:16:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25965A05AF; Thu, 20 Jan 2022 13:16:44 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] loopdev: Do not treat errors when detecting overlap as fatal
Date:   Thu, 20 Jan 2022 13:16:39 +0100
Message-Id: <20220120121639.13047-2-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220120121639.13047-1-jack@suse.cz>
References: <20220120121639.13047-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

When looking for overlapping loop device we can fail getting some loop
device properties when we race with device autoclear. Just squelsh these
errors and try next loop device.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 lib/loopdev.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 27ab06c66848..d49738fde122 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -1777,10 +1777,13 @@ int loopcxt_find_overlap(struct loopdev_cxt *lc, const char *filename,
 
 		rc = loopcxt_is_used(lc, hasst ? &st : NULL,
 				     filename, offset, sizelimit, 0);
-		if (!rc)
-			continue;	/* unused */
-		if (rc < 0)
-			break;		/* error */
+		/*
+		 * Either the loopdev is unused or we've got an error which can
+		 * happen when we are racing with device autoclear. Just ignore
+		 * this loopdev...
+		 */
+		if (rc <= 0)
+			continue;
 
 		DBG(CXT, ul_debugobj(lc, "found %s backed by %s",
 			loopcxt_get_device(lc), filename));
@@ -1789,13 +1792,13 @@ int loopcxt_find_overlap(struct loopdev_cxt *lc, const char *filename,
 		if (rc) {
 			DBG(CXT, ul_debugobj(lc, "failed to get offset for device %s",
 				loopcxt_get_device(lc)));
-			break;
+			continue;
 		}
 		rc = loopcxt_get_sizelimit(lc, &lc_sizelimit);
 		if (rc) {
 			DBG(CXT, ul_debugobj(lc, "failed to get sizelimit for device %s",
 				loopcxt_get_device(lc)));
-			break;
+			continue;
 		}
 
 		/* full match */
-- 
2.31.1

