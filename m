Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33124 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbcHNJaO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Aug 2016 05:30:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id o80so5783095wme.0
        for <util-linux@vger.kernel.org>; Sun, 14 Aug 2016 02:30:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/3] kill: remove pid command-name to option alias
Date: Sun, 14 Aug 2016 08:24:05 +0100
Message-Id: <20160814072406.2991-2-kerolasa@iki.fi>
In-Reply-To: <20160814072406.2991-1-kerolasa@iki.fi>
References: <20160814072406.2991-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Removal was promised to happen at March 2014 and the time has to get rid of
this unexpected feature.

Reference: c5b057b3422504a671ee588fa66574ae876521f1
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt | 5 -----
 misc-utils/kill.1            | 5 -----
 misc-utils/kill.c            | 4 ----
 3 files changed, 14 deletions(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 81a4122..39dc335 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -34,11 +34,6 @@ why:   does not provide control on output data formatting. The recommended solut
 
 --------------------------
 
-what:  "pid" as binary name for "kill --pid"
-why:   too ugly, too obscure
-
---------------------------
-
 What:   mkfs
 Why:    use filesystem specific mkfs.<type>.
 
diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index f50d850..a7d7a74 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -91,11 +91,6 @@ uid as the present process.
 \fB\-p\fR, \fB\-\-pid\fR
 Only print the process id (pid) of the named processes, do not send any
 signals.
-.IP
-The \fB\-\-pid\fR option is automatically enabled when the \fBkill\fR command
-is invoked with the name of
-.BR pid .
-This functionality is deprecated, and will be removed in March 2016.
 .TP
 \fB\-\-verbose\fR
 Print pid(s) that will be signaled with kill along with the signal.
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 34b9487..e52a03d 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -472,10 +472,6 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	ctl.do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
-	if (ctl.do_pid)	/* FIXME: remove in March 2016.  */
-		warnx(_("use of 'kill --pid' option as command name is deprecated"));
-
 	argv = parse_arguments(argc, argv, &ctl);
 
 	/* The rest of the arguments should be process ids and names. */
-- 
2.9.3

