Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:49284 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829AbbBKOHy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 11 Feb 2015 09:07:54 -0500
Message-ID: <54DB6238.5080306@suse.cz>
Date: Wed, 11 Feb 2015 15:07:52 +0100
From: Stanislav Brabec <sbrabec@suse.cz>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/3] script: no logging for non-interactive shells
References: <54DA787B.4090205@suse.cz> <20150211100528.GA32133@ws.net.home>
In-Reply-To: <20150211100528.GA32133@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> Would be better to learn people to fix their shell initialization
> files to not call script(1) for non-interactive sessions?

It makes sense.

>From 8fff32e65399ae07f70e12568d4d5278725673a7 Mon Sep 17 00:00:00 2001
From: Stanislav Brabec <sbrabec@suse.cz>
Date: Wed, 11 Feb 2015 15:02:10 +0100
Subject: [PATCH] script.1: Document behavior in non-interactive shells

And discourage users from such use.
---
 term-utils/script.1 | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/term-utils/script.1 b/term-utils/script.1
index 4573f07..f32030c 100644
--- a/term-utils/script.1
+++ b/term-utils/script.1
@@ -121,6 +121,26 @@ create garbage in the typescript file.
 .B script
 works best with commands that do not manipulate the screen, the results are
 meant to emulate a hardcopy terminal.
+.PP
+It is not recommended to run
+.B script
+in non-interactive shells. The inner shell of
+.B script
+is always interactive, and this could lead to unexpected results. If you use
+.B script
+in the shell initialization file (profile), you should use e. g.
+.RS
+.RE
+.sp
+.na
+.RS
+.nf
+if test -t 0 ; then
+    script
+fi
+.fi
+.RE
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
