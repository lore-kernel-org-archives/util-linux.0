Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47772 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759517Ab1IJRGN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 10 Sep 2011 13:06:13 -0400
Received: by fxd22 with SMTP id 22so1651907fxd.19
        for <util-linux@vger.kernel.org>; Sat, 10 Sep 2011 10:06:12 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: fdformat: fix uninitialized variable
Date: Sat, 10 Sep 2011 19:06:09 +0200
Message-Id: <1315674369-31253-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Spotted by EKOPath compiler.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 disk-utils/fdformat.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index 670242f..29782ec 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -106,7 +106,7 @@ int main(int argc, char **argv)
 {
 	int ch;
 	int ctrl;
-	int verify;
+	int verify = 1;
 	struct stat st;
 
 	static const struct option longopts[] = {
-- 
1.7.3.4

