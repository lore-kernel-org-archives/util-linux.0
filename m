Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:63583 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab2DKSmP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 Apr 2012 14:42:15 -0400
Received: by eekc41 with SMTP id c41so315954eek.19
        for <util-linux@vger.kernel.org>; Wed, 11 Apr 2012 11:42:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] eject: verify writing to streams was successful
Date: Wed, 11 Apr 2012 20:41:56 +0200
Message-Id: <1334169716-2552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 5aec0ba..e008886 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -46,6 +46,7 @@
 #include <libmount.h>
 
 #include "c.h"
+#include "closestream.h"
 #include "nls.h"
 #include "strutils.h"
 #include "xalloc.h"
@@ -921,6 +922,7 @@ int main(int argc, char **argv)
 	setlocale(LC_ALL,"");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
+	atexit(close_stdout);
 
 	/* parse the command line arguments */
 	parse_args(argc, argv, &device);
-- 
1.7.10

