Return-Path: util-linux-owner@vger.kernel.org
Received: from panix.netmeister.org ([166.84.7.99]:52174 "EHLO
        panix.netmeister.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbcJMOuF (ORCPT
        <rfc822;util-linux-ng@vger.kernel.org>);
        Thu, 13 Oct 2016 10:50:05 -0400
Date: Thu, 13 Oct 2016 10:39:32 -0400
From: Jan Schaumann <jschauma@netmeister.org>
To: util-linux-ng@vger.kernel.org
Subject: more(1) may attempt to tcsetattr(3) despite lacking controlling
 terminal
Message-ID: <20161013143932.GA29451@netmeister.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Yesterday I reported the following bug to the Debian maintainers of the
'util-linux' package.  They suggested I should bring it up here:


more(1) may attempt to call tsetattr(3) on stderr even if its process is
not in a process group with a controlling terminal.  As a result,
SIGTTOU will be generated, suspending the process.

The following example illustrates the issue:

$ /bin/sh -c "timeout 60 /bin/sh -c \"ls | more\""

This command will now hang until the timeout, since the shell, ls(1) and
more(1) commands invoked by timeout(1) will be suspended.

Note the difference to

$ timeout 60 /bin/sh -c "ls | more"

which behaves as expected, since here the entire shell command is in the
process group that has the controlling terminal.

Now regardless of whether or not timeout(1) properly sets up the
terminal or process groups, it seems to me that more(1) should not
attempt to manipulate the terminal when it is not in the process group
with the controlling terminal.

As I see it,tThe problem is in text-utils/more.c, where a call to
tcsetattr(3) is made on stderr.  The test for whether or not a tty is
present is not sufficient here, since a tty may be present but not be in
the process group of the controlling terminal.

A simplified PoC of the problematic code looks like this:

--- 8< --------- 8< --------- 8< ---------

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>

int
main(int argc, char ** argv) {
        struct termios otty;
        int no_tty;

        if (setpgid(0, 0) == -1) {
                fprintf(stderr, "Unable to setpgid: %s\n", strerror(errno));
                exit(1);
        }

        no_tty = tcgetattr(fileno(stdout), &otty);

        if (!no_tty) {
#ifdef FIX
                if (tcgetpgrp(fileno(stderr)) == getpgrp()) {
#endif
                        if (tcsetattr(fileno(stderr), TCSANOW, &otty) == -1) {
                                fprintf(stderr, "Unable to tcsetattr: %s\n", strerror(errno));
                                exit(1);
                        }
#ifdef FIX
                }
#endif
        }
        return 0;
}

--- 8< --------- 8< --------- 8< ---------

If compiled without '-DFIX', then we observe the following:

$ ./a.out
$ /bin/sh -c ./a.out
[hangs, can't ^C, need to suspend and kill]

If compiled with '-DFIX', we get the desired behaviour.

The fix to text-utils/more.c should then be:

--- 8< --------- 8< --------- 8< ---------

--- more.c      2016-10-12 18:19:00.858761448 -0400
+++ more.c.orig 2011-09-26 05:50:25.000000000 -0400
@@ -1769,16 +1769,6 @@
 retry:
 #endif /* do_SIGTTOU */
     no_tty = tcgetattr(fileno(stdout), &otty);
-    no_intty = tcgetattr(fileno(stdin), &otty);
-
-    /* If we are not in the process group with the controlling terminal,
-     * then we have on business trying to interact with it, so let's
-     * pretend there isn't a tty. */
-    if (tcgetpgrp(fileno(stdout)) != getpgrp()) {
-       no_tty = 1;
-       no_intty = 1;
-    }
-
     if (!no_tty) {
        docrterase = (otty.c_cc[VERASE] != 255);
        docrtkill =  (otty.c_cc[VKILL] != 255);
@@ -1880,7 +1870,7 @@
        if ((shell = getenv("SHELL")) == NULL)
            shell = "/bin/sh";
     }
-
+    no_intty = tcgetattr(fileno(stdin), &otty);
     tcgetattr(fileno(stderr), &otty);
     savetty0 = otty;
     slow_tty = cfgetispeed(&otty) < B1200;

--- 8< --------- 8< --------- 8< ---------

That is, if the current process group is not the same as the process
group of the controlling terminal, then it's best to pretend that we
don't have a terminal and cause more(1) to merely copy the input rather
than attempt to paginate.


-Jan
