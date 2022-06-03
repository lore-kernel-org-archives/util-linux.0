Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C491CCA47F
	for <util-linux@archiver.kernel.org>; Fri,  3 Jun 2022 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244343AbiFCM2f (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244325AbiFCM2e (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jun 2022 08:28:34 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E0F3A5DD
        for <util-linux@vger.kernel.org>; Fri,  3 Jun 2022 05:28:30 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 137so7109204pgb.5
        for <util-linux@vger.kernel.org>; Fri, 03 Jun 2022 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SO8b3kn8BEWRhPkDf5ZVNKurLmju6I0rnsRvG+a2SI=;
        b=dSXApBoodzagEMfD7XGfZ9i22y0Sl2nhJ4Ctj5C6CDMY0rctYAVLNYwoMGFAlCL3Uo
         N0b+pAWYjt/XYNTtCva1od834iY86oQmZl6cIF0DStLslhSzanR+GEjdlOh3iMogmW7v
         KsjjpVm0kZU5wkYs7CFa/aLBQwbtTek7LVqNpJt9ms4/bm5u0HTf1vhrdOnenApPz3E/
         i+PX3O1u6dumBpqKOLiFEXKXcMqJSmqUrv/GuV0wq8ety1Jhz1RZ3aVRJghwMJ6glcjv
         byXg13LuduhPX947DP0AXLOIkJPLwaMffcy5eDeh0FF5ZHjp3HRCPnGFDZvnxTaZ8X4F
         Cqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3SO8b3kn8BEWRhPkDf5ZVNKurLmju6I0rnsRvG+a2SI=;
        b=R53EVCBVIUHa0qLH6sz2QPZAWtOJpIHYBvTtVdPtuFfw7AgoXi7U+eGL2JzwmoqFQ9
         mwQhGPk6zxYV/AHXYzlwNA6EcpZhW1GzlAbIpeSkpl13vsW+S8+yR0fT9T7k3WYCvwHw
         W6G9f5jbQD3HLQH488JxdleXX8YfjLMXO4uWZFwkRQWzLbPKMRq+D71t482ib2oDJCsV
         Wa06ViyZKJ8SaD2UHh+VrYVY0qzLDdObu5eMgoGH8mS0XiEMcdyeFCkcJVVUpjRlUrU1
         +NfmqcPP8LMJzP8wv9rlN5fK5N5DNEhxe50DVLTjuzAXDGy3l9uoY/GUbsw0GniDrBO1
         CJ0w==
X-Gm-Message-State: AOAM530ob79/ez/nfDXVI/vm8oBBnRpcy5+AG4T+lAcsLRgVvkUWOz+N
        etOXKGK6vCvcP95JI3ei/v4UV4pac2trNg==
X-Google-Smtp-Source: ABdhPJwNyZZlXxgJfnDGLyEtgGjaSzJ/X3JVta7DB9cVyA8a58l2LSGivmfCXKfo6SOs7eMwTiG3tg==
X-Received: by 2002:a63:88c3:0:b0:3fc:98af:8f0 with SMTP id l186-20020a6388c3000000b003fc98af08f0mr8881047pgd.11.1654259310013;
        Fri, 03 Jun 2022 05:28:30 -0700 (PDT)
Received: from always-x1.www.tendawifi.com ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm5173955pgq.72.2022.06.03.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:28:29 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/5] lsblk: add -N/--nvme
Date:   Fri,  3 Jun 2022 20:23:58 +0800
Message-Id: <20220603122402.3274789-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Add -N/--nvme to filter NVMe device only, NVMe usually has a larger
I/O depth, also show COL_RQ_SIZE by default.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 bash-completion/lsblk   |  1 +
 misc-utils/lsblk.8.adoc |  3 +++
 misc-utils/lsblk.c      | 24 +++++++++++++++++++++++-
 misc-utils/lsblk.h      |  1 +
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/bash-completion/lsblk b/bash-completion/lsblk
index ca0ad39d7..011af41c2 100644
--- a/bash-completion/lsblk
+++ b/bash-completion/lsblk
@@ -79,6 +79,7 @@ _lsblk_module()
 				--inverse
 				--topology
 				--scsi
+				--nvme
 				--sort
 				--width
 				--help
diff --git a/misc-utils/lsblk.8.adoc b/misc-utils/lsblk.8.adoc
index 8ffc2cd79..8c6d50f79 100644
--- a/misc-utils/lsblk.8.adoc
+++ b/misc-utils/lsblk.8.adoc
@@ -72,6 +72,9 @@ Group parents of sub-trees to provide more readable output for RAIDs and Multi-p
 *-m*, *--perms*::
 Output info about device owner, group and mode. This option is equivalent to *-o NAME,SIZE,OWNER,GROUP,MODE*.
 
+*-N*, *--nvme*::
+Output info about NVMe devices only.
+
 *-n*, *--noheadings*::
 Do not print a header line.
 
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index fbaa1797f..047f744be 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -1349,6 +1349,16 @@ static int initialize_device(struct lsblk_device *dev,
 		return -1;
 	}
 
+	/* ignore non-NVMe devices */
+	if (lsblk->nvme) {
+		char *transport = get_transport(dev);
+
+		if (!transport || strcmp(transport, "nvme")) {
+			DBG(DEV, ul_debugobj(dev, "non-nvme device -- ignore"));
+			return -1;
+		}
+	}
+
 	DBG(DEV, ul_debugobj(dev, "%s: context successfully initialized", dev->name));
 	return 0;
 }
