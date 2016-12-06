Return-Path: util-linux-owner@vger.kernel.org
Received: from skprod2.natinst.com ([130.164.80.23]:47004 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752096AbcLFQG0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Dec 2016 11:06:26 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (us-aus-exhub1.ni.corp.natinst.com [130.164.68.41])
        by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTPS id uB6G6PPI031455
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <util-linux@vger.kernel.org>; Tue, 6 Dec 2016 10:06:25 -0600
From: Marian Vomir <marian.vomir@ni.com>
To: <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] Revert "hwclock: don't allow non-root access"
Date: Tue, 6 Dec 2016 20:06:19 +0200
Message-ID: <1481047580-28284-1-git-send-email-marian.vomir@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This reverts commit 687cc5d58942b24a9f4013c68876d8cbea907ab1.

There are cases when an unprivileged user wants to set the hardware clock.
The solution is to use capabilities, specifically CAP_SYS_TIME in this case.
---
 sys-utils/hwclock.8.in | 15 +++++++++++++++
 sys-utils/hwclock.c    | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index dec7902..5a7f762 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -577,6 +577,21 @@ This second field is not used under Linux and is always zero.
 See also
 .BR \%settimeofday (2).
 .
+.SS User access and setuid
+.PP
+Sometimes, you need to install
+.B \%hwclock
+setuid root.  If you want users other than the superuser to be able to
+display the clock value using the direct ISA I/O method, install it setuid
+root.  If you have the rtc device interface on your system, or are on a non-ISA
+compatible system, there is probably no need for users to have the direct
+ISA I/O method, so do not bother.  See the
+.BR \-\-rtc " option."
+.PP
+In any case, \fBhwclock\fR will not allow you to set anything unless you have the
+superuser real uid.  (This restriction is not necessary if you haven't
+installed setuid root, but it's there for now.)
+.
 .SS Hardware Clock Access Methods
 .PP
 .B \%hwclock
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 4b201d7..880ba78 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1633,6 +1633,8 @@ int main(int argc, char **argv)
 	 * fractions.
 	 */
 	time_t set_time = 0;	/* Time to which user said to set Hardware Clock */
+
+	bool permitted;		/* User is permitted to do the function */
 	int rc, c;
 
 	/* Variables set by various options; show may also be set later */
@@ -1861,11 +1863,6 @@ int main(int argc, char **argv)
 	argc -= optind;
 	argv += optind;
 
-	if (getuid() != 0) {
-		warnx(_("Sorry, only the superuser can use the Hardware Clock."));
-		hwclock_exit(EX_NOPERM);
-	}
-
 #ifdef HAVE_LIBAUDIT
 	if (testing != TRUE) {
 		if (adjust == TRUE || hctosys == TRUE || systohc == TRUE ||
@@ -1907,6 +1904,28 @@ int main(int argc, char **argv)
 	      | setepoch | predict | compare | get))
 		show = 1;	/* default to show */
 
+	if (getuid() == 0)
+		permitted = TRUE;
+	else {
+		/* program is designed to run setuid (in some situations) */
+		if ((set || systohc || adjust) && !testing) {
+			warnx(_("Sorry, only the superuser can change "
+				"the Hardware Clock."));
+			permitted = FALSE;
+		} else if ((systz || hctosys) && !testing) {
+			warnx(_("Sorry, only the superuser can change "
+				"the System Clock."));
+			permitted = FALSE;
+		} else if (setepoch && !testing) {
+			warnx(_("Sorry, only the superuser can change the "
+				"Hardware Clock epoch in the kernel."));
+			permitted = FALSE;
+		} else
+			permitted = TRUE;
+	}
+
+	if (!permitted)
+		hwclock_exit(EX_NOPERM);
 
 #ifdef __linux__
 	if (getepoch || setepoch) {
@@ -2009,6 +2028,11 @@ void __attribute__((__noreturn__)) hwaudit_exit(int status)
  * with any functions by these names, you will have unresolved external
  * references when you link.
  *
+ * The program is designed to run setuid superuser, since we need to be able
+ * to do direct I/O. (More to the point: we need permission to execute the
+ * iopl() system call). (However, if you use one of the methods other than
+ * direct ISA I/O to access the clock, no setuid is required).
+ *
  * Here's some info on how we must deal with the time that elapses while
  * this program runs: There are two major delays as we run:
  *
-- 
2.7.4

