Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36731 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcEUIIY convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 21 May 2016 04:08:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id x130so1536188oia.3
        for <util-linux@vger.kernel.org>; Sat, 21 May 2016 01:08:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20160520102731.schhho5sl6k7cwq3@ws.net.home>
References: <201603081437.31966.sweet_f_a@gmx.de>
	<CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
	<201603082359.43056.sweet_f_a@gmx.de>
	<20160520102731.schhho5sl6k7cwq3@ws.net.home>
Date: Sat, 21 May 2016 09:08:23 +0100
Message-ID: <CAG27Bk3r-EGNqDadbbcM52DQH0yiv2BYTDnHzDKHZfqNoxCuUA@mail.gmail.com>
Subject: Re: cal: bug on FreeBSD
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: =?UTF-8?Q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 20 May 2016 at 11:27, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Mar 08, 2016 at 11:59:43PM +0100, Rüdiger Meier wrote:
>> On Tuesday 08 March 2016 23:35:01 Sami Kerola wrote:
>> > Does this happen with putp() only? The following should enable you to
>> > test the fputs() output.
>>
>> It's only broken with putp, I tried it like this
>
> It's BSD specific problem, putp (aka tputs) interprets the string.
> That's fine as tputs is sensitive to sequences prefixed by $< and
> everything else is printed to terminal.
>
> BUT probably because BSD has origins in 70' LSD era there is a
> special exception (ncurses sources tinfo/lib_tputs.c):
>
>     #if BSD_TPUTS
>        /*
>         * This ugly kluge deals with the fact that some ancient BSD
>         * programs (like nethack) actually do the likes of tputs("50") to
>         * get delays.
>         */
>         if (isdigit(UChar(*string))) {
>         ...
>         }
>     #endif
>
> and the number is interpreted as argument for delay_output() and never
> printed to the output.
>
> It seems we're little bit fragile with putp() as it's primarily
> designed for terminfo string variables than for a generic output.
> Unfortunately mix tputs() and fputs() is also no perfect due to
> buffering issues (commit 07ac4aa9d4f36a6618fd3ab1423bc33e3903ddbd).
>
> The easy fix is to disable ncurses support for BSD (words like fuck
> and suck are allowed in the commit message for this case:-).

How about disabling just the kludge instead of ncurses altogether?

The change below is also available in the git repository:
git://github.com/kerolasa/lelux-utiliteetit.git cal-bsd-fix

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 21 May 2016 08:47:38 +0100
Subject: [PATCH] cal: make BSD not to do ugly hack when calling tputs()

On BSD systems tputs("<number>") is interpreted as argument for
delay_output() and never printed to the output when BSD_TPUTS is
defined.  The cal(1) does not need such delays, and is printing
various date numbers so disable this unwanted BSDism.

Reported-by: Ruediger Meier <ruediger.meier@ga-group.nl>
Based-on-fix-by: Karel Zak <kzak@redhat.com>
Reference: http://www.spinics.net/lists/util-linux-ng/msg12931.html
Reference: https://github.com/freebsd/freebsd-base-graphics/blob/05dac67f853adbb295eaff5bb65b005d958317a1/contrib/ncurses/ncurses/tinfo/lib_tputs.c#L305-332
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/cal.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 3e20530..4735278 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -87,6 +87,15 @@ static const char *Senter = "", *Sexit = ""; /*
enter and exit standout mode */
 # include <term.h>
 #endif

+/*
+ * Disable ugly BSD hack that makes puts("<number>") to not to be printed.
+ * http://www.spinics.net/lists/util-linux-ng/msg12931.html
+ * https://github.com/freebsd/freebsd-base-graphics/blob/master/contrib/ncurses/ncurses/tinfo/lib_tputs.c#L305-332
+ */
+#ifdef BSD_TPUTS
+# unset BSD_TPUTS
+#endif
+
 static int setup_terminal(char *term)
 {
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW)
-- 
2.8.2
