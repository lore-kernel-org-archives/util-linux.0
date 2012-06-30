Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:39582 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754103Ab2F3QBV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 30 Jun 2012 12:01:21 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] Ensure BUILD_CFDISK is always defined
Date: Sat, 30 Jun 2012 12:01:18 -0400
Message-Id: <1341072078-20095-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This avoids an error when configuring without ncurses:

configure: error: conditional "BUILD_CFDISK" was never defined.
Usually this means the macro was only invoked conditionally.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 configure.ac | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 198366a..cedeeaf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -628,9 +628,7 @@ fi
 AM_CONDITIONAL(HAVE_SLANG, test "x$have_slang" = xyes)
 
 
-if test "x$have_slang" = xyes -o "x$have_ncurses" = xyes; then
-  AM_CONDITIONAL(BUILD_CFDISK, true)
-fi
+AM_CONDITIONAL(BUILD_CFDISK, test "x$have_slang" = xyes -o "x$have_ncurses" = xyes)
 
 
 have_tinfo=no
-- 
1.7.11.1

