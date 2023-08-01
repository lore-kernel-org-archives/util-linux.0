Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8BDC04A94
	for <util-linux@archiver.kernel.org>; Tue,  1 Aug 2023 20:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjHAUIb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Aug 2023 16:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHAUIa (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Aug 2023 16:08:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F9D213E
        for <util-linux@vger.kernel.org>; Tue,  1 Aug 2023 13:08:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bba9539a23so8251525ad.1
        for <util-linux@vger.kernel.org>; Tue, 01 Aug 2023 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1690920509; x=1691525309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cyM/dP+D3U6XSy8Hs2ZbgBd+HnEPAyJWPt8OQCl8Ls0=;
        b=SL/5IvheZcN5py7r/yOCmMFSyq3KOlQ8iIyrXw0FcNVixmH90Xb0nJQD/FG1PNbwdp
         1tqEkuKbQ1NVEiB4X6LnuaB1ea66wcJoA/IgLaT5kwnJ+wPnGDVS621vWsb1BJ3PpWzK
         wuF98I1MTowiW+1VgSlEVGUh3K7A7LST8ZjN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690920509; x=1691525309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyM/dP+D3U6XSy8Hs2ZbgBd+HnEPAyJWPt8OQCl8Ls0=;
        b=LKEilX7USzaCraJiaw3LqCj4x7xsE1zg6Ynqr19obtQZjK4AuZAmnm4r62uYVxTmHN
         3HrAbdmxPZfZ/Sz/b5IkaN+1ecz2NN7HSmYJriNcyYUJmMW1ydTnDH+QhaAp5VRtjpXw
         2woC6S2tG4nr2q/rlj3S0EcTjxSqHZdJGMo36rp05YEjWKeJjA+6Sbzi8iTg2mZ45Ih4
         s8BW0fdDFC8gDLQ9/BxpA2IviIMTldaiet0vTtSNNtxBuHFtPO0PCRa74MQ/TqJIc+Nn
         /EryuVG8ieOCOyzzj5lkYIx4JrOOZjHVGpVLJhxt5AUGzMrlJbvmvbyeAd0ib4yyNkMw
         mr3w==
X-Gm-Message-State: ABy/qLaYkgOEULBKH01IBScpWDeLsYqEZL1+NSb6oFlGbJLWq2XmXQWN
        OJNpp15H4T5DrrrGty5fZ4SRzNGJ9HzCDhJnc1YTSQ==
X-Google-Smtp-Source: APBJJlG7b5TCh8+9PpgLz+YkhRIVIZTne5WSuEr+NK3XswBrlwhbr7edszRi/47z0gaknymqqnHD6w==
X-Received: by 2002:a17:902:db0f:b0:1b8:b0c4:2e3d with SMTP id m15-20020a170902db0f00b001b8b0c42e3dmr13221851plx.4.1690920509500;
        Tue, 01 Aug 2023 13:08:29 -0700 (PDT)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id v11-20020a170902d68b00b001b53d3d8f3dsm10807449ply.299.2023.08.01.13.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 13:08:29 -0700 (PDT)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id EE802496; Tue,  1 Aug 2023 13:08:27 -0700 (PDT)
From:   Markus Mayer <mmayer@broadcom.com>
To:     util-linux mailing list <util-linux@vger.kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH] include: define pidfd syscalls if needed
Date:   Tue,  1 Aug 2023 13:08:24 -0700
Message-Id: <20230801200824.49768-1-mmayer@broadcom.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If the kernel headers are too old to provide the pidfd syscall numbers,
let's define them ourselves. This can be helpful while cross-compiling.
The runtime environment may provide a kernel that is new enough to
handle the calls, even if the toolchain doesn't.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 include/pidfd-utils.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/pidfd-utils.h b/include/pidfd-utils.h
index 18f3c626ade9..ff0bc4c792fc 100644
--- a/include/pidfd-utils.h
+++ b/include/pidfd-utils.h
@@ -7,6 +7,20 @@
 
 #ifdef HAVE_SYS_SYSCALL_H
 # include <sys/syscall.h>
+
+/*
+ * If the kernel headers are too old to provide the syscall numbers, let's
+ * define them ourselves. This can be helpful while cross-compiling.
+ */
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal 424
+#define SYS_pidfd_send_signal __NR_pidfd_send_signal
+#endif
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open 434
+#define SYS_pidfd_open __NR_pidfd_open
+#endif
+
 # if defined(SYS_pidfd_send_signal) && defined(SYS_pidfd_open)
 #  ifdef HAVE_SYS_PIDFD_H
 #   include <sys/pidfd.h>
-- 
2.40.1

