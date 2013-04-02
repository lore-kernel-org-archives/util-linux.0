Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:45066 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTn3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:29 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so881608wgh.20
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/13] setterm: fix various color option argument lists
Date: Tue,  2 Apr 2013 20:42:54 +0100
Message-Id: <1364931777-2645-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The lists did not have correct colors in usage().  Because the usage()
had to be fixed, it is best to make the output easy for translators to
work with.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 74 ++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 37 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 0e72cf0..310c3fa 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -678,43 +678,43 @@ usage(FILE *out) {
 	      _(" %s [options]\n"), program_invocation_short_name);
 
 	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -term <terminal_name>\n"
-		" -reset\n"
-		" -initialize\n"
-		" -cursor <on|off>\n"
-		" -repeat <on|off>\n"
-		" -appcursorkeys <on|off>\n"
-		" -linewrap <on|off>\n"
-		" -default\n"
-		" -foreground <black|blue|green|cyan|red|magenta|yellow|white|default>\n"
-		" -background <black|blue|green|cyan|red|magenta|yellow|white|default>\n"
-		" -ulcolor <black|grey|blue|green|cyan|red|magenta|yellow|white>\n"
-		" -ulcolor <bright blue|green|cyan|red|magenta|yellow|white>\n"
-		" -hbcolor <black|grey|blue|green|cyan|red|magenta|yellow|white>\n"
-		" -hbcolor <bright blue|green|cyan|red|magenta|yellow|white>\n"
-		" -inversescreen <on|off>\n"
-		" -bold <on|off>\n"
-		" -half-bright <on|off>\n"
-		" -blink <on|off>\n"
-		" -reverse <on|off>\n"
-		" -underline <on|off>\n"
-		" -store >\n"
-		" -clear <all|rest>\n"
-		" -tabs < tab1 tab2 tab3 ... >      (tabn = 1-160)\n"
-		" -clrtabs < tab1 tab2 tab3 ... >   (tabn = 1-160)\n"
-		" -regtabs <1-160>\n"
-		" -blank <0-60|force|poke>\n"
-		" -dump   <1-NR_CONSOLES>\n"
-		" -append <1-NR_CONSOLES>\n"
-		" -file dumpfilename\n"
-		" -msg <on|off>\n"
-		" -msglevel <0-8>\n"
-		" -powersave <on|vsync|hsync|powerdown|off>\n"
-		" -powerdown <0-60>\n"
-		" -blength <0-2000>\n"
-		" -bfreq freqnumber\n"
-		" -version\n"
-		" -help\n"), out);
+	fputs(_(" -term <terminal_name>\n"), out);
+	fputs(_(" -reset\n"), out);
+	fputs(_(" -initialize\n"), out);
+	fputs(_(" -cursor <on|off>\n"), out);
+	fputs(_(" -repeat <on|off>\n"), out);
+	fputs(_(" -appcursorkeys <on|off>\n"), out);
+	fputs(_(" -linewrap <on|off>\n"), out);
+	fputs(_(" -default\n"), out);
+	fputs(_(" -foreground <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -background <default|black|blue|cyan|green|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -ulcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -hbcolor <black|blue|bright|cyan|green|grey|magenta|red|white|yellow>\n"), out);
+	fputs(_(" -inversescreen <on|off>\n"), out);
+	fputs(_(" -bold <on|off>\n"), out);
+	fputs(_(" -half-bright <on|off>\n"), out);
+	fputs(_(" -blink <on|off>\n"), out);
+	fputs(_(" -reverse <on|off>\n"), out);
+	fputs(_(" -underline <on|off>\n"), out);
+	fputs(_(" -store\n"), out);
+	fputs(_(" -clear <all|rest>\n"), out);
+	fputs(_(" -tabs <tab1 tab2 tab3 ...>      (tabn = 1-160)\n"), out);
+	fputs(_(" -clrtabs <tab1 tab2 tab3 ...>   (tabn = 1-160)\n"), out);
+	fputs(_(" -regtabs <1-160>\n"), out);
+	fputs(_(" -blank <0-60|force|poke>\n"), out);
+	fputs(_(" -dump   <1-NR_CONSOLES>\n"), out);
+	fputs(_(" -append <1-NR_CONSOLES>\n"), out);
+	fputs(_(" -file dumpfilename\n"), out);
+	fputs(_(" -msg <on|off>\n"), out);
+	fputs(_(" -msglevel <0-8>\n"), out);
+	fputs(_(" -powersave <on|vsync|hsync|powerdown|off>\n"), out);
+	fputs(_(" -powerdown <0-60>\n"), out);
+	fputs(_(" -blength <0-2000>\n"), out);
+	fputs(_(" -bfreq freqnumber\n"), out);
+	fputs(_(" -version\n"), out);
+	fputs(_(" -help\n"), out);
 
 	fprintf(out, USAGE_MAN_TAIL("setterm(1)"));
 
-- 
1.8.2

