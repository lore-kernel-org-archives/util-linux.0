Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60681 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1FHWxm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jun 2011 18:53:42 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so829962iwn.19
        for <util-linux@vger.kernel.org>; Wed, 08 Jun 2011 15:53:42 -0700 (PDT)
From: Josiah Worcester <josiahw@gmail.com>
To: util-linux@vger.kernel.org
Cc: Josiah Worcester <josiahw@gmail.com>
Subject: [PATCH 3/6] checktty: Use NGROUPS_MAX instead of NGROUPS
Date: Wed,  8 Jun 2011 16:52:45 -0600
Message-Id: <1307573568-23643-4-git-send-email-josiahw@gmail.com>
In-Reply-To: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
References: <1307573568-23643-1-git-send-email-josiahw@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Josiah Worcester <josiahw@gmail.com>
---
 login-utils/checktty.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/checktty.c b/login-utils/checktty.c
index 518b701..a8c5247 100644
--- a/login-utils/checktty.c
+++ b/login-utils/checktty.c
@@ -42,7 +42,7 @@
 #define TTY_MAJOR 4
 #endif
 
-static gid_t mygroups[NGROUPS];
+static gid_t mygroups[NGROUPS_MAX];
 static int   num_groups;
 
 #define NAMELEN 128
@@ -83,7 +83,7 @@ am_in_group(char *group)
 static void
 find_groups(gid_t defgrp, const char *user)
 {
-	num_groups = getgroups(NGROUPS, mygroups);
+	num_groups = getgroups(NGROUPS_MAX, mygroups);
 }
 
 static struct ttyclass *
-- 
1.7.5.3

