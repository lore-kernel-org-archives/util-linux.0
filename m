Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871CDC433EF
	for <util-linux@archiver.kernel.org>; Thu,  7 Apr 2022 03:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiDGDzN (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 Apr 2022 23:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiDGDzM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 Apr 2022 23:55:12 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCC289B7
        for <util-linux@vger.kernel.org>; Wed,  6 Apr 2022 20:53:10 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id j8so3750453pll.11
        for <util-linux@vger.kernel.org>; Wed, 06 Apr 2022 20:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48LeoaynMMOULdnBnB58dVAJ6MQEFTRPVgbP+yrRasE=;
        b=cLNSbdANDLNSeb+Y8bA94LigJeMLDsz+qimsO9qwJaTkJeA8bUklXdY0Cj/2pVQ7dZ
         hULynIvvx+ef9NA1l6B9I6I5llDcdPFSd8jyfpvyLzHTDs27LpbaiUGrKPrm+mi5QakL
         yo+bY3QZpWJpYkIt9Tb8pUlpkwvUr5XvGYqmbw4V/Cfw5QfooHC1wiU3bZndFXd2AguV
         9/EWbMO6TetBsNIl1OTAgbaQcjKZTnxHj20HkJCagvm97DLlKDICYNY+ENFrGBUaI7c+
         O3SXLymtkNDuPU3XfO34/6S8zuGiGHHg9V2ann7tvC+RgrydySzYxLVqtTka65R8WEK+
         vQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48LeoaynMMOULdnBnB58dVAJ6MQEFTRPVgbP+yrRasE=;
        b=yNbTLGeiLefZXOPRnBb7BpdabVxgxGcEC0Z8A55SYuLL66+72tZfBSnBHsP5P7xA+h
         zadjBizGHP+DvpN5PPcoJo3bgq/F9/xdaot+Y2ZElSN3vqBDGOsopEHUgBApkhKqFumx
         uWEoHGVOSDClBiAV26m6PRFOCVhi9WUa8AqP41aX1LztUY0z4vO1nSFogR+b25mzRZeK
         XEn231kUhmpDI2wvKmq0HcD9btUrFzgImjLZojTyQB7JTkjHegh7z/Q1S7u91JuqtzUF
         TxqmPIyELHzdfiCSo4hTWP8B4aCZvgVRQR8yiAL3mynJ4Aq1WWxbKygBr1gmMRf3h/mg
         eRvQ==
X-Gm-Message-State: AOAM533M7QDZIVH/bm0Pg066ONWI3wdPzEUXcLhqFO7r/s2/M1kOTB7Z
        IZXGGlW6ayIcfuv2h8atAq2LMA==
X-Google-Smtp-Source: ABdhPJzAQVBXZGMx0IpTSQ/s0wZULUMSpQDJM2WDqjiC44+YBWW/leP4w1sR2QnvSx0wrW6yNPwTcQ==
X-Received: by 2002:a17:90b:390c:b0:1c7:9a94:1797 with SMTP id ob12-20020a17090b390c00b001c79a941797mr13863288pjb.221.1649303590017;
        Wed, 06 Apr 2022 20:53:10 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f771b48736sm21680203pfj.194.2022.04.06.20.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 20:53:09 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kzak@redhat.com
Cc:     util-linux@vger.kernel.org, hch@infradead.org,
        zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/2] blkpr: rename operation to command
Date:   Thu,  7 Apr 2022 11:49:31 +0800
Message-Id: <20220407034932.68323-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Suggested by Karel, rename operation to command.
Thus make this more clear.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 sys-utils/blkpr.8.adoc |  8 ++++----
 sys-utils/blkpr.c      | 44 +++++++++++++++++++++---------------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/sys-utils/blkpr.8.adoc b/sys-utils/blkpr.8.adoc
index 482bdec18..2955643fc 100644
--- a/sys-utils/blkpr.8.adoc
+++ b/sys-utils/blkpr.8.adoc
@@ -22,15 +22,15 @@ The _device_ argument is the pathname of the block device.
 
 == OPTIONS
 
-*-o*, *--operation* _operation_::
-The operation of persistent reservations, supported operations are *register*, *reserve*, *release*, *preempt*,
+*-c*, *--command* _command_::
+The command of persistent reservations, supported commands are *register*, *reserve*, *release*, *preempt*,
 *preempt-abort*, and *clear*.
 
 *-k*, *--key* _key_::
-The key the operation should operate on.
+The key the command should operate on.
 
 *-K*, *--oldkey* _oldkey_::
-The old key the operation should operate on.
+The old key the command should operate on.
 
 *-f*, *--flag* _flag_::
 Supported flag is *ignore-key*.
diff --git a/sys-utils/blkpr.c b/sys-utils/blkpr.c
index d46eb19c1..a5132c003 100644
--- a/sys-utils/blkpr.c
+++ b/sys-utils/blkpr.c
@@ -1,7 +1,7 @@
 /*
  * blkpr.c -- persistent reservations on a block device.
  *
- * Copyright (C) 2021 zhenwei pi <pizhenwei@bytedance.com>
+ * Copyright (C) 2021-2022 zhenwei pi <pizhenwei@bytedance.com>
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -16,8 +16,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
- * This program uses IOC_PR_XXX ioctl to do persistent reservations
- * operation on a block device if the device supports it.
+ * This program uses IOC_PR_XXX ioctl to run persistent reservations
+ * command on a block device if the device supports it.
  */
 #include <string.h>
 #include <unistd.h>
