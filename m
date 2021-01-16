Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7810FC433E9
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5134723119
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAPTMS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 16 Jan 2021 14:12:18 -0500
Received: from foss.arm.com ([217.140.110.172]:58728 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbhAPTMS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 16 Jan 2021 14:12:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63B4712FC;
        Sat, 16 Jan 2021 11:11:32 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F8D83F70D;
        Sat, 16 Jan 2021 11:11:31 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 4/5] uclampset: Plump into the build system
Date:   Sat, 16 Jan 2021 19:09:39 +0000
Message-Id: <20210116190940.2320819-5-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210116190940.2320819-1-qais.yousef@arm.com>
References: <20210116190940.2320819-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 configure.ac             | 9 +++++++++
 schedutils/Makemodule.am | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/configure.ac b/configure.ac
index 20b6c3178..8f66d5ec4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2194,6 +2194,15 @@ AS_IF([test "x$build_chrt" = xyes], [
 	UL_CHECK_SYSCALL([sched_setattr])
 ])
 
+UL_ENABLE_ALIAS([uclampset], [schedutils])
+UL_BUILD_INIT([uclampset])
+UL_REQUIRES_HAVE([uclampset], [schedsetter], [sched_set functions])
+AM_CONDITIONAL([BUILD_UCLAMPSET], [test "x$build_uclampset" = xyes])
+
+AS_IF([test "x$build_uclampset" = xyes], [
+	UL_CHECK_SYSCALL([sched_setattr])
+])
+
 
 AC_ARG_ENABLE([wall],
   AS_HELP_STRING([--disable-wall], [do not build wall]),
diff --git a/schedutils/Makemodule.am b/schedutils/Makemodule.am
index f32d2b307..c781ede63 100644
--- a/schedutils/Makemodule.am
+++ b/schedutils/Makemodule.am
@@ -18,3 +18,10 @@ dist_man_MANS += schedutils/taskset.1
 taskset_SOURCES = schedutils/taskset.c
 taskset_LDADD = $(LDADD) libcommon.la
 endif
+
+if BUILD_UCLAMPSET
+usrbin_exec_PROGRAMS += uclampset
+dist_man_MANS += schedutils/uclampset.1
+uclampset_SOURCES = schedutils/uclampset.c
+uclampset_LDADD = $(LDADD) libcommon.la
+endif
-- 
2.25.1

