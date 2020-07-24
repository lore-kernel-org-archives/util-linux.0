Return-Path: <SRS0=zMQF=BD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A68C433E8
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA682065C
	for <util-linux@archiver.kernel.org>; Fri, 24 Jul 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUPlP80n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgGXKGq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXKGq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 24 Jul 2020 06:06:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB17C0619D3
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bm28so6656234edb.2
        for <util-linux@vger.kernel.org>; Fri, 24 Jul 2020 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=86AVUxRONR48EL+5ky2xKafvx828oTtZwDXptzE1HnI=;
        b=eUPlP80nDTd54KNb1ciTPquhRou9slGu9zi0wDu1aaX7Jdeea4sCm84va88oEKCj56
         9OPgd4fK/YF5YqGkkqXurVQeEvsrRnov267qwqRX/HSAhhZVyTkRCGRgXQ01kP+tOnfN
         dTd1mFrQhvXDP2z2fN9ZHhROAxIm1NM181aSvSFCy9eEuiQz1P350LQZ57PK/cETHIIC
         rNQ3qF01DuJ/JK4r8YuPqVWQXoxH13bpoy1CWbYkRNSZq6qOJv3TmC40mo3wIcSFuQj1
         6oUEJkmsJKMHy3OZpfMtSabhySm7EfF2UJxqEZpZFLvI1URDr8VIqMVyu8Y5alRO+9mn
         Oi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=86AVUxRONR48EL+5ky2xKafvx828oTtZwDXptzE1HnI=;
        b=BF05GQubwGZJEEBWx8DJ6YcOP9NRJryWpKCoKRQ/vWhKPabExq+i20qNH5MWQ+ayWs
         2DJs3wD5Y4IeDbOdbK8qrNjHWrKxkeBvbWUR1Qpc6QLL4qoeqq6aJKI3ycMX4uDsJbYN
         AR4/lWHbTuMrGp2aKE02pysmjlQWHbbLkRzoP9jgNsvnFoOipP01UWIg9lsW+C8rjSkR
         El9ltwqzhHLgk2vR58ZY6q5iUGzb+mfsqsR5oqtRFe0MV9V0I7KpdjDKc6wpwWZNyCTw
         9ERYQf8d9lHDeaWsLjcLEoArlNvKO4w2xjB8v07xuPoLW/MiTD0helj5aMN9GSEc7z51
         DTlA==
X-Gm-Message-State: AOAM533MAUu7teJOPJF/0CwSNqwAknTjn6Q0d2UBgCwVXwDTU0POgmTE
        ZIAGBOPsvRrDQZJzpYPzzoc=
X-Google-Smtp-Source: ABdhPJxjc8yjDyiA7qtfQXKCcMRl/560Y9NgG4OWiRg16DMkeD1G/ZSyqY6i2TvM75ht+Ma6o+iv/g==
X-Received: by 2002:a50:aca6:: with SMTP id x35mr7950138edc.328.1595585204741;
        Fri, 24 Jul 2020 03:06:44 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:3adb:8201:9649:88f:51f8:6a21])
        by smtp.gmail.com with ESMTPSA id p14sm399874edr.23.2020.07.24.03.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 03:06:44 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 05/12] Manual pages: sfdisk.8: Use less aggressive indenting
Date:   Fri, 24 Jul 2020 12:06:11 +0200
Message-Id: <20200724100618.584918-5-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200724100618.584918-1-mtk.manpages@gmail.com>
References: <20200724100618.584918-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The page currently uses rather aggressive indenting, which doesn't
really improve readability, but does have cause ugly line filling.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 disk-utils/sfdisk.8 | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/disk-utils/sfdisk.8 b/disk-utils/sfdisk.8
index 6c54a1699..6415b0f1b 100644
--- a/disk-utils/sfdisk.8
+++ b/disk-utils/sfdisk.8
@@ -344,17 +344,14 @@ Display help text and exit.
 .B sfdisk
 supports two input formats and generic header lines.
 
-.B Header lines
-.RS
+.SS Header lines
 The optional header lines specify generic information that apply to the partition
 table.  The header-line format is:
-.RS
 .sp
 .B "<name>: <value>"
 .sp
 .RE
 The currently recognized headers are:
-.RS
 .TP
 .B unit
 Specify the partitioning unit.  The only supported unit is \fBsectors\fR.
@@ -384,14 +381,11 @@ modify this variable if you're not sure.
 Specify sector size. This header is informative only and it is not used when
 sfdisk creates a new partition table, in this case the real device specific
 value is always used and sector size from the dump is ignored.
-.RE
-.sp
+.PP
 Note that it is only possible to use header lines before the first partition
 is specified in the input.
-.RE
-
-.B Unnamed-fields format
-.RS
+.SS Unnamed-fields format
+\&
 .RS
 .sp
 .I start size type bootable
@@ -441,7 +435,6 @@ Since v2.36 libfdisk supports partition type aliases as extension to shortcuts.
 simple human readable word (e.g. "linux").
 
 Supported shortcuts and aliases:
-.RS
 .TP
 .B L - alias 'linux'
 Linux; means 83 for MBR and 0FC63DAF-8483-4772-8E79-3D69D8477DE4 for GPT.
@@ -464,7 +457,6 @@ Linux RAID; means FD for MBR and A19D880F-05FC-4D3B-A006-743F0F84911E for GPT
 .TP
 .B V - alias 'lvm'
 LVM; means 8E for MBR and E6D6D379-F507-44C2-A23C-238F2A3DF928 for GPT
-.RE
 .PP
 The default
 .I type
@@ -478,10 +470,7 @@ is specified as [\fB*\fR|\fB-\fR], with as default not-bootable.  The
 value of this field is irrelevant for Linux - when Linux runs it has
 been booted already - but it might play a role for certain boot
 loaders and for other operating systems.
-.RE
-
-.B Named-fields format
-.RS
+.SS Named-fields format
 This format is more readable, robust, extensible and allows specifying additional
 information (e.g., a UUID).  It is recommended to use this format to keep your scripts
 more readable.
@@ -501,7 +490,6 @@ The
 .I value
 can be between quotation marks (e.g., name="This is partition name").
 The currently supported fields are:
-.RS
 .TP
 .BI start= number
 The first non-assigned sector aligned according to device I/O limits.  The default
@@ -531,9 +519,6 @@ GPT partition name.
 A hexadecimal number (without 0x) for an MBR partition, a GUID for a GPT partition,
 or a shortcut as for unnamed-fields format.
 For backward compatibility the \fBId=\fR field has the same meaning.
-.RE
-.RE
-
 .SH EMPTY DISK LABEL
 .B sfdisk
 does not create partition table without partitions by default. The lines with
-- 
2.26.2

