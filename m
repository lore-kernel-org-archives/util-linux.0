Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:57769 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751197AbaF2PzE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:55:04 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/7] textual: improve formatting and wording of usage text of setterm
Date: Sun, 29 Jun 2014 17:49:38 +0200
Message-Id: <1404056983-10119-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Mainly: showing that the word color is a placeholder by writing
<color>, showing some numbers as optional, and message levels
and colors as not optional.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 term-utils/setterm.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index d559957..afbd274 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -403,7 +403,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	      _(" %s [options]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" --term          <terminal_name>   override TERM environment variable\n"), out);
-	fputs(_(" --reset                           reset terminal to power on state\n"), out);
+	fputs(_(" --reset                           reset terminal to power-on state\n"), out);
 	fputs(_(" --initialize                      display init string, and use default settings\n"), out);
 	fputs(_(" --default                         use default terminal settings\n"), out);
 	fputs(_(" --store                           save current terminal settings as default\n"), out);
@@ -412,33 +412,33 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" --appcursorkeys [on|off]          cursor key application mode\n"), out);
 	fputs(_(" --linewrap      [on|off]          continue on a new line when a line is full\n"), out);
 	fputs(_(" --inversescreen [on|off]          swap colors for the whole screen\n"), out);
-	fputs(_(" --foreground    [default|color]   set foreground color\n"), out);
-	fputs(_(" --background    [default|color]   set background color\n"), out);
-	fputs(_(" --ulcolor       [bright] [color]  set underlined text color\n"), out);
-	fputs(_(" --hbcolor       [bright] [color]  set bold text color\n"), out);
-	fputs(_("                 [color]: black blue cyan green grey magenta red white yellow\n"), out);
+	fputs(_(" --foreground    default|<color>   set foreground color\n"), out);
+	fputs(_(" --background    default|<color>   set background color\n"), out);
+	fputs(_(" --ulcolor       [bright] <color>  set underlined text color\n"), out);
+	fputs(_(" --hbcolor       [bright] <color>  set bold text color\n"), out);
+	fputs(_("                 <color>: black blue cyan green grey magenta red white yellow\n"), out);
 	fputs(_(" --bold          [on|off]          bold\n"), out);
 	fputs(_(" --half-bright   [on|off]          dim\n"), out);
 	fputs(_(" --blink         [on|off]          blink\n"), out);
 	fputs(_(" --underline     [on|off]          underline\n"), out);
 	fputs(_(" --reverse       [on|off]          swap foreground and background colors\n"), out);
 	fputs(_(" --clear         [all|rest]        clear screen and set cursor position\n"), out);
-	fputs(_(" --tabs          <number ...>      set tab stop positions\n"), out);
-	fputs(_(" --clrtabs       <number ...>      clear tab stop positions\n"), out);
-	fputs(_(" --regtabs       [1-160]           set default tab stop position\n"), out);
-	fputs(_(" --blank         [0-60|force|poke] set inactivity interval\n"), out);
-	fputs(_(" --dump          <number>          write vcsa<number> console dump to file\n"), out);
-	fputs(_(" --append        <number>          append vcsa<number> console dump\n"), out);
-	fputs(_(" --file          <file>            path to vcsa<number> dump file\n"), out);
-	fputs(_(" --msg           [on|off]          kernel messages to console\n"), out);
-	fputs(_(" --msglevel      [0-8]             kernel console log level\n"), out);
+	fputs(_(" --tabs          [<number>...]     set these tab stop positions, or show them\n"), out);
+	fputs(_(" --clrtabs       [<number>...]     clear these tab stop positions, or all\n"), out);
+	fputs(_(" --regtabs       [1-160]           set a regular tab stop interval\n"), out);
+	fputs(_(" --blank         [0-60|force|poke] set time of inactivity before screen blanks\n"), out);
+	fputs(_(" --dump          [<number>]        write vcsa<number> console dump to file\n"), out);
+	fputs(_(" --append        [<number>]        append vcsa<number> console dump to file\n"), out);
+	fputs(_(" --file          <filename>        name of the dump file\n"), out);
+	fputs(_(" --msg           [on|off]          send kernel messages to console\n"), out);
+	fputs(_(" --msglevel      0-8               kernel console log level\n"), out);
 	fputs(_(" --powersave     [on|vsync|hsync|powerdown|off]\n"), out);
 	fputs(_("                                   set vesa powersaving features\n"), out);
 	fputs(_(" --powerdown     [0-60]            set vesa powerdown interval in minutes\n"), out);
 	fputs(_(" --blength       [0-2000]          duration of the bell in milliseconds\n"), out);
 	fputs(_(" --bfreq         <number>          bell frequency in Hertz\n"), out);
-	fputs(_(" --version\n"), out);
-	fputs(_(" --help\n"), out);
+	fputs(_(" --version                         show version information and exit\n"), out);
+	fputs(_(" --help                            display this help and exit\n"), out);
 	fprintf(out, USAGE_MAN_TAIL("setterm(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.0.4

