Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:55098 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2EYSl0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:41:26 -0400
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org, ludwig.nussel@suse.de
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 2/3] su: Add AM_LDFLAGS to su_LDFLAGS.
Date: Fri, 25 May 2012 20:41:00 +0200
Message-Id: <1337971261-20684-3-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
References: <87zk8wboif.fsf@schwinge.name>
 <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 login-utils/Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 60e6f10..d376234 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -89,7 +89,7 @@ su_CFLAGS = -DUSE_PAM=1 $(SUID_CFLAGS) $(AM_CFLAGS)
 chfn_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chsh_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 newgrp_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
-su_LDFLAGS = $(SUID_LDFLAGS)
+su_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 
 login_ldadd_common += -lpam -lpam_misc
 
-- 
1.7.9

