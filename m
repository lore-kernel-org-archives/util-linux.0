Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD8C38A24
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710912075A
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdRahLL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgEFTTc (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEFTTb (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 15:19:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E0EC061A0F
        for <util-linux@vger.kernel.org>; Wed,  6 May 2020 12:19:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so4035866wml.2
        for <util-linux@vger.kernel.org>; Wed, 06 May 2020 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:organization:content-transfer-encoding;
        bh=CCXAOeViMZOQ94+bKAMPFJTXVj00T2pEcJs9VFeu4K0=;
        b=YdRahLL56YktgdgD1q9VTMDNnzFs7/7P9U1i9axhzHXe+2b4z1fD2WPVgCT/pQ4U33
         grnWTuyYs7FXBoGMqp1JLbDCGvY/IF6bcQIzgNtpORRMea6xkeNX8nPvm41z3uPeZ3l+
         ufYyNk01O81ufzdYDG++e9cZi5b18aC7m2z3szW1ssOKXp4rZJi+4jyaxitCFCMuMG94
         AltaxhQyIWT/eogCGA/xMItvs1i32+yh18CjF+PlNINxW9adckIPPrXX32ULyY5ne/85
         lp4Y129ID0EFd47vPH0jSq9upXPmB3L6YtJD9k3E5nTdGvzttnvor/ifrGCb7CX7xxyx
         656Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:organization
         :content-transfer-encoding;
        bh=CCXAOeViMZOQ94+bKAMPFJTXVj00T2pEcJs9VFeu4K0=;
        b=KGAx15d0WWXDCIo41izJbLkrdn5KK+m5uBly70ihQx/DnIhQQlwQUoP7q5kuqNDsGU
         xO64HNNeggz88+wX6qEbdsj/w1sloe5R+IwTrpSsyCTeWphHwcA/C+cBI85DC6M9ep5N
         9HIaOrJeN+07UY8OINYkmTInNxgZ9wyfS70EIxJwFKuyLysrtpCR+ySDLXhrmAS6DaqA
         IpMC3ls1Ehn7IsRoqRHPaUorb5hWkgsqgcIBl59hTl9aSoAnIzDQ+o0/z99S/Gqvu/du
         7BF1MpBQlnfMbpiQ7WCwiARq1dMIoFgUpgt49wz3oK8gERXYnj1q2vdbw886YmOa/x+F
         6wmA==
X-Gm-Message-State: AGi0PuaOkEVBpeZDoNAOT5M4q5H4V8bPpz8fO1f7KknjeqgTcoZEL+tf
        /K+LNt2eWms7SzjRtdgO73iKJMPe
X-Google-Smtp-Source: APiQypJF4Iu+S1eI7mfO8SsLIXbRBfI9wS5JkfqtCVoCiIYSl+5hOrqJ1ID1oWLnhXLMbFi55HFFCg==
X-Received: by 2002:a1c:ded4:: with SMTP id v203mr6149432wmg.106.1588792769771;
        Wed, 06 May 2020 12:19:29 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:8b7c:8150:5102:21e9])
        by smtp.gmail.com with ESMTPSA id g186sm4542545wme.7.2020.05.06.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:19:29 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] more: use libmagic to identify binary files
Date:   Wed,  6 May 2020 20:19:22 +0100
Message-Id: <20200506191923.5272-2-kerolasa@iki.fi>
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

As the old commend said: 'This code would best be shared with the file(1)
program or, perhaps, more should not try to be so smart'.  Now at configure
time one can choose whether more(1) is sharing code with file(1), or not.

Addresses: http://bugs.debian.org/139205
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac             | 12 ++++++++++
 text-utils/Makemodule.am |  2 +-
 text-utils/more.c        | 52 +++++++++++++++++++++++++---------------
 3 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1428dc893..8f50e8102 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1501,6 +1501,18 @@ AS_IF([test "x$with_libz" = xno], [have_z=no], [
   AC_CHECK_LIB([z], [crc32], [have_z=yes], [have_z=no])
 ])
 
