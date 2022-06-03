Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC4CCA473
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244349AbiFCM2l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244350AbiFCM2k (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF8B3A5E1
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id c196so7102287pfb.1
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1bfcK2kRK2LdqkzKi49C42/BVX3W1XkLM2c5yPNrJwQ=;
        b=dNuNCHHUwGvUtVK7yHzchA2vSWH1VxdNnaGVTDymLEKCBXd23xGH67Z59p0TaOq5Ka
         kLAlw6k/XGaFosEoakjoN9iaVQRVGyvYtR0vWQieUpFvzgdXxxX0TzBzPSQOd0oi4gRL
         3q1ECwJgNrDLzLMAdZSBaSmJ24PjqcHAvo3wtl8eBKzEmau65gGJjFvrt+TlNdbHowuC
         egJbIo37tAFDYGGOpw12GdspJzgEnrs5raI4BfnEUCrFOY3VBAmqoGl7pm328N1ncpE/
         gjQVW5wvo0FvGxYPvDBhK7mEyz1rWATrDvIm9EddxQbvcHmynCCpOHkxcQmxmuyXDk6G
         1ikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1bfcK2kRK2LdqkzKi49C42/BVX3W1XkLM2c5yPNrJwQ=;
        b=BjDj59Q4PvuwZlAVn+knyoqR5rv3sJEO98U94eauzUi+vQTY3ymDyRmnksdcOO3tyW
         4oFkNAtzgedxvvYmuE8MAla+m9yN5vk5vhBEKZ4htcmcunH8AzNCRGdGKB8Y3BxsXOSq
         TO3S8Yha88+ByVqtDqdvFNHKFCBU/99pJlwYOoWfKxPMgSiefaaIdYdpdTg4IhfUSWxx
         7aZsQWjoQiof3ptQkPORpOdN7g4pZ8DT1TMb5xq/+HDZdpQoU0ZV9yLFO9XlJ9pveqH0
         psXrJmwkiqCvvKLCb0Ms05zq1F+u/VJWtunfb676M18hL20DqoBSoeQuau34R36TO8xb
         1qHw==
X-Gm-Message-State: AOAM530VrVh0W9pj6SprqMo1B2e/w26MjrjbLsTrDO+06Nlf5QRZ0nCc
        NuJuPPRZ7EL02IovjSPgX7lD9zcKQ1iqxg==
X-Google-Smtp-Source: ABdhPJzgNYtw7xsW5yxUfpUYKAv2Y78bB5YwJHHAJ+LKSfWv65WbN2cZQSqixnYOtYQb0kLIxJ64kw==
X-Received: by 2002:a63:894a:0:b0:3fc:a724:578c with SMTP id v71-20020a63894a000000b003fca724578cmr8861881pgd.499.1654259319318;
        Fri, 03 Jun 2022 05:28:39 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:38 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 4/5] lsblk: introduce 'MQ' column
Date:   Fri,  3 Jun 2022 20:24:01 +0800
Message-Id: <20220603122402.3274789-5-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Typically a modern block device supports mutil queues feature, count
queues by walking '$sysfs/mq' directory. If no '$sysfs/mq' exists, it
is a legacy single queue.

~# lsblk --nvme -o NAME,TYPE,MODEL,TRAN,RQ-SIZE,MQ
NAME    TYPE MODEL                      TRAN   RQ-SIZE  MQ
nvme0n1 disk INTEL SSDPF2KX038TZ        nvme      1023 135
nvme3n1 disk INTEL SSDPE2KX020T8        nvme      1023 128
nvme1n1 disk SAMSUNG MZQL23T8HCLS-00A07 nvme      1023 129
nvme2n2 disk RP2A03T8RK004LX            nvme      1023  64
nvme2n3 disk RP2A03T8RK004LX            nvme      1023  64

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 bash-completion/lsblk |  2 +-
 misc-utils/lsblk.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 697dd23d2..6756764b2 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -11,7 +11,7 @@ _lsblk_module()
 		RO RM HOTPLUG MODEL SERIAL SIZE STATE OWNER GROUP MODE ALIGNMENT MIN-IO OPT-IO
 		PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO
 		WSAME WWN RAND PKNAME HCTL TRAN SUBSYSTEMS REV VENDOR ZONED ZONE-SZ ZONE-WGRAN
-		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX
+		ZONE-APP ZONE-NR ZONE-OMAX ZONE-AMAX DAX MQ
 	"
 
 	case $prev in
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 64d7edad6..d9c4ee982 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -90,6 +90,7 @@ enum {
 	COL_MINIO,
 	COL_MODE,
 	COL_MODEL,
+	COL_MQ,
 	COL_NAME,
 	COL_OPTIO,
 	COL_OWNER,
@@ -189,6 +190,7 @@ static struct colinfo infos[] = {
 	[COL_MINIO] = { "MIN-IO", 6, SCOLS_FL_RIGHT, N_("minimum I/O size"), COLTYPE_NUM },
 	[COL_MODEL] = { "MODEL", 0.1, SCOLS_FL_TRUNC, N_("device identifier") },
 	[COL_MODE] = { "MODE", 10, 0, N_("device node permissions") },
+	[COL_MQ] = { "MQ", 3, SCOLS_FL_RIGHT, N_("device queues") },
 	[COL_NAME] = { "NAME", 0.25, SCOLS_FL_NOEXTREMES, N_("device name") },
 	[COL_OPTIO] = { "OPT-IO", 6, SCOLS_FL_RIGHT, N_("optimal I/O size"), COLTYPE_NUM },
 	[COL_OWNER] = { "OWNER", 0.1, SCOLS_FL_TRUNC, N_("user name"), },
@@ -746,6 +748,34 @@ static void device_read_bytes(struct lsblk_device *dev, char *path, char **str,
 	}
 }
 
+static void process_mq(struct lsblk_device *dev, char **str)
+{
+	DIR *dir;
+	struct dirent *d;
+	unsigned int queues = 0;
+
+	DBG(DEV, ul_debugobj(dev, "%s: process mq", dev->name));
+
+	dir = ul_path_opendir(dev->sysfs, "mq");
+	if (!dir) {
+		*str = xstrdup("1");
+		DBG(DEV, ul_debugobj(dev, "%s: no mq supported, use a single queue", dev->name));
+		return;
+	}
+
+	while ((d = xreaddir(dir))) {
+		if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
+			continue;
+
+		queues++;
+	}
+
+	closedir(dir);
+
+	DBG(DEV, ul_debugobj(dev, "%s: has %d queues", dev->name, queues));
+	xasprintf(str, "%3u", queues);
+}
+
 /*
  * Generates data (string) for column specified by column ID for specified device. If sortdata
  * is not NULL then returns number usable to sort the column if the data are available for the
@@ -1143,6 +1173,9 @@ static char *device_get_data(
 	case COL_DAX:
 		ul_path_read_string(dev->sysfs, &str, "queue/dax");
 		break;
+	case COL_MQ:
+		process_mq(dev, &str);
+		break;
 	};
 
 	return str;
-- 
2.20.1

