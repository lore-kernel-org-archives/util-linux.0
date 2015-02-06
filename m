Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40334 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753666AbbBFS7Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Feb 2015 13:59:16 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id BAB28ABE1
	for <util-linux@vger.kernel.org>; Fri,  6 Feb 2015 18:59:14 +0000 (UTC)
Message-ID: <54D50F02.4000709@suse.cz>
Date: Fri, 06 Feb 2015 19:59:14 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: [PATCH] Fix "Script started" buffering race
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

script -c "echo Hallo World" </dev/null >script.log ; cat script.log

Before:
Hallo World
Script started, file is typescript
Script started, file is typescript
Script done, file is typescript

After:
Script started, file is typescript
Hallo World
Script done, file is typescript
---
 term-utils/script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/term-utils/script.c b/term-utils/script.c
index 548334c..02ba596 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -269,6 +269,7 @@ main(int argc, char **argv) {
 	sigprocmask(SIG_SETMASK, NULL, &block_mask);
 	sigaddset(&block_mask, SIGCHLD);
 
+	fflush(stdout);
 	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
 	child = fork();
 	sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
-- 
2.2.2

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
