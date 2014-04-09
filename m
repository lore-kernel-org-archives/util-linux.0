Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Wed, 9 Apr 2014 14:12:33 +0200
Cc: Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404091207.56691.sweet_f_a@gmx.de> <20140409110251.GT22126@x2.net.home>
In-Reply-To: <20140409110251.GT22126@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404091412.34060.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 April 2014, Karel Zak wrote:
> On Wed, Apr 09, 2014 at 12:07:56PM +0200, Ruediger Meier wrote:
> > Actually I think daily "fstrim -a" IS not a good idea for most of
> > my systems
>
> install service != enable (this is important detail, I'll never agree
> with automatically enabled services).

> BTW, why IS not a good idea for your systems?

Because I don't need it. 

> > but I feel no need to discuss this here on util-linux because
> > the decision whether, how, when and on which devices fstrim should
> > be called should not be made here at all.
>
> well, "fstrim -a" contains heruistic to select the right filestems
> (it really does not call trim for all devices), it has been
> implemented to *avoid* sysadmins creativity. If you don't like it,
> you can use "fstrim <device>" (for example from crontab).

I'd like the documentation more detailed.
Does it really run on all mounts or only /etc/fstab?
Does it write on automounted devices which are probably not owned by the 
admin? Does it affect read-only mounts?

> > If we add scripts with one generic use case for fstrim. Why don't
> > we add the generic boot and maintenance scripts how and when to
> > mount or fsck all filesystems, to activate swap, to get and set
> > hwclock or whatever?
>
> I really don't want to follow this insane direction of the
> discussion.
>
> > Moreover the portability issue. Why adding scripts for systemd only
> > allthough the same could be done without systemd in a more portable
> > way.
>
> is there any other unified, distribution independent and distribution
> supported way to install, but no enable the stuff?

This fstrim.timer IS NOT unified and distribution independent.

IMO the task itself is already installed since we have fstrim's 
option -a". You just need to _enable_ it to run whenever you want for 
example by using crontab. That's trivial.

Nobody would have thought about adding a 1-liner cronjob file to 
util-linux eventhough any distro has /etc/cron.daily/. But now systemd 
timer? Thats what I don't understand.

Ah ... and the "not-enabled" cronjob could have been installed somewhere 
in /usr/share/ or /etc/sysconfig to be linked from /etc/cron.daily/. 
And ... this cronjob would be even more comfortable because you could 
link it from  cron.daily/ cron.hourly/ cron.monthly/ cron.weekly/
without need to copy and edit like such systemd.timer.

If _creating_ a systemd timer is too complicated for today's admins then 
systemd upstream could add a command like
  systemd-create-timer --daily --exec "fstrim -a"
to create and enable it.

cu,
Rudi
