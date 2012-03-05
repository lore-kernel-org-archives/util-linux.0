Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757522Ab2CETjm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:42 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/17] build-sys: fix chkdupexe regression
Date: Mon,  5 Mar 2012 20:38:54 +0100
Message-Id: <1330976334-10751-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 2897f50a6a6d1aab653c7017f7542d26ac2a8a0b resulted breaking
shebang substitution for chkdupexe.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index b40a636..63be8da 100644
--- a/configure.ac
+++ b/configure.ac
@@ -114,6 +114,9 @@ UL_SET_ARCH(M68K, m68*)
 UL_SET_ARCH(MIPS, mips*)
 UL_SET_ARCH(HPPA, hppa*)
 
+dnl script chkdupexe requires perl
+AC_PATH_PROG(PERL, perl)
+
 AC_SYS_LARGEFILE
 
 AM_GNU_GETTEXT_VERSION([0.14.1])
-- 
1.7.9.2

