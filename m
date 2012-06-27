Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:59237 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab2F0Naf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jun 2012 09:30:35 -0400
Message-ID: <4FEB0AF8.2070109@bernhard-voelker.de>
Date: Wed, 27 Jun 2012 15:30:32 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
CC: Sami Kerola <kerolasa@iki.fi>, kerolasa@gmail.com
Subject: Re: [PATCH] Fix typos found by misspellings
References: <4FEAF265.5040000@bernhard-voelker.de>
In-Reply-To: <4FEAF265.5040000@bernhard-voelker.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 06/27/2012 01:45 PM, Bernhard Voelker wrote:
> another round for misspellings ;-)

Sami replied this (off-list):

> I am almost sure variable name should not be touched, no matter how
> wrong it might look or feel.

Thanks for the review.
I left that change out in the second try.

Have a nice day,
Berny

>From 8cd75dc6fe79be83486b449459b4897f71c6c8de Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 27 Jun 2012 15:23:05 +0200
Subject: [PATCH] Fix typos found by misspellings

The tool misspellings (https://github.com/lyda/misspell-check)
detected several typos. Command used:

  $ git ls-files | grep -v ^po/ | misspellings -f -

* Documentation/releases/v2.18-ReleaseNotes: Fix typo in news entry.
* NEWS: Likewise.
* config/texinfo.tex: Fix typo in comments.
* libmount/src/context.c: Fix typo in comment.
* libmount/src/fs.c: Likewise.
* login-utils/login.c: Likewise.
* login-utils.su.1: Fix typo in man page.
* sys-utils/chcpu.c: Fix typo in error message.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 Documentation/releases/v2.18-ReleaseNotes |    2 +-
 NEWS                                      |    2 +-
 config/texinfo.tex                        |    6 +++---
 libmount/src/context.c                    |    2 +-
 libmount/src/fs.c                         |    2 +-
 login-utils/login.c                       |    4 ++--
 login-utils/su.1                          |    2 +-
 sys-utils/chcpu.c                         |    4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/releases/v2.18-ReleaseNotes b/Documentation/releases/v2.18-ReleaseNotes
index 47f590e..b027804 100644
--- a/Documentation/releases/v2.18-ReleaseNotes
+++ b/Documentation/releases/v2.18-ReleaseNotes
@@ -148,7 +148,7 @@ docs:
    - update v2.18 ReleaseNotes  [Karel Zak]
 fallocate:
    - check for number of arguments  [Karel Zak]
-   - support suffixes for --offset and --lenght  [Karel Zak]
+   - support suffixes for --offset and --length  [Karel Zak]
 fdisk:
    - add -c option (switch off DOS mode)  [Karel Zak]
    - cleanup alignment, default to 1MiB offset  [Karel Zak]
diff --git a/NEWS b/NEWS
index c486f9e..e1ea939 100644
--- a/NEWS
+++ b/NEWS
@@ -1300,7 +1300,7 @@ HIGHLIGHTS for version 2.6:

 1) Removed programs:
    - md5sum, dsplit: available in GNU textutils.
-   - syslogd: Sysklogd is now prefered.  It is available at
+   - syslogd: Sysklogd is now preferred.  It is available at
 	tsx-11.mit.edu:/pub/sources/sbin
 	sunsite.unc.edu:/pub/Linux/system/Daemons

diff --git a/config/texinfo.tex b/config/texinfo.tex
index 42e8cb3..b57b2f3 100644
--- a/config/texinfo.tex
+++ b/config/texinfo.tex
@@ -441,7 +441,7 @@
 % to get _exactly_ the rest of the line, we had to prevent such situation.
 % We prepended an \empty token at the very beginning and we expand it now,
 % just before passing the control to \next.
