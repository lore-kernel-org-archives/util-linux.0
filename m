Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36229 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbbFYP3W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 25 Jun 2015 11:29:22 -0400
Received: by wicnd19 with SMTP id nd19so167552939wic.1
        for <util-linux@vger.kernel.org>; Thu, 25 Jun 2015 08:29:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] script: fix variable initialization warning
Date: Thu, 25 Jun 2015 16:29:18 +0100
Message-Id: <1435246158-32445-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

term-utils/script.c:402:19: warning: obsolete use of designated
initializer without '=' [-Wpedantic]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 769b771..990b4a1 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -399,9 +399,9 @@ static void do_io(struct script_control *ctl)
 
 	};
 	struct pollfd pfd[] = {
-		[POLLFD_SIGNAL]	{ .fd = ctl->sigfd,   .events = POLLIN | POLLERR | POLLHUP },
-		[POLLFD_MASTER]	{ .fd = ctl->master,  .events = POLLIN | POLLERR | POLLHUP },
-		[POLLFD_STDIN]	{ .fd = STDIN_FILENO, .events = POLLIN | POLLERR | POLLHUP }
+		[POLLFD_SIGNAL] = { .fd = ctl->sigfd,   .events = POLLIN | POLLERR | POLLHUP },
+		[POLLFD_MASTER] = { .fd = ctl->master,  .events = POLLIN | POLLERR | POLLHUP },
+		[POLLFD_STDIN]	= { .fd = STDIN_FILENO, .events = POLLIN | POLLERR | POLLHUP }
 	};
 
 
-- 
2.4.4

