Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f54.google.com ([74.125.83.54]:41800 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT41 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:27 -0400
Received: by mail-ee0-f54.google.com with SMTP id t10so2403947eei.41
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 30/34] dmesg: add missing initializer [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:45 +0100
Message-Id: <1373226889-3451-31-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/uuidd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index d0ecb95..0427e46 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -480,7 +480,7 @@ int main(int argc, char **argv)
 	const char	*socket_path = UUIDD_SOCKET_PATH;
 	const char	*pidfile_path = NULL;
 	const char	*pidfile_path_param = NULL;
-	const char	*err_context;
+	const char	*err_context = _("unexpected error");
 	char		buf[1024], *cp;
 	char		str[UUID_STR_LEN];
 	uuid_t		uu;
-- 
1.8.3.2

