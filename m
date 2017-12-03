Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41011 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdLCMvW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Dec 2017 07:51:22 -0500
Received: by mail-wr0-f195.google.com with SMTP id z18so14464038wrb.8
        for <util-linux@vger.kernel.org>; Sun, 03 Dec 2017 04:51:21 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] vipw: do not let editor to inherit open file descriptors
Date: Sun,  3 Dec 2017 12:51:14 +0000
Message-Id: <20171203125117.28159-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index b7650de8b..9b7696942 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -257,7 +257,7 @@ static void edit_file(int is_shadow)
 	if (lckpwdf() < 0)
 		err(EXIT_FAILURE, _("cannot get lock"));
 
-	passwd_file = open(orig_file, O_RDONLY, 0);
+	passwd_file = open(orig_file, O_RDONLY | O_CLOEXEC, 0);
 	if (passwd_file < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), orig_file);
 	tmp_fd = pw_tmpfile(passwd_file);
@@ -275,7 +275,7 @@ static void edit_file(int is_shadow)
 	if (end.st_nlink == 0) {
 		if (close_stream(tmp_fd) != 0)
 			err(EXIT_FAILURE, _("write error"));
-		tmp_fd = fopen(tmp_file, "r");
+		tmp_fd = fopen(tmp_file, "r" UL_CLOEXECSTR);
 		if (!tmp_fd)
 			err(EXIT_FAILURE, _("cannot open %s"), tmp_file);
 		if (fstat(fileno(tmp_fd), &end))
-- 
2.15.1

