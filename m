Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45005 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751476AbbBMS7Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Feb 2015 13:59:25 -0500
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 86564AC7B
	for <util-linux@vger.kernel.org>; Fri, 13 Feb 2015 18:59:23 +0000 (UTC)
Message-ID: <54DE498A.80604@suse.cz>
Date: Fri, 13 Feb 2015 19:59:22 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] script.1: Improve documentation of non-interactive behavior
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

- use exit in .profile to avoid non-logged session after typing "exit"
- document that script can read more from stdin than the command inside:

echo -e 'script -c "read a b ; echo a=\$a b=\$b >defs.sh"\n1 2\necho Done' | sh
Script started, file is typescript
1 2
echo Done
Script done, file is typescript
---
 term-utils/script.1 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/term-utils/script.1 b/term-utils/script.1
index e130c77..6b566fe 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -128,7 +128,8 @@ in non-interactive shells. The inner shell of
 .B script
 is always interactive, and this could lead to unexpected results. If you use
 .B script
-in the shell initialization file (profile), you should use e. g.
+in the shell initialization file, you have to avoid entering an infinite
+loop. Use e. g. profile file, which is read by login shells only:
 .RS
 .RE
 .sp
@@ -137,10 +138,15 @@ in the shell initialization file (profile), you should use e. g.
 .nf
 if test -t 0 ; then
     script
+    exit
 fi
 .fi
 .RE
 .PP
+You should also avoid use of script in command pipes, as
+.B script
+can read more input than you would expect.
+.PP
 .SH ENVIRONMENT
 The following environment variable is utilized by
 .BR script :
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
