Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:37139 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaGZRBr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 13:01:47 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-h22.telenor.se (Postfix) with ESMTP id C5C3C24694
	for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 19:01:14 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] buildsys: make tailf linux-only (needs inotify)
Date: Sat, 26 Jul 2014 19:01:11 +0200
Message-Id: <1406394071-1499-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While tailf builds fine on other architectures, it relies
on inotify to work properly. So for example on
Debian architectures using Hurd or kFreeBSD tailf
would work like a regular tail (with a non-functional
-f option), which makes it quite redundant.
This was caught by the util-linux testsuite.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index aae2456..eade79c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1272,7 +1272,8 @@ AM_CONDITIONAL([BUILD_HEXDUMP], [test "x$build_hexdump" = xyes])
 UL_BUILD_INIT([rev], [yes])
 AM_CONDITIONAL([BUILD_REV], [test "x$build_rev" = xyes])
 
-UL_BUILD_INIT([tailf], [yes])
+UL_BUILD_INIT([tailf], [check])
+UL_REQUIRES_LINUX([tailf])
 AM_CONDITIONAL([BUILD_TAILF], [test "x$build_tailf" = xyes])
 
 
-- 
2.0.1

