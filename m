Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:38872 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbaEDPuz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:50:55 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so5728546wes.9
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:50:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/15] cytune: add noreturn function attributes
Date: Sun,  4 May 2014 16:49:54 +0100
Message-Id: <1399218596-21321-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
References: <1399218596-21321-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The query_tty_stats() will exit only when it is signaled to stop.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/cytune.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/cytune.c b/sys-utils/cytune.c
index dde793e..c93951d 100644
--- a/sys-utils/cytune.c
+++ b/sys-utils/cytune.c
@@ -120,7 +120,8 @@ static inline double dtime(struct timeval *tvpnew, struct timeval *tvpold)
 	return diff;
 }
 
-static void signal_handler(int sig __attribute__((__unused__)))
+static void __attribute__((__noreturn__))
+signal_handler(int sig __attribute__((__unused__)))
 {
 	struct cyclades_control *cc;
 	int argc, local_optind;
@@ -135,6 +136,7 @@ static void signal_handler(int sig __attribute__((__unused__)))
 			"and the maximum transfer rate in characters/second was %f"),
 		      cc->filename, cc->threshold_value, cc->maxmax, cc->maxtran);
 	}
+	free(cmon);
 	exit(EXIT_SUCCESS);
 }
 
@@ -161,7 +163,8 @@ static void cyg_get_mon(int fd, struct cyclades_monitor *mon, char *file,
 		err(EXIT_FAILURE, _("cannot get timeout for %s"), file);
 }
 
-static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
+static void __attribute__((__noreturn__))
+query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 {
 	struct cyclades_monitor cywork;
 	struct cyclades_control *cc;
@@ -233,9 +236,6 @@ static void query_tty_stats(int argc, char **argv, struct cytune_modifiers *mod)
 			memcpy(&cc->c, &cywork, sizeof(struct cyclades_monitor));
 		}
 	}
-
-	free(cmon);
-	return;
 }
 
 int main(int argc, char **argv)
-- 
1.9.2