+AC_ARG_WITH([libmagic],
+  AS_HELP_STRING([--without-libmagic], [compile without libmagic]),
+  [], [with_libmagic=auto]
+)
+AS_IF([test "x$with_libmagic" = xno], [have_magic=no], [
+  AC_CHECK_LIB([magic], [magic_open], [
+    AC_DEFINE([HAVE_MAGIC], [1], [Define to 1 if you have the libmagic present.])
+    MAGIC_LIBS="-lmagic"
+  ])
+])
+AC_SUBST([MAGIC_LIBS])
+
 
 AC_ARG_ENABLE([cramfs],
   AS_HELP_STRING([--disable-cramfs], [do not build fsck.cramfs, mkfs.cramfs]),
diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index 3f10934e9..6c4b52082 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -80,7 +80,7 @@ bin_PROGRAMS += more
 dist_man_MANS += text-utils/more.1
 more_SOURCES = text-utils/more.c
 more_CFLAGS = $(AM_CFLAGS) $(BSD_WARN_CFLAGS)
-more_LDADD = $(LDADD) libcommon.la
+more_LDADD = $(LDADD) $(MAGIC_LIBS) libcommon.la
 if HAVE_TINFO
 more_LDADD += $(TINFO_LIBS)
 more_LDADD += $(TINFO_CFLAGS)
diff --git a/text-utils/more.c b/text-utils/more.c
index 69a0b89f6..014b40a6c 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -74,13 +74,17 @@
 # include <term.h>
 #endif
 
-#include "env.h"
+#ifdef HAVE_MAGIC
+# include <magic.h>
+#endif
+
 #include "strutils.h"
 #include "nls.h"
 #include "xalloc.h"
 #include "widechar.h"
 #include "closestream.h"
 #include "rpmatch.h"
+#include "env.h"
 
 #ifdef TEST_PROGRAM
 # define NON_INTERACTIVE_MORE 1
@@ -157,6 +161,9 @@ struct more_control {
 	int last_key_arg;		/* previous key command argument */
 	int last_colon_command;		/* is a colon-prefixed key command */
 	char *shell_line;		/* line to execute in subshell */
+#ifdef HAVE_MAGIC
+	magic_t magic;			/* libmagic database entries */
+#endif
 	unsigned int
 		bad_stdout:1,		/* true if overwriting does not turn off standout */
 		catch_suspend:1,	/* we should catch the SIGTSTP signal */
@@ -350,19 +357,24 @@ static void print_separator(const int c, int n)
 	putchar('\n');
 }
 
-/* magic --
- *	check for file magic numbers.  This code would best be shared
- *	with the file(1) program or, perhaps, more should not try to be
- *	so smart. */
-static int check_magic(FILE *f, char *fs)
+/* check_magic -- check for file magic numbers. */
+static int check_magic(struct more_control *ctl, char *fs)
 {
+#ifdef HAVE_MAGIC
+	const char *mime_encoding = magic_descriptor(ctl->magic, fileno(ctl->current_file));
+
+	if (!mime_encoding || !(strcmp("binary", mime_encoding))) {
+		printf(_("\n******** %s: Not a text file ********\n\n"), fs);
+		return 1;
+	}
+#else
 	signed char twobytes[2];
 
 	/* don't try to look ahead if the input is unseekable */
-	if (fseek(f, 0L, SEEK_SET))
+	if (fseek(ctl->current_file, 0L, SEEK_SET))
 		return 0;
 
-	if (fread(twobytes, 2, 1, f) == 1) {
+	if (fread(twobytes, 2, 1, ctl->current_file) == 1) {
 		switch (twobytes[0] + (twobytes[1] << 8)) {
 		case 0407:	/* a.out obj */
 		case 0410:	/* a.out exec */
@@ -376,7 +388,8 @@ static int check_magic(FILE *f, char *fs)
 			return 1;
 		}
 	}
-	fseek(f, 0L, SEEK_SET);	/* rewind() not necessary */
+	fseek(ctl->current_file, 0L, SEEK_SET);	/* rewind() not necessary */
+#endif
 	return 0;
 }
 
@@ -394,23 +407,17 @@ static void checkf(struct more_control *ctl, char *fs)
 	    (fstat(fileno(ctl->current_file), &st) != 0)) {
 		if (ctl->clear_line_ends)
 			putp(ctl->erase_line);
-		warn(_("stat of %s failed"), fs);
-		ctl->current_file = NULL;
+		warn(_("cannot open %s"), fs);
 		return;
 	}
+#ifndef HAVE_MAGIC
 	if ((st.st_mode & S_IFMT) == S_IFDIR) {
 		printf(_("\n*** %s: directory ***\n\n"), fs);
 		ctl->current_file = NULL;
 		return;
 	}
-	ctl->current_line = 0;
-	ctl->file_position = 0;
-	if ((ctl->current_file = fopen(fs, "r")) == NULL) {
-		fflush(stdout);
-		warn(_("cannot open %s"), fs);
-		return;
-	}
-	if (check_magic(ctl->current_file, fs)) {
+#endif
+	if (check_magic(ctl, fs)) {
 		fclose(ctl->current_file);
 		ctl->current_file = NULL;
 		return;
@@ -704,6 +711,9 @@ static void reset_tty(struct more_control *ctl)
 /* Clean up terminal state and exit. Also come here if interrupt signal received */
 static void __attribute__((__noreturn__)) more_exit(struct more_control *ctl)
 {
+#ifdef HAVE_MAGIC
+	magic_close(ctl->magic);
+#endif
 	reset_tty(ctl);
 	if (ctl->clear_line_ends) {
 		putchar('\r');
@@ -1906,6 +1916,10 @@ int main(int argc, char **argv)
 
 	initterm(&ctl);
 
+#ifdef HAVE_MAGIC
+	ctl.magic = magic_open(MAGIC_MIME_ENCODING | MAGIC_SYMLINK);
+	magic_load(ctl.magic, NULL);
+#endif
 	prepare_line_buffer(&ctl);
 
 	ctl.d_scroll_len = ctl.lines_per_page / 2 - 1;
-- 
2.26.2

