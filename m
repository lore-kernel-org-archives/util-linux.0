Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:37184 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758144Ab3AIWoQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Jan 2013 17:44:16 -0500
Received: by mail-wg0-f51.google.com with SMTP id gg4so1259106wgb.18
        for <util-linux@vger.kernel.org>; Wed, 09 Jan 2013 14:44:14 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] build-sys: ignore chkdupexe
Date: Wed,  9 Jan 2013 22:44:05 +0000
Message-Id: <1357771446-11966-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
References: <1357771446-11966-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index db148ba..c3b9a8b 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -2,3 +2,4 @@ uuidd.8
 uuidd.rc
 uuidd.service
 uuidd.socket
+/chkdupexe
-- 
1.8.1

