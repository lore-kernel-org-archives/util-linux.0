Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:45028 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab3ASAOa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:14:30 -0500
Received: by mail-wi0-f175.google.com with SMTP id hm11so5652098wib.14
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:14:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/22] build-sys: add gcov files to .gitignore
Date: Sat, 19 Jan 2013 00:08:50 +0000
Message-Id: <1358554151-25985-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitignore b/.gitignore
index e85eb07..5a62721 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,9 @@
 *.la
 *.so.*
 *.pc
+*.gcda
+*.gcno
+*.gcov
 Makefile
 aclocal.m4
 autom4te.cache
-- 
1.8.1.1

