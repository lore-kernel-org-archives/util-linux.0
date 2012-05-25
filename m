Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51989 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2EYSQg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:36 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3z-000008-TJ from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:36 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 7/7] setsid: Include <sys/ioctl.h> instead of <termio.h>.
Date: Fri, 25 May 2012 20:16:18 +0200
Message-Id: <1337969778-3154-7-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 sys-utils/setsid.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 6d1eeda..52ad38f 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -15,7 +15,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include <termio.h>
+#include <sys/ioctl.h>
 
 #include "c.h"
 #include "nls.h"
-- 
1.7.9