@@ -49,7 +49,7 @@ static struct type_string pr_type[] = {
 	{PR_EXCLUSIVE_ACCESS_ALL_REGS, "exclusive-access-all-regs"}
 };
 
-static struct type_string pr_operation[] = {
+static struct type_string pr_command[] = {
 	{IOC_PR_REGISTER,      "register"},
 	{IOC_PR_RESERVE,       "reserve"},
 	{IOC_PR_RELEASE,       "release"},
@@ -96,11 +96,11 @@ static int parse_type_by_str(struct type_string *ts, int nmem, char *pattern)
 	{ return parse_type_by_str(XX, ARRAY_SIZE(XX), pattern); }
 
 PRINT_SUPPORTED(pr_type)
-PRINT_SUPPORTED(pr_operation)
+PRINT_SUPPORTED(pr_command)
 PRINT_SUPPORTED(pr_flag)
 
 PARSE(pr_type)
-PARSE(pr_operation)
+PARSE(pr_command)
 PARSE(pr_flag)
 
 static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, int flag)
@@ -144,7 +144,7 @@ static int do_pr(char *path, uint64_t key, uint64_t oldkey, int op, int type, in
 		break;
 	default:
 		errno = EINVAL;
-		err(EXIT_FAILURE, _("unknown operation"));
+		err(EXIT_FAILURE, _("unknown command"));
 	}
 
 	close(fd);
@@ -168,26 +168,26 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Persistent reservations on a device.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -o, --operation <oper>   operation of persistent reservations\n"), out);
+	fputs(_(" -c, --command <cmd>      command of persistent reservations\n"), out);
 	fputs(_(" -k, --key <num>          key to operate\n"), out);
 	fputs(_(" -K, --oldkey <num>       old key to operate\n"), out);
-	fputs(_(" -f, --flag <flag>        operation flag\n"), out);
-	fputs(_(" -t, --type <type>        operation type\n"), out);
+	fputs(_(" -f, --flag <flag>        command flag\n"), out);
+	fputs(_(" -t, --type <type>        command type\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(26));
 
 	fputs(USAGE_ARGUMENTS, out);
 
-	fputs(_(" <oper> is an operation, available operations:\n"), out);
+	fputs(_(" <cmd> is an command, available command:\n"), out);
 	fputs("        ", out);
-	print_pr_operation(out);
+	print_pr_command(out);
 
-	fputs(_(" <flag> is an operation flag, available flags:\n"), out);
+	fputs(_(" <flag> is a command flag, available flags:\n"), out);
 	fputs("        ", out);
 	print_pr_flag(out);
 
-	fputs(_(" <type> is an operation type, available types:\n"), out);
+	fputs(_(" <type> is a command type, available types:\n"), out);
 	fputs("        ", out);
 	print_pr_type(out);
 
@@ -200,12 +200,12 @@ int main(int argc, char **argv)
 	char c;
 	char *path;
 	uint64_t key = 0, oldkey = 0;
-	int operation = -1, type = -1, flag = 0;
+	int command = -1, type = -1, flag = 0;
 
 	static const struct option longopts[] = {
 	    { "help",            no_argument,       NULL, 'h' },
 	    { "version",         no_argument,       NULL, 'V' },
-	    { "operation",       required_argument, NULL, 'o' },
+	    { "command",         required_argument, NULL, 'c' },
 	    { "key",             required_argument, NULL, 'k' },
 	    { "oldkey",          required_argument, NULL, 'K' },
 	    { "flag",            required_argument, NULL, 'f' },
@@ -219,7 +219,7 @@ int main(int argc, char **argv)
 	close_stdout_atexit();
 
 	errno = EINVAL;
-	while ((c = getopt_long(argc, argv, "hVo:k:K:f:t:", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "hVc:k:K:f:t:", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'k':
 			key = strtosize_or_err(optarg,
@@ -229,10 +229,10 @@ int main(int argc, char **argv)
 			oldkey = strtosize_or_err(optarg,
 					_("failed to parse old key"));
 			break;
-		case 'o':
-			operation = parse_pr_operation(optarg);
-			if (operation < 0)
-				err(EXIT_FAILURE, _("unknown operation"));
+		case 'c':
+			command = parse_pr_command(optarg);
+			if (command < 0)
+				err(EXIT_FAILURE, _("unknown command"));
 			break;
 		case 't':
 			type = parse_pr_type(optarg);
@@ -263,7 +263,7 @@ int main(int argc, char **argv)
 		errtryhelp(EXIT_FAILURE);
 	}
 
-	do_pr(path, key, oldkey, operation, type, flag);
+	do_pr(path, key, oldkey, command, type, flag);
 
 	return EXIT_SUCCESS;
 }
-- 
2.25.1

