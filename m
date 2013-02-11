Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ve0-f178.google.com ([209.85.128.178]:32992 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641Ab3BKWmi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Feb 2013 17:42:38 -0500
Received: by mail-ve0-f178.google.com with SMTP id db10so5568589veb.37
        for <util-linux@vger.kernel.org>; Mon, 11 Feb 2013 14:42:37 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <kf0ehe$q7h$1@ger.gmane.org>
References: <kf0ehe$q7h$1@ger.gmane.org>
Date: Mon, 11 Feb 2013 22:42:36 +0000
Message-ID: <CAG27Bk2dO1ztSAy47=j+nmG+v5YuMCBa0i4eorLWw2sFWRT2Pg@mail.gmail.com>
Subject: =?windows-1252?Q?Re=3A_lslocks_=96_=22failed_to_parse_pid=3A_=27WRITE=27=22?=
From: Sami Kerola <kerolasa@iki.fi>
To: "Mantas M." <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 7, 2013 at 2:42 PM, Mantas M. <grawity@gmail.com> wrote:
> When one process is holding an exclusive lock on a file, and other
> processes are waiting for the lock to be released, the contents of
> /proc/locks look like this:
>
> $ cat /proc/locks
> 1: FLOCK  ADVISORY  WRITE 431143 00:0f:6325223 0 EOF
> 1: -> FLOCK  ADVISORY  WRITE 405209 00:0f:6325223 0 EOF
> 1: -> FLOCK  ADVISORY  WRITE 399578 00:0f:6325223 0 EOF
> 1: -> FLOCK  ADVISORY  WRITE 434120 00:0f:6325223 0 EOF
> 2: FLOCK  ADVISORY  WRITE 359765 08:04:28180839 0 EOF
> 3: FLOCK  ADVISORY  WRITE 359765 08:04:28180837 0 EOF
> 4: POSIX  ADVISORY  WRITE 434729 08:04:8653261 0 EOF
> 4: -> POSIX  ADVISORY  WRITE 434737 08:04:8653261 0 EOF
> 5: FLOCK  ADVISORY  WRITE 359765 08:04:28180836 0 EOF
> 6: ...
>
> If I try to run `lslocks`, it fails to parse the "->" lines and exits
> with an error message:
>
>     lslocks: failed to parse pid: 'WRITE'
>
> Can be reproduced by:
>
> touch foo & flock foo -c "sleep 100" & flock foo -c "sleep 100" &
> touch foo & lckdo -w foo sleep 100 & lckdo -w foo sleep 100 &

Hi Mantas,

Thank you for reproducing bit which made creating some sort of fix
quite easy. Karel, and others, what do you think about adding a mode
to output listing which some might say is not a mode at all?


>From 9a71631ffd9181225323747eea971e2cd0d80eb8 Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 11 Feb 2013 22:30:49 +0000
Subject: [PATCH] lslocks: print waiting state when necessary
Organization: Lastminute.com

Earlier output was primarily unexpected.

$ flock foo -c "sleep 100" & flock foo -c "sleep 100" & flock foo -c
"sleep 100" & lslocks
[1] 22352
[2] 22353
[3] 22354
lslocks: failed to parse pid: 'WRITE'

This commit adds WAITING mode to output listing.  The locks which failed
with earlier version will look the following.

COMMAND           PID  TYPE SIZE MODE    M      START        END PATH
[...]
flock           22354 FLOCK   0B WAITING 0          0          0
/home/src/util-linux/foo
flock           22352 FLOCK   0B WAITING 0          0          0
/home/src/util-linux/foo
flock           22353 FLOCK   0B WRITE   0          0          0
/home/src/util-linux/foo

Reported-by: Mantas Mikulenas <grawity@gmail.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lslocks.8 |  2 +-
 misc-utils/lslocks.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/misc-utils/lslocks.8 b/misc-utils/lslocks.8
index 24cda14..34f611c 100644
--- a/misc-utils/lslocks.8
+++ b/misc-utils/lslocks.8
@@ -44,7 +44,7 @@ Type of lock, can be FLOCK (created with flock(2))
or POSIX (created with fcntl(
 Size of the locked file.

 .IP "MODE"
-Lock access permissions (read, write).
+Lock access permissions (read, write, waiting).

 .IP "M"
 Mandatory state of the lock: 0 if none; 1 if set.  (See chmod(1)).
diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 0a82129..1e8f51f 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -226,7 +226,7 @@ static ino_t get_dev_inode(char *str, dev_t *dev)

 static int get_local_locks(struct list_head *locks)
 {
-	int i;
+	int i, waiting;
 	ino_t inode = 0;
 	FILE *fp;
 	char buf[PATH_MAX], *szstr = NULL, *tok = NULL;
@@ -241,6 +241,7 @@ static int get_local_locks(struct list_head *locks)

 		l = xcalloc(1, sizeof(*l));
 		INIT_LIST_HEAD(&l->locks);
+		waiting = 0;

 		for (tok = strtok(buf, " "), i = 0; tok;
 		     tok = strtok(NULL, " "), i++) {
@@ -253,6 +254,11 @@ static int get_local_locks(struct list_head *locks)
 			case 0: /* ignore */
 				break;
 			case 1: /* posix, flock, etc */
+				if (strcmp(tok, "->") == 0) {
+					i--;
+					waiting = 1;
+					continue;
+				}
 				l->type = xstrdup(tok);
 				break;

@@ -260,7 +266,10 @@ static int get_local_locks(struct list_head *locks)
 				l->mandatory = *tok == 'M' ? TRUE : FALSE;
 				break;
 			case 3: /* lock mode */
-				l->mode = xstrdup(tok);
+				if (waiting)
+					l->mode = xstrdup("WAITING");
+				else
+					l->mode = xstrdup(tok);
 				break;

 			case 4: /* PID */
-- 
1.8.1.3
