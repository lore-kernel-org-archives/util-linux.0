Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72229C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A12B2075A
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oRBiH5fb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgEFTTe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 15:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEFTTd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 15:19:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB9EC061A0F
        for <util-linux@vger.kernel.org>; Wed,  6 May 2020 12:19:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i15so3099121wrx.10
        for <util-linux@vger.kernel.org>; Wed, 06 May 2020 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=vAQJ2eIGRSpTR6+NghqZlreCH/5VRLAmCmzGS2xqCKU=;
        b=oRBiH5fbDBxKfkD7+USagqHAUkCoyirBWBPJuYEqK/P0nsA1R6woyi4l8UUN2d0Qo1
         iBRFZRQ7ZHBI2TKkfkFRHKi2LCppkiSYwIUFeORzmru/WfH/r4BJzIzGQ/jsp1fKlTi0
         MnLNY5b2h+oSnoXFML4v2pCX75TMnVZ32+wH5xXCfXhHf/bBWFH9MkvN7yvBlu3wPJFO
         uKA4MxXjnpl/potzkhDEu6kYkFRmJVqX9Md8nn3sra2ALqXieghC46pei0+MuRF+6EZc
         uTANxkST1aqk/SkZcVztDfJ4bVgam96Pkysg7wLsY/DQnxCL0wGiZjWJsPCghSm/NPVz
         8kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:organization
         :content-transfer-encoding;
        bh=vAQJ2eIGRSpTR6+NghqZlreCH/5VRLAmCmzGS2xqCKU=;
        b=DY7Y4SI0jVhvCK01qapdtfsAy0GHI2xZeP18sKn00iUR+IrubVfAvqQWVbCW8OL6Uc
         jWYnCiiNhjoVutt80KDoeVoYgRgW0UAVUjd6OTPoUKfS2zeQyRoNF6yAdw43yVivK4rw
         iYqlc4GbgCAJY2zuV6O6lYKxRxlAS70aH/xPPBrHPR4/Gfvw59MBtDUC0S4Rw4LC7kBy
         ehdt956r1jJuwQzUXSSZAE/dKBJzJomr3ScM/wk5g7M3VQ0VQRWR1IkNKyirfFeY9SeD
         q2PI1O5SadqzldB26KPQZdWdFCljkjVkkUDWU8JWyIkfKFbhWSe57FYqV2JxoHmOqk4J
         OKcQ==
X-Gm-Message-State: AGi0Pubfb6xNjKhryDJwI6/taDBDCDKRhXsndg8Fb0zd8k5mE2LMWvqN
        mvNDfrr32ko4sD1kZC7vs5noBCn2
X-Google-Smtp-Source: APiQypLpAo8XUX96h5GmSupiBSxNGJsL9hUtzJveMcwy+QcxAI5er+4aK1bwXA+FM7ub6l3RTrxiKg==
X-Received: by 2002:adf:a151:: with SMTP id r17mr10725814wrr.161.1588792771126;
        Wed, 06 May 2020 12:19:31 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:8b7c:8150:5102:21e9])
        by smtp.gmail.com with ESMTPSA id q187sm4439186wma.41.2020.05.06.12.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:19:30 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] more: make page and arrow up/down to update view
Date:   Wed,  6 May 2020 20:19:23 +0100
Message-Id: <20200506191923.5272-3-kerolasa@iki.fi>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506191923.5272-1-kerolasa@iki.fi>
References: <20200506191923.5272-1-kerolasa@iki.fi>
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Aim was to introduce page and arrow up/down keys to more(1), but that
also required merging colon_command() and more_key_command() functions.

The more_key_commands enum is pointless from computers point of view.
The command identification performed in read_command() inline with
more_key_command() execution -- but that would be hard for humans, and
source code ought to serve both parties.

Reference: https://github.com/karelzak/util-linux/pull/1003
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 379 +++++++++++++++++++++++++++++-----------------
 1 file changed, 238 insertions(+), 141 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 014b40a6c..b69fa5c5b 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -93,6 +93,11 @@
 #define BACKSPACE	"\b"
 #define CARAT		"^"
 
+#define ARROW_UP	"\x1b\x5b\x41"
+#define ARROW_DOWN	"\x1b\x5b\x42"
+#define PAGE_UP		"\x1b\x5b\x35\x7e"
+#define PAGE_DOWN	"\x1b\x5b\x36\x7e"
+
 #define MIN_LINE_SZ	256	/* minimal line_buf buffer size */
 #define ESC		'\033'
 #define SCROLL_LEN	11
