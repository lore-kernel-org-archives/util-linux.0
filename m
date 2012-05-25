Return-Path: util-linux-owner@vger.kernel.org
Received: from relay1.mentorg.com ([192.94.38.131]:51980 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758319Ab2EYSQd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 May 2012 14:16:33 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=EU1-MAIL.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1SXz3w-0007nQ-IM from Thomas_Schwinge@mentor.com
	for util-linux@vger.kernel.org; Fri, 25 May 2012 11:16:32 -0700
From: Thomas Schwinge <thomas@codesourcery.com>
To: util-linux@vger.kernel.org
Cc: Thomas Schwinge <thomas@codesourcery.com>
Subject: [PATCH 5/7] write: Use PATH_MAX instead of MAXPATHLEN, as elsewhere.
Date: Fri, 25 May 2012 20:16:16 +0200
Message-Id: <1337969778-3154-5-git-send-email-thomas@codesourcery.com>
In-Reply-To: <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
---
 term-utils/write.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index c8aca7e..901ddc4 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -102,7 +102,7 @@ int main(int argc, char **argv)
 	time_t atime;
 	uid_t myuid;
 	int msgsok, myttyfd, c;
-	char tty[MAXPATHLEN], *mytty;
+	char tty[PATH_MAX], *mytty;
 
 	static const struct option longopts[] = {
 		{"version", no_argument, NULL, 'V'},
@@ -296,7 +296,7 @@ void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
 {
 	struct stat s;
-	char path[MAXPATHLEN];
+	char path[PATH_MAX];
 
 	if (strlen(tty) + 6 > sizeof(path))
 		return 1;
@@ -321,7 +321,7 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 	char *login, *pwuid, *nows;
 	struct passwd *pwd;
 	time_t now;
-	char path[MAXPATHLEN], host[MAXHOSTNAMELEN], line[512];
+	char path[PATH_MAX], host[MAXHOSTNAMELEN], line[512];
 
 	/* Determine our login name(s) before the we reopen() stdout */
 	if ((pwd = getpwuid(myuid)) != NULL)
-- 
1.7.9