@@ -1925,6 +1935,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -O, --output-all     output all columns\n"), out);
 	fputs(_(" -P, --pairs          use key=\"value\" output format\n"), out);
 	fputs(_(" -S, --scsi           output info about SCSI devices\n"), out);
+	fputs(_(" -N, --nvme           output info about NVMe devices\n"), out);
 	fputs(_(" -T, --tree[=<column>] use tree format output\n"), out);
 	fputs(_(" -a, --all            print all devices\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
@@ -2010,6 +2021,7 @@ int main(int argc, char *argv[])
 		{ "paths",      no_argument,       NULL, 'p' },
 		{ "pairs",      no_argument,       NULL, 'P' },
 		{ "scsi",       no_argument,       NULL, 'S' },
+		{ "nvme",       no_argument,       NULL, 'N' },
 		{ "sort",	required_argument, NULL, 'x' },
 		{ "sysroot",    required_argument, NULL, OPT_SYSROOT },
 		{ "shell",      no_argument,       NULL, 'y' },
@@ -2043,7 +2055,7 @@ int main(int argc, char *argv[])
 	lsblk_init_debug();
 
 	while((c = getopt_long(argc, argv,
-				"AabdDzE:e:fhJlnMmo:OpPiI:rstVST::w:x:y",
+				"AabdDzE:e:fhJlNnMmo:OpPiI:rstVST::w:x:y",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -2165,6 +2177,16 @@ int main(int argc, char *argv[])
 			add_uniq_column(COL_SERIAL);
 			add_uniq_column(COL_TRANSPORT);
 			break;
+		case 'N':
+			lsblk->nodeps = 1;
+			lsblk->nvme = 1;
+			add_uniq_column(COL_NAME);
+			add_uniq_column(COL_TYPE);
+			add_uniq_column(COL_MODEL);
+			add_uniq_column(COL_SERIAL);
+			add_uniq_column(COL_TRANSPORT);
+			add_uniq_column(COL_RQ_SIZE);
+			break;
 		case 'T':
 			force_tree = 1;
 			if (optarg) {
diff --git a/misc-utils/lsblk.h b/misc-utils/lsblk.h
index b20aa6be9..536120a9c 100644
--- a/misc-utils/lsblk.h
+++ b/misc-utils/lsblk.h
@@ -51,6 +51,7 @@ struct lsblk {
 	unsigned int merge:1;           /* merge sub-trees */
 	unsigned int nodeps:1;		/* don't print slaves/holders */
 	unsigned int scsi:1;		/* print only device with HCTL (SCSI) */
+	unsigned int nvme:1;		/* print NVMe device only */
 	unsigned int paths:1;		/* print devnames with "/dev" prefix */
 	unsigned int sort_hidden:1;	/* sort column not between output columns */
 	unsigned int dedup_hidden :1;	/* deduplication column not between output columns */
-- 
2.20.1

