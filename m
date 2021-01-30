Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C4AC433E0
	for <util-linux@archiver.kernel.org>; Sat, 30 Jan 2021 20:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F9A364E0E
	for <util-linux@archiver.kernel.org>; Sat, 30 Jan 2021 20:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhA3Uvv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 30 Jan 2021 15:51:51 -0500
Received: from foss.arm.com ([217.140.110.172]:40762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhA3Uvv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 30 Jan 2021 15:51:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03E56106F;
        Sat, 30 Jan 2021 12:51:05 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A61663F73D;
        Sat, 30 Jan 2021 12:51:03 -0800 (PST)
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
Subject: [PATCH v2 0/5] Add a new uclampset utility
Date:   Sat, 30 Jan 2021 20:50:34 +0000
Message-Id: <20210130205039.581764-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Changes in v2 (thanks for all reviewers!):

	* Better error handling of invalid options.
	* Expose the special -1 value to reset to system default.
	* Add new --reset-on-fork option.
	* Move sched_attr.h out of include directory to avoid licensing issues.
	* Use pathnames.h for new procfs defines.
	* Use common functions to get command name and handle procfs
	  read/write.
	* Remove --max option and document in help message.
	* Improve help message formatting.
	* Minor manpage tweaks.

A branch of the changes is available at

	git clone https://github.com/qais-yousef/util-linux -b uclampset-v2

Karel, I compiled this v2 on an old Ubuntu 18.04 machine running v4.15 kernel
and didn't see any compilation errors. chrt worked fine and uclampset returns
EINVAL errors as expected. I don't think we need to do anything to deal with
compiling against old kernel headers.


Orignal cover letter
====================

Since kernel v5.3 we have a new feature called utilization clamping that allows
influencing the utilization signals of a task, ultimately influencing the
performance of these tasks.

The series adds a new utility called uclampset that allows the user to
manipulate util clamp (or uclamp for short) for existing running processes or
when running a new command; in a similar spirit to how taskset and chrt
currently work.

Peter/Dietmar/Vincent/Patrick; reviewing the manpage (patch 3) to make sure it
explains this feature right would be much appreciated.

Thanks

--
Qais Yousef

Qais Yousef (5):
  Move sched_attr struct and syscall definitions into header file
  Add uclampset schedutil
  uclampset: Add man page
  uclampset: Plump into the build system
  uclampset: Plumb in bash-completion

 .gitignore                    |   1 +
 bash-completion/Makemodule.am |   3 +
 bash-completion/uclampset     |  39 ++++
 configure.ac                  |   9 +
 include/pathnames.h           |   4 +
 schedutils/Makemodule.am      |   7 +
 schedutils/chrt.c             |  77 +-------
 schedutils/sched_attr.h       | 127 +++++++++++++
 schedutils/uclampset.1        | 174 ++++++++++++++++++
 schedutils/uclampset.c        | 337 ++++++++++++++++++++++++++++++++++
 10 files changed, 702 insertions(+), 76 deletions(-)
 create mode 100644 bash-completion/uclampset
 create mode 100644 schedutils/sched_attr.h
 create mode 100644 schedutils/uclampset.1
 create mode 100644 schedutils/uclampset.c

-- 
2.25.1

