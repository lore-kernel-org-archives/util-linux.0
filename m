Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51986 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab2EYSQe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:34 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3y-0007nm-2b from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:34 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 6/7] write: Don't explicitly include <asm/param.h>.
Date: Fri, 25 May 2012 20:16:17 +0200
Message-Id: <1337969778-3154-6-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It doesn't exist on some systems, but will come in via <sys/param.h> on the
others.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 term-utils/write.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 901ddc4..9964e08 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -57,7 +57,6 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <paths.h>
-#include <asm/param.h>
 #include <getopt.h>
 
 #include "c.h"
-- 
1.7.9

