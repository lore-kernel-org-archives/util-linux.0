Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B091C6FA9D
	for <util-linux@archiver.kernel.org>; Wed,  1 Mar 2023 14:10:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCAOK3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:10:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCAOKX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Mar 2023 09:10:23 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AC43B863
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 06:10:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 020F621A8F
        for <util-linux@vger.kernel.org>; Wed,  1 Mar 2023 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677679809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nrxkam2ABh/PG8FOoI1PtYguhu5Tt+GQ0bdiGNZUiR4=;
        b=pxRCX01paG3RpjHFIGzVsr1NktUeZdNEfTEzxVFD2mnJXko5OuWBZUtBke2rbkipJxc2pg
        YJPOQXFwbTCBFVZ12SNLsAF5g0tQNhhuPmVoWizdOkPe38N56rv5JQfTTnWng+B5pYPUjG
        kZGok6iK5ZM+eOhxvhcNX+cgpd7IVX4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677679809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=nrxkam2ABh/PG8FOoI1PtYguhu5Tt+GQ0bdiGNZUiR4=;
        b=WtgDg0h4ppw9rLXdMZ37/JdtFJOUbCz25EUrk1liidbkM2oXunj4Qt/3rSxjsVKkJIKI6L
        ZSvxmK3uVECMXgCw==
Received: from naga.suse.cz (msuchanek.udp.ovpn1.prg.suse.de [10.100.224.114])
        by relay2.suse.de (Postfix) with ESMTP id D40442C141;
        Wed,  1 Mar 2023 14:10:08 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     util-linux@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] libuuid: Move clock.txt to /run
Date:   Wed,  1 Mar 2023 15:09:57 +0100
Message-Id: <20230301140957.21604-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Some users complain that due to filesystem performance of writing the
clock.txt generating UUIDs is slow.

uuidd would solve this but some distributions do not run it by default.

Moving the clock.txt to /run which is in tmpfs should resolve the
problem even for users not running uuidd.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 libuuid/src/uuidP.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libuuid/src/uuidP.h b/libuuid/src/uuidP.h
index 200702c1e..574a30fca 100644
--- a/libuuid/src/uuidP.h
+++ b/libuuid/src/uuidP.h
@@ -39,7 +39,7 @@
 
 #include "uuid.h"
 
-#define LIBUUID_CLOCK_FILE	"/var/lib/libuuid/clock.txt"
+#define LIBUUID_CLOCK_FILE	"/run/libuuid/clock.txt"
 
 /*
  * Offset between 15-Oct-1582 and 1-Jan-70
-- 
2.39.2

