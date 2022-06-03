Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B30CCA480
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiFCM2f (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbiFCM2e (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD9E3A5D9
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so7064223pjf.5
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=33MKCZABzrdZMiFJLgc55Z9b1IolqVsRzbH2Rv6bY4Q=;
        b=I/sATJd1oXP5eWRhNlwqToxkITJKb+vZv8k2BQAGWPrucd00hVC2eyeMRXU/HMWm3Q
         Ya/I7Gevez9bM7pnkIBzy+HGOaF2o0z6qNuEsYFAE0uadqI6xJ4apE/ivMtmTcYWJ7LZ
         rl2uDzDwjEk5aB1rp0VIfaBjj2mqpyltnvjick25+aXmQDAY6NdxspEDzpjgAxsbrWQz
         nOwscPmVjcUAjAoXrPRekFdvoYCOrTwjYM6ooveF1thglb5Pvp+Z95Cw4sUi7T/OScI9
         UiSyjWraV22msWsvOrBiXE/KfA82/uTJrUrs4GGbZOwSFd78SM5bD8aU9Wv2MjD7i0JK
         UqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=33MKCZABzrdZMiFJLgc55Z9b1IolqVsRzbH2Rv6bY4Q=;
        b=S6BqHoYHFzFmk8WSefJ04TNrsKCMh/L9OmeOA1wlGoiE+iIxey7NECtWSqGtc3HxBW
         nDbAEqbxdRLkxuFkLoG+16YHAJom0r8P2vB+VpX1/8yQ227rOfPMwTI3hMZbcNt3qPkt
         4wGZNe983At44m9bP0gTDZS+3piQYAtDPMCB560zw5wbgP0XPS7qQJpgPN+UrFMSs6YD
         iLfW1srdzufq2G4uzqCXDYV0C9saeeb9iHznnU8/IQ9AopS5hpn7c4XKc7Dwy5KU4GZt
         jInpEdxtV4lBL14l4nZAiNnE9akkRc7yHsic6Ju716y4ZfJk5GDg3sXOX5ZvxNKNAeW7
         Av5w==
X-Gm-Message-State: AOAM531ouDo47AxqmIbKFUNtoaS6UwbmPIYPF/GORpapzHREeTW5V0TG
        DsrCcio5G5jD+VC2hGUh9u28CpkEekok1g==
X-Google-Smtp-Source: ABdhPJz3/yWKjK3VPn3Z47GGo9RynpX8g666yaAW5nuqS3zP7JgbUY3Qk5Nn9enQhqKwHWCpPLbRgg==
X-Received: by 2002:a17:902:dac3:b0:164:13b2:4914 with SMTP id q3-20020a170902dac300b0016413b24914mr10078973plx.135.1654259313156;
        Fri, 03 Jun 2022 05:28:33 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:32 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/5] lsblk: support virtio block
Date:   Fri,  3 Jun 2022 20:23:59 +0800
Message-Id: <20220603122402.3274789-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

virtio blk is quite popular in the virtual machines, support 'TRAN'
column for a virtio block device.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 misc-utils/lsblk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 047f744be..dfa317970 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -514,8 +514,10 @@ static char *get_transport(struct lsblk_device *dev)
 			trans = "ata";
 		free(attr);
 
-	} else if (strncmp(dev->name, "nvme", 4) == 0)
+	} else if (strncmp(dev->name, "nvme", 4) == 0) {
 		trans = "nvme";
+	} else if (strncmp(dev->name, "vd", 2) == 0)
+		trans = "virtio";
 
 	return trans ? xstrdup(trans) : NULL;
 }
-- 
2.20.1

