Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F6DC3A5A2
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA6021726
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bV7QQG6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgjbGKGj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbfHWKRX (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 06:17:23 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57229 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387905AbfHWKRX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 06:17:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 4744F466
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 06:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=EQhwmUw69L+cf
        s37Vf4AGopO3VElJWOQ1Qctmtu6wvw=; b=bV7QQG6TBnQdH2XtQj9w/HtHABkEv
        DX1kMBeOO6MGgonjE92sXi65VCxV9Z8+DYPtAACQ1s05j4knCCySgIQRrAHt1fat
        49dCe61Cj0+lVcqXHZokep66CfsVLcuOyUXjrjMr35neECxhaq+P5ZYHgNajLAJg
        xBSJxY3tVL4iqIizAh3w3fvqdKDhmwnTCsDcVW6T3EXkaKnDfNqjCUJbXRRIf/j2
        3nub/6KBDosnLZQZYm6yP4Qiv76CJvWZkFALF8SHRj3OEFJfvzz6cNvj5/LvlHea
        /ewhBAwiV/hY2tI3K1iwHakN4DF+oEH+1J6ceKF/osolMcqoSa4ezaMSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=EQhwmUw69L+cfs37Vf4AGopO3VElJWOQ1Qctmtu6wvw=; b=hgjbGKGj
        pu2e4PBEf88C1ee5A6w14QHf8PLWftStAZ3EdVK4vK/09mQc/LOD3OudPxjYRQnS
        Fzi2e0M4CE56hDWo+Tcls8jWDW8W4VQjSkU1NMutsF33TdxqH9X7ykBGrc7x6QAD
        5SfEdviqkt+5+CI9OEevCVglImm6JBCWsXIVSy+eKS5ZfamrppshthqPBNYGIoGu
        F0rtXy/kozJybS2VkC7/85FNyw/HiQTj8e4HC5Y5w73mm1ZQv1aHU7OePG9iphjr
        rB7dCjM622HpHwixgFBCSX+HFyx0ciLJ0Z1tWyN8weo23+ykrvq0Owr+aGddfBRv
        L/qtMJqHq5BDWA==
X-ME-Sender: <xms:Mb1fXdt8XhSn28CSijzlSmg30E9XOJfT7IilmdpYsM0NVSLDSpBNMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecukfhppeejjedrudeluddrvddufedrvddttdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhenucevlhhushhtvghrufhiiigvpeeg
X-ME-Proxy: <xmx:Mb1fXVsjArntCjodh0jW1A_p4srJ_nJMpu27XVpuAlJZ9c7IsAKVlg>
    <xmx:Mb1fXTnE700YwP-JB1BQ-thAQugp03HB8-ThJJ3AbDc4K8_o1GxePw>
    <xmx:Mb1fXbuZv2iMDZxpDORrgqJVv7t9OrYybKcfSRoUYQYcbnIPiSR7CA>
    <xmx:Mb1fXWpAc62kMn4wXe2uxA7IvM8uucXSQi714Ca6KcLo9AQukjoF1g>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3142ED60062
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2019 06:17:21 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id 0b1b285b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 10:17:20 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/6] tests: libfdisk: remove reliance on buffer behaviour of standard streams
Date:   Fri, 23 Aug 2019 12:17:03 +0200
Message-Id: <be4da4d3eee59f06f3c99e813f79d61e2636da38.1566555078.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566555078.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The tests in libfdisk/mkpart-full all rely on the buffering behaviour of
standard output and standard error streams, most importantly that stderr
is non-buffering and stdout is buffering. This doesn't hold on all libc
implementations when redirecting to a file, breaking the test suite on
such platforms.

