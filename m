Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:62769 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756460AbcLAIwR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:52:17 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LlpJU-1clQnn1uds-00ZMCW for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:52:15 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/11] login-utils: avoid using the defined utmp sizes.
Date: Thu,  1 Dec 2016 09:52:08 +0100
Message-Id: <1480582332-17407-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c | 18 +++++++++---------
 term-utils/write.c |  2 +-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 42fb914..da7ed36 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -383,7 +383,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	char		logouttime[LAST_TIMESTAMP_LEN];
 	char		length[LAST_TIMESTAMP_LEN];
 	char		final[512];
-	char		utline[UT_LINESIZE+1];
+	char		utline[sizeof(p->ut_line) + 1];
 	char		domain[256];
 	char		*s;
 	int		mins, hours, days;
@@ -394,7 +394,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	 *	uucp and ftp have special-type entries
 	 */
 	utline[0] = 0;
-	strncat(utline, p->ut_line, UT_LINESIZE);
+	strncat(utline, p->ut_line, sizeof(p->ut_line));
 	if (strncmp(utline, "ftp", 3) == 0 && isdigit(utline[3]))
 		utline[3] = 0;
 	if (strncmp(utline, "uucp", 4) == 0 && isdigit(utline[4]))
@@ -406,7 +406,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	if (ctl->show) {
 		char **walk;
 		for (walk = ctl->show; *walk; walk++) {
-			if (strncmp(p->ut_user, *walk, UT_NAMESIZE) == 0 ||
+			if (strncmp(p->ut_user, *walk, sizeof(p->ut_user)) == 0 ||
 			    strcmp(utline, *walk) == 0 ||
 			    (strncmp(utline, "tty", 3) == 0 &&
 			     strcmp(utline + 3, *walk) == 0)) break;
@@ -504,7 +504,7 @@ static int list(const struct last_control *ctl, struct utmp *p, time_t logout_ti
 	if (ctl->usedns || ctl->useip)
 		r = dns_lookup(domain, sizeof(domain), ctl->useip, p->ut_addr_v6);
 	if (r < 0) {
-		len = UT_HOSTSIZE;
+		len = sizeof(p->ut_host);
 		if (len >= (int)sizeof(domain)) len = sizeof(domain) - 1;
 		domain[0] = 0;
 		strncat(domain, p->ut_host, len);
@@ -798,7 +798,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 			for (p = ulist; p; p = next) {
 				next = p->next;
 				if (strncmp(p->ut.ut_line, ut.ut_line,
-				    UT_LINESIZE) == 0) {
+				    sizeof(ut.ut_line)) == 0) {
 					/* Show it */
 					if (c == 0) {
 						quit = list(ctl, &ut, p->ut.ut_tv.tv_sec, R_NORMAL);
@@ -987,10 +987,10 @@ int main(int argc, char **argv)
 			ctl.until = (time_t) (p / 1000000);
 			break;
 		case 'w':
-			if (ctl.name_len < UT_NAMESIZE)
-				ctl.name_len = UT_NAMESIZE;
-			if (ctl.domain_len < UT_HOSTSIZE)
-				ctl.domain_len = UT_HOSTSIZE;
+			if (ctl.name_len < sizeof(((struct utmp *) 0)->ut_user))
+				ctl.name_len = sizeof(((struct utmp *) 0)->ut_user);
+			if (ctl.domain_len < sizeof(((struct utmp *) 0)->ut_host))
+				ctl.domain_len = sizeof(((struct utmp *) 0)->ut_host);
 			break;
 		case '0': case '1': case '2': case '3': case '4':
 		case '5': case '6': case '7': case '8': case '9':
diff --git a/term-utils/write.c b/term-utils/write.c
index e39b848..4f8f21e 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -164,7 +164,7 @@ static void search_utmp(struct write_control *ctl)
 	struct utmp *u;
 	time_t best_atime = 0, tty_atime;
 	int num_ttys = 0, valid_ttys = 0, tty_writeable = 0, user_is_me = 0;
-	char path[UT_LINESIZE + 6];
+	char path[sizeof(u->ut_line) + 6];
 
 	utmpname(_PATH_UTMP);
 	setutent();
-- 
1.8.5.6

