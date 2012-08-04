Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:63892 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab2HDHdi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 03:33:38 -0400
Received: by wibhr14 with SMTP id hr14so198936wib.1
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 00:33:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/5] build-sys: add files make check generates in gitignore
Date: Sat,  4 Aug 2012 09:33:39 +0200
Message-Id: <1344065620-17480-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The config/test-driver appears at automake stage, rest after running
'make check'.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index 8a740e3..7628dda 100644
--- a/.gitignore
+++ b/.gitignore
@@ -44,6 +44,10 @@ tags
 .version
 .dirstamp
 config/ltmain.sh
+config/test-driver
+test-suite.log
+tests/run-nonroot.sh.log
+tests/run-nonroot.sh.trs
 
 # libuuid depends on AX_TLS macro
 !m4/tls.m4
-- 
1.7.11.4

