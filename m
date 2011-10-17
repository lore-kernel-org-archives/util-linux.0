Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 49/49] login: cosmetic changes in docs
Date: Mon, 17 Oct 2011 13:15:28 +0200
Message-Id: <1318850128-23458-50-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |    4 +++-
 login-utils/login.c |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 54b7562..d9d8333 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -219,9 +219,9 @@ login. The default value is "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin
 .I /etc/motd
 .I /etc/passwd
 .I /etc/nologin
-.I /etc/usertty
 .I /etc/pam.d/login
 .I /etc/pam.d/remote
+.I /etc/hushlogins
 .I .hushlogin
 .fi
 .SH "SEE ALSO"
@@ -254,6 +254,8 @@ Derived from BSD login 5.40 (5/9/89) by Michael Glad (glad@daimi.dk)
 for HP-UX
 .br
 Ported to Linux 0.12: Peter Orbaek (poe@daimi.aau.dk)
+.br
+Rewritten to PAM-only version by Karel Zak (kzak@redhat.com)
 .SH AVAILABILITY
 The login command is part of the util-linux package and is available from
 ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/login-utils/login.c b/login-utils/login.c
index f688307..afdb32e 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -4,6 +4,9 @@
  * This program is derived from 4.3 BSD software and is subject to the
  * copyright notice below.
  *
+ * Copyright (C) 2011 Karel Zak <kzak@redhat.com>
+ * Rewritten to PAM-only version.
+ *
  * Michael Glad (glad@daimi.dk)
  * Computer Science Department, Aarhus University, Denmark
  * 1990-07-04
-- 
1.7.6.4
