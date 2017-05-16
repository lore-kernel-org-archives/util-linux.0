Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34190 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdEPHhq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 May 2017 03:37:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so35623620wmf.1
        for <util-linux@vger.kernel.org>; Tue, 16 May 2017 00:37:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] getops: make --a-long option work again
Date: Tue, 16 May 2017 08:37:41 +0100
Message-Id: <20170516073741.10811-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add back a character lost in earlier change.

Regression-from: d27f5fe770025e456fbd33b87a96968f34c455ed
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt-parse.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/getopt-parse.bash b/misc-utils/getopt-parse.bash
index 348c445a4..db8bf6b59 100644
--- a/misc-utils/getopt-parse.bash
+++ b/misc-utils/getopt-parse.bash
@@ -20,7 +20,7 @@
 # Note that we use "$@" to let each command-line parameter expand to a
 # separate word. The quotes around "$@" are essential!
 # We need TEMP as the 'eval set --' would nuke the return value of getopt.
-TEMP=$(getopt -o 'ab:c::' --long '-long,b-long:,c-long::' -n 'example.bash' -- "$@")
+TEMP=$(getopt -o 'ab:c::' --long 'a-long,b-long:,c-long::' -n 'example.bash' -- "$@")
 
 if [ $? -ne 0 ]; then
 	echo 'Terminating...' >&2
-- 
2.13.0

