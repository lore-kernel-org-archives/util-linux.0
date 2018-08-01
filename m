Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51175 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730995AbeHAXOc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Aug 2018 19:14:32 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so192075wmc.0
        for <util-linux@vger.kernel.org>; Wed, 01 Aug 2018 14:26:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] mesg: do not print 'ttyname failed' message unless --verbose requested
Date: Wed,  1 Aug 2018 22:26:44 +0100
Message-Id: <20180801212644.1652-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Lots of people are confused why mesg(1) is priting this message.  Usual
cause seems to be an uninteractive shell trying to turn running 'mesg n'
from a /root/.profile where command invocation is by default on debian based
systems.  This might be rare case when failing silently is better.

Reference: https://www.google.com/search?q=mesg+ttyname+failed
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/mesg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 8714ad1aa..7c4e390bb 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -121,8 +121,11 @@ int main(int argc, char *argv[])
 	argc -= optind;
 	argv += optind;
 
-	if ((tty = ttyname(STDERR_FILENO)) == NULL)
-		err(MESG_EXIT_FAILURE, _("ttyname failed"));
+	if ((tty = ttyname(STDERR_FILENO)) == NULL) {
+		if (verbose == TRUE)
+			err(MESG_EXIT_FAILURE, _("ttyname failed"));
+		exit(MESG_EXIT_FAILURE);
+	}
 	if ((fd = open(tty, O_RDONLY)) < 0)
 		err(MESG_EXIT_FAILURE, _("cannot open %s"), tty);
 	if (fstat(fd, &sb))
-- 
2.18.0

