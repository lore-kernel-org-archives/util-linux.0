Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38126 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577Ab2HDHdj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 4 Aug 2012 03:33:39 -0400
Received: by wibhm11 with SMTP id hm11so199123wib.1
        for <util-linux@vger.kernel.org>; Sat, 04 Aug 2012 00:33:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/5] vipw: make vim writebackup mode work
Date: Sat,  4 Aug 2012 09:33:40 +0200
Message-Id: <1344065620-17480-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
References: <1344065620-17480-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some editors, such as Vim with 'writebackup' mode enabled, use "atomic
save" in which the old file is deleted and a new one with the same name
created in its place.  The vipw tries to detect if such happen by
looking hard temporary file link count, when it is zero reopen
temporary file by using it's path.

Reported-by: Mantas Mikulėnas <grawity@gmail.com>
References: http://www.spinics.net/lists/util-linux-ng/msg06666.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index ed3f43b..1eeeb0d 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -275,6 +275,18 @@ static void edit_file(int is_shadow)
 
 	if (fstat(fileno(tmp_fd), &end))
 		pw_error(tmp_file, 1, 1);
+	/* Some editors, such as Vim with 'writebackup' mode enabled,
+	 * use "atomic save" in which the old file is deleted and a new
+	 * one with the same name created in its place.  */
+	if (end.st_nlink == 0) {
+		if (close_stream(tmp_fd) != 0)
+			err(EXIT_FAILURE, _("write error"));
+		tmp_fd = fopen(tmp_file, "r");
+		if (!tmp_file)
+			err(EXIT_FAILURE, _("cannot open %s"), tmp_file);
+		if (fstat(fileno(tmp_fd), &end))
+			pw_error(tmp_file, 1, 1);
+	}
 	if (begin.st_mtime == end.st_mtime) {
 		warnx(_("no changes made"));
 		pw_error((char *)NULL, 0, 0);
-- 
1.7.11.4

