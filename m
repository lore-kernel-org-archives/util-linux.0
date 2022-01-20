Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C47C433EF
	for <util-linux@archiver.kernel.org>; Thu, 20 Jan 2022 11:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiATLzK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:55:10 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41764 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiATLzK (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 20 Jan 2022 06:55:10 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 215D7212C3;
        Thu, 20 Jan 2022 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1642679709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4RE5fjbWt8+IPcol5w5qutZXZcfMFLx05ZoAkMNB2vs=;
        b=z124jj74dcuPnpgFucNe04B/VIh+2R4QhXQw6bOPLS0xc3u2RVxtHTGoDJHPMAUKi4VKAP
        oiyJEVsgRHpeLcHIC4vXYXEouKPmxsQ8EQ0B9x1cQl9SaPSEN9BeVNk9/FP2NKRSdAYgLo
        gPyAW9hb70qx4gIPpT6GIcQvWhQkm3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1642679709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=4RE5fjbWt8+IPcol5w5qutZXZcfMFLx05ZoAkMNB2vs=;
        b=NeIhz/DdLZfelBKjF9J/tTUcejygGVZ3OlpqgGJyMxesE6qGC4aQD7cnunoUzfM9LIdTur
        VNw5KNly+71PycBg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3A464A3BDD;
        Thu, 20 Jan 2022 11:55:02 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 19F4EA05D9; Thu, 20 Jan 2022 12:47:13 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] mount: Fix race in loop device reuse code
Date:   Thu, 20 Jan 2022 12:47:05 +0100
Message-Id: <20220120114705.25342-1-jack@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Small timing changes in the kernel loop device handling broke the
following loop:

while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done

which quickly reports:
mount: /mnt: can't read superblock on /dev/loop0.
umount: /mnt: not mounted.

And this loop is broken because of a subtle interaction with
systemd-udevd that also opens the loop device. The race seems to be in
mount(8) handling itself and the altered kernel timing makes it happen.
It look like:

bash                                systemd-udevd
  mount -o loop,ro isofs.iso isofs/
    /dev/loop0 is created and bound to isofs.iso, autoclear is set for
    loop0
                                    opens /dev/loop0
  umount isofs/
  loop0 still lives because systemd-udev still has device open
  mount -o loop,ro isofs.iso isofs/
    gets to mnt_context_setup_loopdev()
      loopcxt_find_overlap()
      sees loop0 is still valid and with proper parameters
      reuse = true;
                                    close /dev/loop0
                                      last fd closed => loop0 is
                                        cleaned up
      loopcxt_get_fd()
        opens loop0 but it is no longer the device we wanted!
    calls mount(2) which fails because we cannot read from the loop device

Fix the problem by rechecking that loop device is still attached after
opening the device. This makes sure the kernel will not autoclear the
device anymore.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 libmount/src/context_loopdev.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/libmount/src/context_loopdev.c b/libmount/src/context_loopdev.c
index 88af20c0e522..62e319ce6131 100644
--- a/libmount/src/context_loopdev.c
+++ b/libmount/src/context_loopdev.c
@@ -255,6 +255,25 @@ int mnt_context_setup_loopdev(struct libmnt_context *cxt)
 			DBG(LOOP, ul_debugobj(cxt, "re-using existing loop device %s",
 				loopcxt_get_device(&lc)));
 
+			/* Open loop device to block device autoclear... */
+			if (loopcxt_get_fd(&lc) < 0) {
+				DBG(LOOP, ul_debugobj(cxt, "failed to get loopdev FD"));
+				rc = -errno;
+				goto done;
+			}
+
+			/*
+			 * Now that we certainly have the loop device open,
+			 * verify the loop device was not autocleared in the
+			 * mean time.
+			 */
+			if (!loopcxt_get_info(&lc)) {
+				DBG(LOOP, ul_debugobj(cxt, "lost race with %s teardown",
+						loopcxt_get_device(&lc)));
+				loopcxt_deinit(&lc);
+				break;
+			}
+
 			/* Once a loop is initialized RO, there is no
 			 * way to change its parameters. */
 			if (loopcxt_is_readonly(&lc)
-- 
2.31.1

