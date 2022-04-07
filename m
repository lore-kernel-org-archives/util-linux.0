Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ABC433FE
	for <util-linux@archiver.kernel.org>; Thu,  7 Apr 2022 03:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiDGDzO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 23:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiDGDzN (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 23:55:13 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4078750046
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 20:53:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id m16so3780718plx.3
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2022 20:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKu/XdFvCyCP1ENcEJfzvlBOkXVz8w22G5XDb/wPx9o=;
        b=LLd8BlAXs9d3hbsGNsVl9OKL6BkANTQ7XZxphQNW3KprZluGBpVYEJU1R++05jcd0z
         ay7SoAwAWcjFeBuDQXFDiaLkY5i3knWnfHz8xu51mvqV7Dvja1eQX6E1+sWr94qJEK1n
         IVP5PeJd7ll1KrNgaOtf1a3LfOm+jXoU6P206hWmT2MO7tNT2gMTzPYp04MYKyHDRdMc
         EY7hR1bvut81ry+izixoSI5mWaE8Wv+33BE0FkN3hvsjbWMGi0biPKcGdUNlbie4waFI
         R0Vk8iYNqGauiQTjTzoxts0oH8MYZvVcdvWAQeppMRLKIle6r4KUuekhag2MkiIfvmCg
         izuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKu/XdFvCyCP1ENcEJfzvlBOkXVz8w22G5XDb/wPx9o=;
        b=u/yYQucsHSNXUmSWVIbQ1Aa7ypTMBafdXPnwz/vBP6OvYHPvOlx7ZNONKXoel81ggB
         TcBi4+Knlhuc0lITXNmIatGOhtKY0Gt1whKeGI6h+xeRi6ypL+/LM789i1BaD36T1iBG
         qOOXvBAAwbP+fsLDkdrGd34RHVNECEP73NZhzk1fWIAFrmS1CwEoPzP6YMcSlC6eLfct
         /J42mr8mitBCP3Z9yxdNtRaB7FYNzhDlscXfXsLp/8N1l6wR1rOFsjfR2Dok0p/iiqNL
         GBmdHAabZiJEXfbJpp8/3PlMTPP9FPnvkZHK6EDt6L5l08iNJQeP7aOOJ7/Vz3/0qhEM
         qYuA==
X-Gm-Message-State: AOAM530jshuKxfnTm6n1uBQ+fzcHAk39QVxweDEKq7waEEk/4tPZ2FLm
        /GA90KLBqG4+EljONrMzXxYf43A5yRqe4w==
X-Google-Smtp-Source: ABdhPJwECtkQ5f2F2chKPvnhTev2WzaCqpq6Tbz5yDvKnxmvTAvAdaPeo4AtLnfPgsVRyfBSRqnUoQ==
X-Received: by 2002:a17:90b:4b02:b0:1c7:1bc3:690b with SMTP id lx2-20020a17090b4b0200b001c71bc3690bmr13738147pjb.174.1649303592791;
        Wed, 06 Apr 2022 20:53:12 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm21680203pfj.194.2022.04.06.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 20:53:12 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, hch@infradead.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/2] blkpr: add descriptions for arguments
Date:   Thu,  7 Apr 2022 11:49:32 +0800
Message-Id: <20220407034932.68323-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407034932.68323-1-pizhenwei@bytedance.com>
References: <20220407034932.68323-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Karel pointed out that the arguments of this command is not obvious
enough for end-users. So add the detailed descriptions.

