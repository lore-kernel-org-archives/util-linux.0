Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AC2C433E9
	for <util-linux@archiver.kernel.org>; Sat, 30 Jan 2021 20:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C32264E17
	for <util-linux@archiver.kernel.org>; Sat, 30 Jan 2021 20:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhA3Uvx (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 30 Jan 2021 15:51:53 -0500
Received: from foss.arm.com ([217.140.110.172]:40770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhA3Uvx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 30 Jan 2021 15:51:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4ED7139F;
        Sat, 30 Jan 2021 12:51:07 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5505D3F73D;
        Sat, 30 Jan 2021 12:51:06 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     Karel Zak <kzak@redhat.com>,
        Bernhard Voelker <mail@bernhard-voelker.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 1/5] Move sched_attr struct and syscall definitions into header file
Date:   Sat, 30 Jan 2021 20:50:35 +0000
Message-Id: <20210130205039.581764-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210130205039.581764-1-qais.yousef@arm.com>
References: <20210130205039.581764-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

So that we can re-use them in other files.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 schedutils/chrt.c       | 77 +-------------------------------
 schedutils/sched_attr.h | 97 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 76 deletions(-)
 create mode 100644 schedutils/sched_attr.h

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 3a1608013..052ad7a1b 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -34,83 +34,8 @@
 #include "closestream.h"
 #include "strutils.h"
 #include "procutils.h"
+#include "sched_attr.h"
 
-/* the SCHED_BATCH is supported since Linux 2.6.16
- *  -- temporary workaround for people with old glibc headers
- */
-#if defined (__linux__) && !defined(SCHED_BATCH)
-# define SCHED_BATCH 3
-#endif
-
-/* the SCHED_IDLE is supported since Linux 2.6.23
- * commit id 0e6aca43e08a62a48d6770e9a159dbec167bf4c6
- * -- temporary workaround for people with old glibc headers
- */
-#if defined (__linux__) && !defined(SCHED_IDLE)
-# define SCHED_IDLE 5
-#endif
-
-/* flag by sched_getscheduler() */
-#if defined(__linux__) && !defined(SCHED_RESET_ON_FORK)
-# define SCHED_RESET_ON_FORK 0x40000000
-#endif
-
-/* flag by sched_getattr() */
-#if defined(__linux__) && !defined(SCHED_FLAG_RESET_ON_FORK)
-# define SCHED_FLAG_RESET_ON_FORK 0x01
-#endif
-
-#if defined (__linux__)
-# include <sys/syscall.h>
-#endif
-
-/* usable kernel-headers, but old glibc-headers */
-#if defined (__linux__) && !defined(SYS_sched_setattr) && defined(__NR_sched_setattr)
-# define SYS_sched_setattr __NR_sched_setattr
-#endif
-
-#if defined (__linux__) && !defined(SYS_sched_getattr) && defined(__NR_sched_getattr)
-# define SYS_sched_getattr __NR_sched_getattr
-#endif
-
-#if defined (__linux__) && !defined(HAVE_SCHED_SETATTR) && defined(SYS_sched_setattr)
-# define HAVE_SCHED_SETATTR
-
-struct sched_attr {
-	uint32_t size;
-	uint32_t sched_policy;
-	uint64_t sched_flags;
-
-	/* SCHED_NORMAL, SCHED_BATCH */
-	int32_t sched_nice;
-
-	/* SCHED_FIFO, SCHED_RR */
-	uint32_t sched_priority;
-
-	/* SCHED_DEADLINE (nsec) */
-	uint64_t sched_runtime;
-	uint64_t sched_deadline;
-	uint64_t sched_period;
-};
-
-static int sched_setattr(pid_t pid, const struct sched_attr *attr, unsigned int flags)
-{
-	return syscall(SYS_sched_setattr, pid, attr, flags);
-}
-
-static int sched_getattr(pid_t pid, struct sched_attr *attr, unsigned int size, unsigned int flags)
-{
-	return syscall(SYS_sched_getattr, pid, attr, size, flags);
-}
-#endif
-
-/* the SCHED_DEADLINE is supported since Linux 3.14
- * commit id aab03e05e8f7e26f51dee792beddcb5cca9215a5
- * -- sched_setattr() is required for this policy!
- */
-#if defined (__linux__) && !defined(SCHED_DEADLINE) && defined(HAVE_SCHED_SETATTR)
-# define SCHED_DEADLINE 6
-#endif
 
 /* control struct */
 struct chrt_ctl {
diff --git a/schedutils/sched_attr.h b/schedutils/sched_attr.h
new file mode 100644
index 000000000..b39d37b5d
--- /dev/null
+++ b/schedutils/sched_attr.h
@@ -0,0 +1,97 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ * Copyright (C) 2004 Robert Love
+ */
+#ifndef UTIL_LINUX_SCHED_ATTR_H
+#define UTIL_LINUX_SCHED_ATTR_H
+
+/* the SCHED_BATCH is supported since Linux 2.6.16
+ *  -- temporary workaround for people with old glibc headers
+ */
+#if defined (__linux__) && !defined(SCHED_BATCH)
+# define SCHED_BATCH 3
+#endif
+
+/* the SCHED_IDLE is supported since Linux 2.6.23
+ * commit id 0e6aca43e08a62a48d6770e9a159dbec167bf4c6
+ * -- temporary workaround for people with old glibc headers
+ */
+#if defined (__linux__) && !defined(SCHED_IDLE)
+# define SCHED_IDLE 5
+#endif
+
+/* flag by sched_getscheduler() */
+#if defined(__linux__) && !defined(SCHED_RESET_ON_FORK)
+# define SCHED_RESET_ON_FORK 0x40000000
+#endif
+
+/* flag by sched_getattr() */
+#if defined(__linux__) && !defined(SCHED_FLAG_RESET_ON_FORK)
+# define SCHED_FLAG_RESET_ON_FORK 0x01
+#endif
+
+#if defined (__linux__)
+# include <sys/syscall.h>
+#endif
+
+/* usable kernel-headers, but old glibc-headers */
+#if defined (__linux__) && !defined(SYS_sched_setattr) && defined(__NR_sched_setattr)
+# define SYS_sched_setattr __NR_sched_setattr
+#endif
+
+#if defined (__linux__) && !defined(SYS_sched_getattr) && defined(__NR_sched_getattr)
+# define SYS_sched_getattr __NR_sched_getattr
+#endif
+
+#if defined (__linux__) && !defined(HAVE_SCHED_SETATTR) && defined(SYS_sched_setattr)
+# define HAVE_SCHED_SETATTR
+
+struct sched_attr {
+	uint32_t size;
+	uint32_t sched_policy;
+	uint64_t sched_flags;
+
+	/* SCHED_NORMAL, SCHED_BATCH */
+	int32_t sched_nice;
+
+	/* SCHED_FIFO, SCHED_RR */
+	uint32_t sched_priority;
+
+	/* SCHED_DEADLINE (nsec) */
+	uint64_t sched_runtime;
+	uint64_t sched_deadline;
+	uint64_t sched_period;
+};
+
+static int sched_setattr(pid_t pid, const struct sched_attr *attr, unsigned int flags)
+{
+	return syscall(SYS_sched_setattr, pid, attr, flags);
+}
+
+static int sched_getattr(pid_t pid, struct sched_attr *attr, unsigned int size, unsigned int flags)
+{
+	return syscall(SYS_sched_getattr, pid, attr, size, flags);
+}
+#endif
+
+/* the SCHED_DEADLINE is supported since Linux 3.14
+ * commit id aab03e05e8f7e26f51dee792beddcb5cca9215a5
+ * -- sched_setattr() is required for this policy!
+ */
+#if defined (__linux__) && !defined(SCHED_DEADLINE) && defined(HAVE_SCHED_SETATTR)
+# define SCHED_DEADLINE 6
+#endif
+
+#endif /* UTIL_LINUX_SCHED_ATTR_H */
-- 
2.25.1

