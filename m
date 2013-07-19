Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.treblig.org ([80.68.94.177]:39186 "EHLO mx.treblig.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752348Ab3GSWfD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Jul 2013 18:35:03 -0400
Date: Fri, 19 Jul 2013 23:35:01 +0100
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, rleigh@debian.org
Subject: [PATCH] get_line fixes for wide characters and overflows
Message-ID: <20130719223501.GA13613@gallifrey>
References: <20130716232033.GD9944@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130716232033.GD9944@gallifrey>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
  This is a fix for the bug I reported with 'more' crashing:
http://marc.info/?l=util-linux-ng&m=137401887913346&w=2

It seems to work for me, but I'd appreciate another pair of eyes on it,
especially a pair with a better understanding of wide characters.

I could also see that it might be nice to add my failing case from the bug
as a regression test, but is there a good way to get those tests to run
with a given idea of terminal width/character encoding?

Dave


commit 96c2d8eaed137cbb9d62f0f50bdf689aa8a0f2e3
Author: Dr. David Alan Gilbert <dave@treblig.org>
Date:   Fri Jul 19 23:19:39 2013 +0100

    Ensure there is space at the end of the buffer for the termination
    characters, and that there is space for a full wide character.
    
    Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

diff --git a/text-utils/more.c b/text-utils/more.c
index 3bbeede..b81e32a 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -43,6 +43,7 @@
  *	modified mem allocation handling for util-linux
  */
 
+#include <assert.h>
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
@@ -167,6 +168,9 @@ int shellp;			/* A previous shell command exists */
 sigjmp_buf restore;
 char *Line;			/* Line buffer */
 size_t LineLen;			/* size of Line buffer */
+const unsigned int line_end_space = 2; /* For the nl and \0 at the end */
+const unsigned int wchar_max_bytes = 4; /* I don't see a portable way to
+					determine this */
 int Lpp = LINES_PER_PAGE;	/* lines per page */
 char *Clear;			/* clear screen */
 char *eraseln;			/* erase line */
@@ -827,7 +831,7 @@ static void prompt(char *filename)
 void prepare_line_buffer(void)
 {
 	char *nline;
-	size_t nsz = Mcol * 4;
+	size_t nsz = Mcol * wchar_max_bytes + line_end_space;
 
 	if (LineLen >= nsz)
 		return;
@@ -872,7 +876,7 @@ int get_line(register FILE *f, int *length)
 		Currline++;
 		c = Getc(f);
 	}
-	while (p < &Line[LineLen - 1]) {
+	while (p <= &Line[LineLen - (line_end_space + wchar_max_bytes)]) {
 #ifdef HAVE_WIDECHAR
 		if (fold_opt && use_mbc_buffer_flag && MB_CUR_MAX > 1) {
 			use_mbc_buffer_flag = 0;
@@ -961,7 +965,7 @@ int get_line(register FILE *f, int *length)
 					my_putstring(eraseln);
 					promptlen = 0;
 				} else {
-					for (--p; p < &Line[LineLen - 1];) {
+					for (--p; p <= &Line[LineLen - (1 + line_end_space)];) {
 						*p++ = ' ';
 						if ((++column & 7) == 0)
 							break;
@@ -1039,6 +1043,7 @@ int get_line(register FILE *f, int *length)
 	if (colflg && eatnl && Wrap) {
 		*p++ = '\n';	/* simulate normal wrap */
 	}
+	assert(p < &Line[LineLen]);
 	*length = p - Line;
 	*p = 0;
 	return (column);