-% (Similarily, we have to think about #3 of \argcheckspacesY above: it is
+% (Similarly, we have to think about #3 of \argcheckspacesY above: it is
 % either the null string, or it ends with \^^M---thus there is no danger
 % that a pair of braces would be stripped.
 %
@@ -498,7 +498,7 @@
 % used to check whether the current environment is the one expected.
 %
 % Non-false conditionals (@iftex, @ifset) don't fit into this, so they
-% are not treated as enviroments; they don't open a group.  (The
+% are not treated as environments; they don't open a group.  (The
 % implementation of @end takes care not to call \endgroup in this
 % special case.)

@@ -6405,7 +6405,7 @@ where each line of input produces a line of output.}
 % In case a @footnote appears in a vbox, save the footnote text and create
 % the real \insert just after the vbox finished.  Otherwise, the insertion
 % would be lost.
-% Similarily, if a @footnote appears inside an alignment, save the footnote
+% Similarly, if a @footnote appears inside an alignment, save the footnote
 % text to a box and make the \insert when a row of the table is finished.
 % And the same can be done for other insert classes.  --kasal, 16nov03.

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 2cdd6bb..ce1175e 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -1775,7 +1775,7 @@ int mnt_context_fstab_applied(struct libmnt_context *cxt)
  *
  * The real exit code of the mount.type helper has to be tested by
  * mnt_context_get_helper_status(). The mnt_context_get_status() only inform
- * that exec() has been sucessful.
+ * that exec() has been successful.
  *
  * Returns: 1 if mount.type or mount(2) syscall has been successfully called.
  */
diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 543ffb1..2459b13 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -872,7 +872,7 @@ const char *mnt_fs_get_attributes(struct libmnt_fs *fs)
  *
  * The atrtributes are managed by libmount in userspace only. It's possible
  * that information stored in userspace will not be available for libmount
- * after CLONE_FS unshare. Be carefull, and don't use attributes if possible.
+ * after CLONE_FS unshare. Be careful, and don't use attributes if possible.
  *
  * Returns: 0 on success or negative number in case of error.
  */
diff --git a/login-utils/login.c b/login-utils/login.c
index 6ed996f..fe13d8d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -364,7 +364,7 @@ static void init_tty(struct login_context *cxt)
 	 *
 	 * More precisely, the problem is  ttyn := ttyname(0); ...; chown(ttyn);
 	 * here ttyname() might return "/tmp/x", a hardlink to a pseudotty.
-	 * All of this is a problem only when login is suid, which it isnt.
+	 * All of this is a problem only when login is suid, which it isn't.
 	 */
 	if (!cxt->tty_path || !*cxt->tty_path ||
 	    lstat(cxt->tty_path, &st) != 0 || !S_ISCHR(st.st_mode) ||
@@ -1317,7 +1317,7 @@ int main(int argc, char **argv)
 	/*
 	 * Authentication may be skipped (for example, during krlogin, rlogin,
 	 * etc...), but it doesn't mean that we can skip other account checks.
-	 * The account could be disabled or password expired (althought
+	 * The account could be disabled or password expired (although
 	 * kerberos ticket is valid).         -- kzak@redhat.com (22-Feb-2006)
 	 */
 	loginpam_acct(&cxt);
diff --git a/login-utils/su.1 b/login-utils/su.1
index d069423..82ec287 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -16,7 +16,7 @@ defaults to running an interactive shell as
 For backward compatibilty
 .B su
 defaults to not change the current directory and to only set the
-enviroment variables
+environment variables
 .B HOME
 and
 .B SHELL
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 999ea56..523e9c5 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -140,11 +140,11 @@ static int cpu_set_dispatch(int mode)
 	if (mode == 0) {
 		if (path_writestr("0", _PATH_SYS_CPU_DISPATCH) == -1)
 			err(EXIT_FAILURE, _("Failed to set horizontal dispatch mode"));
-		printf(_("Succesfully set horizontal dispatching mode\n"));
+		printf(_("Successfully set horizontal dispatching mode\n"));
 	} else {
 		if (path_writestr("1", _PATH_SYS_CPU_DISPATCH) == -1)
 			err(EXIT_FAILURE, _("Failed to set vertical dispatch mode"));
-		printf(_("Succesfully set vertical dispatching mode\n"));
+		printf(_("Successfully set vertical dispatching mode\n"));
 	}
 	return EXIT_SUCCESS;
 }
-- 
1.7.7