@@ -121,6 +126,35 @@
 #define TERM_STANDARD_MODE        "smso"
 #define TERM_STD_MODE_GLITCH      "xmc"
 
+/* Used in read_command() */
+typedef enum {
+	more_kc_unknown_command,
+	more_kc_colon,
+	more_kc_repeat_previous,
+	more_kc_backwards,
+	more_kc_jump_lines_per_screen,
+	more_kc_set_lines_per_screen,
+	more_kc_set_scroll_len,
+	more_kc_quit,
+	more_kc_skip_forward,
+	more_kc_next_line,
+	more_kc_clear_screen,
+	more_kc_previous_search_match,
+	more_kc_display_line,
+	more_kc_display_file_and_line,
+	more_kc_repeat_search,
+	more_kc_search,
+	more_kc_run_shell,
+	more_kc_help,
+	more_kc_next_file,
+	more_kc_previous_file,
+	more_kc_run_editor
+} more_key_commands;
+struct number_command {
+	unsigned int number;
+	more_key_commands key;
+};
+
 struct more_control {
 	struct termios output_tty;	/* output terminal */
 	struct termios original_tty;	/* original terminal settings */
@@ -157,9 +191,8 @@ struct more_control {
 		long line_num;		/* line number */
 	} context,
 	  screen_start;
-	cc_t last_key_command;		/* previous more key command */
-	int last_key_arg;		/* previous key command argument */
-	int last_colon_command;		/* is a colon-prefixed key command */
+	unsigned int leading_number;	/* number in front of key command */
+	struct number_command previous_command;	/* previous key command */
 	char *shell_line;		/* line to execute in subshell */
 #ifdef HAVE_MAGIC
 	magic_t magic;			/* libmagic database entries */
@@ -177,14 +210,15 @@ struct more_control {
 		fold_long_lines:1,	/* fold long lines */
 		hard_tabs:1,		/* print spaces instead of '\t' */
 		hard_tty:1,		/* is this hard copy terminal (a printer or such) */
+		leading_colon:1,	/* key command has leading ':' character */
 		is_paused:1,		/* is output paused */
 		no_quit_dialog:1,	/* suppress quit dialog */
 		no_scroll:1,		/* do not scroll, clear the screen and then display text */
 		no_tty_in:1,		/* is input in interactive mode */
 		no_tty_out:1,		/* is output in interactive mode */
 		print_banner:1,		/* print file name banner */
+		reading_num:1,		/* are we reading leading_number */
 		report_errors:1,	/* is an error reported */
-		run_previous_command:1,	/* run previous key command */
 		search_at_start:1,	/* search pattern defined at start up */
 		search_called:1,	/* previous more command was a search */
 		squeeze_spaces:1,	/* suppress white space */
@@ -736,6 +770,12 @@ static cc_t read_user_input(struct more_control *ctl)
 	cc_t c;
 
 	errno = 0;
+	/*
+	 * Key commands can be read() from either stderr or stdin.  If they
+	 * are read from stdin such as 'cat file.txt | more' then the pipe
+	 * input is understood as series key commands - and that is not
+	 * wanted.  Keep the read() reading from stderr.
+	 */
 	if (read(STDERR_FILENO, &c, 1) <= 0) {
 		if (errno != EINTR)
 			more_exit(ctl);
@@ -745,27 +785,124 @@ static cc_t read_user_input(struct more_control *ctl)
 	return c;
 }
 
-/* Read a decimal number from the terminal.  Set cmd to the non-digit
+/* Read a number and command from the terminal.  Set cmd to the non-digit
  * which terminates the number. */
-static int read_number(struct more_control *ctl, cc_t *cmd)
+static struct number_command read_command(struct more_control *ctl)
 {
-	int i;
-	cc_t ch;
-
-	i = 0;
-	ch = ctl->output_tty.c_cc[VKILL];
-	for (;;) {
-		ch = read_user_input(ctl);
-		if (isdigit(ch))
-			i = i * 10 + ch - '0';
-		else if (ch == ctl->output_tty.c_cc[VKILL])
-			i = 0;
-		else {
-			*cmd = ch;
+	cc_t input[8] = { 0 };
+	ssize_t i, ilen;
+	struct number_command cmd = { .key = more_kc_unknown_command };
+
+	/* See stderr note in read_user_input() */
+	if ((ilen = read(STDERR_FILENO, &input, sizeof(input))) <= 0)
+		return cmd;
+	if (2 < ilen) {
+		if (!memcmp(input, ARROW_UP, sizeof(ARROW_UP))) {
+			cmd.key = more_kc_backwards;
+			return cmd;
+		} else if (!memcmp(input, ARROW_DOWN, sizeof(ARROW_DOWN))) {
+			cmd.key = more_kc_skip_forward;
+			return cmd;
+		} else if (!memcmp(input, PAGE_UP, sizeof(PAGE_UP))) {
+			cmd.key = more_kc_backwards;
+			return cmd;
+		} else if (!memcmp(input, PAGE_DOWN, sizeof(PAGE_DOWN))) {
+			cmd.key = more_kc_skip_forward;
+			return cmd;
+		}
+	}
+	for (i = 0; i < ilen; i++) {
+		if (isdigit(input[i])) {
+			if (0 < ctl->reading_num) {
+				ctl->leading_number *= 10;
+				ctl->leading_number += input[i] - '0';
+			} else
+				ctl->leading_number = input[i] - '0';
+			ctl->reading_num = 1;
+			continue;
+		}
+		cmd.number = ctl->leading_number;
+		ctl->reading_num = 0;
+		ctl->leading_number = 0;
+		if (ctl->leading_colon) {
+			ctl->leading_colon = 0;
+			switch (input[i]) {
+			case 'f':
+				cmd.key = more_kc_display_file_and_line;
+				return cmd;
+			case 'n':
+				cmd.key = more_kc_next_file;
+				return cmd;
+			case 'p':
+				cmd.key = more_kc_previous_file;
+				return cmd;
+			default:
+				cmd.key = more_kc_unknown_command;
+				return cmd;
+			}
+		}
+		/* command is a single char */
+		switch (input[i]) {
+		case '.':
+			cmd.key = more_kc_repeat_previous;
+			break;
+		case ':':
+			ctl->leading_colon = 1;
+			break;
+		case 'b':
+		case CTRL('B'):
+			cmd.key = more_kc_backwards;
+			break;
+		case ' ':
+			cmd.key = more_kc_jump_lines_per_screen;
+			break;
+		case 'z':
+			cmd.key = more_kc_set_lines_per_screen;
+			break;
+		case 'd':
+		case CTRL('D'):
+			cmd.key = more_kc_set_scroll_len;
+			break;
+		case 'q':
+		case 'Q':
+			cmd.key = more_kc_quit;
+			break;
+		case 'f':
+		case 's':
+		case CTRL('F'):
+			cmd.key = more_kc_skip_forward;
+			break;
+		case '\n':
+			cmd.key = more_kc_next_line;
+			break;
+		case '\f':
+			cmd.key = more_kc_clear_screen;
+			break;
+		case '\'':
+			cmd.key = more_kc_previous_search_match;
+			break;
+		case '=':
+			cmd.key = more_kc_display_line;
+			break;
+		case 'n':
+			cmd.key = more_kc_repeat_search;
+			break;
+		case '/':
+			cmd.key = more_kc_search;
+			break;
+		case '!':
+			cmd.key = more_kc_run_shell;
+			break;
+		case '?':
+		case 'h':
+			cmd.key = more_kc_help;
+			break;
+		case 'v':
+			cmd.key = more_kc_run_editor;
 			break;
 		}
 	}
-	return i;
+	return cmd;
 }
 
 /* Change displayed file from command line list to next nskip, where nskip
@@ -1128,7 +1265,7 @@ static void run_shell(struct more_control *ctl, char *filename)
 	erase_to_col(ctl, 0);
 	putchar('!');
 	fflush(NULL);
-	if (ctl->run_previous_command && ctl->shell_line)
+	if (ctl->previous_command.key == more_kc_run_shell && ctl->shell_line)
 		fputs(ctl->shell_line, stdout);
 	else {
 		ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '!');
@@ -1145,60 +1282,6 @@ static void run_shell(struct more_control *ctl, char *filename)
 	execute(ctl, filename, ctl->shell, ctl->shell, "-c", ctl->shell_line, 0);
 }
 
-/* Execute a colon-prefixed command.  Returns <0 if not a command that
- * should cause more of the file to be printed. */
-static int colon_command(struct more_control *ctl, char *filename, int cmd, int nlines)
-{
-	char ch;
-
-	if (cmd == 0)
-		ch = read_user_input(ctl);
-	else
-		ch = cmd;
-	ctl->last_colon_command = ch;
-	switch (ch) {
-	case 'f':
-		erase_to_col(ctl, 0);
-		if (!ctl->no_tty_in)
-			ctl->prompt_len =
-			    printf(_("\"%s\" line %d"), ctl->file_names[ctl->argv_position], ctl->current_line);
-		else
-			ctl->prompt_len = printf(_("[Not a file] line %d"), ctl->current_line);
-		fflush(NULL);
-		return -1;
-	case 'n':
-		if (nlines == 0) {
-			if (ctl->argv_position >= ctl->num_files - 1)
-				more_exit(ctl);
-			nlines++;
-		}
-		putchar('\r');
-		erase_to_col(ctl, 0);
-		change_file(ctl, nlines);
-		return 0;
-	case 'p':
-		if (ctl->no_tty_in) {
-			fprintf(stderr, "\a");
-			return -1;
-		}
-		putchar('\r');
-		erase_to_col(ctl, 0);
-		if (nlines == 0)
-			nlines++;
-		change_file(ctl, -nlines);
-		return 0;
-	case '!':
-		run_shell(ctl, filename);
-		return -1;
-	case 'q':
-	case 'Q':
-		more_exit(ctl);
-	default:
-		fprintf(stderr, "\a");
-		return -1;
-	}
-}
-
 /* Skip n lines in the file f */
 static void skip_lines(struct more_control *ctl)
 {
@@ -1503,12 +1586,11 @@ static int skip_forwards(struct more_control *ctl, int nlines, cc_t comchar)
  * display in the current file, zero is returned. */
 static int more_key_command(struct more_control *ctl, char *filename)
 {
-	int nlines;
 	int retval = 0;
-	cc_t colonch;
-	int done = 0;
-	cc_t comchar;
+	int done = 0, search_again = 0;
 	char cmdbuf[INIT_BUF];
+	struct number_command cmd;
+
 	if (!ctl->report_errors)
 		output_prompt(ctl, filename);
 	else
@@ -1517,72 +1599,51 @@ static int more_key_command(struct more_control *ctl, char *filename)
 	for (;;) {
 		if (more_poll(ctl, -1) != 0)
 			continue;
-		nlines = read_number(ctl, &comchar);
-		ctl->run_previous_command = colonch = 0;
-		if (comchar == '.') {	/* Repeat last command */
-			ctl->run_previous_command++;
-			comchar = ctl->last_key_command;
-			nlines = ctl->last_key_arg;
-			if (ctl->last_key_command == ':')
-				colonch = ctl->last_colon_command;
-		}
-		ctl->last_key_command = comchar;
-		ctl->last_key_arg = nlines;
-		if (comchar == ctl->output_tty.c_cc[VERASE]) {
-			erase_to_col(ctl, 0);
-			output_prompt(ctl, filename);
+		cmd = read_command(ctl);
+		if (cmd.key == more_kc_unknown_command)
 			continue;
-		}
-		switch (comchar) {
-		case ':':
-			retval = colon_command(ctl, filename, colonch, nlines);
-			if (retval >= 0)
-				done++;
-			break;
-		case 'b':
-		case CTRL('B'):
+		if (cmd.key == more_kc_repeat_previous)
+			cmd = ctl->previous_command;
+		switch (cmd.key) {
+		case more_kc_backwards:
 			if (ctl->no_tty_in) {
 				fprintf(stderr, "\a");
 				return -1;
 			}
-			retval = skip_backwards(ctl, nlines);
+			retval = skip_backwards(ctl, cmd.number);
 			done = 1;
 			break;
-		case ' ':
-		case 'z':
-			if (nlines == 0)
-				nlines = ctl->lines_per_screen;
-			else if (comchar == 'z')
-				ctl->lines_per_screen = nlines;
-			retval = nlines;
+		case more_kc_jump_lines_per_screen:
+		case more_kc_set_lines_per_screen:
+			if (cmd.number == 0)
+				cmd.number = ctl->lines_per_screen;
+			else if (cmd.key == more_kc_set_lines_per_screen)
+				ctl->lines_per_screen = cmd.number;
+			retval = cmd.number;
 			done = 1;
 			break;
-		case 'd':
-		case CTRL('D'):
-			if (nlines != 0)
-				ctl->d_scroll_len = nlines;
+		case more_kc_set_scroll_len:
+			if (cmd.number != 0)
+				ctl->d_scroll_len = cmd.number;
 			retval = ctl->d_scroll_len;
 			done = 1;
 			break;
-		case 'q':
-		case 'Q':
+		case more_kc_quit:
 			more_exit(ctl);
-		case 's':
-		case 'f':
-		case CTRL('F'):
-			if (skip_forwards(ctl, nlines, comchar))
+		case more_kc_skip_forward:
+			if (skip_forwards(ctl, cmd.number, cmd.number))
 				retval = ctl->lines_per_screen;
 			done = 1;
 			break;
-		case '\n':
-			if (nlines != 0)
-				ctl->lines_per_screen = nlines;
+		case more_kc_next_line:
+			if (cmd.number != 0)
+				ctl->lines_per_screen = cmd.number;
 			else
-				nlines = 1;
-			retval = nlines;
+				cmd.number = 1;
+			retval = cmd.number;
 			done = 1;
 			break;
-		case '\f':
+		case more_kc_clear_screen:
 			if (!ctl->no_tty_in) {
 				more_clear_screen(ctl);
 				more_fseek(ctl, ctl->screen_start.row_num);
@@ -1594,7 +1655,7 @@ static int more_key_command(struct more_control *ctl, char *filename)
 				fprintf(stderr, "\a");
 				break;
 			}
-		case '\'':
+		case more_kc_previous_search_match:
 			if (!ctl->no_tty_in) {
 				erase_to_col(ctl, 0);
 				fputs(_("\n***Back***\n\n"), stdout);
@@ -1607,49 +1668,82 @@ static int more_key_command(struct more_control *ctl, char *filename)
 				fprintf(stderr, "\a");
 				break;
 			}
-		case '=':
+		case more_kc_display_line:
 			erase_to_col(ctl, 0);
 			ctl->prompt_len = printf("%d", ctl->current_line);
 			fflush(NULL);
 			break;
-		case 'n':
+		case more_kc_display_file_and_line:
+			erase_to_col(ctl, 0);
+			if (!ctl->no_tty_in)
+				ctl->prompt_len =
+				    printf(_("\"%s\" line %d"),
+				           ctl->file_names[ctl->argv_position], ctl->current_line);
+			else
+				ctl->prompt_len = printf(_("[Not a file] line %d"),
+							 ctl->current_line);
+			fflush(NULL);
+			break;
+		case more_kc_repeat_search:
 			if (!ctl->previous_search) {
 				more_error(ctl, _("No previous regular expression"));
 				break;
 			}
-			ctl->run_previous_command = 1;
+			search_again = 1;
 			/* fallthrough */
-		case '/':
-			if (nlines == 0)
-				nlines++;
+		case more_kc_search:
+			if (cmd.number == 0)
+				cmd.number++;
 			erase_to_col(ctl, 0);
 			putchar('/');
 			ctl->prompt_len = 1;
 			fflush(NULL);
-			if (ctl->run_previous_command) {
+			if (search_again) {
 				fputc('\r', stderr);
-				search(ctl, ctl->previous_search, nlines);
+				search(ctl, ctl->previous_search, cmd.number);
+				search_again = 0;
 			} else {
 				ttyin(ctl, cmdbuf, sizeof(cmdbuf) - 2, '/');
 				fputc('\r', stderr);
 				ctl->next_search = xstrdup(cmdbuf);
-				search(ctl, ctl->next_search, nlines);
+				search(ctl, ctl->next_search, cmd.number);
 			}
 			retval = ctl->lines_per_screen - 1;
 			done = 1;
 			break;
-		case '!':
+		case more_kc_run_shell:
 			run_shell(ctl, filename);
 			break;
-		case '?':
-		case 'h':
+		case more_kc_help:
 			if (ctl->no_scroll)
 				more_clear_screen(ctl);
 			erase_to_col(ctl, 0);
 			runtime_usage();
 			output_prompt(ctl, filename);
 			break;
-		case 'v':	/* This case should go right before default */
+		case more_kc_next_file:
+			putchar('\r');
+			erase_to_col(ctl, 0);
+			if (cmd.number == 0)
+				cmd.number = 1;
+			if (ctl->argv_position + cmd.number >= (unsigned int)ctl->num_files)
+				more_exit(ctl);
+			change_file(ctl, cmd.number);
+			done = 1;
+			break;
+		case more_kc_previous_file:
+			if (ctl->no_tty_in) {
+				fprintf(stderr, "\a");
+				break;
+			}
+			putchar('\r');
+			erase_to_col(ctl, 0);
+			if (cmd.number == 0)
+				cmd.number = 1;
+			change_file(ctl, -cmd.number);
+			done = 1;
+			break;
+		case more_kc_run_editor:	/* This case should go right before default */
 			if (!ctl->no_tty_in) {
 				execute_editor(ctl, cmdbuf, filename);
 				break;
@@ -1670,8 +1764,11 @@ static int more_key_command(struct more_control *ctl, char *filename)
 			fflush(NULL);
 			break;
 		}
-		if (done)
+		ctl->previous_command = cmd;
+		if (done) {
+			cmd.key = more_kc_unknown_command;
 			break;
+		}
 	}
 	putchar('\r');
 	ctl->no_quit_dialog = 1;
-- 
2.26.2

