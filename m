Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:64289 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab2JNUWk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:22:40 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680717wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:22:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/13] ipcs: clean up permissions printing
Date: Sun, 14 Oct 2012 21:22:20 +0100
Message-Id: <1350246145-10600-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
References: <1350246145-10600-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove old function, and make the new have same name as the old had.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/ipcs.c | 33 ++++-----------------------------
 1 file changed, 4 insertions(+), 29 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 373e85e..960039e 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -691,32 +691,7 @@ int main (int argc, char **argv)
 	return EXIT_SUCCESS;
 }
 
-static void print_perms (int id, struct ipc_perm *ipcp)
-{
-	struct passwd *pw;
-	struct group *gr;
-
-	printf ("%-10d %-10o", id, ipcp->mode & 0777);
-
-	if ((pw = getpwuid(ipcp->cuid)))
-		printf(" %-10s", pw->pw_name);
-	else
-		printf(" %-10u", ipcp->cuid);
-	if ((gr = getgrgid(ipcp->cgid)))
-		printf(" %-10s", gr->gr_name);
-	else
-		printf(" %-10u", ipcp->cgid);
-
-	if ((pw = getpwuid(ipcp->uid)))
-		printf(" %-10s", pw->pw_name);
-	else
-		printf(" %-10u", ipcp->uid);
-	if ((gr = getgrgid(ipcp->gid)))
-		printf(" %-10s\n", gr->gr_name);
-	else
-		printf(" %-10u\n", ipcp->gid);
-}
-static void FIXED_print_perms(struct ipc_stat *is)
+static void print_perms(struct ipc_stat *is)
 {
 	struct passwd *pw;
 	struct group *gr;
@@ -836,7 +811,7 @@ static void do_shm (char format, int use_proc)
 
 	for (shmdsp = shmds; shmdsp->next != NULL; shmdsp = shmdsp->next) {
 		if (format == CREATOR)  {
-			FIXED_print_perms (&(shmdsp->shm_perm));
+			print_perms (&(shmdsp->shm_perm));
 			continue;
 		}
 		pw = getpwuid(shmdsp->shm_perm.uid);
@@ -953,7 +928,7 @@ static void do_sem (char format, int use_proc)
 
 	for (semdsp = semds; semdsp->next != NULL; semdsp = semdsp->next) {
 		if (format == CREATOR)  {
-			FIXED_print_perms (&(semdsp->sem_perm));
+			print_perms (&(semdsp->sem_perm));
 			continue;
 		}
 		pw = getpwuid(semdsp->sem_perm.uid);
@@ -1059,7 +1034,7 @@ static void do_msg (char format, int use_proc)
 
 	for (msgdsp = msgds; msgdsp->next != NULL; msgdsp = msgdsp->next) {
 		if (format == CREATOR)  {
-			FIXED_print_perms (&(msgdsp->msg_perm));
+			print_perms (&(msgdsp->msg_perm));
 			continue;
 		}
 		pw = getpwuid(msgdsp->msg_perm.uid);
-- 
1.7.12.3

