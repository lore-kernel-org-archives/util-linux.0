Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37808 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdIKT5Y (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Sep 2017 15:57:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so7679563wmh.4
        for <util-linux@vger.kernel.org>; Mon, 11 Sep 2017 12:57:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] partx: fix memory leak [asan]
Date: Mon, 11 Sep 2017 20:57:17 +0100
Message-Id: <20170911195717.817-4-kerolasa@iki.fi>
In-Reply-To: <20170911195717.817-1-kerolasa@iki.fi>
References: <20170911195717.817-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/partx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 43a6448db..0d66abadb 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -1054,6 +1054,8 @@ int main(int argc, char **argv)
 	if (loopdev)
 		loopcxt_deinit(&lc);
 
+	free(wholedisk);
+
 	if (close_fd(fd) != 0)
 		err(EXIT_FAILURE, _("write failed"));
 
-- 
2.14.1

