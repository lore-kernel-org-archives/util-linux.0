Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:55842 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXLIY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 May 2014 07:08:24 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so2059830wib.6
        for <util-linux@vger.kernel.org>; Sat, 24 May 2014 04:08:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] setterm: add usage() descriptions
Date: Sat, 24 May 2014 12:08:13 +0100
Message-Id: <1400929696-12548-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 5f59a8b..936892a 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -402,40 +402,41 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fprintf(out,
 	      _(" %s [options]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" --term <terminal_name>\n"), out);
-	fputs(_(" --reset\n"), out);
-	fputs(_(" --initialize\n"), out);
-	fputs(_(" --cursor <on|off>\n"), out);
-	fputs(_(" --repeat <on|off>\n"), out);
-	fputs(_(" --appcursorkeys <on|off>\n"), out);
-	fputs(_(" --linewrap <on|off>\n"), out);
-	fputs(_(" --default\n"), out);
-	fputs(_(" --foreground <default|color>\n"), out);
-	fputs(_(" --background <default|color>\n"), out);
-	fputs(_(" --ulcolor [bright] <color>\n"), out);
-	fputs(_(" --hbcolor [bright] <color>\n"), out);
-	fputs(_(" <color>: black blue cyan green grey magenta red white yellow\n"), out);
-	fputs(_(" --inversescreen <on|off>\n"), out);
-	fputs(_(" --bold <on|off>\n"), out);
-	fputs(_(" --half-bright <on|off>\n"), out);
-	fputs(_(" --blink <on|off>\n"), out);
-	fputs(_(" --reverse <on|off>\n"), out);
-	fputs(_(" --underline <on|off>\n"), out);
-	fputs(_(" --store\n"), out);
-	fputs(_(" --clear <all|rest>\n"), out);
-	fputs(_(" --tabs <tab1 tab2 tab3 ...>      (tabn = 1-160)\n"), out);
-	fputs(_(" --clrtabs <tab1 tab2 tab3 ...>   (tabn = 1-160)\n"), out);
-	fputs(_(" --regtabs <1-160>\n"), out);
-	fputs(_(" --blank <0-60|force|poke>\n"), out);
-	fputs(_(" --dump   <1-NR_CONSOLES>\n"), out);
-	fputs(_(" --append <1-NR_CONSOLES>\n"), out);
-	fputs(_(" --file dumpfilename\n"), out);
-	fputs(_(" --msg <on|off>\n"), out);
-	fputs(_(" --msglevel <0-8>\n"), out);
-	fputs(_(" --powersave <on|vsync|hsync|powerdown|off>\n"), out);
-	fputs(_(" --powerdown <0-60>\n"), out);
-	fputs(_(" --blength <0-2000>\n"), out);
-	fputs(_(" --bfreq freqnumber\n"), out);
+	fputs(_(" --term          <terminal_name>   override TERM environment variable\n"), out);
+	fputs(_(" --reset                           reset terminal to power on state\n"), out);
+	fputs(_(" --initialize                      display init string, and use default settings\n"), out);
+	fputs(_(" --default                         use default terminal settings\n"), out);
+	fputs(_(" --store                           save current terminal settings as default\n"), out);
+	fputs(_(" --cursor        <on|off>          display cursor\n"), out);
+	fputs(_(" --repeat        <on|off>          keyboard repeat\n"), out);
+	fputs(_(" --appcursorkeys <on|off>          cursor key application mode\n"), out);
+	fputs(_(" --linewrap      <on|off>          continue on a new line when a line is full\n"), out);
+	fputs(_(" --inversescreen <on|off>          inverse foreground and background colors\n"), out);
+	fputs(_(" --foreground    <default|color>   set foreground color\n"), out);
+	fputs(_(" --background    <default|color>   set background color\n"), out);
+	fputs(_(" --ulcolor       [bright] <color>  set underlined text color\n"), out);
+	fputs(_(" --hbcolor       [bright] <color>  set bold text color\n"), out);
+	fputs(_("                 <color>: black blue cyan green grey magenta red white yellow\n"), out);
+	fputs(_(" --bold          <on|off>          bold\n"), out);
+	fputs(_(" --half-bright   <on|off>          dim\n"), out);
+	fputs(_(" --blink         <on|off>          blink\n"), out);
+	fputs(_(" --underline     <on|off>          underline\n"), out);
+	fputs(_(" --reverse       <on|off>          reverse all output options\n"), out);
+	fputs(_(" --clear         <all|rest>        clear screen and set cursor position\n"), out);
+	fputs(_(" --tabs          <number ...>      set tab stop positions\n"), out);
+	fputs(_(" --clrtabs       <number ...>      clear tab stop positions\n"), out);
+	fputs(_(" --regtabs       <1-160>           set default tab stop position\n"), out);
+	fputs(_(" --blank         <0-60|force|poke> set inactivity interval\n"), out);
+	fputs(_(" --dump          <number>          write vcsa<number> console dump to file\n"), out);
+	fputs(_(" --append        <number>          append vcsa<number> console dump\n"), out);
+	fputs(_(" --file          <file>            path to vcsa<number> dump file\n"), out);
+	fputs(_(" --msg           <on|off>          kernel messages to console\n"), out);
+	fputs(_(" --msglevel      <0-8>             kernel console log level\n"), out);
+	fputs(_(" --powersave     <on|vsync|hsync|powerdown|off>\n"), out);
+	fputs(_("                                   set vesa powersaving features\n"), out);
+	fputs(_(" --powerdown     <0-60>            set vesa powerdown interval in minutes\n"), out);
+	fputs(_(" --blength       <0-2000>          duration of the bell in milliseconds\n"), out);
+	fputs(_(" --bfreq         freqnumber        bell frequency in Hertz\n"), out);
 	fputs(_(" --version\n"), out);
 	fputs(_(" --help\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("setterm(1)"));
-- 
1.9.3

