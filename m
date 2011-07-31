Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:37130 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883Ab1GaKqk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 31 Jul 2011 06:46:40 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH 3/3] mkswap: Use c.h
Date: Sun, 31 Jul 2011 12:47:21 +0200
Message-Id: <1312109241-13590-3-git-send-email-max@stro.at>
In-Reply-To: <1312109241-13590-1-git-send-email-max@stro.at>
References: <1312109241-13590-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fixes mkswap compilation against klibc.

Signed-off-by: maximilian attems <max@stro.at>
---
 disk-utils/mkswap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index a621641..ab16d13 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -41,7 +41,6 @@
 #include <sys/utsname.h>
 #include <sys/stat.h>
 #include <errno.h>
-#include <err.h>
 #include <getopt.h>
 #ifdef HAVE_LIBSELINUX
 #include <selinux/selinux.h>
@@ -57,6 +56,7 @@
 #include "wholedisk.h"
 #include "writeall.h"
 #include "xalloc.h"
+#include "c.h"
 
 #ifdef HAVE_LIBUUID
 # include <uuid.h>
-- 
1.7.5.4

