Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f43.google.com ([209.85.220.43]:41048 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3JCJgm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Oct 2013 05:36:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz1so2346134pad.2
        for <util-linux@vger.kernel.org>; Thu, 03 Oct 2013 02:36:41 -0700 (PDT)
From: Michael Forney <mforney@mforney.org>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] Use _POSIX_VERSION to determine support for %m
Date: Thu,  3 Oct 2013 02:36:05 -0700
Message-Id: <1380792968-1176-2-git-send-email-mforney@mforney.org>
In-Reply-To: <1380792968-1176-1-git-send-email-mforney@mforney.org>
References: <1380792968-1176-1-git-send-email-mforney@mforney.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

%m is included in POSIX 2008, so we can check if the libc implements
that before failing.
---
 configure.ac | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index cbcda46..95ff8b3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -430,6 +430,7 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
 
     [AC_COMPILE_IFELSE([AC_LANG_SOURCE([
      #include <stdio.h>
+     #include <unistd.h>
 
      #ifdef __GLIBC__
 
@@ -437,8 +438,13 @@ AC_CACHE_VAL([scanf_cv_alloc_modifier],
      #error %m is not available
      #endif
 
-     #else
+     #elif defined(_POSIX_VERSION)
 
+     #if _POSIX_VERSION < 200809L
+     #error %m is not available
+     #endif
+
+     #else
      #error Your C-library is not supported.
      #endif
      ])],
-- 
1.8.4

