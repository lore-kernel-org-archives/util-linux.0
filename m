Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33729 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754662AbcKJK7d (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 10 Nov 2016 05:59:33 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so2346021wmu.0
        for <util-linux@vger.kernel.org>; Thu, 10 Nov 2016 02:59:33 -0800 (PST)
Subject: [PATCH 03/12] Correctly format page cross references
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Cc: mtk.manpages@gmail.com
From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <3dd9ec95-9b81-4a60-7001-c62455346af3@gmail.com>
Date: Thu, 10 Nov 2016 11:59:30 +0100
MIME-Version: 1.0
In-Reply-To: <bda22bd7-a108-f6c8-04b1-ecab7ba82084@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most pages in util-linux follow the standard convention
of formatting page cross references in bold. Fix the
few exceptions that use italic.

Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
---
 login-utils/chfn.1  | 2 +-
 login-utils/login.1 | 2 +-
 sys-utils/mount.8   | 2 +-
 text-utils/pg.1     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/login-utils/chfn.1 b/login-utils/chfn.1
index 0cb5f28..bf837ea 100644
--- a/login-utils/chfn.1
+++ b/login-utils/chfn.1
@@ -72,7 +72,7 @@ Display version information and exit.
 .SH CONFIG FILE ITEMS
 .B chfn
 reads the
-.IR /etc\:/login.defs (5)
+.BR /etc\:/login.defs (5)
 configuration file.  Note that the configuration file could be
 distributed with another package (e.g. shadow-utils).  The following
 configuration items are relevant for
diff --git a/login-utils/login.1 b/login-utils/login.1
index eaa644d..551d3b2 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -136,7 +136,7 @@ Display version information and exit.
 .SH CONFIG FILE ITEMS
 .B login
 reads the
-.IR /etc\:/login.defs (5)
+.BR /etc\:/login.defs (5)
 configuration file.  Note that the configuration file could be
 distributed with another package (e.g. shadow-utils).  The following
 configuration items are relevant for
diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 26bd449..beef622 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -780,7 +780,7 @@ and
 For most types all the
 .B mount
 program has to do is issue a simple
-.IR mount (2)
+.BR mount (2)
 system call, and no detailed knowledge of the filesystem type is required.
 For a few types however (like nfs, nfs4, cifs, smbfs, ncpfs) an ad hoc code is
 necessary.  The nfs, nfs4, cifs, smbfs, and ncpfs filesystems
diff --git a/text-utils/pg.1 b/text-utils/pg.1
index d67adf4..c3cc7a5 100644
--- a/text-utils/pg.1
+++ b/text-utils/pg.1
@@ -25,7 +25,7 @@ reads from standard input.
 If standard output is not a terminal,
 .B pg
 acts like
-.IR cat (1)
+.BR cat (1)
 but precedes each file with its name if there is more than one.
 .PP
 If input comes from a pipe,
@@ -206,7 +206,7 @@ Overrides the system-supplied number of columns if set.
 .TP
 .BR LANG ,\  LC_ALL ,\  LC_COLLATE ,\  LC_CTYPE ,\  LC_MESSAGES
 See
-.IR locale (7).
+.BR locale (7).
 .TP
 .B LINES
 Overrides the system-supplied number of lines if set.
-- 
2.5.5


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
