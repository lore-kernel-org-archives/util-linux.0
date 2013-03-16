Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33166 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853Ab3CPXke (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Mar 2013 19:40:34 -0400
Received: by mail-wg0-f49.google.com with SMTP id ds1so3195970wgb.16
        for <util-linux@vger.kernel.org>; Sat, 16 Mar 2013 16:40:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/7] whereis: support MANPATH environment variable
Date: Sat, 16 Mar 2013 23:40:16 +0000
Message-Id: <1363477219-29245-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
References: <1363477219-29245-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The MANPATH has been around long enough that it can be added to whereis
default search path.

Reference: manpath(1)
Addresses: http://pubs.opengroup.org/onlinepubs/7908799/xbd/envvar.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/whereis.1 | 31 +++++++++++++++++--------------
 misc-utils/whereis.c |  1 +
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/misc-utils/whereis.1 b/misc-utils/whereis.1
index 9b33999..4ce7a07 100644
--- a/misc-utils/whereis.1
+++ b/misc-utils/whereis.1
@@ -30,7 +30,7 @@
 .\" SUCH DAMAGE.
 .\"
 .\" @(#)whereis.1 from UCB 4.2
-.TH WHEREIS 1 "January 2013" "util-linux" "User Commands"
+.TH WHEREIS 1 "March 2013" "util-linux" "User Commands"
 .SH NAME
 whereis \- locate the binary, source, and manual page files for a command
 .SH SYNOPSIS
@@ -113,21 +113,24 @@ or have no source in
 .B $ cd /usr/bin
 .br
 .B $ whereis \-u \-ms \-M /usr/man/man1 \-S /usr/src \-f *
-
-.SH FILES
+.SH "FILE SEARCH PATHS"
+By default
 .B whereis
-contains a basic set of hard-coded paths (see below), but if the
-.B \-B
-option is not specified, it also follows the
+tries to find files from hard-coded paths, which are defined with glob
+patterns. The command attempst to use contents of
 .B $PATH
-environment variable (since version 2.21).
-.IP
-.br
-/{bin,sbin,etc}
-.br
-/usr/{lib,\:bin,\:old,\:new,\:local,\:games,\:include,\:etc,\:src,\:man,\:sbin,\:X386,\:TeX,\:g++-include}
-.br
-/usr/local/{X386,\:TeX,\:X11,\:include,\:lib,\:man,\:etc,\:bin,\:games,\:emacs}
+and
+.B $MANPATH
+environment variables as default search path.  The easiest way to know
+what paths are in use is to add
+.B \-l
+listing option.  Effects of the
+.BR \-B ,
+.BR \-M ,
+and
+.BR \-S
+are display with
+.BR \-l .
 .SH "SEE ALSO"
 .BR chdir (2)
 .SH BUGS
diff --git a/misc-utils/whereis.c b/misc-utils/whereis.c
index e3cfb5f..3fad843 100644
--- a/misc-utils/whereis.c
+++ b/misc-utils/whereis.c
@@ -426,6 +426,7 @@ int main(int argc, char **argv)
 	construct_list(dirlist, BIN_DIR, bindirs);
 	environ_list("PATH", dirlist, BIN_DIR);
 	construct_list(dirlist, MAN_DIR, mandirs);
+	environ_list("MANPATH", dirlist, MAN_DIR);
 	construct_list(dirlist, SRC_DIR, srcdirs);
 
 	do
-- 
1.8.2

