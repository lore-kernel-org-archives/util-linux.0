Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D249AC43334
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiFCM2l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiFCM2h (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A103A5D9
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so7064223pjf.5
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBvyD92W4BnJqxoSKJxnQgpzM95p8SUnfVAQrR//atU=;
        b=mUrjqupYDzG/1Tf8lmhGRfvZ/EvAUBni7U1L8I7hmF+C+HMf/RIICbxVkpYM832rrj
         4lC9AgkqsLCnazvE5bjXLH4rmNlb7OLyboeQHPkG9sRMcaaGd0DBDiGumS3w+CVC8BoI
         Pz/67x7zOP7jJDjNU+2Uz0+xBn6UIxdSMOrpJ/5ZfdBt8L5qxuW1NYLvSg7L8cEVds/j
         ZPJBU53UVTwR7we/eH0C0JZ7DtRA4cwhPO3jMuV61Sn9Xla65OufcZrG9s3UisIaZt+7
         6dppNWBbIU4/cxbrCquu7w365+Cgs2mQGZD9bxXFiCve0upFvEeT/oObuKXCuPh1CqXa
         rSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBvyD92W4BnJqxoSKJxnQgpzM95p8SUnfVAQrR//atU=;
        b=E8CgD+QpDW/7tPZ/0bIekoE9WuZ+ur3BCAk1429rxWph+qDz5Vc7oakmOVrcvCu3wg
         ej+XUerMuswjLGb3JMNpJ6nyhbs3It1TNJj4h0QuWvf07MH+lAT1b9y1NfeitQPtmvYm
         fnjYdnAmGMu/p4u26AlbwLAFpMuGwYZp/LCk9GTk1vVab+R3qSGrIl8AeSQlzHsdvbJi
         QDO5DTOyPLD+LpKNNrtrtLEuK5ZSRLQBNKzrjEbf10/BHvLwQvip4d7Bd/vjIa2BM0Fz
         8Du7s6qZJXKsvbDEfm9IFDgGsqX9a02q8SSW8y//+oWe7Gm5n7fXE+yiz68A+H7m6v4U
         GuJQ==
X-Gm-Message-State: AOAM532nRkg60gNX8uC8mzQFKdQlNCQPHk7Odnrpr/3HDgAA3XScKjTb
        8zBwHUjnaYxtYwAjvL9vQGZpI+B6yFz/5Q==
X-Google-Smtp-Source: ABdhPJykTcaLTqmkLU8a5/eI0HB4y2KSSdkyeyLO7QUQQbSOnLWoPNM2PJnDRdd1/FKrCtA4LEoPVg==
X-Received: by 2002:a17:902:b581:b0:161:5f37:6688 with SMTP id a1-20020a170902b58100b001615f376688mr9901889pls.145.1654259316192;
        Fri, 03 Jun 2022 05:28:36 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:35 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/5] lsblk: add -v/--virtio
Date:   Fri,  3 Jun 2022 20:24:00 +0800
Message-Id: <20220603122402.3274789-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add -v/--virtio to filter the virtio block devices.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 bash-completion/lsblk   |  1 +
 misc-utils/lsblk.8.adoc |  3 +++
 misc-utils/lsblk.c      | 23 ++++++++++++++++++++++-
 misc-utils/lsblk.h      |  1 +
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index 011af41c2..697dd23d2 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -80,6 +80,7 @@ _lsblk_module()
 				--topology
 				--scsi
 				--nvme
+				--virtio
 				--sort
 				--width
 				--help
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 8c6d50f79..6a9770ef2 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -75,6 +75,9 @@ Output info about device owner, group and mode. This option is equivalent to *-o
 *-N*, *--nvme*::
 Output info about NVMe devices only.
 
+*-v*, *--virtio*::
+Output info about virtio devices only.
+
 *-n*, *--noheadings*::
 Do not print a header line.
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index dfa317970..64d7edad6 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1361,6 +1361,16 @@ static int initialize_device(struct lsblk_device *dev,
 		}
 	}
 
+	/* ignore non-virtio devices */
+	if (lsblk->virtio) {
+		char *transport = get_transport(dev);
+
+		if (!transport || strcmp(transport, "virtio")) {
+			DBG(DEV, ul_debugobj(dev, "non-virtio device -- ignore"));
+			return -1;
+		}
+	}
+
 	DBG(DEV, ul_debugobj(dev, "%s: context successfully initialized", dev->name));
 	return 0;
 }
@@ -1938,6 +1948,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
 	fputs(_(" -S, --scsi           output info about SCSI devices\n"), out);
 	fputs(_(" -N, --nvme           output info about NVMe devices\n"), out);
+	fputs(_(" -v, --virtio         output info about virtio devices\n"), out);
 	fputs(_(" -T, --tree[=<column>] use tree format output\n"), out);
 	fputs(_(" -a, --all            print all devices\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
@@ -2024,6 +2035,7 @@ int main(int argc, char *argv[])
 		{ "pairs",      no_argument,       NULL, 'P' },
 		{ "scsi",       no_argument,       NULL, 'S' },
 		{ "nvme",       no_argument,       NULL, 'N' },
+		{ "virtio",     no_argument,       NULL, 'v' },
 		{ "sort",	required_argument, NULL, 'x' },
 		{ "sysroot",    required_argument, NULL, OPT_SYSROOT },
 		{ "shell",      no_argument,       NULL, 'y' },
@@ -2057,7 +2069,7 @@ int main(int argc, char *argv[])
 	lsblk_init_debug();
 
 	while((c = getopt_long(argc, argv,
-				"AabdDzE:e:fhJlNnMmo:OpPiI:rstVST::w:x:y",
+				"AabdDzE:e:fhJlNnMmo:OpPiI:rstVvST::w:x:y",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -2189,6 +2201,15 @@ int main(int argc, char *argv[])
 			add_uniq_column(COL_TRANSPORT);
 			add_uniq_column(COL_RQ_SIZE);
 			break;
+		case 'v':
+			lsblk->nodeps = 1;
+			lsblk->virtio = 1;
+			add_uniq_column(COL_NAME);
+			add_uniq_column(COL_TYPE);
+			add_uniq_column(COL_TRANSPORT);
+			add_uniq_column(COL_SIZE);
+			add_uniq_column(COL_RQ_SIZE);
+			break;
 		case 'T':
 			force_tree = 1;
 			if (optarg) {
diff --git a/misc-utils/lsblk.h b/misc-utils/lsblk.h
index 536120a9c..31c9ecad5 100644
--- a/misc-utils/lsblk.h
+++ b/misc-utils/lsblk.h
@@ -52,6 +52,7 @@ struct lsblk {
 	unsigned int nodeps:1;		/* don't print slaves/holders */
 	unsigned int scsi:1;		/* print only device with HCTL (SCSI) */
 	unsigned int nvme:1;		/* print NVMe device only */
+	unsigned int virtio:1;		/* print virtio device only */
 	unsigned int paths:1;		/* print devnames with "/dev" prefix */
 	unsigned int sort_hidden:1;	/* sort column not between output columns */
 	unsigned int dedup_hidden :1;	/* deduplication column not between output columns */
-- 
2.20.1

