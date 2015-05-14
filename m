Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45823 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161032AbbENPz6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 May 2015 11:55:58 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 26BE1AC5D
	for <util-linux@vger.kernel.org>; Thu, 14 May 2015 15:55:57 +0000 (UTC)
Message-ID: <5554C58C.5080004@suse.cz>
Date: Thu, 14 May 2015 17:55:56 +0200
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] script: Fix mangled EOF and hang on big endian
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On s390 and other big endian machines, doinput() sends NUL instead of
EOF to the tty master. NUL does not even reach the slave, and it is
waiting for more data forever.

If STDIN is not a tty, the bug caused "^@" being into the log, and since
commit 032228c it also causes hang.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 term-utils/script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 02ba596..e0083f2 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -377,9 +377,9 @@ doinput(void) {
 		 * We usually use this when stdin is not a tty, for example:
 		 * echo "ps" | script
 		 */
-		int c = DEF_EOF;
+		char c = DEF_EOF;
 
-		if (write_all(master, &c, 1)) {
+		if (write_all(master, &c, sizeof(char))) {
 			warn (_("write failed"));
 			fail();
 		}
-- 
2.3.7

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
