Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:41242 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754220AbcA3Nba (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 30 Jan 2016 08:31:30 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aPVce-0002k2-1k
	for util-linux@vger.kernel.org; Sat, 30 Jan 2016 14:31:28 +0100
Received: from ppp37-190-56-5.pppoe.spdop.ru ([37.190.56.5])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 30 Jan 2016 14:31:28 +0100
Received: from yumkam by ppp37-190-56-5.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 30 Jan 2016 14:31:28 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: Re: [PATCH 2/2] unshare: allow persisting mount namespaces
Date: Sat, 30 Jan 2016 16:31:06 +0300
Message-ID: <m3twlvfb39.fsf@gmail.com>
References: <1428578536-31603-1-git-send-email-kzak@redhat.com>
	<1428578536-31603-2-git-send-email-kzak@redhat.com>
	<87bnix6xj6.fsf@x220.int.ebiederm.org>
	<20150410081733.GM3923@ws.net.home> <m31t8zhgfv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain

yumkam@gmail.com (Yuriy M. Kaminskiy)
writes:

> Karel Zak <kzak@redhat.com> writes:
>
> (this was commited as c84f2590dfdb8570beeb731e0105f8fe597443d1)
>
>> +static void bind_ns_files_from_child(pid_t *child)
>> +{
>> +	pid_t ppid = getpid();
>> +	ino_t ino = get_mnt_ino(ppid);
>> +
>> +	*child = fork();
>> +
>> +	switch(*child) {
>> +	case -1:
>> +		err(EXIT_FAILURE, _("fork failed"));
>> +	case 0:	/* child */
>> +		do {
>> +			/* wait until parent unshare() */
>> +			ino_t new_ino = get_mnt_ino(ppid);
>> +			if (ino != new_ino)
>> +				break;
>> +		} while (1);
>
> Racing? Suppose, parent died (e.g. unshare(2) failed), (parent) process
> was reaped, new (unrelated) process was created with same pid, as a
> result this function will bind namespaces from wrong process.

... besides, this is a busyloop, if "imposer process" is in same mnt
namespace as original process, it will occupy CPU forever (and this *is*
easy to fix; see attached; note that with attached patch race probability is
reduced, but not totally avoided, there are still window between
read(pipe) and mount() calls [but at least it won't busyloop, and won't
trigger racing on unshare(2) error]).

P.S. that said, for me, on debian's 3.16.7-ckt* kernel, `touch foo && unshare
--mount=foo` still fails with EINVAL (with either unpatched git master
or with this patch), so consider this as "compile-tested only".

> (That said, pretty unlikely, and no idea how to properly fix it).
>

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-unshare-fix-busyloop-and-reduce-racing-probability.patch

>From 64d1e9d905455b8177d65ad58ca2b403bbe8222c Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Sat, 30 Jan 2016 16:18:39 +0300
Subject: [PATCH] unshare: fix busyloop and reduce racing probability

Replace busy-loop with waiting on pipe from parent.

Note: reduces racing probability, but still there are window where
it is possible (if parent unshare process will be [externally] killed
between successful read(fds[0]) and mount() calls).

Signed-off-by: Yuriy M. Kaminskiy <yumkam@gmail.com>
---
 sys-utils/unshare.c | 49 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 7482a8b..bf4f6d2 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -199,27 +199,50 @@ static ino_t get_mnt_ino(pid_t pid)
 	return st.st_ino;
 }
 
-static void bind_ns_files_from_child(pid_t *child)
+static void bind_ns_files_from_child(pid_t *child, int fds[2])
 {
 	pid_t ppid = getpid();
 	ino_t ino = get_mnt_ino(ppid);
 
+	if (pipe(fds) < 0)
+		err(EXIT_FAILURE, _("pipe failed"));
+
 	*child = fork();
 
 	switch(*child) {
 	case -1:
 		err(EXIT_FAILURE, _("fork failed"));
 	case 0:	/* child */
-		do {
-			/* wait until parent unshare() */
-			ino_t new_ino = get_mnt_ino(ppid);
-			if (ino != new_ino)
-				break;
-		} while (1);
+		close(fds[1]);
+		fds[1] = -1;
+		/* wait for parent */
+		for (;;) {
+			char ch = -1;
+
+			switch(read(fds[0], &ch, 1)) {
+			case -1:
+				if (errno == EINTR)
+					continue;
+				/* fallthrough */
+			default:
+				err(EXIT_FAILURE, _("pipe read error"));
+			case 0: /* parent died? */
+				exit(EXIT_FAILURE);
+			case 1:
+				if (ch != 0)
+					exit(EXIT_FAILURE);
+				/* break loop*/;
+			}
+			break;
+		}
+		if (get_mnt_ino(ppid) == ino)
+			exit(EXIT_FAILURE);
 		bind_ns_files(ppid);
 		exit(EXIT_SUCCESS);
 		break;
 	default: /* parent */
+		close(fds[0]);
+		fds[0] = -1;
 		break;
 	}
 }
@@ -288,6 +311,7 @@ int main(int argc, char *argv[])
 	int c, forkit = 0, maproot = 0;
 	const char *procmnt = NULL;
 	pid_t pid = 0;
+	int fds[2];
 	int status;
 	unsigned long propagation = UNSHARE_PROPAGATION_DEFAULT;
 	uid_t real_euid = geteuid();
@@ -358,16 +382,23 @@ int main(int argc, char *argv[])
 	}
 
 	if (npersists && (unshare_flags & CLONE_NEWNS))
-		bind_ns_files_from_child(&pid);
+		bind_ns_files_from_child(&pid, fds);
 
 	if (-1 == unshare(unshare_flags))
 		err(EXIT_FAILURE, _("unshare failed"));
 
 	if (npersists) {
 		if (pid && (unshare_flags & CLONE_NEWNS)) {
-			/* wait for bind_ns_files_from_child() */
 			int rc;
+			char ch = 0;
+
+			/* signal child we are ready */
+			while (write(fds[1], &ch, 1) == -1 && errno == EINTR)
+				;
+			close(fds[1]);
+			fds[1] = -1;
 
+			/* wait for bind_ns_files_from_child() */
 			do {
 				rc = waitpid(pid, &status, 0);
 				if (rc < 0) {
-- 
2.1.4


--=-=-=--

