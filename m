Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33256 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbcL1WCc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 28 Dec 2016 17:02:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id u144so63729861wmu.0
        for <util-linux@vger.kernel.org>; Wed, 28 Dec 2016 14:02:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Adam Borowski <kilobyte@angband.pl>,
        Andreas Henriksson <andreas@fatal.se>, Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/1] setterm: add --resize option
Date: Wed, 28 Dec 2016 22:02:11 +0000
Message-Id: <20161228220211.5634-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reset terminal size by assessing maximum row and column.  This is useful
when actual geometry and kernel terminal driver are not in sync.

Addresses: http://bugs.debian.org/835636
Based-on-work-by: Adam Borowski <kilobyte@angband.pl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.1 |   4 ++
 term-utils/setterm.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 2a06c1a08..643cc0624 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -228,6 +228,10 @@ Turns keyboard repeat on or off.
 Displays the terminal reset string, which typically resets the terminal to
 its power-on state.
 .TP
+\fB\-\-resize\fP
+Reset terminal size by assessing maximum row and column.  This is useful
+when actual geometry and kernel terminal driver are not in sync.
+.TP
 \fB\-\-reverse\fP [\fBon\fP|\fBoff\fP]
 Turns reverse video mode on or off.  Except on a virtual console,
 .B \-\-reverse off
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index abcf8b291..691c3bc2f 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -182,7 +182,7 @@ struct setterm_control {
 	    opt_appck_on:1, opt_invsc_on:1, opt_msg_on:1, opt_cl_all:1,
 	    vcterm:1;
 	/* Option flags.  Set when an option is invoked. */
-	uint64_t opt_term:1, opt_reset:1, opt_initialize:1, opt_cursor:1,
+	uint64_t opt_term:1, opt_reset:1, opt_resize:1, opt_initialize:1, opt_cursor:1,
 	    opt_linewrap:1, opt_default:1, opt_foreground:1,
 	    opt_background:1, opt_bold:1, opt_blink:1, opt_reverse:1,
 	    opt_underline:1, opt_store:1, opt_clear:1, opt_blank:1,
@@ -385,6 +385,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" --term          <terminal_name>   override TERM environment variable\n"), out);
 	fputs(_(" --reset                           reset terminal to power-on state\n"), out);
+	fputs(_(" --resize                          reset terminal rows and columns\n"), out);
 	fputs(_(" --initialize                      display init string, and use default settings\n"), out);
 	fputs(_(" --default                         use default terminal settings\n"), out);
 	fputs(_(" --store                           save current terminal settings as default\n"), out);
