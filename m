Return-Path: <SRS0=sYuO=7Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86047C433E0
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD7C2063A
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 19:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTm/eKOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLTaD (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLTaC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Jun 2020 15:30:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCFBC03E96F
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 12:30:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p5so10928921wrw.9
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=VECZBw4r/oZmVL0Pv1bOK06RWPmXwIjtk7MOq1DMINw=;
        b=kTm/eKOtZ2LF+8jy4Qdstocc/dCQXj/NsEqT/avKgjw6llhjMX3yACLWs8EM7G7ziP
         etC8EtGPCZ0HTrcImHQWBXyWCPx41DGz9LjGy9CXJJQWZxVVGgsa8uqFkRzDrwaU+FE3
         mBO2pPd4K5lR284b9R4OreaZ+FENPS8Fzv22SN9ocz2yrgTttZ6hhypRbZIOvm9mg8LX
         7quqeTSiq4UBCd/mauKvGeIhtWxyNCW/9lJy0yYCRGXa2YXNPsqexwzV0dKOvADH+AZn
         SN1qo7XbUkHYirlV7Ci+ym/Yyo4J5uLcFox9mSsULWd/+6C+qWmED8DbIHAx4Lkf3x+e
         Zq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=VECZBw4r/oZmVL0Pv1bOK06RWPmXwIjtk7MOq1DMINw=;
        b=a5VKimYutMZZLe0Dm+Wlmmobko58Vse3D/iGGAPfVkNLrcv1gYpTH17LqXaxwvkJV5
         565pebTfBniMQ6o6qzBh4CjiUcaS5aKviTq2ltSrJvJB2B/LzEhwMetxCds9rn5N8HdE
         8NZiLMTDFlJ+q/+R6Km0hgwyZG2fzPanLcVXEpLcuPS1XaXPDw+OmRGiXVNwLpGv3Dgq
         N/tQgnsI3ugFWzz5AYnM7Jwvjpe/MsTcIQgfXqXbnjru0DVE7LXzO5M5MJOPZanEusC0
         zpu/xOq9nw9R9R6RM4f0I4xhqrOvxVP1cHXNbVFQMWQGq8IAekkqAraZriW3smlFLG6i
         o9Ng==
X-Gm-Message-State: AOAM532yxqz9UB98TgymyoojUb4LHCmGZZfDwyuzpfifZ3X04apVRO1G
        WgV2cQUv8FxisvBuHdRrfLsfjbe7
X-Google-Smtp-Source: ABdhPJyLAUtaVp1I6lp6IAqSEclJzzLofCnE6cKfpcsiN4540a/bdxKw5nRWoD6EGmn33n4b9d7+Iw==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr455770wmg.148.1591990199673;
        Fri, 12 Jun 2020 12:29:59 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:a8d8:38f:5807:ac47])
        by smtp.gmail.com with ESMTPSA id s132sm11048977wmf.12.2020.06.12.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:29:58 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/1] bash-completion: release preparations
Date:   Fri, 12 Jun 2020 20:29:54 +0100
Message-Id: <20200612192954.2965-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

6e103c7690fe blkzone: Add --force option
9cd88771ef45 fdisk: add --lock and LOCK_BLOCK_DEVICE
921ceaca31bd wipefs: add --lock and LOCK_BLOCK_DEVICE
c3ef1268a0b4 sfdisk: add --lock and LOCK_BLOCK_DEVICE
b8671fe76370 mkswap: add --lock and LOCK_BLOCK_DEVICE
ec8f712157fe cfdisk: add --lock and LOCK_BLOCK_DEVICE
f2229320a9f7 fdisk: add --noauto-pt
7f1f0584c24a nsenter: add support for the time namespace
dd52c4fa011d lsirq: add -n option
ee5a16025046 sfdisk: add --relocate command
99d78b2fefe3 fdisk: add --list-details
65e27d545cb5 sfdisk: add --disk-id to change disk UUID/ID
34fed3ff1740 blkdiscard: use O_EXCL, add --force

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/blkdiscard | 1 +
 bash-completion/blkzone    | 2 +-
 bash-completion/cfdisk     | 1 +
 bash-completion/fdisk      | 3 +++
 bash-completion/lsirq      | 1 +
 bash-completion/mkswap     | 2 +-
 bash-completion/nsenter    | 1 +
 bash-completion/sfdisk     | 3 +++
 bash-completion/wipefs     | 1 +
 9 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/bash-completion/blkdiscard b/bash-completion/blkdiscard