Use the ts_unbuffered function to stop buffering of the standard output
stream to fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tests/expected/libfdisk/mkpart-full-gpt       | 14 +++++-----
 .../libfdisk/mkpart-full-gpt-err-overlap      |  8 +++---
 .../libfdisk/mkpart-full-gpt-nopartno         | 14 +++++-----
 .../libfdisk/mkpart-full-gpt-partno-gap       | 14 +++++-----
 .../libfdisk/mkpart-full-gpt-space-gap        | 10 +++----
 .../libfdisk/mkpart-full-mbr-err-logical      | 14 +++++-----
 .../libfdisk/mkpart-full-mbr-err-nospace      |  6 ++---
 .../libfdisk/mkpart-full-mbr-err-primary      |  6 ++---
 .../expected/libfdisk/mkpart-full-mbr-logical | 14 +++++-----
 .../libfdisk/mkpart-full-mbr-nopartno         | 14 +++++-----
 .../expected/libfdisk/mkpart-full-mbr-primary |  8 +++---
 .../libfdisk/mkpart-full-mbr-primary-nopartno |  8 +++---
 .../libfdisk/mkpart-full-mbr-space-gap        |  6 ++---
 tests/ts/libfdisk/mkpart-full                 | 26 +++++++++----------
 14 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/tests/expected/libfdisk/mkpart-full-gpt b/tests/expected/libfdisk/mkpart-full-gpt
index d33483ac6..7740454fd 100644
--- a/tests/expected/libfdisk/mkpart-full-gpt
+++ b/tests/expected/libfdisk/mkpart-full-gpt
@@ -1,17 +1,17 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=6144,size=2048>
-Requested partition: <partno=3,start=8192,size=2048>
-Requested partition: <partno=4,start=10240,size=2048>
-Requested partition: <partno=5,start=12288,size=2048>
-Requested partition: <partno=6,start=14336,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=8192,size=2048>
 Created a new <removed>.
+Requested partition: <partno=4,start=10240,size=2048>
 Created a new <removed>.
+Requested partition: <partno=5,start=12288,size=2048>
 Created a new <removed>.
+Requested partition: <partno=6,start=14336,size=2048>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-gpt-err-overlap b/tests/expected/libfdisk/mkpart-full-gpt-err-overlap
index 673339230..ebf078415 100644
--- a/tests/expected/libfdisk/mkpart-full-gpt-err-overlap
+++ b/tests/expected/libfdisk/mkpart-full-gpt-err-overlap
@@ -1,11 +1,11 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=6144,size=2048>
-Requested partition: <partno=3,start=5000,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=5000,size=2048>
 Sector 5000 already used.
 sample-fdisk-mkpart-fullspec: failed to add #4 partition
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
diff --git a/tests/expected/libfdisk/mkpart-full-gpt-nopartno b/tests/expected/libfdisk/mkpart-full-gpt-nopartno
index 2c1423b75..fc9fdf240 100644
--- a/tests/expected/libfdisk/mkpart-full-gpt-nopartno
+++ b/tests/expected/libfdisk/mkpart-full-gpt-nopartno
@@ -1,17 +1,17 @@
-Requested partition: <partno=<default>,start=2048,size=2048>
-Requested partition: <partno=<default>,start=4096,size=2048>
-Requested partition: <partno=<default>,start=6144,size=2048>
-Requested partition: <partno=<default>,start=8192,size=2048>
-Requested partition: <partno=<default>,start=10240,size=2048>
-Requested partition: <partno=<default>,start=12288,size=2048>
-Requested partition: <partno=<default>,start=14336,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=8192,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=10240,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=12288,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=14336,size=2048>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-gpt-partno-gap b/tests/expected/libfdisk/mkpart-full-gpt-partno-gap
index b142b5efe..3a65d37e4 100644
--- a/tests/expected/libfdisk/mkpart-full-gpt-partno-gap
+++ b/tests/expected/libfdisk/mkpart-full-gpt-partno-gap
@@ -1,17 +1,17 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=3,start=6144,size=2048>
-Requested partition: <partno=4,start=8192,size=2048>
-Requested partition: <partno=6,start=10240,size=2048>
-Requested partition: <partno=7,start=12288,size=2048>
-Requested partition: <partno=8,start=14336,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=4,start=8192,size=2048>
 Created a new <removed>.
+Requested partition: <partno=6,start=10240,size=2048>
 Created a new <removed>.
