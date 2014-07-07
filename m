Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60260 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233AbaGGWjN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 18:39:13 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so6065156pde.38
        for <util-linux@vger.kernel.org>; Mon, 07 Jul 2014 15:39:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1404765295.16902.139036593.3B689FEB@webmail.messagingengine.com>
References: <1404765295.16902.139036593.3B689FEB@webmail.messagingengine.com>
Date: Mon, 7 Jul 2014 23:39:11 +0100
Message-ID: <CAG27Bk3niwrfc1oW9DfSvxZ2tV3Y=ZXEi1Wb+61AXOBYS_jmWw@mail.gmail.com>
Subject: Re: small problem with kill --queue
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 July 2014 21:34, Benno Schulenberg <bensberg@justemail.net> wrote:
> ./kill --queue 11 12
> kill: sending signal to 12 failed: Operation not permitted
>
> /kill --queue data 12
> kill: unknown signal data; valid signals:
>  1 HUP      2 INT      3 QUIT     4 ILL      5 TRAP     [...]
>
> But "data" is not a signal, it is meant to be a number, an integer,
> a value passed to the signalled process.
>
> In misc-utils.c it does this:
>
>         arg = *argv;
>         if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
>                 err_nosig(arg);
>
> But it should not run arg_to_signum() on the argument, it
> should simply parse it as an integer, and when that fails,
> it should not call err_nosig() but say something like "not
> a number".  Right?

Hi Benno,

Right. I am not sure did I mess up or someone else earlier when
--queue was introduced. Which way ever that was now when I look
sigqueue(3) manual page your change proposal makes sense. Please have
a look of the change below, that I hope to get reviewed before the
final v2.25 is out.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 7 Jul 2014 23:31:56 +0100
Subject: [PATCH] kill: use --queue argument as sigval integer

The sigqueue(3) takes two values, signal and sigval.  Contents of the
signal can be altered with --signal option argument, so the --queue
argument should be reserved to affect sigval_int.

Reference: http://man7.org/linux/man-pages/man3/sigqueue.3.html
Reported-by: Benno Schulenberg <bensberg@justemail.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.1     | 18 ++++++++++++------
 misc-utils/kill.c     |  4 +---
 tests/ts/kill/options |  4 ++--
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/misc-utils/kill.1 b/misc-utils/kill.1
index dd1b1ee..65d094f 100644
--- a/misc-utils/kill.1
+++ b/misc-utils/kill.1
@@ -98,14 +98,20 @@ This functionality is deprecated, and will not be
removed in March 2016.
 Use
 .BR sigqueue (2)
 rather than
-.BR kill (2)
-and the
+.BR kill (2).
+Argument
 .I sigval
-argument is used to specify an integer to be sent with the signal.  If the
-receiving process has installed a handler for this signal using the SA_SIGINFO
-flag to
+is an integer that sent with the signal.  If the receiving process has
+installed a handler for this signal using the SA_SIGINFO flag to
 .BR sigaction (2),
-then it can obtain this data via the si_value field of the siginfo_t structure.
+then it can obtain the sigval integer via the si_value field of the
+siginfo_t structure passed as the second argument to the handler.
+The
+.B \-\-queue
+should be combined with
+.BI \-\-signal " signal"
+when other than a SIGTERM is wanted to accompanied with
+.IR sigval .
 .SH NOTES
 It is not possible to send a signal to explicitly selected thread in a
 multithreaded process by
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 5d2f27d..a24087f 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -412,9 +412,7 @@ static char **parse_arguments(int argc, char
**argv, struct kill_control *ctl)
  errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--queue");
  argc--, argv++;
  arg = *argv;
- if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
- err_nosig(arg);
- ctl->sigdata.sival_int = ctl->numsig;
+ ctl->sigdata.sival_int = strtos32_or_err(arg, _("argument error"));
  ctl->use_sigval = 1;
  continue;
  }
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
index 6cdaa24..5af78d9 100755
--- a/tests/ts/kill/options
+++ b/tests/ts/kill/options
@@ -51,8 +51,8 @@ try_option -s 1
 try_option --signal 1
 try_option --signal HUP
 try_option --signal SIGHUP
-try_option -q HUP
-try_option --queue HUP
+try_option -s 1 -q 42
+try_option -s 1 --queue 42
 try_option -1
 try_option -HUP
 try_option -SIGHUP
-- 
2.0.1
