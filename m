Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:52087 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTeG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:34:06 -0400
Received: by mail-wg0-f43.google.com with SMTP id f12so6030591wgh.34
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:34:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/14] docs: col.1: fix manual page name section [checkmans.sh]
Date: Mon,  8 Apr 2013 20:32:55 +0100
Message-Id: <1365449579-13238-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ lexgrog text-utils/col.1
text-utils/col.1: parse failed

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/col.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/col.1 b/text-utils/col.1
index 9efc72f..2b36c85 100644
--- a/text-utils/col.1
+++ b/text-utils/col.1
@@ -35,7 +35,7 @@
 .\"     @(#)col.1	6.8 (Berkeley) 6/17/91
 .\"
 .TH COL "1" "September 2011" "util-linux" "User Commands"
-.SH COL
+.SH NAME
 col - filter reverse line feeds from input
 .SH SYNOPSIS
 .B col
-- 
1.8.2.1

