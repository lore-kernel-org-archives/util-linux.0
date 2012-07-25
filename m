Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab2GYTPv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:51 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] tests: fdisk: change expected test output
Date: Wed, 25 Jul 2012 21:15:21 +0200
Message-Id: <1343243745-1172-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Align with commit 289dcc90234680063a336925a99d1ef04e97cbda.  The check
will work for now.  Notice that the fdisk check will probably get more
changes in near future, see reference for more information.

Reference: http://marc.info/?l=util-linux-ng&m=134251966722938&w=2
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/fdisk/oddinput | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index d90866b..bc9952b 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 
 Nonexistant file
-lt-fdisk: unable to open _a_file_that_does_not_exist_: No such file or directory
+lt-fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
 Too small file
-lt-fdisk: unable to open oddinput.toosmall: Success
+lt-fdisk: cannot open oddinput.toosmall: Success
-- 
1.7.11.3