+Requested partition: <partno=7,start=12288,size=2048>
 Created a new <removed>.
+Requested partition: <partno=8,start=14336,size=2048>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-gpt-space-gap b/tests/expected/libfdisk/mkpart-full-gpt-space-gap
index c26f2896b..64b2da4ab 100644
--- a/tests/expected/libfdisk/mkpart-full-gpt-space-gap
+++ b/tests/expected/libfdisk/mkpart-full-gpt-space-gap
@@ -1,13 +1,13 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=6144,size=2048>
-Requested partition: <partno=2,start=8192,size=2048>
-Requested partition: <partno=3,start=12288,size=2048>
-Requested partition: <partno=4,start=14336,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=8192,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=12288,size=2048>
 Created a new <removed>.
+Requested partition: <partno=4,start=14336,size=2048>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-err-logical b/tests/expected/libfdisk/mkpart-full-mbr-err-logical
index c2c0b0df6..6d48f487a 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-err-logical
+++ b/tests/expected/libfdisk/mkpart-full-mbr-err-logical
@@ -1,17 +1,17 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=6144,size=2048>
-Requested partition: <partno=3,start=8192,size=22528>
-Requested partition: <partno=4,start=10240,size=2048>
-Requested partition: <partno=5,start=4096,size=2048>
-sample-fdisk-mkpart-fullspec: failed to add #6 partition
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=8192,size=22528>
 Created a new <removed>.
+Requested partition: <partno=4,start=10240,size=2048>
 Adding logical partition 5
 Created a new <removed>.
+Requested partition: <partno=5,start=4096,size=2048>
+sample-fdisk-mkpart-fullspec: failed to add #6 partition
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-err-nospace b/tests/expected/libfdisk/mkpart-full-mbr-err-nospace
index d7a006569..a79c5800a 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-err-nospace
+++ b/tests/expected/libfdisk/mkpart-full-mbr-err-nospace
@@ -1,9 +1,9 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=4096,size=2048>
 Start sector 4096 out of range.
 sample-fdisk-mkpart-fullspec: failed to add #3 partition
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-err-primary b/tests/expected/libfdisk/mkpart-full-mbr-err-primary
index 1142f6531..93edf2b07 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-err-primary
+++ b/tests/expected/libfdisk/mkpart-full-mbr-err-primary
@@ -1,9 +1,9 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=6,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=6,start=6144,size=2048>
 Extended partition does not exists. Failed to add logical partition.
 sample-fdisk-mkpart-fullspec: failed to add #7 partition
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-logical b/tests/expected/libfdisk/mkpart-full-mbr-logical
index 97e7a4a54..ff2611cbb 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-logical
+++ b/tests/expected/libfdisk/mkpart-full-mbr-logical
@@ -1,19 +1,19 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=6144,size=2048>
-Requested partition: <partno=3,start=8192,size=22528>
-Requested partition: <partno=4,start=10240,size=2048>
-Requested partition: <partno=5,start=14336,size=2048>
-Requested partition: <partno=6,start=18432,size=12288>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=8192,size=22528>
 Created a new <removed>.
+Requested partition: <partno=4,start=10240,size=2048>
 Adding logical partition 5
 Created a new <removed>.
+Requested partition: <partno=5,start=14336,size=2048>
 Adding logical partition 6
 Created a new <removed>.
+Requested partition: <partno=6,start=18432,size=12288>
 Adding logical partition 7
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-nopartno b/tests/expected/libfdisk/mkpart-full-mbr-nopartno
index 23f7ad5a7..c8c449cd1 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-nopartno
+++ b/tests/expected/libfdisk/mkpart-full-mbr-nopartno
@@ -1,19 +1,19 @@
-Requested partition: <partno=<default>,start=2048,size=2048>
-Requested partition: <partno=<default>,start=4096,size=2048>
-Requested partition: <partno=<default>,start=6144,size=2048>
-Requested partition: <partno=<default>,start=8192,size=22528>
-Requested partition: <partno=<default>,start=10240,size=2048>
-Requested partition: <partno=<default>,start=14336,size=2048>
-Requested partition: <partno=<default>,start=18432,size=12288>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=8192,size=22528>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=10240,size=2048>
 Adding logical partition 5
 Created a new <removed>.
