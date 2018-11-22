Return-Path: <SRS0=iT9e=OB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCAFC43441
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8F820685
	for <util-linux@archiver.kernel.org>; Thu, 22 Nov 2018 15:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8F820685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datacom.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbeKWBpn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:45:43 -0500
Received: from mx.datacom.ind.br ([177.66.5.10]:47188 "EHLO
        mail.datacom.com.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729854AbeKWBpn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 22 Nov 2018 20:45:43 -0500
Received: from mail.datacom.com.br (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTPS id 974241BA45EC
        for <util-linux@vger.kernel.org>; Thu, 22 Nov 2018 13:06:35 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTP id 8792E1BA45F0
        for <util-linux@vger.kernel.org>; Thu, 22 Nov 2018 13:06:35 -0200 (-02)
Received: from mail.datacom.com.br ([127.0.0.1])
        by localhost (mail.datacom.com.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Ap-QvcP5X3c for <util-linux@vger.kernel.org>;
        Thu, 22 Nov 2018 13:06:35 -0200 (-02)
Received: from pedeld202344.datacom.net (pedeld202344.datacom.net [10.0.120.87])
        by mail.datacom.com.br (Postfix) with ESMTPSA id 5E2D81BA45EC
        for <util-linux@vger.kernel.org>; Thu, 22 Nov 2018 13:06:35 -0200 (-02)
From:   Carlos Santos <casantos@datacom.com.br>
To:     util-linux@vger.kernel.org
Subject: [PATCH] build-sys: make fdisk, sfdisk, cfdisk optional (enabled by default)
Date:   Thu, 22 Nov 2018 13:05:49 -0200
Message-Id: <20181122150549.32675-1-casantos@datacom.com.br>
X-Mailer: git-send-email 2.14.5
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Useful for embedded systems, on which only few utilities are required.

Signed-off-by: Carlos Santos <casantos@datacom.com.br>
---
 configure.ac | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index e32cfc7e4..7e9fcc5f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1152,26 +1152,30 @@ AC_SUBST([LIBFDISK_VERSION_INFO])
 AC_DEFINE_UNQUOTED([LIBFDISK_VERSION], ["$LIBFDISK_VERSION"], [libfdisk version string])
 
 
-UL_BUILD_INIT([fdisk], [check])
+AC_ARG_ENABLE([fdisk],
+  AS_HELP_STRING([--disable-fdisk], [do not build fdisk(8), sfdisk(8) and cfdisk(8)]),
+  [], [UL_DEFAULT_ENABLE([fdisk], [check])]
+)
+UL_BUILD_INIT([fdisk])
 UL_REQUIRES_HAVE([fdisk], [openat], [openat functions])
 UL_REQUIRES_BUILD([fdisk], [libfdisk])
 UL_REQUIRES_BUILD([fdisk], [libsmartcols])
 AM_CONDITIONAL([BUILD_FDISK], [test "x$build_fdisk" = xyes])
 
 
-UL_BUILD_INIT([sfdisk], [check])
+UL_BUILD_INIT([sfdisk])
 UL_REQUIRES_HAVE([sfdisk], [openat], [openat functions])
 UL_REQUIRES_BUILD([sfdisk], [libfdisk])
 UL_REQUIRES_BUILD([sfdisk], [libsmartcols])
-AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_sfdisk" = xyes])
+AM_CONDITIONAL([BUILD_SFDISK], [test "x$build_fdisk" = xyes])
 
 
-UL_BUILD_INIT([cfdisk], [check])
+UL_BUILD_INIT([cfdisk])
 UL_REQUIRES_BUILD([cfdisk], [libfdisk])
 UL_REQUIRES_BUILD([cfdisk], [libsmartcols])
 UL_REQUIRES_HAVE([cfdisk], [open_memstream], [open_memstream function])
 UL_REQUIRES_HAVE([cfdisk], [ncursesw,slang,ncurses], [ncursesw, ncurses or slang library])
-AM_CONDITIONAL([BUILD_CFDISK], [test "x$build_cfdisk" = xyes])
+AM_CONDITIONAL([BUILD_CFDISK], [test "x$build_fdisk" = xyes])
 
 
 AC_ARG_ENABLE([mount],
-- 
2.14.5

