Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:55028 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbcCHW7r (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Mar 2016 17:59:47 -0500
From: =?utf-8?q?R=C3=BCdiger_Meier?= <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: cal: bug on FreeBSD
Date: Tue, 8 Mar 2016 23:59:43 +0100
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <201603081437.31966.sweet_f_a@gmx.de> <CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
In-Reply-To: <CAG27Bk02Yx5fxpV0sWGaLF7W4jSVOcKwGXWQBBQ7DLT48kZF8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201603082359.43056.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On Tuesday 08 March 2016 23:35:01 Sami Kerola wrote:
> On 8 March 2016 at 13:37, Rdiger Meier <sweet_f_a@gmx.de> wrote:
> > cal skips the first day of the week if it has 2 digits.
> >
> > # diff ./cal
> >  Mo Tu We Th Fr Sa Su
> >               1  2  3
> >   4  5  6  7  8  9 10
> > -11 12 13 14 15 16 17
> > -18 19 20 21 22 23 24
> > -25 26 27 28 29 30
> > + 12 13 14 15 16 17
> > + 19 20 21 22 23 24
> > + 26 27 28 29 30
> >
> > The bug was introduced by my own commit
> > 07ac4aa9  cal: all output must use my_putstring
> >
> > This is the related code in cal_output_months()
> >
> > for (d =DAYS_IN_WEEK * week_line;
> >      d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
> >         if (0 < i->days[d]) {
> >                 if (reqday = i->days[d])
> >                         sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ?
> > 3 : 2), "", Senter, (ctl->julian ? 3 : 2), i->days[d], Sexit);
> >                 else
> >                         sprintf(out, "%*d", skip, i->days[d]);
> > /*                             ^^^^^
> >  *         if we print this with fputs instead of my_putstring/putp
> >  *         below than it looks good */
> >         } else
> >                 sprintf(out, "%*s", skip, "");
> >         my_putstring(out);
> >         if (skip < (int)ctl->day_width)
> >                 skip++;
> > }
> >
> >
> > Is putp() broken on that machine or could we fix it?
>
> Hi Rudi,
>
> Does this happen with putp() only? The following should enable you to
> test the fputs() output.

It's only broken with putp, I tried it like this

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index c687c6c..ea3187e 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -680,15 +680,22 @@ static void cal_output_months(struct cal_month *month, const struct cal_control
                        for (d = DAYS_IN_WEEK * week_line;
                             d < DAYS_IN_WEEK * week_line + DAYS_IN_WEEK; d++) {
                                if (0 < i->days[d]) {
-                                       if (reqday == i->days[d])
+                                       if (reqday == i->days[d]) {
                                                sprintf(out, "%*s%s%*d%s", skip - (ctl->julian ? 3 : 2),
                                                       "", Senter, (ctl->julian ? 3 : 2),
                                                       i->days[d], Sexit);
-                                       else
+                                               my_putstring(out);
+                                       } else {
                                                sprintf(out, "%*d", skip, i->days[d]);
-                               } else
+                                               //my_putstring(out);
+                                               //printf("%s",out);
+                                               fputs(out, stdout);
+                                               //putp(out);
+                                       }
+                               } else {
                                        sprintf(out, "%*s", skip, "");
-                               my_putstring(out);
+                                       my_putstring(out);
+                               }
                                if (skip < (int)ctl->day_width)
                                        skip++;
                        }

> p.s. What is 'that' machine.. just wondering if problem could be
> reproduced.

It's a FreeBSD 10.2. It's easy to run it via qemu like this
$ qemu-kvm  -smp 2 -m 1024 -cdrom FreeBSD-10.2-RELEASE-amd64-bootonly.iso -drive if=virtio,file=freebsd.qcow2

cu,
Rudi
