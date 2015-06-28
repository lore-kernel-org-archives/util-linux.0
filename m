Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33125 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbF1Tng (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:36 -0400
Received: by wiwl6 with SMTP id l6so82590247wiw.0
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/7] getopt: use $(...) command substitution in example script [shellcheck]
Date: Sun, 28 Jun 2015 20:43:24 +0100
Message-Id: <1435520605-4296-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: https://github.com/koalaman/shellcheck/wiki/SC2006
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt-parse.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/getopt-parse.bash b/misc-utils/getopt-parse.bash
index 29e7f6f..aab8c62 100644
--- a/misc-utils/getopt-parse.bash
+++ b/misc-utils/getopt-parse.bash
@@ -19,8 +19,8 @@
 # Note that we use `"$@"' to let each command-line parameter expand to a
 # separate word. The quotes around `$@' are essential!
 # We need TEMP as the `eval set --' would nuke the return value of getopt.
-TEMP=`getopt -o ab:c:: --long a-long,b-long:,c-long:: \
-     -n 'example.bash' -- "$@"`
+TEMP=$(getopt -o ab:c:: --long a-long,b-long:,c-long:: \
+     -n 'example.bash' -- "$@")
 
 if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
 
-- 
2.4.4

