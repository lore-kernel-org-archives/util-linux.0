Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:55096 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755961Ab2EYSlY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:41:24 -0400
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org, ludwig.nussel@suse.de
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 1/3] su: Don't include the unused <sys/fsuid.h>.
Date: Fri, 25 May 2012 20:40:59 +0200
Message-Id: <1337971261-20684-2-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
References: <87zk8wboif.fsf@schwinge.name>
 <1337971261-20684-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 login-utils/su.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/login-utils/su.c b/login-utils/su.c
index edd6d10..29042f0 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -81,7 +81,6 @@ enum
 # include <security/pam_misc.h>
 # include <signal.h>
 # include <sys/wait.h>
-# include <sys/fsuid.h>
 #endif
 
 #if HAVE_SYSLOG_H && HAVE_SYSLOG
-- 
1.7.9

