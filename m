Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37938 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab2ENHwF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 May 2012 03:52:05 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 96C63A3823
	for <util-linux@vger.kernel.org>; Mon, 14 May 2012 09:52:03 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] lib/tt: make get_terminal_width available externally
Date: Mon, 14 May 2012 09:51:57 +0200
Message-Id: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also, rename get_terminal_width() to tt_get_terminal_width()
to match naming convention of other exported functions.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/tt.h |    1 +
 lib/tt.c     |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tt.h b/include/tt.h
index 36d3bb2..9aa04db 100644
--- a/include/tt.h
+++ b/include/tt.h
@@ -86,5 +86,6 @@ extern struct tt_line *tt_add_line(struct tt *tb, struct tt_line *parent);
 
 extern int tt_line_set_data(struct tt_line *ln, int colnum, const char *data);
 extern int tt_line_set_userdata(struct tt_line *ln, void *data);
+extern int tt_get_terminal_width(void);
 
 #endif /* UTIL_LINUX_TT_H */
diff --git a/lib/tt.c b/lib/tt.c
index 1b5fbac..af3a34e 100644
--- a/lib/tt.c
+++ b/lib/tt.c
@@ -253,7 +253,7 @@ int tt_line_set_data(struct tt_line *ln, int colnum, const char *data)
 	return 0;
 }
 
-static int get_terminal_width(void)
+int tt_get_terminal_width(void)
 {
 #ifdef TIOCGSIZE
 	struct ttysize	t_win;
@@ -750,7 +750,7 @@ int tt_print_table(struct tt *tb)
 		return -1;
 
 	if (tb->first_run && !tb->termwidth) {
-		tb->termwidth = get_terminal_width();
+		tb->termwidth = tt_get_terminal_width();
 		if (tb->termwidth <= 0)
 			tb->termwidth = 80;
 	}
-- 
1.7.7

