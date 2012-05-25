Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51965 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab2EYSQb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:31 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3u-0007n7-W9 from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:31 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 4/7] login: Include <linux/major.h> only if it exists.
Date: Fri, 25 May 2012 20:16:15 +0200
Message-Id: <1337969778-3154-4-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It isn't required on non-Linux systems.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 login-utils/login.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index f459b79..7384940 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -49,7 +49,9 @@
 #include <stdlib.h>
 #include <sys/syslog.h>
 #include <sys/sysmacros.h>
-#include <linux/major.h>
+#ifdef HAVE_LINUX_MAJOR_H
+# include <linux/major.h>
+#endif
 #include <netdb.h>
 #include <lastlog.h>
 #include <security/pam_appl.h>
-- 
1.7.9

