Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33339 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcEIV1u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id r12so22518101wme.0
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/12] write: remove unnecessary utmp variables
Date: Mon,  9 May 2016 22:27:25 +0100
Message-Id: <1462829248-6935-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getutent() calls are not thread safe, and reference documentation is
recommending to copy the context of the structures if information is wished
to be stored.  But excessive copying does not seem to be relevant for single
threaded application.

Reference: http://www.gnu.org/software/libc/manual/html_node/Manipulating-the-Database.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 1ae3c82..403d4a7 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -126,17 +126,15 @@ static int check_tty(char *tty, int *mesg_allowed, time_t *tty_atime, int shower
  */
 static int check_utmp(const struct write_control *ctl)
 {
-	struct utmp u;
-	struct utmp *uptr;
+	struct utmp *u;
 	int res = 1;
 
 	utmpname(_PATH_UTMP);
 	setutent();
 
-	while ((uptr = getutent())) {
-		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(ctl->dst_login, u.ut_user, sizeof(u.ut_user)) == 0 &&
-		    strncmp(ctl->dst_tty, u.ut_line, sizeof(u.ut_line)) == 0) {
+	while ((u = getutent())) {
+		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0 &&
+		    strncmp(ctl->dst_tty, u->ut_line, sizeof(u->ut_line)) == 0) {
 			res = 0;
 			break;
 		}
@@ -159,38 +157,34 @@ static int check_utmp(const struct write_control *ctl)
  */
 static void search_utmp(struct write_control *ctl)
 {
-	struct utmp u;
-	struct utmp *uptr;
+	struct utmp *u;
 	time_t best_atime = 0, tty_atime;
 	int num_ttys = 0, valid_ttys = 0, mesg_allowed = 0, user_is_me = 0;
-	char atty[sizeof(u.ut_line) + 1];
 
 	utmpname(_PATH_UTMP);
 	setutent();
 
-	while ((uptr = getutent())) {
-		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(ctl->dst_login, u.ut_user, sizeof(u.ut_user)) == 0) {
+	while ((u = getutent())) {
+		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0) {
 			num_ttys++;
-			xstrncpy(atty, u.ut_line, sizeof(atty));
-			if (check_tty(atty, &mesg_allowed, &tty_atime, 0))
+			if (check_tty(u->ut_line, &mesg_allowed, &tty_atime, 0))
 				/* bad term? skip */
 				continue;
 			if (ctl->src_uid && !mesg_allowed)
 				/* skip ttys with msgs off */
 				continue;
-			if (strcmp(atty, ctl->src_tty) == 0) {
+			if (strcmp(u->ut_line, ctl->src_tty) == 0) {
 				user_is_me = 1;
 				/* don't write to yourself */
 				continue;
 			}
-			if (u.ut_type != USER_PROCESS)
+			if (u->ut_type != USER_PROCESS)
 				/* it's not a valid entry */
 				continue;
 			valid_ttys++;
 			if (tty_atime > best_atime) {
 				best_atime = tty_atime;
-				xstrncpy(ctl->dst_tty, atty, sizeof(ctl->dst_tty));
+				xstrncpy(ctl->dst_tty, u->ut_line, sizeof(ctl->dst_tty));
 			}
 		}
 	}
-- 
2.8.2

