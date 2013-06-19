Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46235 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756915Ab3FSQAK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Jun 2013 12:00:10 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so5177671pbc.7
        for <util-linux@vger.kernel.org>; Wed, 19 Jun 2013 09:00:09 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com>
References: <CADJQGJfOj2GQNdoW89hC2LMukC_cwPuJVBiN6+xy64UphbOiZg@mail.gmail.com>
Date: Wed, 19 Jun 2013 17:00:09 +0100
Message-ID: <CAG27Bk0tULzTdYpPPZz3C9Z2XZk9mTHbV=UCkMJEW+6XbRFZvw@mail.gmail.com>
Subject: Re: forking in setsid
From: Sami Kerola <kerolasa@iki.fi>
To: Damien Wyart <damien.wyart@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 June 2013 15:53, Damien Wyart <damien.wyart@gmail.com> wrote:
> While searching information about setsid and daemonization, I came accros
> the following "bug" report in Debian :
> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495881
>
> Unfortunately, it doesn't seem to have been forwarded upstream after
> creation, and never received an answer.
>
> I would be interested in getting your opinions about it and the patch
> attached to it.

Hi Damien,

I am not sure if it is good idea to change default behavior of the
software. Perhaps waiting return value of child should be new option,
something like


>From c2deb80ef6feb7039a0554e4b8a8272e59cb1a87 Mon Sep 17 00:00:00 2001
From: Daniel Kahn Gillmor <dkg@fifthhorseman.net>
Date: Wed, 20 Aug 2008 12:00:00 +0100
Subject: [PATCH] setsid: add an option to wait child return value
Organization: Lastminute.com

This change was sent by Damien Wyart in behalf of Daniel Kahn Gillmor.

Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=495881
Reference: http://permalink.gmane.org/gmane.linux.utilities.util-linux-ng/7736
Reported-by: Damien Wyart <damien.wyart@gmail.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setsid.1 |  5 +++++
 sys-utils/setsid.c | 28 +++++++++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index eff7948..da8d648 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -15,6 +15,11 @@ runs a program in a new session.
 .TP
 \fB\-c\fP, \fB\-\-ctty\fP
 Set the controlling terminal to the current one.
+.TP
+\fB\-w\fP, \fB\-\-wait\fP
+Wait the execution of the program to end, and return the exit value of
+the child as return value of the
+.BR setsid .
 .SH "SEE ALSO"
 .BR setsid (2)
 .SH AUTHOR
diff --git a/sys-utils/setsid.c b/sys-utils/setsid.c
index 756a520..0e11a1a 100644
--- a/sys-utils/setsid.c
+++ b/sys-utils/setsid.c
@@ -9,6 +9,9 @@
  * 2001-01-18 John Fremlin <vii@penguinpowered.com>
  * - fork in case we are process group leader
  *
+ * 2008-08-20 Daniel Kahn Gillmor <dkg@fifthhorseman.net>
+ * - if forked, wait on child process and emit its return code.
+ *
  */

 #include <getopt.h>
@@ -16,6 +19,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/ioctl.h>
+#include <sys/types.h>
+#include <sys/wait.h>

 #include "c.h"
 #include "nls.h"
@@ -29,8 +34,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
  program_invocation_short_name);

  fputs(USAGE_OPTIONS, out);
- fputs(_(" -c, --ctty     set the controlling terminal to the current one\n"),
- out);
+ fputs(_(" -c, --ctty     set the controlling terminal to the current
one\n"), out);
+ fputs(_(" -w, --wait     wait program to exit, and use the same
return\n"), out);

  fputs(USAGE_HELP, out);
  fputs(USAGE_VERSION, out);
@@ -43,10 +48,13 @@ int main(int argc, char **argv)
 {
  int ch;
  int ctty = 0;
+ pid_t pid;
+ int status = 0;

  static const struct option longopts[] = {
  {"ctty", no_argument, NULL, 'c'},
  {"version", no_argument, NULL, 'V'},
+ {"wait", no_argument, NULL, 'w'},
  {"help", no_argument, NULL, 'h'},
  {NULL, 0, NULL, 0}
  };
@@ -56,7 +64,7 @@ int main(int argc, char **argv)
  textdomain(PACKAGE);
  atexit(close_stdout);

- while ((ch = getopt_long(argc, argv, "+Vhc", longopts, NULL)) != -1)
+ while ((ch = getopt_long(argc, argv, "+Vhcw", longopts, NULL)) != -1)
  switch (ch) {
  case 'V':
  printf(UTIL_LINUX_VERSION);
@@ -64,6 +72,9 @@ int main(int argc, char **argv)
  case 'c':
  ctty=1;
  break;
+ case 'w':
+ status = 1;
+ break;
  case 'h':
  usage(stdout);
  default:
@@ -74,15 +85,22 @@ int main(int argc, char **argv)
  usage(stderr);

  if (getpgrp() == getpid()) {
- switch (fork()) {
+ pid = fork();
+ switch (pid) {
  case -1:
  err(EXIT_FAILURE, _("fork"));
  case 0:
  /* child */
  break;
  default:
+ if (!status)
+ return EXIT_SUCCESS;
  /* parent */
- return 0;
+ if (wait(&status) != pid)
+ err(EXIT_FAILURE, "wait");
+ if (WIFEXITED(status))
+ return WEXITSTATUS(status);
+ err(status, _("child %d did not exit normally"), pid);
  }
  }
  if (setsid() < 0)
--
1.8.3.1
