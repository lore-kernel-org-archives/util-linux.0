Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:51649 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755960AbaGIPUP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jul 2014 11:20:15 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] build-sys: improve the informative message when not building some util
Date: Wed,  9 Jul 2014 17:20:10 +0200
Message-Id: <1404919210-11737-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 m4/ul.m4 |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/m4/ul.m4 b/m4/ul.m4
index b8a5390..fb0dd85 100644
--- a/m4/ul.m4
+++ b/m4/ul.m4
@@ -148,7 +148,7 @@ AC_DEFUN([UL_REQUIRES_LINUX], [
     check:yes)
       [build_]suffix=yes ;;
     check:*)
-      AC_MSG_WARN([non-linux system; do not build $1])
+      AC_MSG_WARN([non-linux system; not building $1])
       [build_]suffix=no ;;
     esac
   fi
@@ -175,7 +175,7 @@ AC_DEFUN([UL_EXCLUDE_ARCH], [
     yes:*)
       [build_]suffix=yes ;;
     check:$2)
-      AC_MSG_WARN([exclude for $host architecture; do not build $1])
+      AC_MSG_WARN([excluded for $host architecture; not building $1])
       [build_]suffix=no ;;
     check:*)
       [build_]suffix=yes ;;
@@ -217,7 +217,7 @@ AC_DEFUN([UL_REQUIRES_HAVE], [
     check:yes)
       [build_]suffix=yes ;;
     check:*)
-      AC_MSG_WARN([$3 not found; do not build $1])
+      AC_MSG_WARN([$3 not found; not building $1])
       [build_]suffix=no ;;
     esac
   fi
@@ -275,7 +275,7 @@ AC_DEFUN([UL_REQUIRES_BUILD], [
     check:yes)
       [build_]suffix=yes ;;
     check:*)
-      AC_MSG_WARN([$2 disabled; do not build $1])
+      AC_MSG_WARN([$2 disabled; not building $1])
       [build_]suffix=no ;;
     esac
   fi
@@ -315,7 +315,7 @@ AC_DEFUN([UL_REQUIRES_SYSCALL_CHECK], [
       yes:no)
         AC_MSG_ERROR([$1 selected but callname syscall not found]) ;;
       check:no)
-        AC_MSG_WARN([callname syscall not found; do not build $1])
+        AC_MSG_WARN([callname syscall not found; not building $1])
         [build_]suffix=no ;;
       *)
         dnl default $ul_cv_syscall_ is SYS_ value
-- 
1.7.0.4

