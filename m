Return-Path: <SRS0=YMMD=WT=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4FAC3A5A5
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789F92166E
	for <util-linux@archiver.kernel.org>; Fri, 23 Aug 2019 13:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="woPI2Y0a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KwEF/iuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389780AbfHWNdL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:41581 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389164AbfHWNdL (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 23 Aug 2019 09:33:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AC1AA3C4;
        Fri, 23 Aug 2019 09:33:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 23 Aug 2019 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=k2okwuta6PeHI
        93pfYIQLuB/XY4sURo7z4fFu2tjEBA=; b=woPI2Y0a4akNsOWeQt3NHDTuLjAzY
        tW7XwAXe2crjBUQ+XknayTaS5BeYdJv52NnJtcD4OApcnoir3LA8t2yxbnsHNMAV
        cr1+WM2i/QYdNbosRamiB8ry1FRIYcAitrllGqYFRKTMXISO7eK1iExpWx3VSIDH
        Mz7heK7QJowsvM2U8l/tlq5kc4gDR0v2e2MvUHc+6oCRm67RAx3P2QWVHlisMQit
        owxbCgkIX/AoylLDLweWHlGLnxvcvlaL50+cQIiqTasretnw9g/yMjGz9LmAHGK6
        EuSIrSop0FKatqhO5pM7dAWli18tbAL920JG8XgJNXooduvK8rhEpq4Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=k2okwuta6PeHI93pfYIQLuB/XY4sURo7z4fFu2tjEBA=; b=KwEF/iuF
        Zd3OHtH/IRDMB38eR5iV2D8QjB5X5obKNS0UX6eLN4bbtOwRA4ExBCXXZoH4+Jm0
        L9JuAiwUYqJyTP222i48XPA+SA30I/GGNrRzIMNPAkgT0Z3n7K3KvGIQWqnObGC6
        Z2TZGW9fHatPUW91ewFm4JQToqLABfhwO+xn+JEIKDjY2XoCfKYp/aajAdcTviI2
        PQgTi58bLkuD2HGEn897zqC682IfzIO3j1DxLXvbMaTIKymLYcNLT1Grkd5DDDx3
        GGdyNQhz9pAgGVZOwDV2gwHq1YpnflxlP3jNYA3+zUyUEEdTkOY46ZWSmqTWooL1
        SsjlkkC4RjTLzg==
X-ME-Sender: <xms:FetfXSCayuSJAQCmX7MwDC86BrEbYc5-5Wcr99B_XnrZF54lIj2pqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeejrddule
    durddvudefrddvtddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    necuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:FetfXQxVYefQR-6vFJtsCxoeyEvn1x1KKjnPEdRgre_LEIpZtrMrxw>
    <xmx:FetfXQnrlIdaNKiSM9-_X04hOKiKpDlF0KyOePxMne5ULcZzkXXOaA>
    <xmx:FetfXVEy3Q7UHJx2mIlWbrcXM76oS5SqHzS5Gq13gxnG5MfDzRoM7w>
    <xmx:FetfXfPbHFxgJmCUJMqjiAacZrTfvvVJU1m2x_J5q3woFQe7D8Sc1g>
Received: from NSJAIL (x4dbfd5c8.dyn.telefonica.de [77.191.213.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6551480064;
        Fri, 23 Aug 2019 09:33:08 -0400 (EDT)
Received: from localhost (10.192.0.11 [10.192.0.11])
        by NSJAIL (OpenSMTPD) with ESMTPSA id a37a52eb (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 23 Aug 2019 13:33:04 +0000 (UTC)
From:   Patrick Steinhardt <ps@pks.im>
To:     util-linux@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Karel Zak <kzak@redhat.com>
Subject: [PATCH v2 2/6] tests: libfdisk: remove reliance on buffer behaviour of standard streams
Date:   Fri, 23 Aug 2019 15:32:54 +0200
Message-Id: <eaea98e968735752999d25db183c36f7c3b38d52.1566566906.git.ps@pks.im>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566566906.git.ps@pks.im>
References: <cover.1566555078.git.ps@pks.im> <cover.1566566906.git.ps@pks.im>
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

Use `ts_run --unbuffered` to stop buffering of the standard output
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
index eda506ef6..9fb46ef67 100755
--- a/tests/ts/libfdisk/mkpart-full
+++ b/tests/ts/libfdisk/mkpart-full
@@ -31,7 +31,7 @@ ts_check_test_command "$TS_CMD_WIPEFS"
 TEST_IMAGE_NAME=$(ts_image_init 15)
 
 ts_init_subtest "mbr-primary"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -45,7 +45,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 
 ts_init_subtest "mbr-primary-nopartno"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -59,7 +59,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ## no extended but partno > 4 requested
 ts_init_subtest "mbr-err-primary"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	7,6144,2048 \
@@ -72,7 +72,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ## no extended but partno > 4 requested
 ts_init_subtest "mbr-err-nospace"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,4096,2048 \
@@ -85,7 +85,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 
 ts_init_subtest "mbr-logical"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -101,7 +101,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "mbr-nopartno"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -118,7 +118,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ### 6th partition (logical) out of extended
 ts_init_subtest "mbr-err-logical"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -134,7 +134,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "mbr-space-gap"
-$TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label mbr --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,6144,2048 \
 	3,8192,2048 \
@@ -146,7 +146,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -162,7 +162,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-nopartno"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} -- \
+ts_run --unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} -- \
 	-,2048,2048 \
 	-,4096,2048 \
 	-,6144,2048 \
@@ -179,7 +179,7 @@ $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ### 4th partition overlap 4th and 5th
 ts_init_subtest "gpt-err-overlap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	3,6144,2048 \
@@ -195,7 +195,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-partno-gap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,4096,2048 \
 	4,6144,2048 \
@@ -211,7 +211,7 @@ ts_finalize_subtest
 $TS_CMD_WIPEFS --all --force ${TEST_IMAGE_NAME} &> /dev/null
 
 ts_init_subtest "gpt-space-gap"
-$TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
+ts_run --unbuffered $TESTPROG --label gpt --device ${TEST_IMAGE_NAME} \
 	1,2048,2048 \
 	2,6144,2048 \
 	3,8192,2048 \
-- 
2.23.0

