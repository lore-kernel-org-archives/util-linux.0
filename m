Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:64035 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMTzx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:53 -0400
Received: by mail-we0-f172.google.com with SMTP id r3so2764980wey.31
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/33] include: add close_fd() for noticing write errors before close()
Date: Sat, 13 Apr 2013 20:54:44 +0100
Message-Id: <1365882901-11429-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Essentially this helper function is similar to close_stream(), but for
file descriptors.

When a file descriptors are close()'d status of write is often
overlooked.  The close_fd() will try to determine what happen to writes
with fsync() before closing the file descriptor.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/closestream.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/closestream.h b/include/closestream.h
index d61b83b..2535c8b 100644
--- a/include/closestream.h
+++ b/include/closestream.h
@@ -48,4 +48,23 @@ close_stdout(void)
 		_exit(EXIT_FAILURE);
 }
 
+#ifndef HAVE_FSYNC
+static inline int
+fsync(int fd __attribute__((__unused__)))
+{
+	return 0;
+}
+#endif
+
+static inline int
+close_fd(int fd)
+{
+	const int fsync_fail = (fsync(fd) != 0);
+	const int close_fail = (close(fd) != 0);
+
+	if (fsync_fail || close_fail)
+		return EOF;
+	return 0;
+}
+
 #endif /* UTIL_LINUX_CLOSESTREAM_H */
-- 
1.8.2.1

