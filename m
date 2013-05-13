Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3-g21.free.fr ([212.27.42.3]:36930 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754793Ab3EMOvW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 May 2013 10:51:22 -0400
From: Gilles Espinasse <g.esp@free.fr>
To: util-linux@vger.kernel.org
Cc: Gilles Espinasse <g.esp@free.fr>
Subject: =?UTF-8?q?=5BPATCH=5D=20util-linux=20minor=20typo=20fixes?=
Date: Mon, 13 May 2013 16:51:08 +0200
Message-Id: <1368456668-18523-1-git-send-email-g.esp@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gilles Espinasse <g.esp@free.fr>
---
 Documentation/releases/v2.23-ReleaseNotes |    2 +-
 configure.ac                              |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/releases/v2.23-ReleaseNotes b/Documentation/releases/v2.23-ReleaseNotes
index 7e9ed88..ce07ac1 100644
--- a/Documentation/releases/v2.23-ReleaseNotes
+++ b/Documentation/releases/v2.23-ReleaseNotes
@@ -150,7 +150,7 @@ bash-completion:
    - Don't offer any more completions after help or version.  [Ville Skyttä]
    - Don't offer short options where corresponding long one exists.  [Ville Skyttä]
    - Symlink runuser symlink to su so it gets loaded on demand.  [Ville Skyttä]
-   - add bash completetion configure option  [Sami Kerola]
+   - add bash completion configure option  [Sami Kerola]
    - add completion files to Makefile.am  [Sami Kerola]
    - add swapoff  [Bernhard Voelker]
    - disk-utils  [Sami Kerola]
diff --git a/configure.ac b/configure.ac
index dad0439..4050fe4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1308,7 +1308,7 @@ AM_CONDITIONAL(BUILD_SETTERM, test "x$build_setterm" = xyes)
 
 
 AC_ARG_ENABLE([schedutils],
-  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, teskset]),
+  AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, taskset]),
   [], enable_schedutils=yes
 )
 UL_BUILD_INIT([schedutils])
-- 
1.7.2.5

