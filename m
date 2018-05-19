Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.hi.is ([130.208.165.104]:38982 "EHLO mx2.hi.is"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeESAKB (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 18 May 2018 20:10:01 -0400
Received: from hekla.rhi.hi.is (hekla.rhi.hi.is [IPv6:2a00:c88:4000:1650::165:2])
        by mx2.hi.is (8.14.7/8.14.7) with ESMTP id w4J09uuw013837
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <util-linux@vger.kernel.org>; Sat, 19 May 2018 00:09:58 GMT
Received: from hekla.rhi.hi.is (localhost [127.0.0.1])
        by hekla.rhi.hi.is (8.14.4/8.14.4) with ESMTP id w4J09unF032236
        for <util-linux@vger.kernel.org>; Sat, 19 May 2018 00:09:56 GMT
Received: (from bjarniig@localhost)
        by hekla.rhi.hi.is (8.14.4/8.14.4/Submit) id w4J09uxL032235
        for util-linux@vger.kernel.org; Sat, 19 May 2018 00:09:56 GMT
Date: Sat, 19 May 2018 00:09:56 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: util-linux@vger.kernel.org
Subject: [PATCH] man: Change the only argument to two for the two-fonts macros
Message-ID: <20180519000956.GA32228@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

  Punctuation marks have been left in the only argument of two-fonts
macros, instead of being separated from it to make the second one.

Signed-off-by: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
---
 login-utils/chfn.1   | 4 ++--
 login-utils/chsh.1   | 2 +-
 misc-utils/mcookie.1 | 2 +-
 term-utils/setterm.1 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 58262d4b9..c7130c47e 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -97,9 +97,9 @@ This is the default.
 .SH "EXIT STATUS"
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
 .SH "SEE ALSO"
-.BR chsh(1),
+.BR chsh (1),
 .BR finger (1),
-.BR login.defs(5),
+.BR login.defs (5),
 .BR passwd (5)
 .SH AUTHOR
 Salvatore Valente <svalente@mit.edu>
diff --git a/login-utils/chsh.1 b/login-utils/chsh.1
index c03ef65e5..c955b05d8 100644
--- a/login-utils/chsh.1
+++ b/login-utils/chsh.1
@@ -55,7 +55,7 @@ only accept shells listed in this file, unless you are root.
 Returns 0 if operation was successful, 1 if operation failed or command syntax was not valid.
 .SH "SEE ALSO"
 .BR login (1),
-.BR login.defs(5),
+.BR login.defs (5),
 .BR passwd (5),
 .BR shells (5)
 .SH AUTHOR
diff --git a/misc-utils/mcookie.1 b/misc-utils/mcookie.1
index 254157902..1ac50ef13 100644
--- a/misc-utils/mcookie.1
+++ b/misc-utils/mcookie.1
@@ -17,7 +17,7 @@ system.  Typical usage:
 .PP
 The "random" number generated is actually the MD5 message
 digest of random information coming from one of the sources
-.IR "getrandom() "
+.IR getrandom ()
 system call,
 .IR /dev/urandom ,
 .IR /dev/random ,
diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 07495c5e7..88e118934 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -179,7 +179,7 @@ Makes the terminal continue on a new line when a line is full.
 .TP
 .BR \-\-msg " [" on | off "]  (virtual consoles only)"
 Enables or disables the sending of kernel
-.BR printk()
+.BR printk ()
 messages to the console.
 .TP
 \fB\-\-msglevel\fP \fB0-8\fP  (virtual consoles only)
-- 
2.17.0


-- 
Bjarni I. Gislason
