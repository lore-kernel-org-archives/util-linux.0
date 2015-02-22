Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:42666 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbBVOnX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:23 -0500
Received: by wesw62 with SMTP id w62so13568097wes.9
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/12] script: add noreturn function attributes
Date: Sun, 22 Feb 2015 14:42:49 +0000
Message-Id: <1424616169-693-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 54e10b4..e15ea38 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -172,7 +172,7 @@ static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 	exit(EXIT_SUCCESS);
 }
 
-static void fail(struct script_control *ctl)
+static void __attribute__((__noreturn__)) fail(struct script_control *ctl)
 {
 	kill(0, SIGTERM);
 	done(ctl);
@@ -336,7 +336,7 @@ static void getslave(struct script_control *ctl)
 	ioctl(ctl->slave, TIOCSCTTY, 0);
 }
 
-static void doshell(struct script_control *ctl)
+static void __attribute__((__noreturn__)) doshell(struct script_control *ctl)
 {
 	char *shname;
 
-- 
2.3.0

