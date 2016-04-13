Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Robby Workman <rworkman@slackware.com>
Subject: Re: v2.29 plan: kill mtab
Date: Wed, 13 Apr 2016 13:03:15 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com> <20160411205934.blmh2xx3bgxw4vwm@ws.net.home> <alpine.LNX.2.02.1604121931070.16273@connie.slackware.com>
In-Reply-To: <alpine.LNX.2.02.1604121931070.16273@connie.slackware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604131303.16574.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 13 April 2016, Robby Workman wrote:
> On Mon, 11 Apr 2016, Karel Zak wrote:
> > On Sun, Apr 10, 2016 at 09:35:41PM -0700, Robby Workman wrote:
> >> Karel Zak wrote:
> >>> libmount supports three scenarios:
> >>>
> >>> 1) regular classic /etc/mtab
> >>>
> >>> 2) /etc/mtab symlink to /proc/self/mount -- in this case libmount
> >>> uses /proc/self/mountinfo and /run/mount/utab
> >>>
> >>> The current default is to detect symlink and on-the-fly switch
> >>> between 1) and 2).
> >>>
> >>> 3) --enable-libmount-force-mountinfo -- don't care about the
> >>> symlink and always use /proc/self/mountinfo. This is robust
> >>> solution required for example by systemd, because unfortunately
> >>> sometimes people use broken stuff (init scripts, tools, etc.)
> >>> which removes the symlink.
> >>>
> >>>
> >>> I'd like to make 3) default, the question is what with mtab code:
> >>>
> >>>    a) #ifdef all mtab code (and add
> >>> --enable-libmount-support-mtab)
> >>>
> >>>    b) remove mtab support at all (because it's evil and horrible
> >>> code)
> >>>
> >>> Comments?
> >>
> >> We still use SysV init because it suits our needs just fine, and
> >> we have no plans to migrate to systemd in the foreseeable future,
> >> so we don't have any other compelling reason to use anything other
> >> than classic /etc/mtab. As such, we'd certainly appreciate, at the
> >> very least, leaving the mtab support in util-linux.
> >
> > This discussion is really not about init, but about mtab that is
> > broken by design.
>
> Okay, then how about this? Our current use of /etc/mtab works well
> for us, and as far as I'm aware, we've experienced absolutely
> none of this "[breakage] by design"

AFAIR we've had a lot of /etc/mtab related bugs in past, for sure also 
reproducable on Slackware. For util-linux upstream it's annyoing to fix 
these bugs by adding ugly code ... although there is a rock-solid 
replacement available since many years.

> - as such, we'd be grealy 
> appreciative if the option remains to continue using it.

There are many advantages by using /proc and unfixable issues 
with /etc/mtab file. IMHO in this case you should have a real reason 
why you don't want to go forward.

> -RW
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
