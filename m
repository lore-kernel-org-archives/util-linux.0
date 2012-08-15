Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47056 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2HOJKV convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Aug 2012 05:10:21 -0400
Received: by bkwj10 with SMTP id j10so432598bkw.19
        for <util-linux@vger.kernel.org>; Wed, 15 Aug 2012 02:10:20 -0700 (PDT)
From: Andrea Bonomi <a.bonomi@endian.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 2/2] agetty: display network address in issue
Date: Wed, 15 Aug 2012 11:10:19 +0200
Message-Id: <E7E42693-8D57-4A82-AF6A-F781234E6D66@endian.com>
To: util-linux@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1278)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andrea Bonomi <a.bonomi@endian.com>

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index ebfdb96..2d8f7db 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -3,7 +3,7 @@
 agetty \- alternative Linux getty
 
 .SH SYNOPSIS
-.BR "agetty " [\-8chiLmnsUw]
+.BR "agetty " [\-8chiLmnsUwx]
 .RI "[\-a " user ]
 .RI "[\-f " issue_file ]
 .RI "[\-H " login_host ]
@@ -198,6 +198,10 @@ Wait for the user or the modem to send a carriage-return or a
 linefeed character before sending the \fI/etc/issue\fP (or other) file
 and the login prompt. Very useful in connection with the \-I option.
 .TP
+\-x, \-\-interface \fIinterface_name\fP
+The IPv4 and IPv6 addresses of a network interface can be displayed in
+the issue. The name of the network is configured by this option.
+.TP
 \-\-noclear
 Do not clear the screen before prompting for the login name
 (the screen is normally cleared).
@@ -269,6 +273,15 @@ time etc. All escape codes consist of a backslash (\\) immediately
 followed by one of the letters explained below.
 
 .TP
+4
+Insert the IPv4 address of the configured network interface.
+.TP
+6
+Insert the IPv6 address of the configured network interface.
+.TP
+x
+Name of the configured network interface (configured by the -x option).
+.TP
 b
 Insert the baudrate of the current line.
 .TP

