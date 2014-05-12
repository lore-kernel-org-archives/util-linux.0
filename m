Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: last: please review -F and --time-format
Date: Mon, 12 May 2014 13:01:02 +0200
Cc: kerolasa@gmail.com, "util-linux" <util-linux@vger.kernel.org>
References: <201405071631.53729.sweet_f_a@gmx.de> <201405082226.36617.sweet_f_a@gmx.de> <20140512102510.GB8951@x2.net.home>
In-Reply-To: <20140512102510.GB8951@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201405121301.02972.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 12 May 2014, Karel Zak wrote:
> On Thu, May 08, 2014 at 10:26:36PM +0200, Ruediger Meier wrote:
> > That's a bit ugly to fix without more refactoring. I've tried here
> > to address both issues:
> > https://github.com/karelzak/util-linux/pull/73
>
>  Merged, but note that code like:
>
>    if (ctl->time_fmt > LAST_TIMEFTM_SHORT_CTIME)
>
>  is fragile (as someone can modify LAST_TIMEFTM_* enum), it would be
>  better to introduce any macro and keep it near to LAST_TIMEFTM_*
>  definitions or fix the problem in a better way.

Yes, my first version of that patch had hardcoded

   if (timefmts[ctl->time_fmt].out > 7)

because the particular strings in these if statements really require "7" 
and nothing else. But then I've notived that the whole thing explodes 
anyway if somebody would change fmt values.

cu,
Rudi