+Requested partition: <partno=<default>,start=14336,size=2048>
 Adding logical partition 6
 Created a new <removed>.
+Requested partition: <partno=<default>,start=18432,size=12288>
 Adding logical partition 7
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-primary b/tests/expected/libfdisk/mkpart-full-mbr-primary
index 31e84344d..c71ec9e1f 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-primary
+++ b/tests/expected/libfdisk/mkpart-full-mbr-primary
@@ -1,11 +1,11 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=4096,size=2048>
-Requested partition: <partno=2,start=6144,size=2048>
-Requested partition: <partno=3,start=8192,size=22528>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=3,start=8192,size=22528>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-primary-nopartno b/tests/expected/libfdisk/mkpart-full-mbr-primary-nopartno
index 90a71f3ab..33ba9ff88 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-primary-nopartno
+++ b/tests/expected/libfdisk/mkpart-full-mbr-primary-nopartno
@@ -1,11 +1,11 @@
-Requested partition: <partno=<default>,start=2048,size=2048>
-Requested partition: <partno=<default>,start=4096,size=2048>
-Requested partition: <partno=<default>,start=6144,size=2048>
-Requested partition: <partno=<default>,start=8192,size=22528>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=4096,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=<default>,start=8192,size=22528>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/expected/libfdisk/mkpart-full-mbr-space-gap b/tests/expected/libfdisk/mkpart-full-mbr-space-gap
index 45d45071f..881ea9ec7 100644
--- a/tests/expected/libfdisk/mkpart-full-mbr-space-gap
+++ b/tests/expected/libfdisk/mkpart-full-mbr-space-gap
@@ -1,9 +1,9 @@
-Requested partition: <partno=0,start=2048,size=2048>
-Requested partition: <partno=1,start=6144,size=2048>
-Requested partition: <partno=2,start=8192,size=2048>
 Created a new <removed>.
+Requested partition: <partno=0,start=2048,size=2048>
 Created a new <removed>.
+Requested partition: <partno=1,start=6144,size=2048>
 Created a new <removed>.
+Requested partition: <partno=2,start=8192,size=2048>
 Created a new <removed>.
 Disk <removed>: 15 MiB, 15728640 bytes, 30720 sectors
 Units: sectors of 1 * 512 = 512 bytes
diff --git a/tests/ts/libfdisk/mkpart-full b/tests/ts/libfdisk/mkpart-full
index eda506ef6..7f6413b09 100755
--- a/tests/ts/libfdisk/mkpart-full
+++ b/tests/ts/libfdisk/mkpart-full
@@ -31,7 +31,7 @@ ts_check_test_command "$TS_CMD_WIPEFS"
 TEST_IMAGE_NAME=$(ts_image_init 15)
 
 ts_init_subtest "mbr-primary"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -45,7 +45,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 
 ts_init_subtest "mbr-primary-nopartno"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -59,7 +59,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ## no extended but partno > 4 requested
 ts_init_subtest "mbr-err-primary"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	7,6144,2048 \
@@ -72,7 +72,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ## no extended but partno > 4 requested
 ts_init_subtest "mbr-err-nospace"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,4096,2048 \
@@ -85,7 +85,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 
 ts_init_subtest "mbr-logical"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -101,7 +101,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "mbr-nopartno"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -118,7 +118,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ### 6th partition (logical) out of extended
 ts_init_subtest "mbr-err-logical"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -134,7 +134,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "mbr-space-gap"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,6144,2048 \
 	3,8192,2048 \
@@ -146,7 +146,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -162,7 +162,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-nopartno"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} -- \
+ts_unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -179,7 +179,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ### 4th partition overlap 4th and 5th
 ts_init_subtest "gpt-err-overlap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -195,7 +195,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-partno-gap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	4,6144,2048 \
@@ -211,7 +211,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-space-gap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,6144,2048 \
 	3,8192,2048 \
-- 
2.23.0

