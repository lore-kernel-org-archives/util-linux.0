Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:57414 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbaGIUtL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 16:49:11 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so7940953wgh.2
        for <util-linux@vger.kernel.org>; Wed, 09 Jul 2014 13:49:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] kill: use --queue option argument as sigval integer value
Date: Wed,  9 Jul 2014 21:49:03 +0100
Message-Id: <1404938943-2543-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1404938943-2543-1-git-send-email-kerolasa@iki.fi>
References: <1404938943-2543-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The sigqueue(3) takes two values, signal and sigval.  Contents of the
signal can be altered with --signal option argument, so the --queue
argument should be reserved to affect sigval_int.

This is regression fix introduced by commit
9e8dffd5cd29f03029b1ac99eecb129532ca5c0f.

Reference: http://man7.org/linux/man-pages/man3/sigqueue.3.html
Reported-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c     | 4 +---
 tests/ts/kill/options | 4 ++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index f2362c3..2f89427 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -412,9 +412,7 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
 			argc--, argv++;
 			arg = *argv;
-			if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
-				err_nosig(arg);
-			ctl->sigdata.sival_int = ctl->numsig;
+			ctl->sigdata.sival_int = strtos32_or_err(arg, _("argument error"));
 			ctl->use_sigval = 1;
 			continue;
 		}
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
index 6cdaa24..5af78d9 100755
--- a/tests/ts/kill/options
+++ b/tests/ts/kill/options
@@ -51,8 +51,8 @@ try_option -s 1
 try_option --signal 1
 try_option --signal HUP
 try_option --signal SIGHUP
-try_option -q HUP
-try_option --queue HUP
+try_option -s 1 -q 42
+try_option -s 1 --queue 42
 try_option -1
 try_option -HUP
 try_option -SIGHUP
-- 
2.0.1

