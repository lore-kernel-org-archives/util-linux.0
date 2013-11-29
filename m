Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53133 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899Ab3K2Poh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Nov 2013 10:44:37 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 03223A7D78
	for <util-linux@vger.kernel.org>; Fri, 29 Nov 2013 16:44:36 +0100 (CET)
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: werner@suse.de
Subject: [PATCH] Support the special terminal on first serial line on a S/390
Date: Fri, 29 Nov 2013 16:44:25 +0100
Message-Id: <1385739865-24696-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

which is due legacy reasons a block terminal of type 3270 or higher.
Whereas the second serial line on a S/390(x) is a real character
terminal which is compatible with VT220.

Signed-off-by: Werner Fink <werner@suse.de>
---
 term-utils/agetty.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git term-utils/agetty.c term-utils/agetty.c
index 113f8e7..c881f3d 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -49,6 +49,10 @@
 #  ifndef DEFAULT_VCTERM
 #    define DEFAULT_VCTERM "linux"
 #  endif
+#  if defined (__s390__) || defined (__s390x__)
+#    define DEFAULT_TTYS0  "ibm327x"
+#    define DEFAULT_TTYS1  "vt220"
+#  endif
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt102"
 #  endif
@@ -1052,6 +1056,20 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 	if (tcgetattr(STDIN_FILENO, tp) < 0)
 		log_err(_("%s: failed to get terminal attributes: %m"), tty);
 
+#if defined (__s390__) || defined (__s390x__)
+	if (!op->term) {
+	        /*
+		 * Special terminal on first serial line on a S/390(x) which
+		 * is due legacy reasons a block terminal of type 3270 or
+		 * higher.  Whereas the second serial line on a S/390(x) is
+		 * a real character terminal which is compatible with VT220.
+		 */
+		if (strcmp(op->tty, "ttyS0") == 0)
+			op->term = DEFAULT_TTYS0;
+		else if (strcmp(op->tty, "ttyS1") == 0)
+			op->term = DEFAULT_TTYS1;
+	}
+#endif
 	/*
 	 * Detect if this is a virtual console or serial/modem line.
 	 * In case of a virtual console the ioctl TIOCMGET fails and
-- 
1.7.9.2

