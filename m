Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab1HaKtJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 31 Aug 2011 06:49:09 -0400
Date: Wed, 31 Aug 2011 12:48:59 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Cc: "Gabor Z. Papp" <gzp@papp.hu>
Subject: dmesg(1) bug
Message-ID: <20110831104859.GB1547@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 There is a bug in the new dmesg(1) code, affected are systems without
 CONFIG_PRINTK_TIME and maybe some very old systems with kernel <= 2.6.16.
 The problem is that dmesg incorrectly works with empty lines (e.g. "<6>\n").

 Possible workaround is: dmesg -r

 It's possible to reproduce by:

    $ dmesg -r | wc -l
    $ dmesg | wc -l

 on affected systems the commands return different number of lines.

 The bugfix is below.  ... boys, why nobody uses -rc releases?

    Karel


>From 22f69825778f992ff98ed100252bf5e00a15d9d1 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 31 Aug 2011 12:28:39 +0200
Subject: [PATCH] dmesg: fix for non-CONFIG_PRINTK_TIME kernels

 * dmesg(1) incorrectly assumes that lines like "<6>\n"
   are broken.

 * it's more robust to assume the end of the record is "\n<"

 * print \n for empty lines

Reported-by: "Gabor Z. Papp" <gzp@papp.hu>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/dmesg.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 6090f4e..8e7bb4b 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -442,12 +442,12 @@ static int get_next_record(struct dmesg_control *ctl, struct dmesg_record *rec)
 
 		if (!begin)
 			begin = p;
-		if (*p == '\n')
-			end = p;
 		if (i + 1 == rec->next_size) {
 			end = p + 1;
 			i++;
-		}
+		} else if (*p == '\n' && *(p + 1) == '<')
+			end = p;
+
 		if (begin && !*begin)
 			begin = NULL;	/* zero(s) at the end of the buffer? */
 		if (!begin || !end)
@@ -469,9 +469,6 @@ static int get_next_record(struct dmesg_control *ctl, struct dmesg_record *rec)
 			}
 		}
 
-		if (end <= begin)
-			return -1;	/* error */
-
 		if (*begin == '[' && (*(begin + 1) == ' ' ||
 				      isdigit(*(begin + 1)))) {
 			if (ctl->delta || ctl->ctime) {
@@ -534,12 +531,15 @@ static void print_buffer(const char *buf, size_t size,
 	}
 
 	while (get_next_record(ctl, &rec) == 0) {
-		if (!rec.mesg_size)
-			continue;
 
 		if (!accept_record(ctl, &rec))
 			continue;
 
+		if (!rec.mesg_size) {
+			putchar('\n');
+			continue;
+		}
+
 		if (ctl->decode && rec.level >= 0 && rec.facility >= 0)
 			printf("%-6s:%-6s: ", facility_names[rec.facility].name,
 					      level_names[rec.level].name);
-- 
1.7.6

