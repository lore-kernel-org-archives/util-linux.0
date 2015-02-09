Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:53087 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760527AbbBIPLG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 9 Feb 2015 10:11:06 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] setarch: fix typo (missing braces) for ppcle
Date: Mon,  9 Feb 2015 16:11:02 +0100
Message-Id: <1423494662-2658-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1423494662-2658-1-git-send-email-sweet_f_a@gmx.de>
References: <1423494662-2658-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Introduced in 77eb13b9, noticed on ppc64le.

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/setarch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index c8ca5f8..76892ab 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -160,9 +160,9 @@ static int set_arch(const char *pers, unsigned long options, int list)
 		{PER_LINUX,	"ppc64pseries",	"ppc64"},
 		{PER_LINUX,	"ppc64iseries",	"ppc64"},
 # else
-		PER_LINUX32,	"ppc32le",	"ppcle"},
-		PER_LINUX32,	"ppcle",	"ppcle"},
-		PER_LINUX,	"ppc64le",	"ppc64le"},
+		{PER_LINUX32,	"ppc32le",	"ppcle"},
+		{PER_LINUX32,	"ppcle",	"ppcle"},
+		{PER_LINUX,	"ppc64le",	"ppc64le"},
 # endif
 #endif
 #if defined(__x86_64__) || defined(__i386__) || defined(__ia64__)
-- 
1.8.4.5

