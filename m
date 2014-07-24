Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.187]:60358 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932732AbaGXNbK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 24 Jul 2014 09:31:10 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] mcookie: avoid format warning
Date: Thu, 24 Jul 2014 15:30:54 +0200
Message-Id: <1406208654-7786-1-git-send-email-mail@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

"gcc (SUSE Linux) 4.8.1 20130909 [gcc-4_8-branch revision 202388]"
issued the following warning:

  warning: format ‘%zu’ expects argument of type ‘size_t’, \
  but argument 3 has type ‘int’ [-Wformat=]

* misc-utils/mcookie.c (main): Change format from %zu to %d.
RAND_BYTES is an enum, thus of type int.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 misc-utils/mcookie.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index a46ea0c..c370c2a 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -182,8 +182,8 @@ int main(int argc, char **argv)
 	random_get_bytes(&buf, RAND_BYTES);
 	MD5Update(&ctl.ctx, buf, RAND_BYTES);
 	if (ctl.verbose)
-		fprintf(stderr, P_("Got %zu byte from %s\n",
-				   "Got %zu bytes from %s\n", RAND_BYTES),
+		fprintf(stderr, P_("Got %d byte from %s\n",
+				   "Got %d bytes from %s\n", RAND_BYTES),
 				RAND_BYTES, random_tell_source());
 
 	MD5Final(digest, &ctl.ctx);
-- 
1.8.4.2

