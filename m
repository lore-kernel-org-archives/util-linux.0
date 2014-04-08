Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:50905 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756179AbaDHRMR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 13:12:17 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fstrim: add systemd units
Date: Tue, 8 Apr 2014 19:12:11 +0200
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404081407.29362.sweet_f_a@gmx.de> <20140408154213.GG585@rampage>
In-Reply-To: <20140408154213.GG585@rampage>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404081912.12297.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 08 April 2014, Dave Reisner wrote:
> On Tue, Apr 08, 2014 at 02:07:28PM +0200, Ruediger Meier wrote:
> > On Tuesday 08 April 2014, Thomas Bchler wrote:
> > > Am 08.04.2014 12:25, schrieb Ruediger Meier:
> > > > Hm, isn't this a bit over the top? Adding a script just to
> > > > call "fstrim -a" automatically?
> > >
> > > It's a common task. I was getting tired of having to add this on
> > > every single machine that I set up.
> >
> > For me it's very common task to do "rm -rf /tmp" after each reboot.
> > I have to setup this on every single machine. Should I go to
> > coreutils, the developers of rm to add a script which calls "rm -rf
> > /tmp" on reboot?
> > No, of course my distribution should give me that feature.
>
> You're again comparing one-time bootstrap tasks to recurring
> maintenance tasks. Does your distribution ship any cronjobs which
> reside in /etc/cron.*?

Of course they do ... /etc/cron.daily/suse.de-clean-tmp ... to "find" 
some files and "rm" them. This script comes with the distro and neither 
from coreutils (rm) nor findutils (find).

> You'd be better off comparing the proposed 
> timer and service unit to this.

?

> > > > Should we also add scripts for "mount -a" or "fsck -a" or
> > > > "swapon -a"?
> > >
> > > And what purpose would that serve? Did you just take random
> > > commands and add '-a' to prove a point?
> >
> > I wanted to point out that util-linux is a project to provide us
> > tools and not all the ways how and when to use them. systemd
> > ustream is mounting and fsck'ing our filesystems automatically. So
> > they can also fstrim if they find it useful.
>
> Again, you're not making a reasonable comparison here.
>
> > > > And wouldn't we also need to add "example crontab" lines for
> > > > non-systemd systems! Sounds a bit ridiculous, right?
> > >
> > > You can add them if you feel like it. But this is not an
> > > "example" file, it is ready to be used.
> >
> > An example crontab line is also ready to use. Your example timer is
> > (hopefully) not automatically enabled just because it is installed.
>
> No, it's up to the local admin to enable it.
>
> > > > I think it's the distro's or admin's job to write and add the
> > > > scripts for filesystems maintenance etc.
> > >
> > > That's ridiculous. We finally, for the first time ever, have a
> > > unified way of creating service definitions that can be used
> > > unchanged in all relevant distributions (except Gentoo and
> > > Slackware, of course).
> >
> > Beside the fact that before "unique service definitions" were
> > invented nobody would have thought that one would need such thing
> > just to call a single commandline one time per day.
>
> Really? You've never heard of cron?

You haven't understood my poor english I guess. I ment everybody knows 
since 40 years how to do such trivial task by using cron. Now since we 
have that great systemd's timer service definitions we start to add 2 
new files for such simple task to a core project like util-linux ...? 
That's what I ment with "a bit over the top" in my first email.

I know nobody will die if util-linux ships such fstrim.timer but it's 
IMO ugly and the wrong place.

> > > The main advantage of this unification is that they can
> > > be shipped and maintained by upstream projects - after all, the
> > > upstream projects know what services make sense and how to start
> > > them properly.
> >
> > I don't say something against systemd here and I don't see this
> > black and white only. I'am just against adding sysadmin scripts
> > which actually do only trivial things. Though it might be worth to
> > add such unit file if it does something more interesting, like we
> > have already uuidd.service and uuidd.socket (and uuidd.rc) which
> > provides nices ways how to start uuidd.
> >
> > > > BTW fstrim.timer is missing in "make dist" tar ball.
> > >
> > > Sorry, you are right. I'm a bit lost in this build system, Karel
> > > probably knows how to fix this.

cu,
Rudi
