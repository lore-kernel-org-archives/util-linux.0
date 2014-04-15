Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:51102 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754308AbaDOLQE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:16:04 -0400
Received: by mail-wi0-f173.google.com with SMTP id z2so5474044wiv.6
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:16:03 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 9/9] lib/procutils: reset errno before strtol() call
Date: Tue, 15 Apr 2014 12:15:35 +0100
Message-Id: <1397560535-14622-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When going through /proc the last entry made readdir() to alter errno,
which made the strtol() to think something went wrong, resulting kill(1)
tests to fail when running in --parallel mode.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/procutils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/procutils.c b/lib/procutils.c
index d633261..31b77ff 100644
--- a/lib/procutils.c
+++ b/lib/procutils.c
@@ -86,7 +86,7 @@ int proc_next_tid(struct proc_tasks *tasks, pid_t *tid)
 
 		if (!isdigit((unsigned char) *d->d_name))
 			continue;
-
+		errno = 0;
 		*tid = (pid_t) strtol(d->d_name, &end, 10);
 		if (errno || d->d_name == end || (end && *end))
 			return -1;
@@ -183,6 +183,7 @@ int proc_next_pid(struct proc_processes *ps, pid_t *pid)
 		}
 
 		p = NULL;
+		errno = 0;
 		*pid = (pid_t) strtol(d->d_name, &p, 10);
 		if (errno || d->d_name == p || (p && *p))
 			return errno ? -errno : -1;
-- 
1.9.2

