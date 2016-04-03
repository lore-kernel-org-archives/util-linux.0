Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f193.google.com ([209.85.217.193]:33787 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110AbcDCIfi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Apr 2016 04:35:38 -0400
Received: by mail-lb0-f193.google.com with SMTP id bc4so16129619lbc.0
        for <util-linux@vger.kernel.org>; Sun, 03 Apr 2016 01:35:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] chrt: validate priority before trying to use it
Date: Sun,  3 Apr 2016 09:35:29 +0100
Message-Id: <1459672529-2278-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier message:

$ chrt -i 1 ls
chrt: failed to set pid 0's policy: Invalid argument

basically told 'something failed', while the new one tries to be more
helpful.

$ chrt -i 1 ls
chrt: unsupported priority value for the policy: 1: see --max for valid range

Addresses: https://bugs.debian.org/791707
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 schedutils/chrt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 64a5858..202ce25 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -504,7 +504,11 @@ int main(int argc, char **argv)
 #endif
 	if (ctl->pid == -1)
 		ctl->pid = 0;
-
+	if (ctl->priority < sched_get_priority_min(ctl->policy) ||
+	    sched_get_priority_max(ctl->policy) < ctl->priority)
+		errx(EXIT_FAILURE,
+		     _("unsupported priority value for the policy: %d: see --max for valid range"),
+		     ctl->priority);
 	set_sched(ctl);
 
 	if (ctl->verbose)
-- 
2.8.0

