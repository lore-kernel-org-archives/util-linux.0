Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AA0C48BDF
	for <util-linux@archiver.kernel.org>; Thu, 24 Jun 2021 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A612B613F6
	for <util-linux@archiver.kernel.org>; Thu, 24 Jun 2021 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFXNJe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 24 Jun 2021 09:09:34 -0400
Received: from server.contractcoder.biz ([67.209.116.215]:51780 "EHLO
        server.contractcoder.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhFXNJd (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 24 Jun 2021 09:09:33 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2021 09:09:33 EDT
Received: by server.contractcoder.biz (Postfix, from userid 109)
        id 7F0862500944; Thu, 24 Jun 2021 13:59:21 +0100 (BST)
Received: from contractcoder.biz (cpc137950-brom13-2-0-cust104.16-1.cable.virginm.net [82.46.16.105])
        by server.contractcoder.biz (Postfix) with ESMTPSA id 61C612500941
        for <util-linux@vger.kernel.org>; Thu, 24 Jun 2021 13:59:19 +0100 (BST)
Date:   Thu, 24 Jun 2021 13:59:18 +0100
From:   Ian Jones <ian@contractcoder.biz>
To:     util-linux@vger.kernel.org
Subject: POSIX compliance patch preventing exit on EOF without -e flag.
Message-ID: <20210624125918.GB2541@contractcoder.biz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, 

I hope you don't mind my sending you this patch. I ran into a problem
with a piece of software that relies on POSIX compliant implementation
of more, that only exits on EOF with the addition of a -e flag.

Having checked the POSIX documentation for more this would appear to be
correct behavior:
https://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.html

Best regards,

Ian

--OgqxwSJOaUobr8KG
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Implemented-e-and-changed-default-behavior-to-be-POS.patch"

From 65ee6afeeb4940d7ea0a83dcb3c2c3d2d78f2503 Mon Sep 17 00:00:00 2001
From: Ian Jones <ian@contractcoder.biz>
Date: Thu, 24 Jun 2021 13:40:52 +0100
Subject: [PATCH] Implemented -e and changed default behavior to be POSIX
 compliant:
 https://pubs.opengroup.org/onlinepubs/9699919799/utilities/more.html

---
 text-utils/more.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 6299e8d82..a5faea286 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -207,6 +207,7 @@ struct more_control {
 		eat_newline:1,		/* is newline ignored after 80 cols */
 		erase_input_ok:1,	/* is erase input supported */
 		erase_previous_ok:1,	/* is erase previous supported */
+		exit_on_eof:1,	    /* exit on EOF */
 		first_file:1,		/* is the input file the first in list */
 		fold_long_lines:1,	/* fold long lines */
 		hard_tabs:1,		/* print spaces instead of '\t' */
@@ -243,6 +244,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	printf("%s\n", _(" -l, --no-pause        suppress pause after form feed"));
 	printf("%s\n", _(" -c, --print-over      do not scroll, display text and clean line ends"));
 	printf("%s\n", _(" -p, --clean-print     do not scroll, clean screen and display text"));
+	printf("%s\n", _(" -e, --exit-on-eof     exit on EOF"));
 	printf("%s\n", _(" -s, --squeeze         squeeze multiple blank lines into one"));
 	printf("%s\n", _(" -u, --plain           suppress underlining and bold"));
 	printf("%s\n", _(" -n, --lines <number>  the number of lines per screenful"));
@@ -264,6 +266,7 @@ static void argscan(struct more_control *ctl, int as_argc, char **as_argv)
 		{ "no-pause",    no_argument,       NULL, 'l' },
 		{ "print-over",  no_argument,       NULL, 'c' },
 		{ "clean-print", no_argument,       NULL, 'p' },
+		{ "exit-on-eof", no_argument,       NULL, 'e' },
 		{ "squeeze",     no_argument,       NULL, 's' },
 		{ "plain",       no_argument,       NULL, 'u' },
 		{ "lines",       required_argument, NULL, 'n' },
@@ -324,7 +327,8 @@ static void argscan(struct more_control *ctl, int as_argc, char **as_argv)
 		case 'n':
 			ctl->lines_per_screen = strtou16_or_err(optarg, _("argument error"));
 			break;
-		case 'e':	/* ignored silently to be posix compliant */
+		case 'e':
+            ctl->exit_on_eof = 1;
 			break;
 		case 'V':
 			print_version(EXIT_SUCCESS);
@@ -1809,7 +1813,7 @@ static void screen(struct more_control *ctl, int num_lines)
 
 	for (;;) {
 		while (num_lines > 0 && !ctl->is_paused) {
-			if ((nchars = get_line(ctl, &length)) == EOF) {
+			if ((nchars = get_line(ctl, &length)) == EOF && ctl->exit_on_eof) {
 				if (ctl->clear_line_ends)
 					putp(ctl->clear_rest);
 				return;
@@ -1834,7 +1838,7 @@ static void screen(struct more_control *ctl, int num_lines)
 			num_lines--;
 		}
 		fflush(NULL);
-		if ((c = more_getc(ctl)) == EOF) {
+		if ((c = more_getc(ctl)) == EOF && ctl->exit_on_eof) {
 			if (ctl->clear_line_ends)
 				putp(ctl->clear_rest);
 			return;
-- 
2.20.1


--OgqxwSJOaUobr8KG--