@@ -437,6 +438,7 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 	enum {
 		OPT_TERM = CHAR_MAX + 1,
 		OPT_RESET,
+		OPT_RESIZE,
 		OPT_INITIALIZE,
 		OPT_CURSOR,
 		OPT_REPEAT,
@@ -474,6 +476,7 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 	static const struct option longopts[] = {
 		{"term", required_argument, NULL, OPT_TERM},
 		{"reset", no_argument, NULL, OPT_RESET},
+		{"resize", no_argument, NULL, OPT_RESIZE},
 		{"initialize", no_argument, NULL, OPT_INITIALIZE},
 		{"cursor", required_argument, NULL, OPT_CURSOR},
 		{"repeat", required_argument, NULL, OPT_REPEAT},
@@ -527,6 +530,9 @@ static void parse_option(struct setterm_control *ctl, int ac, char **av)
 		case OPT_RESET:
 			ctl->opt_reset = set_opt_flag(ctl->opt_reset);
 			break;
+		case OPT_RESIZE:
+			ctl->opt_resize = set_opt_flag(ctl->opt_resize);
+			break;
 		case OPT_INITIALIZE:
 			ctl->opt_initialize = set_opt_flag(ctl->opt_initialize);
 			break;
@@ -815,6 +821,101 @@ static int vc_only(struct setterm_control *ctl, const char *err)
 	return ctl->vcterm;
 }
 
+static void tty_raw(struct termios *saved_attributes, int *saved_fl)
+{
+	struct termios tattr;
+
+	fcntl(STDIN_FILENO, F_GETFL, saved_fl);
+	tcgetattr(STDIN_FILENO, saved_attributes);
+	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
+	memcpy(&tattr, saved_attributes, sizeof(struct termios));
+	tattr.c_lflag &= ~(ICANON | ECHO);
+	tattr.c_cc[VMIN] = 1;
+	tattr.c_cc[VTIME] = 0;
+	tcsetattr(STDIN_FILENO, TCSAFLUSH, &tattr);
+}
+
+static void tty_restore(struct termios *saved_attributes, int *saved_fl)
+{
+	fcntl(STDIN_FILENO, F_SETFL, *saved_fl);
+	tcsetattr(STDIN_FILENO, TCSANOW, saved_attributes);
+}
+
+static int select_wait(void)
+{
+	struct timeval tv;
+	fd_set set;
+
+	FD_ZERO(&set);
+	FD_SET(STDIN_FILENO, &set);
+	tv.tv_sec = 0;
+	tv.tv_usec = 100;
+	return select(1, &set, NULL, NULL, &tv);
+}
+
+static int resizetty(void)
+{
+	/* 
+	 * \e7        Save current state (cursor coordinates, attributes,
+	 *                character sets pointed at by G0, G1).
+	 * \e[r       Set scrolling region; parameters are top and bottom row.
+	 * \e[99999E  Move cursor down 99999 rows.
+	 * \e[99999C  Move cursor right 99999 columns.
+	 */
+	static const char *setup = "\e7\e[r\e[99999E\e[99999C";
+	/* \e[6n      Report cursor position.  */
+	static const char *getpos = "\e[6n";
+	/* \e8        Restore state most recently saved by \e7. */
+	static const char *restore = "\e8";
+	char retstr[32];
+	int row, col;
+	size_t pos;
+	ssize_t rc;
+	struct winsize ws;
+	struct termios saved_attributes;
+	int saved_fl;
+
+	if (!isatty(STDIN_FILENO))
+		errx(EXIT_FAILURE, _("stdin does not refer to a terminal"));
+
+	tty_raw(&saved_attributes, &saved_fl);
+	if (write(STDIN_FILENO, setup, strlen(setup)) < 0 ||
+	    write(STDIN_FILENO, getpos, strlen(getpos)) < 0) {
+		warn(_("write failed"));
+		tty_restore(&saved_attributes, &saved_fl);
+		return 1;
+	}
+	for (pos = 0; pos < sizeof(retstr) - 1;) {
+		if (0 == select_wait())
+			break;
+		if ((rc =
+		     read(STDIN_FILENO, retstr + pos,
+			  sizeof(retstr) - 1 - pos)) < 0) {
+			warn(_("read failed"));
+			tty_restore(&saved_attributes, &saved_fl);
+			return 1;
+		}
+		pos += rc;
+		if (retstr[pos - 1] == 'R')
+			break;
+	}
+	retstr[pos] = 0;
+	if (write(STDIN_FILENO, restore, strlen(restore)) < 0)
+		warn(_("read failed"));
+	tty_restore(&saved_attributes, &saved_fl);
+	rc = sscanf(retstr, "\033[%d;%dR", &row, &col);
+	if (rc != 2) {
+		warnx(_("invalid cursor position: %s"), retstr);
+		return 1;
+	}
+	memset(&ws, 0, sizeof(struct winsize));
+	ioctl(STDIN_FILENO, TIOCGWINSZ, &ws);
+	ws.ws_row = row;
+	ws.ws_col = col;
+	ioctl(STDIN_FILENO, TIOCSWINSZ, &ws);
+	return 0;
+}
+
 static void perform_sequence(struct setterm_control *ctl)
 {
 	int result;
@@ -823,6 +924,11 @@ static void perform_sequence(struct setterm_control *ctl)
 	if (ctl->opt_reset)
 		putp(ti_entry("rs1"));
 
+	/* -resize. */
+	if (ctl->opt_resize)
+		if (resizetty())
+			warnx(_("reset failed"));
+
 	/* -initialize. */
 	if (ctl->opt_initialize)
 		putp(ti_entry("is2"));
-- 
2.11.0

