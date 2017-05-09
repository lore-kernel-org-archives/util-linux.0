Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36503 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753819AbdEISLC (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 May 2017 14:11:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so2128044wrc.3
        for <util-linux@vger.kernel.org>; Tue, 09 May 2017 11:11:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/5] docs: make column.1 example to use ascii output
Date: Tue,  9 May 2017 19:10:52 +0100
Message-Id: <20170509181052.3610-5-kerolasa@iki.fi>
In-Reply-To: <20170509181052.3610-1-kerolasa@iki.fi>
References: <20170509181052.3610-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In same go ease reading by having data and arguments in same order.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.1 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index b605d505d..03f669789 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -125,12 +125,12 @@ Print fstab with header line and align number to the right:
 .PP
 Print a tree:
 .EX
-\fBecho -e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column --tree 3 --tree-id 1 --tree-parent 2\fR
+\fBecho -e '1 0 A\\n2 1 AA\\n3 1 AB\\n4 2 AAA\\n5 2 AAB' | column --tree-id 1 --tree-parent 2 --tree 3\fR
 1  0  A
-2  1  ├─AA
-4  2  │ ├─AAA
-5  2  │ └─AAB
-3  1  └─AB
+2  1  |-AA
+4  2  | |-AAA
+5  2  | `-AAB
+3  1  `-AB
 .EE
 .SH BUGS
 Version 2.23 changed the
-- 
2.12.2

