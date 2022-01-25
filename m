Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718EEC433FE
	for <util-linux@archiver.kernel.org>; Tue, 25 Jan 2022 10:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242345AbiAYKU2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:20:28 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43080 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiAYKRq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 25 Jan 2022 05:17:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E24DE1F380;
        Tue, 25 Jan 2022 10:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643105847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5zRSl6aTXLhWqqHCvjUFsWYj607jhVkjXsigZz4Scf8=;
        b=n5p3h9LwR7jvahkcZ1MibgJY4HEPzTgKmR53A75c9qrY1uU1zfSN+gast6T4wmC/hyTs1V
        vlGda+1oRVHz+THD/1Mp8vCS8BghhxbrKsn/bjuD9VUZUl1RnFznRJxP6+IvfnPjDMvYyc
        9TgRi1IL6KC8qx/VATRwpSNmMi0WMQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643105847;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5zRSl6aTXLhWqqHCvjUFsWYj607jhVkjXsigZz4Scf8=;
        b=Mu6mJXij9MBXLbZffN//D5/5qXKr7McjQEHkhbDV9k4LO2wEX5SsuKw6Sq4YIvT9sewXMZ
        tqJLQuniF1KdDZBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE25613DAE;
        Tue, 25 Jan 2022 10:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LFL+LDfO72GMYgAAMHmgww
        (envelope-from <sbrabec@suse.cz>); Tue, 25 Jan 2022 10:17:27 +0000
Message-ID: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
Date:   Tue, 25 Jan 2022 11:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
To:     util-linux@vger.kernel.org
Content-Language: en-US
Cc:     Ali Abdallah <ali.abdallah@suse.com>
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] Whitelist libuuid clock file
Organization: SUSE Linux, s. r. o.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Return back ProtectSystem to strict, and enable access to
/var/lib/libuuid only.

Note: As LIBUUID_CLOCK_FILE does not use @localstatedir@, we use
/var here as well.

Signed-off-by: Ali Abdallah <ali.abdallah@suse.com>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
  misc-utils/uuidd.service.in | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/misc-utils/uuidd.service.in b/misc-utils/uuidd.service.in
index 065b4a194..e64ca59b5 100644
--- a/misc-utils/uuidd.service.in
+++ b/misc-utils/uuidd.service.in
@@ -8,6 +8,7 @@ ExecStart=@usrsbin_execdir@/uuidd --socket-activation
  Restart=no
  User=uuidd
  Group=uuidd
+ProtectSystem=strict
  ProtectHome=yes
  PrivateDevices=yes
  PrivateNetwork=yes
@@ -17,6 +18,7 @@ ProtectKernelModules=yes
  ProtectControlGroups=yes
  RestrictAddressFamilies=AF_UNIX
  MemoryDenyWriteExecute=yes
+ReadWritePaths=/var/lib/libuuid/
  SystemCallFilter=@default @file-system @basic-io @system-service 
@signal @io-event @network-io

  [Install]
-- 
2.34.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