The description comes from linux/Documentation/block/pr.rst, and
modify a bit.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 sys-utils/blkpr.c | 81 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index a5132c003..906fa7883 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -37,29 +37,77 @@
 struct type_string {
 	int type;
 	char *str;
+	char *desc;
 };
 
 /* This array should keep align with enum pr_type of linux/types.h */
 static struct type_string pr_type[] = {
-	{PR_WRITE_EXCLUSIVE,           "write-exclusive"},
-	{PR_EXCLUSIVE_ACCESS,          "exclusive-access"},
-	{PR_WRITE_EXCLUSIVE_REG_ONLY,  "write-exclusive-reg-only"},
-	{PR_EXCLUSIVE_ACCESS_REG_ONLY, "exclusive-access-reg-only"},
-	{PR_WRITE_EXCLUSIVE_ALL_REGS,  "write-exclusive-all-regs"},
-	{PR_EXCLUSIVE_ACCESS_ALL_REGS, "exclusive-access-all-regs"}
+	{PR_WRITE_EXCLUSIVE,           "write-exclusive",
+	"Only the initiator that owns the reservation can write to the\n"
+	"\t\tdevice. Any initiator can read from the device.\n"},
+
+	{PR_EXCLUSIVE_ACCESS,          "exclusive-access",
+	"Only the initiator that owns the reservation can access the device.\n"},
+
+	{PR_WRITE_EXCLUSIVE_REG_ONLY,  "write-exclusive-reg-only",
+	"Only initiators with a registered key can write to the device,\n"
+	"\t\tAny initiator can read from the device.\n"},
+
+	{PR_EXCLUSIVE_ACCESS_REG_ONLY, "exclusive-access-reg-only",
+	"Only initiators with a registered key can access the device.\n"},
+
+	{PR_WRITE_EXCLUSIVE_ALL_REGS,  "write-exclusive-all-regs",
+	"Only initiators with a registered key can write to the device.\n"
+	"\t\tAny initiator can read from the device.\n"
+	"\t\tAll initiators with a registered key are considered reservation holders.\n"
+	"\t\tPlease reference the SPC spec on the meaning of a reservation\n"
+	"\t\tholder if you want to use this type.\n"},
+
+	{PR_EXCLUSIVE_ACCESS_ALL_REGS, "exclusive-access-all-regs",
+	"Only initiators with a registered key can access the device.\n"
+	"\t\tAll initiators with a registered key are considered reservation holders.\n"
+	"\t\tPlease reference the SPC spec on the meaning of a reservation\n"
+	"\t\tholder if you want to use this type.\n"}
 };
 
 static struct type_string pr_command[] = {
-	{IOC_PR_REGISTER,      "register"},
-	{IOC_PR_RESERVE,       "reserve"},
-	{IOC_PR_RELEASE,       "release"},
-	{IOC_PR_PREEMPT,       "preempt"},
-	{IOC_PR_PREEMPT_ABORT, "preempt-abort"},
-	{IOC_PR_CLEAR,         "clear"},
+	{IOC_PR_REGISTER,      "register",
+	"This command registers a new reservation if the key argument\n"
+	"\t\tis non-null. If no existing reservation exists oldkey must be zero,\n"
+	"\t\tif an existing reservation should be replaced oldkey must contain\n"
+	"\t\tthe old reservation key.\n"
+	"\t\tIf the key argument is 0 it unregisters the existing reservation passed\n"
+	"\t\tin oldkey.\n"},
+
+	{IOC_PR_RESERVE,       "reserve",
+	"This command reserves the device and thus restricts access for other\n"
+	"\t\tdevices based on the type argument.  The key argument must be the existing\n"
+	"\t\treservation key for the device as acquired by the register, preempt,\n"
+	"\t\tpreempt-abort commands.\n"},
+
+	{IOC_PR_RELEASE,       "release",
+	"This command releases the reservation specified by key and flags\n"
+	"\t\tand thus removes any access restriction implied by it.\n"},
+
+	{IOC_PR_PREEMPT,       "preempt",
+	"This command releases the existing reservation referred to by\n"
+	"\t\told_key and replaces it with a new reservation of type for the\n"
+	"\t\treservation key key.\n"},
+
+	{IOC_PR_PREEMPT_ABORT, "preempt-abort",
+	"This command works like preempt except that it also aborts\n"
+	"\t\tany outstanding command sent over a connection identified by oldkey.\n"},
+
+	{IOC_PR_CLEAR,         "clear",
+	"This command unregisters both key and any other reservation key\n"
+	"\t\tregistered with the device and drops any existing reservation.\n"},
 };
 
 static struct type_string pr_flag[] = {
-	{PR_FL_IGNORE_KEY, "ignore-key"}
+	{PR_FL_IGNORE_KEY, "ignore-key",
+	"Ignore the existing reservation key.  This is commonly supported for\n"
+	"\t\tregister command, and some implementation may support the flag for\n"
+	"\t\treserve command.\n"}
 };
 
 static void print_type(FILE *out, struct type_string *ts, size_t nmem)
@@ -67,9 +115,7 @@ static void print_type(FILE *out, struct type_string *ts, size_t nmem)
 	size_t i;
 
 	for (i = 0; i < nmem; i++) {
-		fprintf(out, "%s", ts[i].str);
-		fputs(i + 2 < nmem ? ", " :
-		      i + 1 < nmem ? _(", and ") : "\n", out);
+		fprintf(out, "\t%s: %s\n", ts[i].str, ts[i].desc);
 	}
 }
 
@@ -180,15 +226,12 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_ARGUMENTS, out);
 
 	fputs(_(" <cmd> is an command, available command:\n"), out);
-	fputs("        ", out);
 	print_pr_command(out);
 
 	fputs(_(" <flag> is a command flag, available flags:\n"), out);
-	fputs("        ", out);
 	print_pr_flag(out);
 
 	fputs(_(" <type> is a command type, available types:\n"), out);
-	fputs("        ", out);
 	print_pr_type(out);
 
 	printf(USAGE_MAN_TAIL("blkpr(8)"));
-- 
2.25.1

