Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51722 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757087Ab1EXU5K (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 May 2011 16:57:10 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so2169065ewy.19
        for <util-linux@vger.kernel.org>; Tue, 24 May 2011 13:57:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/13] docs: colrm manual update
Date: Tue, 24 May 2011 22:56:41 +0200
Message-Id: <1306270604-6154-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Inform about long, help & version and options.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/colrm.1 |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/text-utils/colrm.1 b/text-utils/colrm.1
index 1f3d4b0..04a41b1 100644
--- a/text-utils/colrm.1
+++ b/text-utils/colrm.1
@@ -51,6 +51,14 @@ If called with two parameters the columns from the first column
 to the last column will be removed.
 .Pp
 Column numbering starts with column 1.
+.Pp
+The options are as follows:
+.Bl -tag -width "-lnum"
+.It Fl V, Fl Fl version
+Output version information and exit.
+.It Fl H, Fl Fl help
+Output help and exit.
+.El
 .Sh SEE ALSO
 .Xr awk 1 ,
 .Xr column 1 ,
-- 
1.7.5.2