index f28e5d4c2..ab69e7fb1 100644
--- a/bash-completion/blkdiscard
+++ b/bash-completion/blkdiscard
@@ -16,6 +16,7 @@ _blkdiscard_module()
 	case $cur in
 		-*)
 			OPTS="
+				--force
 				--offset
 				--length
 				--step
diff --git a/bash-completion/blkzone b/bash-completion/blkzone
index b64295348..cc9352730 100644
--- a/bash-completion/blkzone
+++ b/bash-completion/blkzone
@@ -25,7 +25,7 @@ _blkzone_module()
 		-*)
 			case $prev in
 				'report'|'reset')
-					OPTS="--verbose --offset --length --count"
+					OPTS="--verbose --offset --length --count --force"
 					;;
 				*)
 					OPTS="--help --version"
diff --git a/bash-completion/cfdisk b/bash-completion/cfdisk
index 180d987f8..4da6fb8b5 100644
--- a/bash-completion/cfdisk
+++ b/bash-completion/cfdisk
@@ -17,6 +17,7 @@ _cfdisk_module()
 		-*)
 			OPTS="	--color
 				--zero
+				--lock
 				--help
 				--version"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
diff --git a/bash-completion/fdisk b/bash-completion/fdisk
index a29b5f686..c42c329bd 100644
--- a/bash-completion/fdisk
+++ b/bash-completion/fdisk
@@ -75,6 +75,9 @@ _fdisk_module()
 				--compatibility
 				--color
 				--list
+				--list-details
+				--noauto-pt
+				--lock
 				--output
 				--type
 				--units
diff --git a/bash-completion/lsirq b/bash-completion/lsirq
index b644559e5..c706876f8 100644
--- a/bash-completion/lsirq
+++ b/bash-completion/lsirq
@@ -28,6 +28,7 @@ _lsirq_module()
 	esac
 	OPTS="	--json
 		--pairs
+		--noheadings
 		--output
 		--sort
 		--help
diff --git a/bash-completion/mkswap b/bash-completion/mkswap
index 3fc5ca574..97c9292e4 100644
--- a/bash-completion/mkswap
+++ b/bash-completion/mkswap
@@ -27,7 +27,7 @@ _mkswap_module()
 	esac
 	case $cur in
 		-*)
-			OPTS="--check --force --pagesize --label --swapversion --uuid --version --help"
+			OPTS="--check --force --pagesize --lock --label --swapversion --uuid --version --help"
 			COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
 			return 0
 			;;
diff --git a/bash-completion/nsenter b/bash-completion/nsenter
index ad56f06e4..8ee74612e 100644
--- a/bash-completion/nsenter
+++ b/bash-completion/nsenter
@@ -42,6 +42,7 @@ _nsenter_module()
 				--pid=
 				--cgroup=
 				--user=
+				--time=
 				--setuid
 				--setgid
 				--preserve-credentials
diff --git a/bash-completion/sfdisk b/bash-completion/sfdisk
index 8386c9fb5..8aa051626 100644
--- a/bash-completion/sfdisk
+++ b/bash-completion/sfdisk
@@ -58,10 +58,12 @@ _sfdisk_module()
 				--show-geometry
 				--list
 				--list-free
+				--disk-id
 				--reorder
 				--show-size
 				--list-types
 				--verify
+				--relocate
 				--delete
 				--part-label
 				--part-type
@@ -73,6 +75,7 @@ _sfdisk_module()
 				--move-data
 				--force
 				--color
+				--lock
 				--partno
 				--no-act
 				--no-reread
diff --git a/bash-completion/wipefs b/bash-completion/wipefs
index 8c31fba4a..8e49a8bda 100644
--- a/bash-completion/wipefs
+++ b/bash-completion/wipefs
@@ -41,6 +41,7 @@ _wipefs_module()
 				--force
 				--noheadings
 				--json
+				--lock
 				--no-act
 				--offset
 				--output
-- 
2.27.0

