Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:33281 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:31 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so3656256wgh.12
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/33] setsid: exit when control terminal cannot be set
Date: Sat, 13 Apr 2013 20:54:37 +0100
Message-Id: <1365882901-11429-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setsid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index b3e6ebf..756a520 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 
 	if (ctty) {
 		if (ioctl(STDIN_FILENO, TIOCSCTTY, 1))
-			warn(_("failed to set the controlling terminal"));
+			err(EXIT_FAILURE, _("failed to set the controlling terminal"));
 	}
 	execvp(argv[optind], argv + optind);
 	err(EXIT_FAILURE, _("failed to execute %s"), argv[optind]);
-- 
1.8.2.1

