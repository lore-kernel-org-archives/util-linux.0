Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:59975 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:05 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so2960613wib.7
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/17] setterm: remove usage comment segment
Date: Sun, 18 May 2014 15:05:29 +0100
Message-Id: <1400421941-14244-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is enough trouble to keep usage output aligned with getopt() parsing,
manual page, and bash-completion, so get rid of the unnecessary effort
duplication.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 734d275..268ddec 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -19,52 +19,6 @@
  * 1999-02-22 Arkadiusz Miśkiewicz <misiek@pld.ORG.PL>
  * - added Native Language Support
  *
- *
- * Syntax:
- *
- * setterm
- *   [ -term terminal_name ]
- *   [ -reset ]
- *   [ -initialize ]
- *   [ -cursor [on|off] ]
- *   [ -repeat [on|off] ]
- *   [ -appcursorkeys [on|off] ]
- *   [ -linewrap [on|off] ]
- *   [ -snow [on|off] ]
- *   [ -softscroll [on|off] ]
- *   [ -defaults ]
- *   [ -foreground black|red|green|yellow|blue|magenta|cyan|white|default ]
- *   [ -background black|red|green|yellow|blue|magenta|cyan|white|default ]
- *   [ -ulcolor black|grey|red|green|yellow|blue|magenta|cyan|white ]
- *   [ -ulcolor bright red|green|yellow|blue|magenta|cyan|white ]
- *   [ -hbcolor black|grey|red|green|yellow|blue|magenta|cyan|white ]
- *   [ -hbcolor bright red|green|yellow|blue|magenta|cyan|white ]
- *   [ -inversescreen [on|off] ]
- *   [ -bold [on|off] ]
- *   [ -half-bright [on|off] ]
- *   [ -blink [on|off] ]
- *   [ -reverse [on|off] ]
- *   [ -underline [on|off] ]
- *   [ -store ]
- *   [ -clear [ all|rest ] ]
- *   [ -tabs [tab1 tab2 tab3 ... ] ]     (tabn = 1-160)
- *   [ -clrtabs [ tab1 tab2 tab3 ... ]   (tabn = 1-160)
- *   [ -regtabs [1-160] ]
- *   [ -blank [0-60|force|poke|] ]
- *   [ -dump   [1-NR_CONS ] ]
- *   [ -append [1-NR_CONS ] ]
- *   [ -file dumpfilename ]
- *   [ -standout [attr] ]
- *   [ -msg [on|off] ]
- *   [ -msglevel [0-8] ]
- *   [ -powersave [on|vsync|hsync|powerdown|off] ]
- *   [ -powerdown [0-60] ]
- *   [ -blength [0-2000] ]
- *   [ -bfreq freq ]
- *   [ -version ]
- *   [ -help ]
- *
- *
  * Semantics:
  *
  * Setterm writes to standard output a character string that will
-- 
1.9.2

