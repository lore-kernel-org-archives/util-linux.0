Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB055C433DB
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C9F22AAD
	for <util-linux@archiver.kernel.org>; Sat, 16 Jan 2021 19:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbhAPTMz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 16 Jan 2021 14:12:55 -0500
Received: from foss.arm.com ([217.140.110.172]:58772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbhAPTMz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 16 Jan 2021 14:12:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5917A1396;
        Sat, 16 Jan 2021 11:11:34 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74A4E3F70D;
        Sat, 16 Jan 2021 11:11:33 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     util-linux@vger.kernel.org
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 5/5] uclampset: Plumb in bash-completion
Date:   Sat, 16 Jan 2021 19:09:40 +0000
Message-Id: <20210116190940.2320819-6-qais.yousef@arm.com>
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
 bash-completion/Makemodule.am |  3 +++
 bash-completion/uclampset     | 39 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 bash-completion/uclampset

diff --git a/bash-completion/Makemodule.am b/bash-completion/Makemodule.am
index b80c23f7b..3384ba4e2 100644
--- a/bash-completion/Makemodule.am
+++ b/bash-completion/Makemodule.am
@@ -210,6 +210,9 @@ endif
 if BUILD_CHRT
 dist_bashcompletion_DATA += bash-completion/chrt
 endif
+if BUILD_UCLAMPSET
+dist_bashcompletion_DATA += bash-completion/uclampset
+endif
 if BUILD_IONICE
 dist_bashcompletion_DATA += bash-completion/ionice
 endif
diff --git a/bash-completion/uclampset b/bash-completion/uclampset
new file mode 100644
index 000000000..44ae80365
--- /dev/null
+++ b/bash-completion/uclampset
@@ -0,0 +1,39 @@
+_uclampset_module()
+{
+	local cur prev OPTS
+	COMPREPLY=()
+	cur="${COMP_WORDS[COMP_CWORD]}"
+	prev="${COMP_WORDS[COMP_CWORD-1]}"
+	case $prev in
+		'-h'|'--help'|'-V'|'--version')
+			return 0
+			;;
+	esac
+	case $cur in
+		-*)
+			OPTS="
+				--all-tasks
+				--help
+				--max
+				--pid
+				--system
+				--verbose
+				--version
+			"
+			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
+			return 0
+			;;
+	esac
+	local i
+	for i in ${COMP_WORDS[*]}; do
+		case $i in
+		'-p'|'--pid')
+			COMPREPLY=( $(compgen -W "$(cd /proc && echo [0-9]*)" -- $cur) )
+			return 0
+			;;
+		esac
+	done
+	COMPREPLY=( $(compgen -c -- $cur) )
+	return 0
+}
+complete -F _uclampset_module uclampset
-- 
2.25.1

