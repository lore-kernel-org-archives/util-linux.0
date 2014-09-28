Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:60448 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaI1TxH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:07 -0400
Received: by mail-we0-f180.google.com with SMTP id x48so1125314wes.25
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 20/23] libsmartcols: add explicit column flags default
Date: Sun, 28 Sep 2014 20:51:53 +0100
Message-Id: <1411933916-30576-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Useful when initializing without any specific action in mind, or when
reseting flags later on.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libsmartcols/src/libsmartcols.h.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsmartcols/src/libsmartcols.h.in b/libsmartcols/src/libsmartcols.h.in
index e612560..1699a4a 100644
--- a/libsmartcols/src/libsmartcols.h.in
+++ b/libsmartcols/src/libsmartcols.h.in
@@ -78,6 +78,7 @@ enum {
  * Column flags
  */
 enum {
+	SCOLS_FL_DEFAULT     = 0,	   /* use default functionality */
 	SCOLS_FL_TRUNC       = (1 << 0),   /* truncate fields data if necessary */
 	SCOLS_FL_TREE        = (1 << 1),   /* use tree "ascii art" */
 	SCOLS_FL_RIGHT	     = (1 << 2),   /* align to the right */
-- 
2.1.1

