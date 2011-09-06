Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:38532 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753229Ab1IFWk3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 Sep 2011 18:40:29 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH] libuuid: add limits.h include for OPEN_MAX
Date: Wed,  7 Sep 2011 00:41:25 +0200
Message-Id: <1315348885-31997-1-git-send-email-max@stro.at>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Needed as definition for usage in close_all_fds().
Noticed on klibc build.

Signed-off-by: maximilian attems <max@stro.at>
---
 libuuid/src/gen_uuid.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/libuuid/src/gen_uuid.c b/libuuid/src/gen_uuid.c
index f4c8997..492bb75 100644
--- a/libuuid/src/gen_uuid.c
+++ b/libuuid/src/gen_uuid.c
@@ -53,6 +53,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <limits.h>
 #include <sys/types.h>
 #ifdef HAVE_SYS_TIME_H
 #include <sys/time.h>
-- 
1.7.5.4

