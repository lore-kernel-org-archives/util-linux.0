Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52108 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635Ab2I2JW2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 29 Sep 2012 05:22:28 -0400
Received: by wgbdr13 with SMTP id dr13so2537159wgb.1
        for <util-linux@vger.kernel.org>; Sat, 29 Sep 2012 02:22:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] docs: column.1 describe change of separator behavior in bugs section
Date: Sat, 29 Sep 2012 10:21:59 +0100
Message-Id: <1348910519-10684-1-git-send-email-kerolasa@iki.fi>
References: <50636D1D.3080007@draigBrady.com>
In-Reply-To: <1348692336-21301-1-git-send-email-kerolasa@iki.fi> <50636D1D.3080007@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add to manual page how to achieve old behavior, just in case someone
relies on buggy behavior of the command.

Reported-by: Pádraig Brady <P@draigbrady.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.1 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 2050666..775c73b 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -65,6 +65,35 @@ the screen if no other information is available.
 .nf
 sed 's/#.*//' /etc/fstab | column -t
 .nf
+.SH BUGS
+The util-linux version 2.23 changed
+.B \-s
+option to be non-greedy.  The change made the following output
+.PP
+.EX
+$ printf "a:b:c\n1::3\n" | column  -t -s ':'
+a  b  c
+1  3
+.EE
+.PP
+to be
+.PP
+.EX
+$ printf "a:b:c\n1::3\n" | column  -t -s ':'
+a  b  c
+1     3
+.EE
+.PP
+If there is need to use greedy separator the old behavior can be achieved
+by filtering with
+.BR sed (1).
+.PP
+.EX
+$ printf "xzcatxzdog\\ndonkeyxzzxkong\\n" |
+> sed 's/^[xz]*//
+> s/[xz]\\+/x/g' |
+> column -t -s xz
+.EE
 .SH "SEE ALSO"
 .BR colrm (1),
 .BR ls (1),
-- 
1.7.12.1

