Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85018C47094
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 16:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61A2E61208
	for <util-linux@archiver.kernel.org>; Mon,  7 Jun 2021 16:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFGQNH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 7 Jun 2021 12:13:07 -0400
Received: from foss.arm.com ([217.140.110.172]:36662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGQNG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Jun 2021 12:13:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 301B1143D;
        Mon,  7 Jun 2021 09:11:15 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86E253F694;
        Mon,  7 Jun 2021 09:11:14 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH] uclampset: Fix left over optind++
Date:   Mon,  7 Jun 2021 17:11:11 +0100
Message-Id: <20210607161111.3071084-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The code was changed to use ':' in getopt_long() but these were left
over by mistake causing weird random errors when using these options
depending on the order they were fed.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

Sorry not sure how this slipped through. I'm sure I tested it before I posted
the patches but something must have gone wrong in my testing :(

 schedutils/uclampset.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/schedutils/uclampset.c b/schedutils/uclampset.c
index 444e350f4..e09d6a7f9 100644
--- a/schedutils/uclampset.c
+++ b/schedutils/uclampset.c
@@ -253,7 +253,6 @@ int main(int argc, char **argv)
 		case 'p':
 			errno = 0;
 			ctl->pid = strtos32_or_err(optarg, _("invalid PID argument"));
-			optind++;
 			break;
 		case 's':
 			ctl->system = 1;
@@ -268,13 +267,11 @@ int main(int argc, char **argv)
 			ctl->util_min = strtos32_or_err(optarg, _("invalid util_min argument"));
 			ctl->util_min_set = 1;
 			validate_util(ctl->util_min);
-			optind++;
 			break;
 		case 'M':
 			ctl->util_max = strtos32_or_err(optarg, _("invalid util_max argument"));
 			ctl->util_max_set = 1;
 			validate_util(ctl->util_max);
-			optind++;
 			break;
 		case 'V':
 			print_version(EXIT_SUCCESS);
-- 
2.25.1

