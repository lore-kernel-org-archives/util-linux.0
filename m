Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D760C54EBE
	for <util-linux@archiver.kernel.org>; Sat,  7 Jan 2023 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjAGT43 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 7 Jan 2023 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGT41 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 7 Jan 2023 14:56:27 -0500
Received: from aurora.tech (unknown [64.124.54.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E533210C9
        for <util-linux@vger.kernel.org>; Sat,  7 Jan 2023 11:56:24 -0800 (PST)
Received: by aurora.tech (Postfix, from userid 1001)
        id AF53416400AF; Sat,  7 Jan 2023 11:47:14 -0800 (PST)
From:   alison@she-devel.com
To:     util-linux@vger.kernel.org
Cc:     kzak@redhat.com, achaiken@aurora.tech, alison@she-devel.com
Subject: [PATCH 0/3] clarify the usage and behavior of the taskset command
Date:   Sat,  7 Jan 2023 11:47:05 -0800
Message-Id: <20230107194708.6878-1-alison@she-devel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

The following changes since commit f9596dd4807f4d8da5bda14cd65efc0e5c375cac:

  Merge branch 'waitpid' of https://github.com/t-8ch/util-linux (2023-01-06 17:05:04 +0100)

are available in the Git repository at:

  git://github.com/chaiken/util-linux.git schedutils

for you to fetch changes up to be71e7c656a47e996eebff855119c9f1a2141cd5:

  schedutils: better illustrate the usage of cpu-lists with taskset (2023-01-07 09:41:16 -0800)

Alison Chaiken (3):
  schedutils: clarify confusing mask example in taskset man page
  schedutils: clarify meaning of taskset return code
  schedutils: better illustrate the usage of cpu-lists with taskset

 schedutils/taskset.1.adoc | 42 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

-- 
2.32.0

