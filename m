Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:35383 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030Ab2ITNyB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Sep 2012 09:54:01 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 573EAA30EC
	for <util-linux@vger.kernel.org>; Thu, 20 Sep 2012 15:54:00 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] setterm: make error message more informative
Date: Thu, 20 Sep 2012 15:53:50 +0200
Message-Id: <1348149230-32642-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If `setterm -dump` fails because of lack of permission to read
/dev/vcsa, it should not report that it couldn't read /dev/vcsa0.
This could be misleading if there is only /dev/vcsa, but not /dev/vcsa0.

Before:
$ ./setterm -dump
setterm: Couldn't read /dev/vcsa0

After:
$ ./setterm -dump
setterm: Couldn't read neither /dev/vcsa0 nor /dev/vcsa

(Note: /dev/vcsa0 does not exist and the user does not have read
permission on /dev/vcsa in this case).

Addresses: https://bugzilla.novell.com/show_bug.cgi?id=780615
Reported-by: Christopher Yeleighton <giecrilj@stegny.2a.pl>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 term-utils/setterm.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index a2cf93b..18873f3 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -1208,9 +1208,13 @@ screendump(int vcnum, FILE * F)
 	close(fd);
 	return;
 
-      read_error:
-	warnx(_("Couldn't read %s"), infile);
-      error:
+read_error:
+	if (vcnum != 0)
+		warnx(_("Couldn't read %s"), infile);
+	else
+		warnx(_("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
+
+error:
 	if (fd >= 0)
 		close(fd);
 	exit(EXIT_FAILURE);
-- 
1.7.7

